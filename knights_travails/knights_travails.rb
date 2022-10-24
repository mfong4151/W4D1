require_relative 'tree_node'


class KnightPathFinder

    DIRECTIONS=[[2,1],[1,2],[-2,-1],[-1,-2],[-2,1],[-1,2],[2,-1],[1,-2]]
    @@considered_positions = []
    def self.valid_moves(i,j)
        

        if i < 0 || j < 0 || i >= 8 || j >= 8 || @@considered_positions.include?([i,j])
            return false
        else
            @@considered_positions << [i,j] #[[2,1] [1,2]]
            return true
        end 
        
    end

    attr_reader :root_node

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos) #do we need to look at this?
        
        #build_move_tree
    end

    def considered_positions
        return @@considered_positions
    end

    def render
        
        #[@root_node.children,@root_node.value]
    end
    
    #temp will be container for our path up to that point
    # def find_path(target, temp = []) #target is our result from bfs
    #     curr = self.root_node
    #     return nil if curr.children == [] 

    #     if curr.value == target
    #         temp << curr.value
    #         return temp
    #     end
        
    #     curr.children.each do |child|
    #         child_path = child.find_path(target, temp)     
    #         if child_path != nil 
    #             temp << child.value
    #             return temp
    #         end
    #     end
    #     return nil
    # end



    def new_move_positions(pos)
        values = self.values
        self.valid_moves(pos)

    end

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

    def build_move_tree(target_pos)

        #Create instance of KnightPathFinder
        #call bfs on our KPF instance
        child = self.bfs(target_pos)
        return nil if !child
        path = []
        while child.parent != nil 
            path << child.value
            child = child.parent
        end 
        path << child.value
        #if bfs returns target_pos, then we access considered_positions
        #check considered positions for parent of target_pos
        #Put parent into path array (starts at []) continue until the parent is our starting position
        @@considered_positions = []
        return path.reverse
    end

end

# kpf = KnightPathFinder.new([0, 0])
# path = kpf.bfs([3,3])
# p kpf.root_node.children


# Polytree_node
# def initialize(value)
#     @value = value
#     @parent = nil
#     @children = []
# end


#kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
#kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]] 

#knight can only move hori 2 vert 1, vert 2 hori 1. 

#[2,1], [1, 2] [-1, -2] ..... 

#[0, 0]
#/ \  \  \ 
#[2, 1] [1, 2]
 #\
# [children of 2,1]



 #matrix = Array.new(8){Array.new(8,)}

