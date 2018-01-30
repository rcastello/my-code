import sys

# Allow to limit the length of the list being printed out, by
# supplying a command line argument
# There is no need to understand this bit; it is not part of the exercise
try:
    limit = int(sys.argv[1])
except IndexError:
    limit = sys.maxint+1
except ValueError:
    print "\nThe command line argument must be an integer\n"
    sys.exit()


########################################################################
# The first solution
print "\nThe explicit version:"
########################################################################
passwds = open('/etc/passwd', 'r')
pairs = []
for line in passwds:
    line = line.split(':')
    userid, username = int(line[2]), line[0]
    pairs.append((userid, username))
pairs.sort()
result = []
for pair in pairs:
    result.append(pair[1])
print result[:limit]


########################################################################
# While the following is terse, most people would consider the former
# clearer. You shold try to find a happy balance between brevity and
# long-windedness.
print "\nThe three-line version:"
########################################################################
pairs = [ (lambda l:(int(l[2]),l[0]))(line.split(':',3))
          for line in open('/etc/passwd', 'r') ]
pairs.sort()
print [ pair[1] for pair in pairs[:limit] ]


########################################################################
# in python2.4 or later
major, minor = sys.version_info[:2]
if major>=2 and minor >=4:
#  you can to do it all in one (long, incomprehensible) line:
    print "\nThe one-line version:"
########################################################################
    [ pair[1] for pair in sorted([ (lambda l:(int(l[2]),l[0]))(line.split(':',3))  for line in open('/etc/passwd', 'r') ])[:limit]]


########################################################################
# An INCORRECT solution
print "\nNote that the order is wrong if you forget to corvert to int:"
########################################################################
pairs = [ (lambda l:(l[2],l[0]))(line.split(':',3))
          for line in open('/etc/passwd', 'r') ]
pairs.sort()
print [ pair[1] for pair in pairs[:limit] ]
    
