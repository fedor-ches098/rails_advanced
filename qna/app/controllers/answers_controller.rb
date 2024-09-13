class AnswersController < ApplicationController
  include Liked
  
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[update destroy best]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    
    flash[:notice] = 'Your answer successfully created.' if @answer.save
  end 

  def update
    if current_user.author?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    else
      redirect_to @answer.question
    end
  end
  
  def destroy
    if current_user.author?(@answer)
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted.'
    else
      flash[:notice] = 'Only author can delete answer.'
      redirect_to @answer.question
    end
  end

  def best
    @answer.best! if current_user.author?(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url])
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def load_question
    @question = Question.with_attached_files.find(params[:question_id])
  end
end
