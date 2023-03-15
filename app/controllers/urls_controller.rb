require 'base64'

class UrlsController < ApplicationController
    def index
        short_url = params[:short_url]

        if short_url.nil?
          return render(
            json: { message: "short_url is missing"}, 
            status: 400, 
           )
        end


        url = Url.find_by(short_url: short_url)
        if url.nil?
          return render(
            json: { message: "Url could not be found"}, 
            status: 404, 
           )
        end

        redirect_to(url.long_url, status: 301, allow_other_host: true)
    end

    def shorten
        # Shorten needs to hash the url and save it
        url = params[:longUrl]

        if url.nil?
         return render(
            json: { message: "longUrl is missing"}, 
            status: 400,
          )
        end

        if Url.where(long_url: url).exists?
            short_url = Url.find_by(long_url: url).short_url
            return render json: { short_url: short_url}
        end

        #create url,
        # generate hash for  the
        url = Url.create!(long_url: url)
        url.generate_short_url
        url.save!

        render json: { short_url: url.short_url }
    end

    def url_params
        params.permit(:longUrl, :short_url) 
     end
end
