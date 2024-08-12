class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[edit update destroy]

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else 
      render 'questions/show'
    end
  end 

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end
  
  def destroy
    flash[:notice] = if current_user.author?(@answer)
                       @answer.destroy
                       'Answer successfully deleted.'
                     else
                       'Only author can delete answer.'
                     end

    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
