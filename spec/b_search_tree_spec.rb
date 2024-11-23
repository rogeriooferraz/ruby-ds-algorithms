require "./lib/tree/b_search_tree"

describe BSearchTree do

  bst = BSearchTree.new

  # -----------------------------------------------------------------------------
  # Constructor
  # -----------------------------------------------------------------------------

  it "Test Case 1 - Constructor" do

    bst0 = BSearchTree.new

    expect(bst0).to eq("")

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]
    output = input.sort

    bst1 = BSearchTree.new(input)

    expect(bst1).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Insert
  # -----------------------------------------------------------------------------

  it "Test Case 2 - Insert" do

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]
    output = input.sort

    input.each do |item|
      bst.insert(item)
    end

    expect(bst).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Slice
  # -----------------------------------------------------------------------------

  it "Test Case 3 - Slice" do

    input = [7]
    output = [7]

    expect(bst.slice(*input)).to eq(output)
    expect(bst[*input]).to eq(output)

    input = [6, 13]
    output = [6, 7, 8, 10, 13]

    expect(bst.slice(*input)).to eq(output)
    expect(bst[*input]).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Min
  # -----------------------------------------------------------------------------

  it "Test Case 4 - Min" do

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]
    output = input.min

    expect(bst.min.key).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Max
  # -----------------------------------------------------------------------------

  it "Test Case 5 - Max" do

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]
    output = input.max

    expect(bst.max.key).to eq(output)
  end

  # -----------------------------------------------------------------------------
  # Search
  # -----------------------------------------------------------------------------

  it "Test Case 6 - Search" do

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]

    item = 6
    expect(bst.bsearch(item)&.key).to eq(item)

    item = 13
    expect(bst.bsearch(item)&.key).to eq(item)

    item = 4
    expect(bst.bsearch(item)&.key).to eq(item)

    item = 0
    expect(bst.bsearch(item)&.key).to eq(nil)
  end

  # -----------------------------------------------------------------------------
  # Delete
  # -----------------------------------------------------------------------------

  it "Test Case 7 - Delete" do

    input = [1, 8, 7, 6, 13, 4, 14, 3, 10]
    output = ""

    input.each do |item|
      bst.delete(item)
    end

    expect(bst).to eq(output)
  end
end
