from cmind import utils
import os

def preprocess(i):
    os_info = i['os_info']

    env = i['env']

    state = i['state']

    import json
    print (json.dump(env, indent=2))
    input('xyz')

    print ('')
    print ('Current directory: {}'.format(os.getcwd()))

    print ('')

    extra = ''
    if env.get('CM_ABTF_NUM_CLASSES', '')!='':
        extra +=' --num-classes '+str(env['CM_ABTF_NUM_CLASSES'])

    if extra!='':
        print ('')
        print ('Extra command line: {}'.format(extra))

    env['CM_ABTF_EXTRA_CMD'] = extra

    return {'return':0}

def postprocess(i):

    return {'return':0}