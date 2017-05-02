class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      flash[:success] = 'Erfolgreich!'
      MessageMailer.confirmation_mail(@participant).deliver_now
      redirect_to root_path
    else
      flash[:danger] = 'Bitte gültige Angaben machen und alle Pflichtfelder ausfüllen.'
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
