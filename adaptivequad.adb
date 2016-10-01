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
		task AQuadTaskLeft is entry Start; entry Get(LeftIn: out Float);
		end AQuadTaskLeft;

		task body AQuadTaskLeft is
		begin
			for I in 1 .. 2 loop
				select
					accept Start do
						null;
					end Start;
					Left:= RecAQuad(A, C, Eps / 2.0, Left);
				or
					accept Get(LeftIn: out Float) do
						LeftIn := Left;
					end Get;
				or
					terminate;
				end select;
			end loop;
		end AQuadTaskLeft;

		task AQuadTaskRight is entry Start; entry Get(RightIn: out Float);
		end AQuadTaskRight;

		task body AQuadTaskRight is
		begin
			for I in 1 .. 2 loop
				select
					accept Start do
						null;
					end Start;
					Right:= RecAQuad(C, B, Eps / 2.0, Right);
				or
					accept Get(RightIn: out Float) do
						RightIn := Right;
					end Get;
				or
					terminate;
				end select;
			end loop;
		end AQuadTaskRight;


	begin
		Left:= SimpsonsRule(A, C);
		Right:= SimpsonsRule(C, B);

		if (abs (Left + Right - Whole)) <= (15.0 * eps) then
			return Left + Right + ((Left + Right - Whole) / 15.0);
		else
			AQuadTaskLeft.Start;
			AQuadTaskRight.Start;

			AQuadTaskLeft.Get(Left);
			AQuadTaskRight.Get(Right);
			return Left + Right;
		end if;
	end RecAQuad;

	function AQuad(A: Float; B: Float; Eps: Float) return Float is
	begin
		return RecAQuad(A, B, Eps, SimpsonsRule(A, B));
	end AQuad;
end AdaptiveQuad;
