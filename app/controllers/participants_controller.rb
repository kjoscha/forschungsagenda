class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all.order(:organisation).order(:last_name)
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      MessageMailer.confirmation_mail(@participant).deliver_now
      flash[:success] = 'Erfolgreich angemeldet. Eine Bestätigungsemail wurde an Ihre Email versandt!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
      render :new
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      flash[:success] = 'Erfolgreich aktualisiert'
      redirect_to participants_path
    else
      flash.now[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
      render :new
    end
  end

  private

  def participant_params
    params.require(:participant).permit(
      :sex,
      :title,
      :first_name,
      :last_name,
      :organisation,
      :address,
      :postal_code,
      :city,
      :country,
      :email,
      :email_confirmation,
      :telephone,
      :accepted_data_storage
    )
  end
end
