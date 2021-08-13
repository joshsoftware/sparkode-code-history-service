# frozen_string_literal: true

class CodeSerializer < ActiveModel::Serializer
  attributes :id, :answer, :language_id, :problem_id, :token
end
