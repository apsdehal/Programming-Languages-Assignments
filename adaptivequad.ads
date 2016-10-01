generic
	with function F(X: Float) return Float;

package AdaptiveQuad is
	function SimpsonsRule(A, B: Float) return Float;
	function AQuad(A, B, Eps: Float) return Float;
	function RecAQuad(A, B, Eps, Whole: Float) return Float;
end AdaptiveQuad;
