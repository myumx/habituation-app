module Api
  module V1
    class HabituationsController < ApplicationController
      before_action :set_habituation, only: [:show, :update, :destroy]

      def index
        habituations = Habituation.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded habituations', data: habituations }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the habituation', data: @habituation }
      end

      def create
        habituation = Habituation.new(habituation_params)
        if habituation.save
          render json: { status: 'SUCCESS', data: habituation }
        else
          render json: { status: 'ERROR', data: habituation.errors }
        end
      end

      def destroy
        @habituation.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the habituation', data: @habituation }
      end

      def update
        if @habituation.update(habituation_params)
          render json: { status: 'SUCCESS', message: 'Updated the habituation', data: @habituation }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @habituation.errors }
        end
      end

      private

      def set_habituation
        @habituation = Habituation.find(params[:id])
      end

      def habituation_params
        params.require(:habituation).permit(:title, :slack_notification)
      end
    end
  end
end