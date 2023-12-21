local docker = require('docker-nvim')

-- set the workdir to use the current directory when calling docker exec
docker.use_cwd_as_workdir = true

vim.keymap.set("n", "<leader>cp", docker.pick_conatiner)

-- <leader>cb to run build
vim.keymap.set("n", "<leader>cb", function() docker.do_job("bash -c 'source /usr/bin/pre_build_script.sh && ./cmakeBuild.sh -c -r -64 -b -j16 --deploy'") end)
-- <leader>cd to run deploy
vim.keymap.set("n", "<leader>cd", function() docker.do_job("bash -c 'source /usr/bin/pre_build_script.sh && ./dailyOutputCopy.sh -64'") end)
-- <leader>cu to run unit tests
vim.keymap.set("n", "<leader>cu", function() docker.do_job("bash -c 'source /usr/bin/pre_build_script.sh && ./runTests.sh -64 --stages unit'") end)
-- <leader>ci to run integration tests
vim.keymap.set("n", "<leader>ci", function() docker.do_job("bash -c 'source /usr/bin/pre_build_script.sh && ./runTests.sh -64 --stages integration'") end)
-- <leader>cc to prompt user for the command that should be run
vim.keymap.set("n", "<leader>cc", function()
	local command = vim.fn.input('Command: ')
	docker.do_job(command)
end)

