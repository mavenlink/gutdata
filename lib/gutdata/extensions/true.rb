# encoding: UTF-8
#
# Copyright (c) 2010-2015 GutData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

class TrueClass
  # +true+ is not duplicable:
  #
  #   true.duplicable? # => false
  #   true.dup         # => TypeError: can't dup TrueClass
  def duplicable?
    false
  end
end
