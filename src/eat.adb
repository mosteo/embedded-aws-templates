with Ada.Containers.Indefinite_Ordered_Maps;

package body Eat is

   package Maps is new Ada.Containers.Indefinite_Ordered_Maps
     (String, Data_Access);

   Resources : Maps.Map;

   --------------
   -- Register --
   --------------

   procedure Register
     (Name : String; Data : not null Data_Access; Date : Ada.Calendar.Time)
   is
      pragma Unreferenced (Date);
   begin
      Resources.Insert (Name, Data);
   end Register;

   ---------
   -- Get --
   ---------

   function Get (Name : String) return Data_Access is
     (if Resources.Contains (Name)
      then Resources (Name)
      else null);

   ---------
   -- Get --
   ---------

   function Get (Name : String) return Unbounded_String is
      --  This presumes, for a bit of efficiency, that stream elements are same
      --  size as characters. We enforce a check on this just in case.
      pragma Assert (Character'Size = Ada.Streams.Stream_Element'Size);

      Ptr  : constant Data_Access := Get (Name);
      Str  : String (1 .. Ptr'Length)
        with Address => Ptr (Ptr'First)'address;
      Data : Unbounded_String;
   begin
      Set_Unbounded_String (Data, Str);

      return Data;
   end Get;

end Eat;
