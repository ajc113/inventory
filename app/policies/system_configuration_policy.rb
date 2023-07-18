# frozen_string_literal: true

class SystemConfigurationPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    super_admin?
  end

  def update?
    super_admin?
  end

  def edit?
    super_admin?
  end

  private

  def super_admin?
    user.has_role?(:super_admin)
  end
end
