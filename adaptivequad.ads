generic
	with function F(X: Float) return Float;

package AdaptiveQuad is
	function SimpsonsRule(A: Float; B: Float) return Float;
	function AQuad(A: Float; B: Float; Eps: Float) return Float;
	function RecAQuad(A: Float; B: Float; Eps: Float; Whole: Float) return Float;
end AdaptiveQuad;
