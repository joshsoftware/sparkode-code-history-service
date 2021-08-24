# frozen_string_literal: true

class CodeSerializer < ActiveModel::Serializer
  attributes :id, :answer, :lang_code, :problem_id #, :token
end
