require File.join(File.dirname(__FILE__), "spec_helper")

describe "Middleware" do
  it "should work" do
    visit "/"
    response_body.should == "Yo merboutpost"
  end
end