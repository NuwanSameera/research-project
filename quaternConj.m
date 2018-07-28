        function qConj = quaternConj(q)
        %   Converts a quaternion to its conjugate.
            qConj = [q(:,1) -q(:,2) -q(:,3) -q(:,4)];
        end