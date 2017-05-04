class ParticipantsController < ApplicationController
  before_filter :authenticate, only: [:index, :show]

  def index
    @participants = Participant.all.order(:organisation).order(:last_name)
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
      MessageMailer.confirmation_mail(@participant).deliver_now
      redirect_to page_2_path(@participant.id)
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
      if params[:page] == 'update'
        flash[:success] = 'Erfolgreich aktualisiert.'
        redirect_to participants_path
      elsif params[:page] == 'page_1'
        redirect_to page_2_path
      elsif params[:page] == 'page_2'
        redirect_to page_3_path
      elsif params[:page] == 'page_3'
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

  private

  def edit
    @participant = Participant.find(params[:id])
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
