function [vector] = HOG_vector(cell, Gabs, Gtheta);
Hog_vector = zeros(1,9);

[width, height] = size(Gabs);

for m = 1: width
    for n = 1: height
        if Gtheta(m,n) >= 1 && Gtheta(m,n) <= 20
            Hog_vector(1,1) = Hog_vector(1,1) +((20 - Gtheta(m,n))/20) *Gabs(m,n);
            Hog_vector(1,2) = Hog_vector(1,2) +(Gtheta(m,n)/20) *Gabs(m,n);
                
        elseif Gtheta(m,n) >= 21 && Gtheta(m,n) <= 40
            if Gtheta(m,n) <= 30
                Hog_vector(1,1) = Hog_vector(1,1) + ((20 - Gtheta(m,n)) / 20) * Gabs(m,n);
                Hog_vector(1,2) = Hog_vector(1,2) + (Gtheta(m,n) / 20)* Gabs(m,n);
            else
                Hog_vector(1,2) = Hog_vector(1,2) + ((40 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,3) = Hog_vector(1,3) + ((Gtheta(m,n) - 20) / 20) * Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 41 && Gtheta(m,n) <= 60
            if Gtheta(m,n) <= 50
                Hog_vector(1,2) = Hog_vector(1,2) + ((40 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,3) = Hog_vector(1,3) + ((Gtheta(m,n) - 20) / 20)* Gabs(m,n);
            else
                Hog_vector(1,3) = Hog_vector(1,3) + ((60 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,4) = Hog_vector(1,4) + ((Gtheta(m,n) - 40) / 20)* Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 61 && Gtheta(m,n) <= 80
            if Gtheta(m,n) <= 70
                Hog_vector(1,3) = Hog_vector(1,3) + ((60 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,4) = Hog_vector(1,4) + ((Gtheta(m,n) - 40) / 20)* Gabs(m,n);
            else
                Hog_vector(1,4) = Hog_vector(1,4) + ((80 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,5) = Hog_vector(1,5) + ((Gtheta(m,n) - 60) / 20)* Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 81 && Gtheta(m,n) <= 100
            if Gtheta(m,n) <= 90
                Hog_vector(1,4) = Hog_vector(1,4) + ((80 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,5) = Hog_vector(1,5) + ((Gtheta(m,n) - 60) / 20) * Gabs(m,n);
            else
                Hog_vector(1,5) = Hog_vector(1,5) + ((100 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,6) = Hog_vector(1,6) + ((Gtheta(m,n) - 80) / 20)* Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 101 && Gtheta(m,n) <= 120
            if Gtheta(m,n) <= 110
                Hog_vector(1,5) = Hog_vector(1,5) + ((100 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,6) = Hog_vector(1,6) + ((Gtheta(m,n) - 80) / 20)* Gabs(m,n);
            else
                Hog_vector(1,6) = Hog_vector(1,6) + double((120 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,7) = Hog_vector(1,7) + double((Gtheta(m,n) - 100) / 20)* Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 121 && Gtheta(m,n) <= 140
            if Gtheta(m,n) <= 130
                Hog_vector(1,6) = Hog_vector(1,6) + ((120 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,7) = Hog_vector(1,7) + ((Gtheta(m,n) - 100) / 20)* Gabs(m,n);
            else
                Hog_vector(1,7) = Hog_vector(1,7) + ((140 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,8) = Hog_vector(1,8) + ((Gtheta(m,n) - 120) / 20)* Gabs(m,n);
            end
        elseif Gtheta(m,n) >= 141 && Gtheta(m,n) <= 160
            if Gtheta(m,n) <= 150
                Hog_vector(1,7) = Hog_vector(1,7) + ((140 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,8) = Hog_vector(1,8) + ((Gtheta(m,n) - 120) / 20)* Gabs(m,n);
            else
                Hog_vector(1,8) = Hog_vector(1,8) + ((160 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,9) = Hog_vector(1,9) + ((Gtheta(m,n) - 140) / 20)* Gabs(m,n);
            end
        else
                Hog_vector(1,8) = Hog_vector(1,8) + ((160 - Gtheta(m,n)) / 20)* Gabs(m,n);
                Hog_vector(1,9) = Hog_vector(1,9) + ((Gtheta(m,n) - 140) / 20)* Gabs(m,n);
            end
        end
    end
    
    vector = Hog_vector;
end