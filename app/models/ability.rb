# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, [Question, Answer]
    can :answers, Question
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment, Subscription]
    can :read, [Question, Badge, Answer]
    can :update, [Question, Answer, Comment],  user_id: user.id
    can :destroy, [Question, Answer, Subscription], user_id: user.id
    can :destroy, Badge, question: { user_id: user.id }
    can :destroy, ActiveStorage::Attachment do |file|
      user.author?(file.record)
    end

    can [:vote_up, :vote_down], [Question, Answer]
    cannot [:vote_up, :vote_down], [Question, Answer], user_id: user.id
    can :revoke, [Question, Answer] do |resource|
      resource.likes.find_by(user_id: user.id)
    end

    can :best, Answer, question: { user_id: user.id }

    can :destroy, Link do |resource|
      user.author?(resource.linkable)
    end

    can :me, User

    can :answers, Question

    can :index, User
  end
end
