Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2804E6FA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfD2PzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 11:55:18 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47432 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728578AbfD2PzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 11:55:18 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Apr 2019 18:55:15 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3TFtF7n025539;
        Mon, 29 Apr 2019 18:55:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 2/4] pyverbs: Changes to print-related functions
Date:   Mon, 29 Apr 2019 18:55:11 +0300
Message-Id: <20190429155513.30543-3-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429155513.30543-1-noaos@mellanox.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- Instead of writing the flags one after another, print a single
  flag per line. This will be easier to read in case there are more
  than one or two flags.
- Add missing spaces between module functions.
- Avoid using 'except' and limit it to a specific exception type.
- When translating enum values, avoid exceptions by returning a
  default value in case of a KeyError (e.g. 'Invalid state').
- Replace the numeric representation of the device_cap_flags field
  e.g. instead of:
  device_cap_flags:               0xed721c36
  have:
  Device cap flags      :
  IBV_DEVICE_BAD_PKEY_CNTR
  IBV_DEVICE_BAD_QKEY_CNTR
  IBV_DEVICE_AUTO_PATH_MIG
  IBV_DEVICE_CHANGE_PHY_PORT
  IBV_DEVICE_PORT_ACTIVE_EVENT
  IBV_DEVICE_SYS_IMAGE_GUID
  IBV_DEVICE_RC_RNR_NAK_GEN
  IBV_DEVICE_MEM_WINDOW
  IBV_DEVICE_XRC
  IBV_DEVICE_MEM_MGT_EXTENSIONS
  IBV_DEVICE_MEM_WINDOW_TYPE_2B
  IBV_DEVICE_RAW_IP_CSUM
  IBV_DEVICE_MANAGED_FLOW_STEERING

Change-Id: I85b0e49c188bd164e4f815bf4cc9e543b94f0f77
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/device.pyx | 87 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index e953b7fc2eaf..72acc4d2829f 100644
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -334,7 +334,8 @@ cdef class DeviceAttr(PyverbsObject):
             print_format.format('HW version', self.hw_ver) +\
             print_format.format('Max QP', self.max_qp) +\
             print_format.format('Max QP WR', self.max_qp_wr) +\
-            print_format.format('Device cap flags', self.device_cap_flags) +\
+            print_format.format('Device cap flags',
+                                translate_device_caps(self.device_cap_flags)) +\
             print_format.format('Max SGE', self.max_sge) +\
             print_format.format('Max SGE RD', self.max_sge_rd) +\
             print_format.format('MAX CQ', self.max_cq) +\
@@ -702,6 +703,7 @@ cdef class PortAttr(PyverbsObject):
             print_format.format('Phys state', phys_state_to_str(self.attr.phys_state)) +\
             print_format.format('Flags', self.attr.flags)
 
+
 def guid_format(num):
     """
     Get GUID representation of the given number, including change of endianness.
@@ -714,38 +716,51 @@ def guid_format(num):
     hex_array = [''.join(x) for x in zip(hex_array[0::2], hex_array[1::2])]
     return ':'.join(hex_array)
 
+
 def translate_transport_type(transport_type):
-    return {-1:'UNKNOWN', 0:'IB', 1:'IWARP', 2:'USNIC',
-            3:'USNIC_UDP'}[transport_type]
+    l = {0: 'IB', 1: 'IWARP', 2: 'USNIC', 3: 'USNIC UDP'}
+    try:
+        return l[transport_type]
+    except KeyError:
+        return 'Unknown'
+
 
 def translate_node_type(node_type):
-    return {-1:'UNKNOWN', 1:'CA', 2:'SWITCH', 3:'ROUTER',
-            4:'RNIC', 5:'USNIC', 6:'USNIC_UDP'}[node_type]
+    l = {1: 'CA', 2: 'Switch', 3: 'Router', 4: 'RNIC', 5: 'USNIC',
+         6: 'USNIC UDP'}
+    try:
+        return l[node_type]
+    except KeyError:
+        return 'Unknown'
+
 
 def guid_to_hex(node_guid):
     return hex(node_guid).replace('L', '').replace('0x', '')
 
+
 def port_state_to_str(port_state):
-    l = {0: 'NOP', 1: 'Down', 2: 'Init', 3: 'Armed',4: 'Active',
-         5: 'Active defer'}
+    l = {0: 'NOP', 1: 'Down', 2: 'Init', 3: 'Armed', 4: 'Active', 5: 'Defer'}
     try:
-        return '{s} ({n})'.format(s=l[port_state], n=port_state)
-    except:
-        return 'Invalid state'
+        return '{s} ({n})'.format(s=l[port_state].name, n=port_state)
+    except KeyError:
+        return 'Invalid state ({s})'.format(s=port_state)
+
 
 def translate_mtu(mtu):
     l = {1: 256, 2: 512, 3: 1024, 4: 2048, 5: 4096}
     try:
         return '{s} ({n})'.format(s=l[mtu], n=mtu)
-    except:
-        return 'Invalid MTU'
+    except KeyError:
+        return 'Invalid MTU ({m})'.format(m=mtu)
+
 
 def translate_link_layer(ll):
     l = {0: 'Unspecified', 1:'InfiniBand', 2:'Ethernet'}
     try:
         return l[ll]
-    except:
-        return 'Invalid link layer {ll}'.format(ll=ll)
+    except KeyError:
+        return 'Invalid link layer ({ll})'.format(ll=ll)
+
 
 def translate_port_cap_flags(flags):
     l = {e.IBV_PORT_SM: 'IBV_PORT_SM',
@@ -774,6 +789,7 @@ def translate_port_cap_flags(flags):
          e.IBV_PORT_IP_BASED_GIDS: 'IBV_PORT_IP_BASED_GIDS'}
     return str_from_flags(flags, l)
 
+
 def translate_port_cap_flags2(flags):
     l = {e.IBV_PORT_SET_NODE_DESC_SUP: 'IBV_PORT_SET_NODE_DESC_SUP',
          e.IBV_PORT_INFO_EXT_SUP: 'IBV_PORT_INFO_EXT_SUP',
@@ -783,38 +799,71 @@ def translate_port_cap_flags2(flags):
          e.IBV_PORT_LINK_SPEED_HDR_SUP: 'IBV_PORT_LINK_SPEED_HDR_SUP'}
     return str_from_flags(flags, l)
 
+
+def translate_device_caps(flags):
+    l = {e.IBV_DEVICE_RESIZE_MAX_WR: 'IBV_DEVICE_RESIZE_MAX_WR',
+         e.IBV_DEVICE_BAD_PKEY_CNTR: 'IBV_DEVICE_BAD_PKEY_CNTR',
+         e.IBV_DEVICE_BAD_QKEY_CNTR: 'IBV_DEVICE_BAD_QKEY_CNTR',
+         e.IBV_DEVICE_RAW_MULTI: 'IBV_DEVICE_RAW_MULTI',
+         e.IBV_DEVICE_AUTO_PATH_MIG: 'IBV_DEVICE_AUTO_PATH_MIG',
+         e.IBV_DEVICE_CHANGE_PHY_PORT: 'IBV_DEVICE_CHANGE_PHY_PORT',
+         e.IBV_DEVICE_UD_AV_PORT_ENFORCE: 'IBV_DEVICE_UD_AV_PORT_ENFORCE',
+         e.IBV_DEVICE_CURR_QP_STATE_MOD: 'IBV_DEVICE_CURR_QP_STATE_MOD',
+         e.IBV_DEVICE_SHUTDOWN_PORT: 'IBV_DEVICE_SHUTDOWN_PORT',
+         e.IBV_DEVICE_INIT_TYPE: 'IBV_DEVICE_INIT_TYPE',
+         e.IBV_DEVICE_PORT_ACTIVE_EVENT: 'IBV_DEVICE_PORT_ACTIVE_EVENT',
+         e.IBV_DEVICE_SYS_IMAGE_GUID: 'IBV_DEVICE_SYS_IMAGE_GUID',
+         e.IBV_DEVICE_RC_RNR_NAK_GEN: 'IBV_DEVICE_RC_RNR_NAK_GEN',
+         e.IBV_DEVICE_SRQ_RESIZE: 'IBV_DEVICE_SRQ_RESIZE',
+         e.IBV_DEVICE_N_NOTIFY_CQ: 'IBV_DEVICE_N_NOTIFY_CQ',
+         e.IBV_DEVICE_MEM_WINDOW: 'IBV_DEVICE_MEM_WINDOW',
+         e.IBV_DEVICE_UD_IP_CSUM: 'IBV_DEVICE_UD_IP_CSUM',
+         e.IBV_DEVICE_XRC: 'IBV_DEVICE_XRC',
+         e.IBV_DEVICE_MEM_MGT_EXTENSIONS: 'IBV_DEVICE_MEM_MGT_EXTENSIONS',
+         e.IBV_DEVICE_MEM_WINDOW_TYPE_2A: 'IBV_DEVICE_MEM_WINDOW_TYPE_2A',
+         e.IBV_DEVICE_MEM_WINDOW_TYPE_2B: 'IBV_DEVICE_MEM_WINDOW_TYPE_2B',
+         e.IBV_DEVICE_RC_IP_CSUM: 'IBV_DEVICE_RC_IP_CSUM',
+         e.IBV_DEVICE_RAW_IP_CSUM: 'IBV_DEVICE_RAW_IP_CSUM',
+         e.IBV_DEVICE_MANAGED_FLOW_STEERING: 'IBV_DEVICE_MANAGED_FLOW_STEERING'}
+    return str_from_flags(flags, l)
+
+
 def str_from_flags(flags, dictionary):
-    str_flags = ""
+    str_flags = "\n  "
     for bit in dictionary:
         if flags & bit:
             str_flags += dictionary[bit]
-            str_flags += ' '
+            str_flags += '\n  '
     return str_flags
 
+
 def phys_state_to_str(phys):
     l =  {1: 'Sleep', 2: 'Polling', 3: 'Disabled',
           4: 'Port configuration training', 5: 'Link up',
           6: 'Link error recovery', 7: 'Phy test'}
     try:
         return '{s} ({n})'.format(s=l[phys], n=phys)
-    except:
+    except KeyError:
         return 'Invalid physical state'
 
+
 def width_to_str(width):
     l = {1: '1X', 2: '4X', 4: '8X', 16: '2X'}
     try:
         return '{s} ({n})'.format(s=l[width], n=width)
-    except:
+    except KeyError:
         return 'Invalid width'
 
+
 def speed_to_str(speed):
     l = {1: '2.5 Gbps', 2: '5.0 Gbps', 4: '5.0 Gbps', 8: '10.0 Gbps',
          16: '14.0 Gbps', 32: '25.0 Gbps', 64: '50.0 Gbps'}
     try:
         return '{s} ({n})'.format(s=l[speed], n=speed)
-    except:
+    except KeyError:
         return 'Invalid speed'
 
+
 def get_device_list():
     """
     :return: list of IB_devices on current node
-- 
2.17.2

