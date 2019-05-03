# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    slug = params[:slug] || params[:id]
    stats = true if slug[-1] == '+'
    # rubocop:disable GuardClause
    unless stats
      Click.create(link: @link)
      redirect_to @link.url
    end
    # rubocop:enable GuardClause
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  # rubocop:disable AbcSize
  # POST /links
  # POST /links.json
  def create
    @link = Link.new(user: link_user, url: build_link, slug: SecureRandom.hex[0..6])
    respond_to do |format|
      if @link.save
        format.html { redirect_to "/#{@link.slug}+", notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable AbcSize

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to "/#{@link.slug}+", notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def link_user
    current_user if user_signed_in?
  end

  def build_link
    url = link_params[:url]
    parsed = URI.parse url
    parsed = URI.parse "http://#{url}" unless parsed.scheme
    Rails.logger.debug "Shortening #{parsed}"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find_by(slug: params[:id]) || Link.find_by(slug: params[:id][0..-2])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:url)
  end
end
