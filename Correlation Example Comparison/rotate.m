function xy = rotate(angle, combine_variables)

xy = combine_variables*[cos(angle) -sin(angle); sin(angle) cos(angle)];


end