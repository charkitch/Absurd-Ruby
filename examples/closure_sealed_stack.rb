def untouchable_stack_generator
  stack = []
  
  add = -> (element) do 
    stack.push(element)
    true
  end  
  
  remove = -> () do
    element = stack.pop
    element
  end  
  
  peek = -> () do
    element = stack[-1]
    element
  end

  empty = -> () do
    stack.empty?
  end
  
  return { 
    add: add, 
    remove: remove, 
    peek: peek,
    empty: empty,
    }
end  
