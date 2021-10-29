RailsAdmin.config do |config|

    ### Popular gems integration
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  ## == Cancan ==
  #config.authorize_with :cancan
  ## == Pundit ==
  # config.authorize_with :pundit


  config.authorize_with do
    unless current_user.try(:admin?) 
      redirect_to main_app.root_path, notice: I18n.t('models.admin.notice')
    end
  end

  #config.authorize_with :cancan

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

  end
end
