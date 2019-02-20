# Absurd-Ruby
Some wacky things done in Ruby for educational purposes. 


These are some methods, flawed but interesting, I have created while looking at Ruby's functional programming capabilities. 

### Untouchable Stack Generator.

  [Link to code](https://github.com/charkitch/Absurd-Ruby/blob/master/examples/closure_sealed_stack.rb)

  The method that started this whole repository! Untouchable stack generator is a method for securing a stack implemented as
  an array from all but the most determined meddlers. Calling the method generates a storage array for elements and an api for
  treating that array as a stack while making accessing the underlying array in violation of stack principles difficult enough
  that it could only be done intentionally. If interested in how to still access the underlying array please [see below](#how_to_break_it) 
  
  The method creates an array and then returns a hash of four key-value pairs. The key of add points to a lambda that pushes 
  the argument passed to the lambda when it is called into the array created when the stack generator is called. The key of
  remove points to a lambda that pops the last element off of the stack and return that element. The key of peek points to a
  lambda that returns the most recently added element in the array. The key of empty points to a lambda that when invoked
  returns a boolean indicating if the stack is empty. 
  
  An example of invocation is below with a useful error on line 8. 
  
  ```
  [4] pry(main)> new_stack = untouchable_stack_generator
 => {:add=>#<Proc:0x007f97149f9388@(pry):22 (lambda)>,
 :remove=>#<Proc:0x007f97149f9360@(pry):27 (lambda)>,
 :peek=>#<Proc:0x007f97149f9338@(pry):32 (lambda)>}
            
[5] pry(main)> new_stack[:add].(4) #If you are not familiar .(4) is the same as .call(4)
=> true
[6] pry(main)> new_stack[:add].(10)
=> true
[7] pry(main)> new_stack[:peek].() # .() is an alternative to .call
=> 10
[8] pry(main)> new_stack[:remove] #An easy error to make in Ruby, unlike with regular methods there is a differene between referencing the function and invoking it. 
=> #<Proc:0x007f97149f9360@(pry):27 (lambda)>
[9] pry(main)> new_stack[:remove].()
=> 10
[10] pry(main)> new_stack[:peek].()
=> 4
[11] pry(main)> new_stack[:remove].()
=> 4
[12] pry(main)> new_stack[:peek].()
=> nil
  ```
  This method does make interfering with the stack's array implementation impossible by regular means but creates memory
  issues and ignores the benifits of OOP inheritence(every new stack generates a new api/hash). It was however very fun to
  create.
  
  
  ### <a name="how_to_break_it"></a> How to still access the array and break this whole thing. 
  Still want to mess with the underlying array though? Here is how! 
  
  ```
  [34] pry(main)> context = new_stack[:add].binding
=> #<Binding:0x007f875cc21df8>
[35] pry(main)> context.local_variables
=> [:stack, :add, :remove, :peek]
[36] pry(main)> grabbed_stack = context.local_variable_get(:stack)
=> [3, 2, 1, 0]
[37] pry(main)> grabbed_stack.push('Not that unreachable, is it?')
=> [3, 2, 1, 0, "Not that unreachable, is it?"]
[38] pry(main)> new_stack[:peek].()
=> "Not that unreachable, is it?"
```
