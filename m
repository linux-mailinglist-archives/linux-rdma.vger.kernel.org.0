Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5066814F15
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfEFPHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50104 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727387AbfEFPHt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:49 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:40 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7eda019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 04/11] pyverbs: Add work requests related classes
Date:   Mon,  6 May 2019 18:07:31 +0300
Message-Id: <20190506150738.19477-5-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds SGE, RecvWR and SendWR classes.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt |   1 +
 pyverbs/libibverbs.pxd |  68 +++++++++
 pyverbs/wr.pxd         |  16 +++
 pyverbs/wr.pyx         | 310 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 pyverbs/wr.pxd
 create mode 100644 pyverbs/wr.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index b7ec880ecd29..9545e5052628 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -9,6 +9,7 @@ rdma_cython_module(pyverbs
   enums.pyx
   mr.pyx
   pd.pyx
+  wr.pyx
   )
 
 rdma_python_module(pyverbs
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 118d9ea2c2d4..33c655f42491 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -257,6 +257,74 @@ cdef extern from 'infiniband/verbs.h':
         ibv_pd              *pd
         unsigned int        handle
 
+    cdef struct ibv_sge:
+        unsigned long   addr
+        unsigned int    length
+        unsigned int    lkey
+
+    cdef struct ibv_recv_wr:
+        unsigned long   wr_id
+        ibv_recv_wr     *next
+        ibv_sge         *sg_list
+        int             num_sge
+
+    cdef struct rdma:
+        unsigned long   remote_addr
+        unsigned int    rkey
+
+    cdef struct atomic:
+        unsigned long   remote_addr
+        unsigned long   compare_add
+        unsigned long   swap
+        unsigned int    rkey
+
+    cdef struct ud:
+        ibv_ah          *ah
+        unsigned int    remote_qpn
+        unsigned int    remote_qkey
+
+    cdef union wr:
+        rdma            rdma
+        atomic          atomic
+        ud              ud
+
+    cdef struct ibv_mw_bind_info:
+        ibv_mr          *mr
+        unsigned long   addr
+        unsigned long   length
+        unsigned int    mw_access_flags
+
+    cdef struct bind_mw:
+        ibv_mw              *mw
+        unsigned int        rkey
+        ibv_mw_bind_info    bind_info
+
+    cdef struct tso:
+        void            *hdr
+        unsigned short  hdr_sz
+        unsigned short  mss
+
+    cdef union unnamed:
+        bind_mw         bind_mw
+        tso             tso
+
+    cdef struct xrc:
+        unsigned int    remote_srqn
+
+    cdef union qp_type:
+        xrc             xrc
+
+    cdef struct ibv_send_wr:
+        unsigned long   wr_id
+        ibv_send_wr     *next
+        ibv_sge         *sg_list
+        int             num_sge
+        ibv_wr_opcode   opcode
+        unsigned int    send_flags
+        wr              wr
+        qp_type         qp_type
+        unnamed         unnamed
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
diff --git a/pyverbs/wr.pxd b/pyverbs/wr.pxd
new file mode 100644
index 000000000000..64b16091116a
--- /dev/null
+++ b/pyverbs/wr.pxd
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+
+from .base cimport PyverbsCM
+from pyverbs cimport libibverbs as v
+
+
+cdef class SGE(PyverbsCM):
+    cdef v.ibv_sge *sge
+    cpdef read(self, length, offset)
+
+cdef class RecvWR(PyverbsCM):
+    cdef v.ibv_recv_wr recv_wr
+
+cdef class SendWR(PyverbsCM):
+    cdef v.ibv_send_wr send_wr
diff --git a/pyverbs/wr.pyx b/pyverbs/wr.pyx
new file mode 100644
index 000000000000..2dc766282db3
--- /dev/null
+++ b/pyverbs/wr.pyx
@@ -0,0 +1,310 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies Inc. All rights reserved. See COPYING file
+
+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
+from pyverbs.base import PyverbsRDMAErrno
+cimport pyverbs.libibverbs_enums as e
+from pyverbs.addr cimport AH
+
+cdef extern from 'stdlib.h':
+    void *malloc(size_t size)
+    void free(void *ptr)
+cdef extern from 'string.h':
+    void *memcpy(void *dest, const void *src, size_t n)
+
+
+cdef class SGE(PyverbsCM):
+    """
+    Represents ibv_sge struct. It has a read function to allow users to keep
+    track of data. Write function is not provided as a scatter-gather element
+    can be using a MR or a DMMR. In case direct (device's) memory is used,
+    write can't be done using memcpy that relies on CPU-specific optimizations.
+    A SGE has no way to tell which memory it is using.
+    """
+    def __cinit__(self, addr, length, lkey):
+        """
+        Initializes a SGE object.
+        :param addr: The address to be used for read/write
+        :param length: Available buffer size
+        :param lkey: Local key of the used MR/DMMR
+        :return: A SGE object
+        """
+        self.sge = <v.ibv_sge*>malloc(sizeof(v.ibv_sge))
+        if self.sge == NULL:
+            raise PyverbsError('Failed to allocate an SGE')
+        self.sge.addr = addr
+        self.sge.length = length
+        self.sge.lkey = lkey
+
+    def __dealloc(self):
+        self.close()
+
+    cpdef close(self):
+        free(self.sge)
+
+    cpdef read(self, length, offset):
+        """
+        Reads <length> bytes of data starting at <offset> bytes from the
+        SGE's address.
+        :param length: How many bytes to read
+        :param offset: Offset from the SGE's address in bytes
+        :return: The data written at the SGE's address + offset
+        """
+        cdef char *sg_data
+        cdef int off = offset
+        sg_data = <char*>(self.sge.addr + off)
+        return <object>sg_data[:length]
+
+    def _get_sge(self):
+        return <object>self.sge
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('Address', hex(self.sge.addr)) +\
+               print_format.format('Length', self.sge.length) +\
+               print_format.format('Key', hex(self.sge.lkey))
+
+    @property
+    def addr(self):
+        return self.sge.addr
+    @addr.setter
+    def addr(self, val):
+        self.sge.addr = val
+
+    @property
+    def length(self):
+        return self.sge.length
+    @length.setter
+    def length(self, val):
+        self.sge.length = val
+
+    @property
+    def lkey(self):
+        return self.sge.lkey
+    @lkey.setter
+    def lkey(self, val):
+        self.sge.lkey = val
+
+
+cdef class RecvWR(PyverbsCM):
+    def __cinit__(self, wr_id=0, num_sge=0, sg=None,
+                  RecvWR next_wr=None):
+        """
+        Initializes a RecvWR object.
+        :param wr_id: A user-defined WR ID
+        :param num_sge: Size of the scatter-gather array
+        :param sg: A scatter-gather array
+        :param: next_wr: The next WR in the list
+        :return: A RecvWR object
+        """
+        cdef v.ibv_sge *dst
+        if num_sge < 1 or sg is None:
+            raise PyverbsUserError('A WR needs at least one SGE')
+        self.recv_wr.sg_list = <v.ibv_sge*>malloc(num_sge * sizeof(v.ibv_sge))
+        if self.recv_wr.sg_list == NULL:
+            raise PyverbsRDMAErrno('Failed to malloc SG buffer')
+        dst = self.recv_wr.sg_list
+        copy_sg_array(<object>dst, sg, num_sge)
+        self.recv_wr.num_sge = num_sge
+        self.recv_wr.wr_id = wr_id
+        if next_wr is not None:
+            self.recv_wr.next = &next_wr.recv_wr
+
+    def __dealloc(self):
+        self.close()
+
+    cpdef close(self):
+        free(self.recv_wr.sg_list)
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('WR ID', self.recv_wr.wr_id) +\
+               print_format.format('Num SGE', self.recv_wr.num_sge)
+
+    @property
+    def next_wr(self):
+        if self.recv_wr.next == NULL:
+            return None
+        val = RecvWR()
+        val.recv_wr = self.recv_wr.next[0]
+        return val
+    @next_wr.setter
+    def next_wr(self, RecvWR val not None):
+        self.recv_wr.next = &val.recv_wr
+
+    @property
+    def wr_id(self):
+        return self.recv_wr.wr_id
+    @wr_id.setter
+    def wr_id(self, val):
+        self.recv_wr.wr_id = val
+
+    @property
+    def num_sge(self):
+        return self.recv_wr.num_sge
+    @num_sge.setter
+    def num_sge(self, val):
+        self.recv_wr.num_sge = val
+
+
+cdef class SendWR(PyverbsCM):
+    def __cinit__(self, wr_id=0, opcode=e.IBV_WR_SEND, num_sge=0, sg = None,
+                  send_flags=e.IBV_SEND_SIGNALED, SendWR next_wr = None):
+        """
+        Initialize a SendWR object with user-provided or default values.
+        :param wr_id: A user-defined WR ID
+        :param opcode: The WR's opcode
+        :param num_sge: Number of scatter-gather elements in the WR
+        :param send_flags: Send flags as define in ibv_send_flags enum
+        :param sg: A SGE element, head of the scatter-gather list
+        :return: An initialized SendWR object
+        """
+        cdef v.ibv_sge *dst
+        if num_sge < 1 or sg is None:
+            raise PyverbsUserError('A WR needs at least one SGE')
+        self.send_wr.sg_list = <v.ibv_sge*>malloc(num_sge * sizeof(v.ibv_sge))
+        if self.send_wr.sg_list == NULL:
+            raise PyverbsRDMAErrno('Failed to malloc SG buffer')
+        dst = self.send_wr.sg_list
+        copy_sg_array(<object>dst, sg, num_sge)
+        self.send_wr.num_sge = num_sge
+        self.send_wr.wr_id = wr_id
+        if next_wr is not None:
+            self.send_wr.next = &next_wr.send_wr
+        self.send_wr.opcode = opcode
+        self.send_wr.send_flags = send_flags
+
+    def __dealloc(self):
+        self.close()
+
+    cpdef close(self):
+        free(self.send_wr.sg_list)
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('WR ID', self.send_wr.wr_id) +\
+               print_format.format('Num SGE', self.send_wr.num_sge) +\
+               print_format.format('Opcode', self.send_wr.opcode) +\
+               print_format.format('Send flags',
+                                   send_flags_to_str(self.send_wr.send_flags))
+
+    @property
+    def next_wr(self):
+        if self.send_wr.next == NULL:
+            return None
+        val = SendWR()
+        val.send_wr = self.send_wr.next[0]
+        return val
+    @next_wr.setter
+    def next_wr(self, SendWR val not None):
+        self.send_wr.next = &val.send_wr
+
+    @property
+    def wr_id(self):
+        return self.send_wr.wr_id
+    @wr_id.setter
+    def wr_id(self, val):
+        self.send_wr.wr_id = val
+
+    @property
+    def num_sge(self):
+        return self.send_wr.num_sge
+    @num_sge.setter
+    def num_sge(self, val):
+        self.send_wr.num_sge = val
+
+    @property
+    def opcode(self):
+        return self.send_wr.opcode
+    @opcode.setter
+    def opcode(self, val):
+        self.send_wr.opcode = val
+
+    @property
+    def send_flags(self):
+        return self.send_wr.send_flags
+    @send_flags.setter
+    def send_flags(self, val):
+        self.send_wr.send_flags = val
+
+    property sg_list:
+        def __set__(self, SGE val not None):
+            self.send_wr.sg_list = val.sge
+
+    def set_wr_ud(self, AH ah not None, rqpn, rqkey):
+        """
+        Set the members of the ud struct in the send_wr's wr union.
+        :param ah: An address handle object
+        :param rqpn: The remote QP number
+        :param rqkey: The remote QKey, authorizing access to the destination QP
+        :return: None
+        """
+        self.send_wr.wr.ud.ah = ah.ah
+        self.send_wr.wr.ud.remote_qpn = rqpn
+        self.send_wr.wr.ud.remote_qkey = rqkey
+
+    def set_wr_rdma(self, rkey, addr):
+        """
+        Set the members of the rdma struct in the send_wr's wr union, used for
+        RDMA extended transport header creation.
+        :param rkey: Key to access the specified memory address.
+        :param addr: Start address of the buffer
+        :return: None
+        """
+        self.send_wr.wr.rdma.remote_addr = addr
+        self.send_wr.wr.rdma.rkey = rkey
+
+    def set_wr_atomic(self, rkey, addr, compare_add, swap=0):
+        """
+        Set the members of the atomic struct in the send_wr's wr union, used
+        for the atomic extended transport header.
+        :param rkey: Key to access the specified memory address.
+        :param addr: Start address of the buffer
+        :param compare_add: The data operand used in the compare portion of the
+                            compare and swap operation
+        :param swap: The data operand used in atomic operations:
+                     - In compare and swap this field is swapped into the
+                       addressed buffer
+                     - In fetch and add this field is added to the contents of
+                       the addressed buffer
+        :return: None
+        """
+        self.send_wr.wr.atomic.remote_addr = addr
+        self.send_wr.wr.atomic.rkey = rkey
+        self.send_wr.wr.atomic.compare_add = compare_add
+        self.send_wr.wr.atomic.swap = swap
+
+    def set_qp_type_xrc(self, remote_srqn):
+        """
+        Set the members of the xrc struct in the send_wr's qp_type union, used
+        for the XRC extended transport header.
+        :param remote_srqn: The XRC SRQ number to be used by the responder fot
+                            this packet
+        :return: None
+        """
+        self.send_wr.qp_type.xrc.remote_srqn = remote_srqn
+
+def send_flags_to_str(flags):
+    send_flags = {e.IBV_SEND_FENCE: 'IBV_SEND_FENCE',
+                  e.IBV_SEND_SIGNALED: 'IBV_SEND_SIGNALED',
+                  e.IBV_SEND_SOLICITED: 'IBV_SEND_SOLICITED',
+                  e.IBV_SEND_INLINE: 'IBV_SEND_INLINE',
+                  e.IBV_SEND_IP_CSUM: 'IBV_SEND_IP_CSUM'}
+    flags_str = ''
+    for f in send_flags:
+        if flags & f:
+            flags_str += send_flags[f]
+            flags_str += ' '
+    return flags_str
+
+
+cdef copy_sg_array(dst_obj, sg, num_sge):
+    cdef v.ibv_sge *dst = <v.ibv_sge*>dst_obj
+    cdef v.ibv_sge *src
+    for i in range(num_sge):
+        # Avoid 'storing unsafe C derivative of temporary Python' errors
+        # that will occur if we merge the two following lines.
+        tmp = sg[i]._get_sge()
+        src = <v.ibv_sge*>tmp
+        memcpy(dst, src, sizeof(v.ibv_sge))
+        dst += 1
-- 
2.17.2

