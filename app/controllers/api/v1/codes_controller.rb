# frozen_string_literal: true

module Api
  module V1
    class CodesController < ApiController
      before_action :find_code, only: %i[show]

      def create
        code = Code.new(code_params)
        if code.save
          render_success(data: { code: serialize_resource(code, CodeSerializer) }, message: I18n.t('success.message'))
        else
          render_error(message: code.errors.messages)
        end
      end

      def show
        render_success(data: { code: serialize_resource(@code, CodeSerializer) }, message: I18n.t('success.message'))
      end

      def index
        codes = Code.where(token: params[:token], language_id: params[:language_id],
                           problem_id: params[:problem_id])
        render_success(data: { code: serialize_resource(codes, CodeSerializer) }, message: I18n.t('success.message'))
      end

      private

      def code_params
        params.permit(:answer, :problem_id, :language_id, :token)
      end

      def find_code
        @code = Code.where(token: params[:token], language_id: params[:language_id],
                           problem_id: params[:problem_id]).last
        render json: { data: {}, message: I18n.t('not_found.message') } unless @code
      end
    end
  end
end
