if exists("loaded_rosed")
  finish
endif
let loaded_rosed = 1

let s:save_cpo=&cpo
set cpo&vim

command -nargs=* Rosed :call Rosed(<f-args>)

function! Rosed(package, filename)
python << EOF
import rospkg
import os


def python_input(message='input'):
    vim.command('call inputsave()')
    vim.command("let user_input = input('" + message + ": ')")
    vim.command('call inputrestore()')
    return vim.eval('user_input')


def get_file_paths(package_name, file_name):
    try:
        package_path = rospkg.RosPack().get_path(package_name)
    except rospkg.ResourceNotFound:
        vim.command('echo "That package does not exist"')
        return

    documents = list()
    for root, dirs, files in os.walk(package_path):
        for candidate_file in files:
            if file_name == candidate_file:
                documents.append(os.path.join(root, file_name))

    if not documents:
        vim.command('echo "That file does not exist in that package"')
        return
    elif len(documents) > 1:
        options = '\n'.join(('{}) {}'.format(i+1, file_name)
                             for i, file_name in enumerate(documents)))
        prompt = ('You have chosen a non-unique filename, '
                  'please pick one of the following:\n{}\n#? '
                  .format(options))
        choice = python_input(prompt)
        try:
            choice = int(choice) - 1
            document = documents[choice]
        except (ValueError, IndexError):
            return
    else:
        document = documents[0]

    # Open up the document in a tab.
    vim.command('tabedit {}'.format(document))

get_file_paths(vim.eval('a:package'), vim.eval('a:filename'))
EOF
endfunction
