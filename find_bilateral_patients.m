

environment_setup();

task = 'common'; 

% [patients, types] = get_patients('Tasks', {'common', 'auditory'});
% [patients, types] = get_patients('Tasks', {'common'});
[patients, types] = get_patients(); patients = patients(161:end); types = types(161:end);

probesOfInterest = {'TOP1'}; % if LTOP exists, 

patientsOfInterest = false(size(patients));

for p = 1:length(patients)
%     if p < 84; continue; end % TESTING
    
    tic
    
    patient = patients{p};
    type = types{p};
    fprintf('Getting traces for: %s (%d/%d)\n', patient, p, length(patients));
    
    D = get_nk_metadata(paths,patient,task,type);
    
    chnames = D.ch_names;
    
    if all(ismember(probesOfInterest, chnames))
        patientsOfInterest(p) = true;
    end
    
    clearvars D
    
    toc
end
