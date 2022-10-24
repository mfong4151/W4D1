def bfs(target_pos)
    queue = [@root_node]
    while !queue.empty?
        node = queue.shift
        return node if node.value == target_pos
        
        DIRECTIONS.each do |y, x|
            i, j = y + node.value[0], x + node.value[1]
            #check if i, y is a valid position.
            if KnightPathFinder.valid_moves(i, j)
                    #if yes, make a polytree node. make it a child of a node. add new polytree node 
                    #to the queue
                child = PolyTreeNode.new([i, j])
                node.add_child(child)
                queue << child

            end
        end
    end
    nil 
    #look at what we're doing after we evaluate the inner each loop
end 