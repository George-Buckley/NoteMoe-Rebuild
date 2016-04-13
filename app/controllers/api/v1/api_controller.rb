module Api
    module V1
        class ApiController < ApplicationController
                before_filter :restrict_access
                respond_to :json
        end
    end
end