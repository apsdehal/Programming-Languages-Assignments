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
		task AQuadTaskLeft is entry Start;
		end AQuadTaskLeft;

		task body AQuadTaskLeft is
		begin
			select
				accept Start do
					null;
				end Start;
				Left:= RecAQuad(A, C, Eps / 2.0, Left);
			or
				terminate;
			end select;
		end AQuadTaskLeft;

		task AQuadTaskRight is entry Start;
		end AQuadTaskRight;

		task body AQuadTaskRight is
		begin
			select
				accept Start do
					null;
				end Start;
				Right:= RecAQuad(C, B, Eps / 2.0, Right);
			or
				terminate;
			end select;
		end AQuadTaskRight;


	begin
		Left:= SimpsonsRule(A, C);
		Right:= SimpsonsRule(C, B);

		if (abs (Left + Right - Whole)) <= (15.0 * eps) then
			return Left + Right + ((Left + Right - Whole) / 15.0);
		else
			AQuadTaskLeft.Start;
			AQuadTaskRight.Start;
			return Left + Right;
		end if;
	end RecAQuad;

	function AQuad(A: Float; B: Float; Eps: Float) return Float is
	begin
		return RecAQuad(A, B, Eps, SimpsonsRule(A, B));
	end AQuad;
end AdaptiveQuad;
