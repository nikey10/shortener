class WebsitesController < ApplicationController
  def index; end

  def create
    website = Website.new(website_params)
    if website.save
      flash[:short] = root_url + website.short
    else
      flash[:errors] = website.errors.full_messages
    end
    redirect_to :root
  end

  def popular_websites
    @websites = Website.order(visits: :desc).limit(100)
  end

  def show
    website = Website.find_short(params[:slug])
    if website
      website.update(visits: website.visits + 1)
      redirect_to website.url
    else
      flash[:errors] = ['Website not found']
      redirect_to :root
    end
  end

  private

  def website_params
    params.require(:website).permit(:url)
  end
end
