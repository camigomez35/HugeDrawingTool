require 'rspec'
require 'huge'

describe "initialize" do
	before(:each) do
		@tool = HugeDrawingTool.new	
	end

  it "should initialize an empty canvas" do
  	expect(@tool.instance_variable_get(:@canvas)).to eq([[]])
  end

  it "should initialize 'init' to false" do
    expect(@tool.instance_variable_get(:@init)).to eq(false)
  end
end

describe "drawing" do
  before(:each) do
    @tool = HugeDrawingTool.new
    @tool.send(:handle_input, ["C", 20, 4])
  end

  it "should create a new canvas" do
    expect(@tool.instance_variable_get(:@canvas).length).to eq(6)
    expect(@tool.instance_variable_get(:@canvas)[0].length).to eq(22)
  end

	# Drawing lines
  it "should draw a horizontal line" do
    @tool.send(:draw_horizontal_line, [1, 2, 6, 2])

    expect(@tool.instance_variable_get(:@canvas)[2][1]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[2][2]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[2][3]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[2][4]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[2][5]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[2][6]).to eq("x")
  end

  it "should draw a vertical line" do
    @tool.send(:draw_vertical_line, [6, 3, 6, 4])

    expect(@tool.instance_variable_get(:@canvas)[3][6]).to eq("x")
    expect(@tool.instance_variable_get(:@canvas)[4][6]).to eq("x")
  end

  # Filling In
  it "should fill in empty space appropriately" do
    @tool.send(:fill_area, [10, 3, "o"])
    expect(@tool.instance_variable_get(:@canvas)[3][10]).to eq("o")
  end
end