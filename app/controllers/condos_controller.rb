class CondosController < ApplicationController
  # GET /condos
  # GET /condos.json
  def index
    @condos = Condo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @condos }
    end
  end

  # GET /condos/1
  # GET /condos/1.json
  def show
    @condo = Condo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @condo }
    end
  end

  # GET /condos/new
  # GET /condos/new.json
  def new
    @condo = Condo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @condo }
    end
  end

  # GET /condos/1/edit
  def edit
    @condo = Condo.find(params[:id])
  end

  # POST /condos
  # POST /condos.json
  def create
    @condo = Condo.new(params[:condo])

    respond_to do |format|
      if @condo.save
        format.html { redirect_to @condo, notice: 'Condo was successfully created.' }
        format.json { render json: @condo, status: :created, location: @condo }
      else
        format.html { render action: "new" }
        format.json { render json: @condo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /condos/1
  # PUT /condos/1.json
  def update
    @condo = Condo.find(params[:id])

    respond_to do |format|
      if @condo.update_attributes(params[:condo])
        format.html { redirect_to @condo, notice: 'Condo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @condo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condos/1
  # DELETE /condos/1.json
  def destroy
    @condo = Condo.find(params[:id])
    @condo.destroy

    respond_to do |format|
      format.html { redirect_to condos_url }
      format.json { head :no_content }
    end
  end
end
