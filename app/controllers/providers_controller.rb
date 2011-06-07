class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.xml
  def index
    @providers = Provider.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        format.html { redirect_to(@provider, :notice => 'Provider was successfully created.') }
        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to(@provider, :notice => 'Provider was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to(providers_url) }
      format.xml  { head :ok }
    end
  end

  def get_new_providers
    api_calls = 40
    
    if api_calls > 2
      @city = Place.incomplete.first
      api_calls -= 1
      @total_results = get_total_results(@city.name).to_i
      queries = (@total_results/100).to_i
      @new_providers = []
      if queries < api_calls
        api_calls -= queries
        if @total_results > 0
          @city_providers = get_providers(@city.name, queries)
          if !@city_providers.nil?
            @city_providers.each do |p|
              provider = Provider.find_by_name(p)
              if provider.nil?
                new_provider = Provider.new(:name => p)
                new_provider.save
                @new_providers << new_provider
              end
            end
          end
        end
        @city.complete = 'true'
        @city.save      
      end
    end

    
  end



end
