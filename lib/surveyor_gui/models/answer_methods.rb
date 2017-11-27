module SurveyorGui
  module Models
    module AnswerMethods

      def self.included(base)
        base.send :belongs_to, :question
        base.send :has_many, :responses
        base.send :belongs_to, :column
        base.send :default_scope, lambda { base.order('display_order') }
        base.send :attr_accessible, :text, :response_class, :display_order, :original_choice, :hide_label, :question_id, 
                  :display_type, :is_comment, :column if defined? ActiveModel::MassAssignmentSecurity
        base.send :scope, :is_not_comment, -> { base.where(is_comment: false) }
        base.send :scope, :is_comment, -> { base.where(is_comment: true) }
      end

      def split_or_hidden_text(part = nil)
        #return "" if hide_label.to_s == "true"
        return "" if display_type.to_s == "hidden_label"
        part == :pre ? text.split("|",2)[0] : (part == :post ? text.split("|",2)[1] : text)
      end

      def not_comment?
        is_comment.nil? || is_comment == false
      end

    end
  end
end
