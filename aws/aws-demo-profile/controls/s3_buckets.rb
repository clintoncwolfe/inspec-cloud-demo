control "Check our demo bucket for dangerous settings" do
  impact 1.0
  describe aws_s3_bucket('inspec-testing-public-default.chef.io') do
    it { should_not be_public }
  end
end
