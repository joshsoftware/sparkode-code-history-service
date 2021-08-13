# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Code' do
  let!(:code) { create(:code) }

  get '/api/v1/codes/:token/:problem_id/:language_id' do
    parameter :token, 'DrivesCandidate token'
    parameter :problem_id, 'Problem id'
    parameter :language_id, 'Language id'
    context 'with valid params' do
      let!(:token) { code.token }
      let!(:problem_id) { code.problem_id }
      let!(:language_id) { code.language_id }
      example 'get code related to a drives_candidate and problem' do
        do_request
        response = JSON.parse(response_body)
        expect(response['data']['code']['answer']).to eq(code.answer)
        expect(status).to eq(200)
      end
    end
    context 'with invalid params' do
      let!(:token) { Faker::Internet.uuid }
      let!(:problem_id) { Faker::Number.number(digits: 4) }
      let!(:language_id) { Faker::Number.number(digits: 2) }
      example ' returns not found error message' do
        do_request
        response = JSON.parse(response_body)
        expect(response['message']).to eq(I18n.t('not_found.message'))
        expect(status).to eq(200)
      end
    end
  end

  post '/api/v1/codes' do
    parameter :token, 'DrivesCandidate token'
    parameter :problem_id, 'Problem id'
    parameter :answer, 'Code answer'
    parameter :language_id, 'Language id'
    context 'with valid params' do
      let!(:token) { Faker::Internet.uuid }
      let!(:problem_id) { Faker::Number.number(digits: 4) }
      let!(:answer) { Faker::Lorem.paragraph }
      let!(:language_id) { Faker::Number.number(digits: 4) }
      example 'create new code and store to database' do
        previous_code_count = Code.count
        do_request
        response = JSON.parse(response_body)
        expect(response['data']['code']['problem_id']).to eq(problem_id)
        expect(status).to eq(200)
        expect(Code.count).to eq(previous_code_count + 1)
      end
    end

    context 'with missing problem id returns missing parameter error' do
      let!(:answer) { Faker::Lorem.paragraph }
      let!(:language_id) { Faker::Number.digit }
      example ' returns not found error message as token is fake' do
        previous_code_count = Code.count
        do_request
        response = JSON.parse(response_body)
        expect(response['message']).to eq(I18n.t('missing_parameter.message'))
        expect(status).to eq(200)
        expect(Code.count).to eq(previous_code_count)
      end
    end
  end
end
