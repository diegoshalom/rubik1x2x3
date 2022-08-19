classdef R123
    properties
        state = [[1 2];[1 1];[3 4]];
        moves = '';
        statestr = num2str([1 1 3 2 1 4])
        distance = 0
    end
    methods(Static)

    end
    methods 
        function self = move(self,indmove)
            % 3 posibles movimientos R, D, U
            % como fijo el cubito 2 [izda,medio], no tengo movimiento de L
            switch upper(indmove)
            case 'R'
                self.state([4,6]) =  self.state([6,4]);
                self.state([5]) =  -self.state([5]);
            case 'D'
                self.state([3,6]) =  self.state([6,3]);
            case 'U'
                self.state([1,4]) =  self.state([4,1]);
            end
            self.statestr = num2str(self.state(:)');
            self.moves(end+1) = indmove; 
            self.distance = self.distance+1; 
        end

        function out = checksol(self)
            solstate = [[1 2];[1 1];[3 4]];
            out = all((solstate(:)-self.state(:))==0);
        end  
        function showstate(self)
            fprintf('%2d %2d\n',self.state([1,4]))
            fprintf('%2d %2d\n',self.state([2,5]))            
            fprintf('%2d %2d\n',self.state([3,6]))            
        end
    end
end