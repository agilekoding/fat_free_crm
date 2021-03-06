# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
# Take into account current time zone when serializing datetime values
# See: https://rails.lighthouseapp.com/projects/8994/tickets/6096-to_xml-datetime-format-regression

ActiveModel::Serializers::Xml::Serializer::Attribute.class_eval do
  def initialize(name, serializable, raw_value=nil)
    @name, @serializable = name, serializable
    raw_value = raw_value.in_time_zone if raw_value.respond_to?(:in_time_zone)
    @value = raw_value || @serializable.send(name)
    @type  = compute_type
  end
end

