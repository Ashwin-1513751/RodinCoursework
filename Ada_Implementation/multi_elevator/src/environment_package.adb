--  Copyright (c) 2020, 2023 University of Southampton.
--
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
--
--  The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.

--  This package body implements the environment for the MULTI elevator.
--
--  @author: htson
--  @version: 1.0



package body Environment_Package with SPARK_Mode is

   function HasCabinAbove(n : in Cabin_Number) return Boolean is
   begin
      -- Task B3. Provide the implementation for this using FOR loop
      for i in cabins_array'Range loop
         if cabins_array(i).shaft = cabins_array(n).shaft  then
            if cabins_array(i).floor = cabins_array(n).floor + 1 then
                   return True;
            end if;
         end if;
      end loop;
      return False;
   end HasCabinAbove;
   
   function HasCabinBelow(n : in Cabin_Number) return Boolean is
   begin
      -- Task B3. Provide the implementation for this using FOR loop
      for i in cabins_array'Range loop
         if cabins_array(i).shaft = cabins_array(n).shaft  then
            if cabins_array(i).floor = cabins_array(n).floor - 1 then
                   return True;
            end if;
         end if;
      end loop;
      return False;
   end HasCabinBelow;

   function HasCabinAtBottomUpShaft return Boolean is
   	CN : Cabin_Number := 1;
   begin
      -- Task B3. Provide the implementation for this using WHILE loop
      -- Remember to have Loop invariant and variant, e.g.,
      -- pragma Loop_Variant (...)
      -- pragma Loop_Invariants (...)
      while CN < cabins_array'Length loop
      	
         pragma Loop_Invariant (Invariants(cabins_array, up_buttons_array, down_buttons_array));
        

         -- if CN = 1 then (for some I in 1 => (cabins_array(I).floor /= 0 and cabins_array(I).shaft /= Up))))

         pragma Loop_Variant (Increases => CN);
         if (cabins_array(CN).shaft = Up and cabins_array(CN).floor = 0) then
            return True;
         end if;
         CN := CN + 1;
      end loop;
      return False;
   end HasCabinAtBottomUpShaft;
   
   function HasCabinAtTopDownShaft return Boolean is
   	CN : Cabin_Number := 1;
   begin
      -- Task B3. Provide the implementation for this using WHILE loop
      -- Remember to have Loop invariant and variant, e.g.,
      -- pragma Loop_Variant (...)
      -- pragma Loop_Invariants (...)
      while CN < cabins_array'Length loop
      	
         pragma Loop_Invariant (Invariants(cabins_array, up_buttons_array, down_buttons_array));

        
         pragma Loop_Variant (Increases => CN);

        if CN > 1 then
            if cabins_array(CN-1).shaft = Down and cabins_array(CN-1).floor = TOP_FLOOR then
               return True;
            end if;
         else
            if CN = 1 then 
               if cabins_array(2).shaft = Down and cabins_array(2).floor = TOP_FLOOR then
                     return True;
               end if;
            else
               return False;
            end if; 
         end if;


         


         CN := CN + 1;
      end loop;
      return False;
   end HasCabinAtTopDownShaft;
   
   -- Procedure to move the cabins according to the motor status.
   procedure Environment is
   begin
      for n in Cabin_Number loop
         pragma Loop_Invariant (Invariants(cabins_array, up_buttons_array, down_buttons_array));
         if cabins_array(n).motor = On then
            if cabins_array(n).shaft = Up then
               if cabins_array(n).floor /= TOP_FLOOR then
                  if HasCabinAbove(n) then
                     Put("Cabin ");
                     Put(n);
                     Put_Line("cannot move since there is a cabin above");
                  else
                     MovesUp(n);
                     Put("=Environment= Cabin ");
                     Put(n);
                     Put_Line(" moves up");
                  end if;
               else
                  if HasCabinAtTopDownShaft then
                     Put("Cabin ");
                     Put(n);
                     Put_Line("cannot move since there is a cabin at top down shaft");
                  else
                     CabinUpToDown(n);
                     Put("=Environment= Cabin ");
                     Put(n);
                     Put_Line(" moves from up to down");
                  end if;
               end if;
            else -- Down shaft
               if cabins_array(n).floor /= 0 then
                  if HasCabinBelow(n) then
                     Put("Cabin ");
                     Put(n);
                     Put_Line("cannot move since there is a cabin below");
                  else
                     MovesDown(n);
                     Put("=Environment= Cabin ");
                     Put(n);
                     Put_Line(" moves down");
                  end if;
               else
                  if HasCabinAtBottomUpShaft then
                     Put("Cabin ");
                     Put(n);
                     Put_Line("cannot move since there is a cabin at bottom of up shaft");
                  else
                     CabinDownToUp(n);
                     Put("=Environment= Cabin ");
                     Put(n);
                     Put_Line(" moves from down to up");
                  end if;
               end if;
            end if;
         end if;
      end loop;
   end environment;

end Environment_Package;
