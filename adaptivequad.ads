generic
	with function F(X: Float) return Float;

package AdaptiveQuad is
	function SimpsonsRule(A, B: in Float) return Float;
	function AQuad(A, B, Eps: in Float) return Float;
	function RecAQuad(A, B, Eps, Whole: in Float) return Float;
end AdaptiveQuad;
