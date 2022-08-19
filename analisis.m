%% Resolucion del cubo rubik 1x2x3
% fijo el cubito 2 [izquierda,medio]
% no tengo movimiento de L
% 3 posibles movimientos R, D, U
% La notación de cubitos es una matriz de 3x2: 
%   esquinas: [1|2|3|4] Solo importa la posición. No pueden estar en otra orientación
%   fila del medio: [1|-1] según si está resuelto o no
% El estado resuelto es  [[1 2];[1 1];[3 4]]
% A partir del estado resuelto, voy haciendo todos los movimientos posibles.
% Si se crean estados nuevos, los guardo. Si ya estaban, los tiro.
% Y ahora recorro los estados nuevos creados, y hago movimientos.


%% testeos de la clase
r = R123; %inicializo resuelto
r = r.move('U');
r = r.move('D')
r = r.move('R')
r.showstate()


%% Loop para generar todos los estados posibles
allmoves = 'UDR';
ustates = R123; %unique states
fprintf('Distance #states #states total\n')
fprintf('0  1  1\n')
for distance = 1:6 %itero sobre los movimientos posibles
    %paso por todos los estados unicos guardados hasta ahora
    for inds = 1:length(ustates)        
        %si la distancia es menor a distance-1 es que ya los analicé
        if ustates(inds).distance<distance-1
            continue
        end
        %pruebo todos los movimientos, a ver si creo un estado nuevo
        for indmove = 1:length(allmoves)
            currstate = ustates(inds);
            move = allmoves(indmove);
            % si vuelvo a mover lo mismo que antes, salteo
            if ~isempty(currstate.moves) && move == currstate.moves(end)
                continue
            end
            currstate = currstate.move(move);
            %si el estado después de mover no está en la lista, lo agrego
            if ~ismember(currstate.statestr,{ustates.statestr})
                ustates(end+1) = currstate;
            end
        end        
    end
    fprintf('%d %2d %2d\n',distance,sum([ustates.distance]==distance),length(ustates))
end
figure(1);clf
hist([ustates.distance],0:7)
xlabel('Distancia')
ylabel('Cantidad')
grid on

fprintf('Cantidad total de estados distintos: %d\n',length(ustates))
