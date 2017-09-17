import gdb
import itertools
import re

# Try to use the new-style pretty-printing if available.
_use_gdb_pp = True
try:
    import gdb.printing
except ImportError:
    _use_gdb_pp = False

class SEStringPrinter:
    "Print a slickedit::SEString"
    def __init__ (self, val):
        self.val = val
    def to_string (self):
        ptr = self.val['textBuf']['buffer']
        len = self.val['textBuf']['textLen']
        return ptr.string (len)
    def display_hint (self):
        return 'string'

def sestring_lookup_function (val):
    lookup_tag = val.type.tag
    regex = re.compile ("^slickedit::SEString$")
    if lookup_tag == None:
        return None
    if regex.match (lookup_tag):
        return SEStringPrinter (val)
    return None

class SEArrayPrinter:
    "Print a slickedit::SEArray"

    class _iterator:
        def __init__ (self, start, numItems):
            self.item = start
            self.numItems = numItems
            self.count = 0

        def __iter__(self):
            return self

        def next(self):
            count = self.count
            self.count = self.count + 1
            if self.count >= self.numItems:
                raise StopIteration
            if self.count >= 1000:
                raise StopIteration
            elt = self.item.dereference()
            self.item = self.item + 1
            return ('[%d]' % count, elt)

    def __init__(self, typename, val):
        self.typename = typename
        self.val = val

    def children(self):
        itemtype = self.val.type.template_argument (0)
        firstItem = self.val['mArrayBuf']['mList']
        firstItem = firstItem.cast(itemtype.pointer ())
        numItems = self.val['mArrayBuf']['mNumItems']
        return self._iterator(firstItem, numItems)
                              

    def to_string(self):
        start = self.val['mArrayBuf']['mList'].address
        numItems = self.val['mArrayBuf']['mNumItems']
        return ('%s of length %d' % (self.typename, self.numItems))

    def display_hint(self):
        return 'array'

def searray_lookup_function (val):
    lookup_tag = val.type.tag
    regex = re.compile ("^slickedit::SEArray<.*>$")
    if lookup_tag == None:
        return None
    if regex.match (lookup_tag):
        return SEArrayPrinter (lookup_tag, val)
    return None

def register_slickedit_printers (obj):
    global _use_gdb_pp
    global sestring_lookup_function
    if _use_gdb_pp:
        gdb.printing.register_pretty_printer(obj, sestring_lookup_function)
        gdb.printing.register_pretty_printer(obj, searray_lookup_function)
    else:
        if obj is None:
            obj = gdb
        obj.pretty_printers.append(sestring_lookup_function)
