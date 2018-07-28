function [z_k] = computeMeasurmentModel(q, g ,h , a_k, m_k)
    O = [0 0 0; 0 0 0; 0 0 0];
    C_b_n = computeDirectionCosineMatrix(q);
    z_k = [C_b_n O; O C_b_n] * [g ; h] + [a_k; m_k];
end
