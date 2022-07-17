module IsExpectedResponse
  def is_expected_response
    subject
    expect(response)
  end
end
