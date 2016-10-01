with Text_IO;
use Text_IO;

package body AdaptiveQuad is
	function SimpsonsRule(A: Float; B: Float) return Float is
		C: Float := (A + B) / 2.0;
		H3: Float := (abs (B - A)) / 6.0;
	begin
		return H3 * (F(A) + 4.0 * F(C) + F(B));
	end SimpsonsRule;


	function RecAQuad(A: Float; B: Float; Eps: Float; Whole: Float) return Float is
		C: Float := (A + B) / 2.0;
		Left: Float;
		Right: Float;
		task type AQuadTask is
			entry Start(A, B, Eps, Whole: in Float);
			entry Get(ResultIn: out Float);
		end AQuadTask;

		task body AQuadTask is
			StartP: Float;
			EndP: Float;
			Epsilon: Float;
			Full: Float;
			Result: Float;
		begin
			select
				accept Start(A, B, Eps, Whole: in Float) do
					StartP:= A;
					EndP:= B;
					Epsilon:= Eps;
					Full:= Whole;
				end Start;
			or
				terminate;
			end select;

			Result:= RecAQuad(StartP, EndP, Epsilon, Full);

			select
				accept Get(ResultIn: out Float) do
					ResultIn:= Result;
				end Get;
			or
				terminate;
			end select;
		end AQuadTask;

		TLeft: AQuadTask;
		TRight: AQuadTask;
		LeftResult: Float;
		RightResult: Float;
	begin
		Left:= SimpsonsRule(A, C);
		Right:= SimpsonsRule(C, B);

		if (abs (Left + Right - Whole)) <= (15.0 * eps) then
			return Left + Right + ((Left + Right - Whole) / 15.0);
		else
			TLeft.Start(A, C, Eps / 2.0, Left);
			TRight.Start(C, B, Eps / 2.0, Right);

			TLeft.Get(LeftResult);
			TRight.Get(RightResult);
			return LeftResult + RightResult;
		end if;
	end RecAQuad;

	function AQuad(A: Float; B: Float; Eps: Float) return Float is
	begin
		return RecAQuad(A, B, Eps, SimpsonsRule(A, B));
	end AQuad;
end AdaptiveQuad;
