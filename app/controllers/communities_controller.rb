class CommunitiesController < ApplicationController
    before_action :authenticate_account!, except: [ :index, :show]
    before_action :set_community, only: [ :show]

    def index
        @communities = Community.all
    end

    def show
        @posts = @community.posts
        @subscriber_count = @community.subscribers.count
    end

    def new
        @community = Community.new
    end

    def create
        @community = Community.new comunity_values
        @community.account_id = current_account.id
        if @community.save
            redirect_to communities_path
        else
            render :new
        end
    end

    private

    def set_community
        @community = Community.find(params[:id])
    end

    def comunity_values
        params.require(:community).permit(:name, :url, :rules)
    end
end