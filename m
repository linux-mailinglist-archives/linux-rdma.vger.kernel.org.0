Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9514A14F16
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEFPHp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:45 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50074 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727388AbfEFPHo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:44 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:40 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edX019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 01/11] pyverbs: Add support for address handle creation
Date:   Mon,  6 May 2019 18:07:28 +0300
Message-Id: <20190506150738.19477-2-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds the needed classes for Address Handle creation: GRH,
GlobalRoute, AHAttr and AH.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt |   3 +-
 pyverbs/addr.pxd       |  16 +-
 pyverbs/addr.pyx       | 389 +++++++++++++++++++++++++++++++++++++++--
 pyverbs/libibverbs.pxd |  35 ++++
 pyverbs/pd.pxd         |   1 +
 pyverbs/pd.pyx         |   6 +-
 pyverbs/utils.py       |  35 ++++
 7 files changed, 466 insertions(+), 19 deletions(-)
 create mode 100644 pyverbs/utils.py

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 65cd578cdff4..b30793dcbb8f 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -12,9 +12,10 @@ rdma_cython_module(pyverbs
   )
 
 rdma_python_module(pyverbs
-  pyverbs_error.py
   __init__.py
+  pyverbs_error.py
   run_tests.py
+  utils.py
   )
 
 rdma_python_test(pyverbs/tests
diff --git a/pyverbs/addr.pxd b/pyverbs/addr.pxd
index 313cd68fb0d2..389c2d5bdb2e 100644
--- a/pyverbs/addr.pxd
+++ b/pyverbs/addr.pxd
@@ -1,9 +1,23 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPYING file
 
-from .base cimport PyverbsObject
+from .base cimport PyverbsObject, PyverbsCM
 from pyverbs cimport libibverbs as v
 
 
 cdef class GID(PyverbsObject):
     cdef v.ibv_gid gid
+
+cdef class GRH(PyverbsObject):
+    cdef v.ibv_grh grh
+
+cdef class GlobalRoute(PyverbsObject):
+    cdef v.ibv_global_route gr
+
+cdef class AHAttr(PyverbsObject):
+    cdef v.ibv_ah_attr ah_attr
+
+cdef class AH(PyverbsCM):
+    cdef v.ibv_ah *ah
+    cdef object pd
+    cpdef close(self)
diff --git a/pyverbs/addr.pyx b/pyverbs/addr.pyx
index 5713f9392d0f..462a45bc7a4a 100644
--- a/pyverbs/addr.pyx
+++ b/pyverbs/addr.pyx
@@ -1,9 +1,14 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPYING file
 
-import sys
 from libc.stdint cimport uint8_t
+
+from pyverbs.utils import gid_str_to_array, gid_str
 from .pyverbs_error import PyverbsUserError
+from pyverbs.base import PyverbsRDMAErrno
+cimport pyverbs.libibverbs as v
+from pyverbs.pd cimport PD
+from pyverbs.cq cimport WC
 
 cdef extern from 'endian.h':
     unsigned long be64toh(unsigned long host_64bits)
@@ -13,6 +18,13 @@ cdef class GID(PyverbsObject):
     """
     GID class represents ibv_gid. It enables user to query for GIDs values.
     """
+    def __cinit__(self, val=None):
+        if val is not None:
+            vals = gid_str_to_array(val)
+
+            for i in range(16):
+                self.gid.raw[i] = <uint8_t>int(vals[i],16)
+
     @property
     def gid(self):
         """
@@ -29,23 +41,368 @@ cdef class GID(PyverbsObject):
         'xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx'
         :return: None
         """
-        val = val.split(':')
-        if len(val) != 8:
-            raise PyverbsUserError("Invalid GID value ({val})".format(val=val))
-        if any([len(v) != 4 for v in val]):
-            raise PyverbsUserError("Invalid GID value ({val})".format(val=val))
-        val_int = int("".join(val), 16)
-        vals = []
-        for i in range(8):
-            vals.append(val[i][0:2])
-            vals.append(val[i][2:4])
+        self._set_gid(val)
+
+    def _set_gid(self, val):
+        vals = gid_str_to_array(val)
 
         for i in range(16):
             self.gid.raw[i] = <uint8_t>int(vals[i],16)
 
     def __str__(self):
-        hex_values = '%016x%016x' % (be64toh(self.gid._global.subnet_prefix),
-                                   be64toh(self.gid._global.interface_id))
-        return ':'.join([hex_values[0:4], hex_values[4:8], hex_values[8:12],
-                         hex_values[12:16], hex_values[16:20], hex_values[20:24],
-                         hex_values[24:28],hex_values[28:32]])
+        return gid_str(self.gid._global.subnet_prefix,
+                       self.gid._global.interface_id)
+
+
+cdef class GRH(PyverbsObject):
+    """
+    Represents ibv_grh struct. Used when creating or initializing an
+    Address Handle from a Work Completion.
+    """
+    def __cinit__(self, GID sgid=None, GID dgid=None, version_tclass_flow=0,
+                  paylen=0, next_hdr=0, hop_limit=1):
+        """
+        Initializes a GRH object
+        :param sgid: Source GID
+        :param dgid: Destination GID
+        :param version_tclass_flow: A 32b big endian used to communicate
+                                    service level e.g. across subnets
+        :param paylen: A 16b big endian that is the packet length in bytes,
+                       starting from the first byte after the GRH up to and
+                       including the last byte of the ICRC
+        :param next_hdr: An 8b unsigned integer specifying the next header
+                         For non-raw packets: 0x1B
+                         For raw packets: According to IETF RFC 1700
+        :param hop_limit: An 8b unsigned integer specifying the number of hops
+                          (i.e. routers) that the packet is permitted to take
+                          prior to being discarded
+        :return: A GRH object
+        """
+        self.grh.dgid = dgid.gid
+        self.grh.sgid = sgid.gid
+        self.grh.version_tclass_flow = version_tclass_flow
+        self.grh.paylen = paylen
+        self.grh.next_hdr = next_hdr
+        self.grh.hop_limit = hop_limit
+
+    @property
+    def dgid(self):
+        return gid_str(self.grh.dgid._global.subnet_prefix,
+                       self.grh.dgid._global.interface_id)
+    @dgid.setter
+    def dgid(self, val):
+        vals = gid_str_to_array(val)
+        for i in range(16):
+            self.grh.dgid.raw[i] = <uint8_t>int(vals[i],16)
+
+    @property
+    def sgid(self):
+        return gid_str(self.grh.sgid._global.subnet_prefix,
+                       self.grh.sgid._global.interface_id)
+    @sgid.setter
+    def sgid(self, val):
+        vals = gid_str_to_array(val)
+        for i in range(16):
+            self.grh.sgid.raw[i] = <uint8_t>int(vals[i],16)
+
+    @property
+    def version_tclass_flow(self):
+        return self.grh.version_tclass_flow
+
+    @version_tclass_flow.setter
+    def version_tclass_flow(self, val):
+        self.grh.version_tclass_flow = val
+
+    @property
+    def paylen(self):
+        return self.grh.paylen
+    @paylen.setter
+    def paylen(self, val):
+        self.grh.paylen = val
+
+    @property
+    def next_hdr(self):
+        return self.grh.next_hdr
+    @next_hdr.setter
+    def next_hdr(self, val):
+        self.grh.next_hdr = val
+
+    @property
+    def hop_limit(self):
+        return self.grh.hop_limit
+    @hop_limit.setter
+    def hop_limit(self, val):
+        self.grh.hop_limit = val
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('DGID', self.dgid) +\
+               print_format.format('SGID', self.sgid) +\
+               print_format.format('version tclass flow', self.version_tclass_flow) +\
+               print_format.format('paylen', self.paylen) +\
+               print_format.format('next header', self.next_hdr) +\
+               print_format.format('hop limit', self.hop_limit)
+
+
+cdef class GlobalRoute(PyverbsObject):
+    """
+    Represents ibv_global_route. Used in Address Handle creation and describes
+    the values to be used in the GRH of the packets that will be sent using
+    this Address Handle.
+    """
+    def __cinit__(self, GID dgid=None, flow_label=0, sgid_index=0, hop_limit=1,
+                  traffic_class=0):
+        """
+        Initializes a GlobalRoute object with given parameters.
+        :param dgid: Destination GID
+        :param flow_label: A 20b value. If non-zero, gives a hint to switches
+                           and routers that this sequence of packets must be
+                           delivered in order
+        :param sgid_index: An index in the port's GID table that identifies the
+                           originator of the packet
+        :param hop_limit: An 8b unsigned integer specifying the number of hops
+                          (i.e. routers) that the packet is permitted to take
+                          prior to being discarded
+        :param traffic_class: An 8b unsigned integer specifying the required
+                              delivery priority for routers
+        :return: A GlobalRoute object
+        """
+        self.gr.dgid=dgid.gid
+        self.gr.flow_label = flow_label
+        self.gr.sgid_index = sgid_index
+        self.gr.hop_limit = hop_limit
+        self.gr.traffic_class = traffic_class
+
+    @property
+    def dgid(self):
+        return gid_str(self.gr.dgid._global.subnet_prefix,
+                       self.gr.dgid._global.interface_id)
+    @dgid.setter
+    def dgid(self, val):
+        vals = gid_str_to_array(val)
+        for i in range(16):
+            self.gr.dgid.raw[i] = <uint8_t>int(vals[i],16)
+
+    @property
+    def flow_label(self):
+        return self.gr.flow_label
+    @flow_label.setter
+    def flow_label(self, val):
+        self.gr.flow_label = val
+
+    @property
+    def sgid_index(self):
+        return self.gr.sgid_index
+    @sgid_index.setter
+    def sgid_index(self, val):
+        self.gr.sgid_index = val
+
+    @property
+    def hop_limit(self):
+        return self.gr.hop_limit
+    @hop_limit.setter
+    def hop_limit(self, val):
+        self.gr.hop_limit = val
+
+    @property
+    def traffic_class(self):
+        return self.gr.traffic_class
+    @traffic_class.setter
+    def traffic_class(self, val):
+        self.gr.traffic_class = val
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('DGID', self.dgid) +\
+               print_format.format('flow label', self.flow_label) +\
+               print_format.format('sgid index', self.sgid_index) +\
+               print_format.format('hop limit', self.hop_limit) +\
+               print_format.format('traffic class', self.traffic_class)
+
+
+cdef class AHAttr(PyverbsObject):
+    """ Represents ibv_ah_attr struct """
+    def __cinit__(self, dlid=0, sl=0, src_path_bits=0, static_rate=0,
+                  is_global=0, port_num=1, GlobalRoute gr=None):
+        """
+        Initializes an AHAttr object.
+        :param dlid: Destination LID, a 16b unsigned integer
+        :param sl: Service level, an 8b unsigned integer
+        :param src_path_bits: When LMC (LID mask count) is used in the port,
+                              packets are being sent with the port's base LID,
+                              bitwise ORed with the value of the src_path_bits.
+                              An 8b unsigned integer
+        :param static_rate: An 8b unsigned integer limiting the rate of packets
+                            that are being sent to the subnet
+        :param is_global: If non-zero, GRH information exists in the Address
+                          Handle
+        :param port_num: The local physical port from which the packets will be
+                         sent
+        :param grh: Attributes of a global routing header. Will only be used if
+                    is_global is non zero.
+        :return: An AHAttr object
+        """
+        self.ah_attr.port_num = port_num
+        self.ah_attr.sl = sl
+        self.ah_attr.src_path_bits = src_path_bits
+        self.ah_attr.dlid = dlid
+        self.ah_attr.static_rate = static_rate
+        self.ah_attr.is_global = is_global
+        # Do not set GRH fields for a non-global AH
+        if is_global:
+            if gr is None:
+                raise PyverbsUserError('Global AH Attr is created but gr parameter is None')
+            self.ah_attr.grh.dgid = gr.gr.dgid
+            self.ah_attr.grh.flow_label = gr.flow_label
+            self.ah_attr.grh.sgid_index = gr.sgid_index
+            self.ah_attr.grh.hop_limit = gr.hop_limit
+            self.ah_attr.grh.traffic_class = gr.traffic_class
+
+    @property
+    def port_num(self):
+        return self.ah_attr.port_num
+    @port_num.setter
+    def port_num(self, val):
+        self.ah_attr.port_num = val
+
+    @property
+    def sl(self):
+        return self.ah_attr.sl
+    @sl.setter
+    def sl(self, val):
+        self.ah_attr.sl = val
+
+    @property
+    def src_path_bits(self):
+        return self.ah_attr.src_path_bits
+    @src_path_bits.setter
+    def src_path_bits(self, val):
+        self.ah_attr.src_path_bits = val
+
+    @property
+    def dlid(self):
+        return self.ah_attr.dlid
+    @dlid.setter
+    def dlid(self, val):
+        self.ah_attr.dlid = val
+
+    @property
+    def static_rate(self):
+        return self.ah_attr.static_rate
+    @static_rate.setter
+    def static_rate(self, val):
+        self.ah_attr.static_rate = val
+
+    @property
+    def is_global(self):
+        return self.ah_attr.is_global
+    @is_global.setter
+    def is_global(self, val):
+        self.ah_attr.is_global = val
+
+    @property
+    def dgid(self):
+        if self.ah_attr.is_global:
+            return gid_str(self.ah_attr.grh.dgid._global.subnet_prefix,
+                           self.ah_attr.grh.dgid._global.interface_id)
+    @dgid.setter
+    def dgid(self, val):
+        if self.ah_attr.is_global:
+            vals = gid_str_to_array(val)
+            for i in range(16):
+                self.ah_attr.grh.dgid.raw[i] = <uint8_t>int(vals[i],16)
+
+    @property
+    def flow_label(self):
+        if self.ah_attr.is_global:
+            return self.ah_attr.grh.flow_label
+    @flow_label.setter
+    def flow_label(self, val):
+        self.ah_attr.grh.flow_label = val
+
+    @property
+    def sgid_index(self):
+        if self.ah_attr.is_global:
+            return self.ah_attr.grh.sgid_index
+    @sgid_index.setter
+    def sgid_index(self, val):
+        self.ah_attr.grh.sgid_index = val
+
+    @property
+    def hop_limit(self):
+        if self.ah_attr.is_global:
+            return self.ah_attr.grh.hop_limit
+    @hop_limit.setter
+    def hop_limit(self, val):
+        self.ah_attr.grh.hop_limit = val
+
+    @property
+    def traffic_class(self):
+        if self.ah_attr.is_global:
+            return self.ah_attr.grh.traffic_class
+    @traffic_class.setter
+    def traffic_class(self, val):
+        self.ah_attr.grh.traffic_class = val
+
+    def __str__(self):
+        print_format = '  {:22}: {:<20}\n'
+        if self.is_global:
+            global_format = print_format.format('dgid', self.dgid) +\
+                            print_format.format('flow label', self.flow_label) +\
+                            print_format.format('sgid index', self.sgid_index) +\
+                            print_format.format('hop limit', self.hop_limit) +\
+                            print_format.format('traffic_class', self.traffic_class)
+        else:
+            global_format = ''
+        return print_format.format('port num', self.port_num) +\
+               print_format.format('sl', self.sl) +\
+               print_format.format('source path bits', self.src_path_bits) +\
+               print_format.format('dlid', self.dlid) +\
+               print_format.format('static rate', self.static_rate) +\
+               print_format.format('is global', self.is_global) + global_format
+
+
+cdef class AH(PyverbsCM):
+    def __cinit__(self, PD pd, **kwargs):
+        """
+        Initializes an AH object with the given values.
+        Two creation methods are supported:
+        - Creation via AHAttr object (calls ibv_create_ah)
+        - Creation via a WC object (calls ibv_create_ah_from_wc)
+        :param pd: PD object this AH belongs to
+        :param kwargs: Arguments:
+           * *attr* (AHAttr)
+               An AHAttr object (represents ibv_ah_attr struct)
+            * *wc*
+               A WC object to use for AH initialization
+            * *grh*
+               A GRH object to use for AH initialization (when using wc)
+            * *port_num*
+               Port number to be used for this AH (when using wc)
+        :return: An AH object on success
+        """
+        if len(kwargs) == 1:
+            # Create AH via ib_create_ah
+            ah_attr = <AHAttr>kwargs['attr']
+            self.ah = v.ibv_create_ah(pd.pd, &ah_attr.ah_attr)
+        else:
+            # Create AH from WC
+            wc = <WC>kwargs['wc']
+            grh = <GRH>kwargs['grh']
+            port_num = kwargs['port_num']
+            self.ah = v.ibv_create_ah_from_wc(pd.pd, &wc.wc, &grh.grh, port_num)
+        if self.ah == NULL:
+            raise PyverbsRDMAErrno('Failed to create AH')
+        pd.add_ref(self)
+        self.pd = pd
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        self.logger.debug('Closing AH')
+        if self.ah != NULL:
+            if v.ibv_destroy_ah(self.ah):
+                raise PyverbsRDMAErrno('Failed to destroy AH')
+            self.ah = NULL
+            self.pd = None
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 979022069887..118d9ea2c2d4 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -228,6 +228,35 @@ cdef extern from 'infiniband/verbs.h':
         unsigned long   tag
         unsigned int    priv
 
+    cdef struct ibv_grh:
+        unsigned int    version_tclass_flow
+        unsigned short    paylen
+        unsigned char    next_hdr
+        unsigned char    hop_limit
+        ibv_gid         sgid
+        ibv_gid         dgid
+
+    cdef struct ibv_global_route:
+        ibv_gid         dgid
+        unsigned int    flow_label
+        unsigned char    sgid_index
+        unsigned char    hop_limit
+        unsigned char    traffic_class
+
+    cdef struct ibv_ah_attr:
+        ibv_global_route    grh
+        unsigned short        dlid
+        unsigned char        sl
+        unsigned char        src_path_bits
+        unsigned char        static_rate
+        unsigned char        is_global
+        unsigned char        port_num
+
+    cdef struct ibv_ah:
+        ibv_context         *context
+        ibv_pd              *pd
+        unsigned int        handle
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
@@ -287,3 +316,9 @@ cdef extern from 'infiniband/verbs.h':
     unsigned int ibv_wc_read_flow_tag(ibv_cq_ex *cq)
     void ibv_wc_read_tm_info(ibv_cq_ex *cq, ibv_wc_tm_info *tm_info)
     unsigned long ibv_wc_read_completion_wallclock_ns(ibv_cq_ex *cq)
+    ibv_ah *ibv_create_ah(ibv_pd *pd, ibv_ah_attr *attr)
+    int ibv_init_ah_from_wc(ibv_context *context, uint8_t port_num,
+                            ibv_wc *wc, ibv_grh *grh, ibv_ah_attr *ah_attr)
+    ibv_ah *ibv_create_ah_from_wc(ibv_pd *pd, ibv_wc *wc, ibv_grh *grh,
+                                  uint8_t port_num)
+    int ibv_destroy_ah(ibv_ah *ah)
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index fc2e405600d0..0b8fb10e6c67 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -11,3 +11,4 @@ cdef class PD(PyverbsCM):
     cdef add_ref(self, obj)
     cdef object mrs
     cdef object mws
+    cdef object ahs
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 65cc851b0ecf..c2164f8381bd 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -6,6 +6,7 @@ from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.device cimport Context, DM
 from .mr cimport MR, MW, DMMR
+from pyverbs.addr cimport AH
 
 cdef extern from 'errno.h':
     int errno
@@ -27,6 +28,7 @@ cdef class PD(PyverbsCM):
         self.logger.debug('PD: Allocated ibv_pd')
         self.mrs = weakref.WeakSet()
         self.mws = weakref.WeakSet()
+        self.ahs = weakref.WeakSet()
 
     def __dealloc__(self):
         """
@@ -44,7 +46,7 @@ cdef class PD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing PD')
-        self.close_weakrefs([self.mws, self.mrs])
+        self.close_weakrefs([self.ahs, self.mws, self.mrs])
         if self.pd != NULL:
             rc = v.ibv_dealloc_pd(self.pd)
             if rc != 0:
@@ -57,5 +59,7 @@ cdef class PD(PyverbsCM):
             self.mrs.add(obj)
         elif isinstance(obj, MW):
             self.mws.add(obj)
+        elif isinstance(obj, AH):
+            self.ahs.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
diff --git a/pyverbs/utils.py b/pyverbs/utils.py
new file mode 100644
index 000000000000..01adceab568c
--- /dev/null
+++ b/pyverbs/utils.py
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+
+import struct
+
+from pyverbs.pyverbs_error import PyverbsUserError
+
+be64toh = lambda num: struct.unpack('Q', struct.pack('!Q', num))[0]
+
+def gid_str(subnet_prefix, interface_id):
+    hex_values = '%016x%016x' % (be64toh(subnet_prefix), be64toh(interface_id))
+    return ':'.join([hex_values[0:4], hex_values[4:8], hex_values[8:12],
+                     hex_values[12:16], hex_values[16:20], hex_values[20:24],
+                     hex_values[24:28],hex_values[28:32]])
+
+
+def gid_str_to_array(val):
+    """
+    Splits a GID to an array of u8 that can be easily assigned to a GID's raw
+    array.
+    :param val: GID value in 8 words format
+    'xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx'
+    :return: An array of format xx:xx etc.
+    """
+    val = val.split(':')
+    if len(val) != 8:
+        raise PyverbsUserError('Invalid GID value ({val})'.format(val=val))
+    if any([len(v) != 4 for v in val]):
+        raise PyverbsUserError('Invalid GID value ({val})'.format(val=val))
+    val_int = int(''.join(val), 16)
+    vals = []
+    for i in range(8):
+        vals.append(val[i][0:2])
+        vals.append(val[i][2:4])
+    return vals
-- 
2.17.2

