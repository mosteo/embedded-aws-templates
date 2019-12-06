with Ada.Calendar;
with Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Eat is

   --  Embedded AWS Templates. We offer here minimal stuff to impersonate
   --  the AWS embedded resource manager. It affords users of EAT to register/
   --  retrieve the embedded resources, without any of the wonderful template
   --  engine processing of Templates Parser

   Unknown_Resource : exception;

   type Data_Access is access constant Ada.Streams.Stream_Element_Array;

   procedure Register (Name : String;
                       Data : not null Data_Access;
                       Date : Ada.Calendar.Time);

   function Get (Name : String) return Data_Access with
     Post =>
       Get'Result /= null or else
       raise Unknown_Resource with "Unknown resource: " & Name;

   function Get (Name : String) return Unbounded_String with
     Post =>
       Length (Get'Result) > 0 or else
       raise Unknown_Resource with "Unknown resource: " & Name;

end Eat;
