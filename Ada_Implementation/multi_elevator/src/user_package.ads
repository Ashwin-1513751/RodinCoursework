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

--  This package declares the procedures for the user interface of the MULTI
--  elevator simulation.
--
--  @author: htson
--  @version: 1.0
with Button_Package; use Button_Package;
with Door_Package; use Door_Package;
with Cabin_Package; use Cabin_Package;
with Multi; use Multi;
with Floor_Package; use Floor_Package;
with Motor_Package; use Motor_Package;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package User_Package with SPARK_Mode is

   procedure user with
     Global => (Input => (Default_Width,
                          Default_Base),
                In_Out => (File_System,
                          cabins_array,
                          up_buttons_array,
                          down_buttons_array)
               ),
     Pre => Invariants(cabins_array,
                       up_buttons_array,
                       down_buttons_array),
     Post => Invariants(cabins_array,
                          up_buttons_array,
                          down_buttons_array);
end User_Package;
