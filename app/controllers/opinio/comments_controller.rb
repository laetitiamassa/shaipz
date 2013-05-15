class Opinio::CommentsController < ApplicationController
  include Opinio::Controllers::InternalHelpers
  include Opinio::Controllers::Replies if Opinio.accept_replies

  def index
    @comments = resource.comments.page(params[:page])

  end

  def create
    @comment = resource.comments.build(params[:comment])
    @comment.owner = send(Opinio.current_user_method)
    @project = resource
    if @comment.save
      NotificationMailer.new_comment(@project.participants, @project).deliver
      flash_area = :notice
      message = t('comment.sending_success')
    else
      flash_area = :error
      message = t('comment.sending_error')
    end

    respond_to do |format|
      format.js
      format.html do
        set_flash(flash_area, message)
        redirect_to(opinio_after_create_path(resource))
      end
    end
  end

  def destroy
    @comment = Opinio.project.constantize.find(params[:id])

    if can_destroy_opinio?(@comment)
      @comment.destroy
      set_flash(:notice, t('opinio.messages.comment_destroyed'))
    else
      #flash[:error]  = I18n.translate('opinio.comment.not_permitted', :default => "Not permitted")
      logger.warn "user #{send(Opinio.current_user_method)} tried to remove a comment from another user #{@comment.owner.id}"
      render :text => "unauthorized", :status => 401 and return
    end

    

    respond_to do |format|
      format.js
      format.html { redirect_to( opinio_after_destroy_path(@comment) ) }
    end

    def can_destroy_opinio?
      comment_destroy_conditions do |comment|
        comment.owner == current_user
      end
    end

  end
  
end