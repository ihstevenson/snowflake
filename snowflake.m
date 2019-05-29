
function [xy, trips] = snowflake(A,B,C,lim)

L = 2*lim;

n1 = length(A);
n2 = length(B);
n3 = length(C);

if n1 == 0 || n2 == 0 || n3 == 0
    xy = [];
    trips = [];
    return;
elseif ~issorted(A) || ~issorted(B) || ~issorted(C)
    warning('Input spike times should be sorted')
end

% rough estimate of # of time difference required (assuming independence)
eN = ceil(prod([n1, n2, n3]/max([A(end), B(end), C(end)])) * 2*L * 2);
trips = zeros(eN, 3);

% Compute all the time differences within the range L
lastStartIdx = 1;
lastStartIdxC = 1;
k = 1;
for n = 1:n1
    incIdx = 0;
    incIdxC = 0;
    for m = lastStartIdx:n2
        timeDiff = B(m) - A(n);
        if timeDiff >= -L
            if incIdx==0
                incIdx = m;
            end
            if timeDiff <= L
                for p = lastStartIdxC:n3
                    timeDiffC = C(p) - A(n);
                    if timeDiffC >= -L
                        if incIdxC==0
                            incIdxC = p;
                        end
                    
                        if timeDiffC <= L
                            trips(k,:) = [n m p];
                            k = k + 1;
                        else
                            break;
                        end
                    end
                end               
            else % this is the ending point
                break;
            end
        end
    end
    if incIdx>0
        lastStartIdx = incIdx;
    end
    if incIdxC>0
        lastStartIdxC = incIdxC;
    end
end
trips = trips(1:(k-1),:);
% edges = linspace(Ta,Tb,bin);
% cch = histc(diffs(:,1),edges);

% cartesian coordinates 
trips = trips(abs(B(trips(:,2))-A(trips(:,1)))<lim,:);
trips = trips(abs(C(trips(:,3))-B(trips(:,2)))<lim,:);
trips = trips(abs(A(trips(:,1))-C(trips(:,3)))<lim,:);
xy = [(2*C(trips(:,3))-(A(trips(:,1))+B(trips(:,2))))/sqrt(3) B(trips(:,2))-A(trips(:,1))];