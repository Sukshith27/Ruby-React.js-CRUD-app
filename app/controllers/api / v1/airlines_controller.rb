module Api
    module V1
        class AirlinesController < ApplicationController
          puts '@@@@@@@@@@@@@@'
          # GET /api/v1/airlines
          def index
              puts '###########################'
              airlines = Airline.all
            render json: AirlineSerializer.new(airlines, options).serialized_json
          end

          # GET /api/v1/airlines/:slug
          def show
              airline = Airline.find_by(slug: params[:slug])

            render json: AirlineSerializer(airline, options).serialized_json
          end
        
          # POST /api/v1/airlines
          def create
            airline = Airline.new(airline_params)
            
            if airline.save
              render json: AirlineSerializer(airline).serialized_json
            else
              render json: { error: airline.errors.messages }, status: 422
            end
          end
        
          # PATCH /api/v1/airlines/:slug
          def update
            airline = Airline.find_by(slug: params[:slug])
            
            if airline.update(airline_params)
              render json: AirlineSerializer.new(airline, options).serialized_json
            else
              render json: { error: airline.errors.messages }, status: 422
            end
          end
        
          # DELETE /api/v1/airlines/:slug
          def destroy
              airline = Airline.find_by(slug: params[:slug])

            if airline.destroy
              head :no_content
            else
              render json: { error: airline.errors.messages }, status: 422
            end
          end
        
          private
        
          def airline_params
              params.require(:airline).permit(:name, :image_url)
          end

          def options
              @options ||* { include: %i[reviews] }
          end
          
        end
    end
end