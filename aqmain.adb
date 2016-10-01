with AdaptiveQuad;
with Ada.Float_Text_IO;
with Text_IO;
use Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

procedure AQMain is
	package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
	package FTIO renames Ada.Float_Text_IO;
	use FloatFunctions;

	Epsilon: Float := 0.000001;

	function MyF(A: in Float) return Float is
	begin
		return Sin(A ** 2);
	end MyF;

	package SinSquareAdaptiveQuad is new AdaptiveQuad(MyF);

	task type PrintResult is
		entry Receive(A: in Float; B: in Float; Res: in Float);
	end PrintResult;

	task body PrintResult is
	Result: Float;
	StartPoint: Float;
	EndPoint: Float;
	begin
		loop
			select
				accept Receive(A: in Float; B: in Float; Res: in Float) do
					StartPoint:= A;
					EndPoint:= B;
					Result:= Res;
				end Receive;
			or
				terminate;
			end select;

			Put("The area under sin(x^2) for x = ");
			FTIO.Put(StartPoint);
			Put(" to ");
			FTIO.Put(EndPoint);
			Put(" is ");
			FTIO.Put(Result);
			New_Line;
		end loop;
	end PrintResult;

	task type ComputeArea is
		entry Receive(A: in Float; B: in Float);
	end ComputeArea;

	task body ComputeArea is
	Result: Float;
	StartPoint: Float;
	EndPoint: Float;
	PR: PrintResult;
	begin
		loop
			select
				accept Receive(A: in Float; B: in Float) do
					StartPoint:= A;
					EndPoint:= B;
				end Receive;
			or
				terminate;
			end select;

			Result:= SinSquareAdaptiveQuad.AQuad(StartPoint, EndPoint, Epsilon);
			PR.receive(StartPoint, EndPoint, Result);
		end loop;
	end ComputeArea;

	task ReadPairs;

	task body ReadPairs is
		A: Float;
		B: Float;
		InputCount: Integer := 5;
		CA: ComputeArea;
	begin
		for I in 1 .. InputCount loop
			FTIO.Get(A);
			FTIO.Get(B);
			CA.Receive(A, B);
		end loop;
	end ReadPairs;

begin
	null;
end AQMain;
