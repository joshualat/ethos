require 'ethos/type'

scope '.cast' do
  spec 'casts a value to a String' do
    expected = String 1
    result = Ethos::Type.cast 1, String

    assert result, :==, expected
  end

  spec 'casts a value to an Integer' do
    expected = Integer 1
    result = Ethos::Type.cast 1, Integer

    assert result, :==, expected
  end
end