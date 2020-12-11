# frozen_string_literal: true

require 'spec_helper'

Spree::Order.class_eval do
  attr_accessor :did_transition
end

module Spree
  describe OrdersController, type: :request, with_guest_session: true do
    # Regression test for https://github.com/spree/spree/issues/2004
    context "with a transition callback on first state" do
      let(:order) { create(:order, user: nil, store: store) }
      let!(:store) { create(:store) }

      before do
        first_state, = Spree::Order.checkout_steps.first
        Spree::Order.state_machine.after_transition to: first_state do |order|
          order.update(number: 'test')
        end
      end

      it "correctly calls the transition callback" do
        expect(order.number).not_to eq 'test'
        order.line_items << create(:line_item)
        put spree.order_path(order.number), params: { checkout: "checkout" }
        expect(order.reload.number).to eq 'test'
      end
    end
  end
end
