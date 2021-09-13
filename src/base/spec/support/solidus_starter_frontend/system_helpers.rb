module SystemHelpers
  def checkout_as_guest
    click_button "Checkout"
    click_on 'Continue'
  end
end
