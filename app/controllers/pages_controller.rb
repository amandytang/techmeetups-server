class PagesController < ApplicationController

  def join_meetup

    @event_id = params[:event_id]
    @token = params[:token]

    @response = HTTParty.post("https://api.meetup.com/2/rsvp/",
      :body => { :rsvp => 'yes',
                 :event_id => @event_id
               },
      :headers => {
        'Authorization' => "Bearer #{@token}"
      }
    )

    puts @response.body

    status = {}
    if @response.body.include?("problem")

      if @response.body.include?("too_few_spots")
        status["error"] = "There are not enough spots for your rsvp."
        render :json => status

      elsif @response.body.include?("You must be a member of this group to RSVP to the event.")
        status["error"] = "You must be a member of this group to RSVP to the event."
        render :json => status

      elsif @response.body.include?("unauthorized")
        status["error"] = "You are not authorized to make that request."
        render :json => status

      else
        status["error"] = "Something went wrong."
        render :json => status
      end

    end
  end


  def join_group

    @group_id = params[:group_id]
    @group_urlname = params[:group_urlname]
    @token = params[:token]

    @response = HTTParty.post("https://api.meetup.com/2/profile/",
      :body => { :group_id => @group_id,
                 :group_urlname => @group_urlname
               },
      :headers => {
        'Authorization' => "Bearer #{@token}"
      }
    )

    puts @response.body

    status = {}

    if @response.body.include?("problem")
      status["error"] = "Something went wrong."
      render :json => status
    end

  end


  def attending

    @token = params[:token]
    @fields = params[:fields]

    options = { :fields => @fields }
    @response = HTTParty.get("https://api.meetup.com/self/calendar/",
      query: options,
      :headers => {
        'Authorization' => "Bearer #{@token}"
      }
    )

    puts @response.body
    render :json => @response.body

  end

end
