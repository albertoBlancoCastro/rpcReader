function rmdirOS(inputPath,OS,verbose)


if(exist(inputPath,'dir'))
    if(verbose == 1)
        disp(['Deleting folder ' inputPath]);
    end
    
    if(strcmp(OS,'windows'))
        system(['rmdir ' inputPath]);
    elseif(strcmp(OS,'linux'))
        system(['rm -r ' inputPath]);
    else
        disp('Operating system not defined. Stopping')
        pause;
    end
end

return
