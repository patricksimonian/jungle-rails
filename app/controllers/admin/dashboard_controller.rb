class Admin::DashboardController < ApplicationController
  extend AdminHelper
  Admin::DashboardController.authenticate_with
  def show
  end
end
