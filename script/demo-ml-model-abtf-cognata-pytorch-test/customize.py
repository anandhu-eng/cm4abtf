from cmind import utils
import os

def preprocess(i):
    os_info = i['os_info']

    env = i['env']

    state = i['state']

    print ('')
    print ('Current directory: {}'.format(os.getcwd()))

    print ('')

    extra = ''

    if extra!='':
        print ('')
        print ('Extra command line: {}'.format(extra))

    env['CM_ABTF_EXTRA_CMD'] = extra

    return {'return':0}

def postprocess(i):

    return {'return':0}
