class PolyTreeNode

    attr_reader :value , :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []

    end

    def parent=(node)

        if self.parent != nil
            i = self.parent.children.index(self)
            self.parent.children.delete_at(i)
            
        end

        @parent = node 

        if node != nil && !node.children.include?(self)
            node.children << self

        end
    
    end

    def add_child(node)
        if !@children.include?(node)
            node.parent=(self)
        end
    end

    def remove_child(node)
        if @children.include?(node)
            node.parent=(nil)
        else 
            raise ArgumentError.new"invalid input"
        end
    end

    def dfs(target_value)

        return self if value == target_value
        return nil if children.empty?

        @children.each do |child|
            target = child.dfs(target_value)
            return target if target != nil
        end
        
        nil
    end

    def bfs(target_value)
        queue = [self]
        while !queue.empty?
            node = queue.shift
            return node if node.value == target_value
            if !node.children.empty?
                node.children.each do |child|
                    queue << child
                end
            end
        end
        nil
    end 

end


#  node.dfs 
#  / | \ 
#  a b c
#  /\ 
# d  e
#    /\ 
#    f g

#node
#/\ 