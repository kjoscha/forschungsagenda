class ParticipantsController < ApplicationController
  before_filter :authenticate, only: [:index, :show]

  def index
    @participants = Participant.completed.sort_by(&:organisation).sort_by(&:last_name)
    respond_to do |format|
      format.html
      format.xls { headers['Content-Disposition'] = "attachment; filename=\"teilnehmer_innenliste - #{Date.today.to_s}.xls\"" }
    end
  end

  def new
    @participant = Participant.new
  end

  def edit_page_2
    edit
  end

  def edit_page_3
    edit
  end

  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      session[:user_id] = @participant.id
      redirect_to page_2_path(@participant.id)
    else
      if @participant.errors.messages[:email]
        flash.now[:danger] = 'Bitte gültige und nicht bereits angemeldete Emailadresse angeben.'
        render :new
      else
        flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
        render :new
      end
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    admin_or_session?
    if @participant.update_attributes(participant_params)
      if params[:page] == 'update'
        flash[:success] = 'Erfolgreich aktualisiert.'
        redirect_to participants_path
      elsif params[:page] == 'page_1'
        redirect_to page_2_path
      elsif params[:page] == 'page_2'
        redirect_to page_3_path
      elsif params[:page] == 'page_3'
        MessageMailer.confirmation_mail(@participant).deliver_now
        flash[:success] = 'Erfolgreich angemeldet. Eine Bestätigungsemail wurde an Ihr Emailadresse versandt.'
        redirect_to root_path
      end
    else
      if params[:page] == 'update'
        flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
        render :show
      elsif params[:page] == 'page_1'
        flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
        render :new
      elsif params[:page] == 'page_2'
        flash.now[:danger] = 'Bitte Teilnahme für alle Veranstaltungen wählen.'
        render 'edit_page_2'
      elsif params[:page] == 'page_3'
        flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
        render 'edit_page_3'
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    if @participant.destroy
      flash[:success] = 'Erfolgreich gelöscht.'
      redirect_to :back
    end
  end

  private

  def admin_or_session?
    session[:user_id] == @participant.id || authenticate
  end

  def edit
    @participant = Participant.find(params[:id])
    admin_or_session?
  end

  def participant_params
    params.require(:participant).permit(
      :sex,
      :title,
      :first_name,
      :last_name,
      :organisation,
      :position,
      :group,
      :custom_group,
      :address,
      :postal_code,
      :city,
      :country,
      :email,
      :email_confirmation,
      :telephone,
      :accepted_data_storage,
      :do_opening,
      :do_lunch,
      :do_1330_workshop,
      :do_dinner,
      :fr_1015_workshop,
      :fr_lunch,
      :focus,
      :transport,
      :measure,
      :slogan,
      :portrait,
    )
  end
end
