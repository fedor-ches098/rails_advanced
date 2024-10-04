class AnswersController < ApplicationController
  include Liked
  
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[update destroy best]
  before_action :init_comment, only: %i[create update best]

  after_action :publish_answer, only: :create

  authorize_resource

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    flash[:notice] = 'Your answer successfully created.' if @answer.save
  end 

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end
  
  def destroy
    @answer.destroy
    flash[:notice] = 'Answer successfully deleted.'
  end

  def best
    @answer.best! if current_user.author?(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url])
  end

  def publish_answer
    return if @answer.errors.any?

    files = @answer.files.map { |f| { id: f.id, name: f.filename.to_s, url: url_for(f) }}
    
    ActionCable.server.broadcast(
      "question_#{@answer.question_id}_answers", {
        answer: @answer,
        files: files,
        links: @answer.links,
        rating: @answer.rating_sum
      }.to_json
    )
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def load_question
    @question = Question.with_attached_files.find(params[:question_id])
  end

  def init_comment
    @comment = Comment.new
  end
end
