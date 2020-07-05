Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74456214B1C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGEIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33110 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgGEIUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5dw001729;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5gG009327;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5le009323;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH V1 rdma-core 11/13] pyverbs: Support verbs import APIs
Date:   Sun,  5 Jul 2020 11:19:47 +0300
Message-Id: <1593937189-8744-12-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

Importing a device, PD and MR enables processes to share their context
and then share PDs and MRs that is associated with.
This commit supports importing/unimporting a device, PD and MR by
wrapping the relevant verbs in the current Context, PD and MR objects.

Reviewed-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/device.pyx     | 12 ++++++++--
 pyverbs/libibverbs.pxd |  5 +++++
 pyverbs/mr.pxd         |  1 +
 pyverbs/mr.pyx         | 60 +++++++++++++++++++++++++++++++++++++++++---------
 pyverbs/pd.pxd         |  1 +
 pyverbs/pd.pyx         | 37 +++++++++++++++++++++++++------
 6 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 88cd906..95e112b 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -87,6 +87,9 @@ cdef class Context(PyverbsCM):
             * *cmid*
               A CMID object. If not None, it means that the device was already
               opened by a CMID class, and only a pointer assignment is missing.
+            * *cmd_fd*
+              A command FD. If passed, the device will be imported from the
+              given cmd_fd using ibv_import_device.
         :return: None
         """
         cdef int count
@@ -107,10 +110,16 @@ cdef class Context(PyverbsCM):
         self.name = kwargs.get('name')
         provider_attr = kwargs.get('attr')
         cmid = kwargs.get('cmid')
+        cmd_fd = kwargs.get('cmd_fd')
         if cmid is not None:
             self.context = cmid.id.verbs
             cmid.ctx = self
             return
+        if cmd_fd is not None:
+            self.context = v.ibv_import_device(cmd_fd)
+            if self.context == NULL:
+                raise PyverbsRDMAErrno('Failed to import device')
+            return
 
         if self.name is None:
             raise PyverbsUserError('Device name must be provided')
@@ -152,8 +161,7 @@ cdef class Context(PyverbsCM):
                             self.xrcds, self.vars])
             rc = v.ibv_close_device(self.context)
             if rc != 0:
-                raise PyverbsRDMAErrno('Failed to close device {dev}'.
-                                       format(dev=self.device.name))
+                raise PyverbsRDMAErrno(f'Failed to close device {self.name}')
             self.context = NULL
 
     @property
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 7a75511..dfd4924 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -601,6 +601,11 @@ cdef extern from 'infiniband/verbs.h':
     void ibv_wr_start(ibv_qp_ex *qp)
     int ibv_wr_complete(ibv_qp_ex *qp)
     void ibv_wr_abort(ibv_qp_ex *qp)
+    ibv_context *ibv_import_device(int cmd_fd)
+    ibv_mr *ibv_import_mr(ibv_pd *pd, uint32_t handle)
+    void ibv_unimport_mr(ibv_mr *mr)
+    ibv_pd *ibv_import_pd(ibv_context *context, uint32_t handle)
+    void ibv_unimport_pd(ibv_pd *pd)
 
 
 cdef extern from 'infiniband/driver.h':
diff --git a/pyverbs/mr.pxd b/pyverbs/mr.pxd
index 82ae79f..7c3bb8e 100644
--- a/pyverbs/mr.pxd
+++ b/pyverbs/mr.pxd
@@ -14,6 +14,7 @@ cdef class MR(PyverbsCM):
     cdef object is_huge
     cdef object is_user_addr
     cdef void *buf
+    cdef object _is_imported
     cpdef read(self, length, offset)
 
 cdef class MWBindInfo(PyverbsCM):
diff --git a/pyverbs/mr.pyx b/pyverbs/mr.pyx
index b7b2196..da566cb 100644
--- a/pyverbs/mr.pyx
+++ b/pyverbs/mr.pyx
@@ -27,7 +27,7 @@ cdef class MR(PyverbsCM):
     MR class represents ibv_mr. Buffer allocation in done in the c'tor. Freeing
     it is done in close().
     """
-    def __init__(self, PD pd not None, length, access, address=None):
+    def __init__(self, PD pd not None, length=0, access=0, address=None, **kwargs):
         """
         Allocate a user-level buffer of length <length> and register a Memory
         Region of the given length and access flags.
@@ -37,6 +37,11 @@ cdef class MR(PyverbsCM):
         :param address: Memory address to register (Optional). If it's not
                         provided, a memory will be allocated in the class
                         initialization.
+        :param kwargs: Arguments:
+            * *handle*
+                A valid kernel handle for a MR object in the given PD.
+                If passed, the MR will be imported and associated with the
+                context that is associated with the given PD using ibv_import_mr.
         :return: The newly created MR on success
         """
         super().__init__()
@@ -52,7 +57,20 @@ cdef class MR(PyverbsCM):
             # uintptr_t is guaranteed to be large enough to hold any pointer.
             # In order to safely cast addr to void*, it is firstly cast to uintptr_t.
             self.buf = <void*><uintptr_t>address
-        else:
+
+        mr_handle = kwargs.get('handle')
+        # If a MR handle is passed import MR and finish
+        if mr_handle is not None:
+            self.mr = v.ibv_import_mr(pd.pd, mr_handle)
+            if self.mr == NULL:
+                raise PyverbsRDMAErrno('Failed to import MR')
+            self._is_imported = True
+            self.pd = pd
+            pd.add_ref(self)
+            return
+
+        # Allocate a buffer
+        if not address:
             if self.is_huge:
                 # Rounding up to multiple of HUGE_PAGE_SIZE
                 self.mmap_length = length + (HUGE_PAGE_SIZE - length % HUGE_PAGE_SIZE) \
@@ -77,6 +95,10 @@ cdef class MR(PyverbsCM):
         self.logger.debug('Registered ibv_mr. Length: {l}, access flags {a}'.
                           format(l=length, a=access))
 
+    def unimport(self):
+        v.ibv_unimport_mr(self.mr)
+        self.close()
+
     def __dealloc__(self):
         self.close()
 
@@ -86,21 +108,24 @@ cdef class MR(PyverbsCM):
         MR may be deleted directly or indirectly by closing its context, which
         leaves the Python PD object without the underlying C object, so during
         destruction, need to check whether or not the C object exists.
+        In case of an imported MR no deregistration will be done, it's left
+        for the original MR, in order to prevent double dereg by the GC.
         :return: None
         """
         if self.mr != NULL:
             self.logger.debug('Closing MR')
-            rc = v.ibv_dereg_mr(self.mr)
-            if rc != 0:
-                raise PyverbsRDMAError('Failed to dereg MR', rc)
+            if not self._is_imported:
+                rc = v.ibv_dereg_mr(self.mr)
+                if rc != 0:
+                    raise PyverbsRDMAError('Failed to dereg MR', rc)
+                if not self.is_user_addr:
+                    if self.is_huge:
+                        munmap(self.buf, self.mmap_length)
+                    else:
+                        free(self.buf)
             self.mr = NULL
             self.pd = None
-        if not self.is_user_addr:
-            if self.is_huge:
-                munmap(self.buf, self.mmap_length)
-            else:
-                free(self.buf)
-        self.buf = NULL
+            self.buf = NULL
 
     def write(self, data, length):
         """
@@ -144,6 +169,19 @@ cdef class MR(PyverbsCM):
     def length(self):
         return self.mr.length
 
+    @property
+    def handle(self):
+        return self.mr.handle
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return 'MR\n' + \
+               print_format.format('lkey', self.lkey) + \
+               print_format.format('rkey', self.rkey) + \
+               print_format.format('length', self.length) + \
+               print_format.format('buf', <uintptr_t>self.buf) + \
+               print_format.format('handle', self.handle)
+
 
 cdef class MWBindInfo(PyverbsCM):
     def __init__(self, MR mr not None, addr, length, mw_access_flags):
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index ae4324a..94d453e 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -19,6 +19,7 @@ cdef class PD(PyverbsCM):
     cdef object ahs
     cdef object qps
     cdef object parent_domains
+    cdef object _is_imported
 
 cdef class ParentDomainInitAttr(PyverbsObject):
     cdef v.ibv_parent_domain_init_attr init_attr
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index d54c4f8..2a35d11 100755
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -20,19 +20,31 @@ from pyverbs.qp cimport QP
 
 
 cdef class PD(PyverbsCM):
-    def __init__(self, object creator not None):
+    def __init__(self, object creator not None, **kwargs):
         """
         Initializes a PD object. A reference for the creating Context is kept
         so that Python's GC will destroy the objects in the right order.
         :param creator: The Context/CMID object creating the PD
+        :param kwargs: Arguments:
+            * *handle*
+                A valid kernel handle for a PD object in the given creator
+                (Context). If passed, the PD will be imported and associated
+                with the given handle in the given context using ibv_import_pd.
         """
         super().__init__()
+        pd_handle = kwargs.get('handle')
         if issubclass(type(creator), Context):
             # Check if the ibv_pd* was initialized by an inheriting class
             if self.pd == NULL:
-                self.pd = v.ibv_alloc_pd((<Context>creator).context)
+                if pd_handle is not None:
+                    self.pd = v.ibv_import_pd((<Context>creator).context, pd_handle)
+                    self._is_imported = True
+                    err_str = 'Failed to import PD'
+                else:
+                    self.pd = v.ibv_alloc_pd((<Context>creator).context)
+                    err_str = 'Failed to allocate PD'
                 if self.pd == NULL:
-                    raise PyverbsRDMAErrno('Failed to allocate PD')
+                    raise PyverbsRDMAErrno(err_str)
             self.ctx = creator
         elif issubclass(type(creator), CMID):
             cmid = <CMID>creator
@@ -43,7 +55,7 @@ cdef class PD(PyverbsCM):
             raise PyverbsUserError('Cannot create PD from {type}'
                                    .format(type=type(creator)))
         self.ctx.add_ref(self)
-        self.logger.debug('PD: Allocated ibv_pd')
+        self.logger.debug('Created PD')
         self.srqs = weakref.WeakSet()
         self.mrs = weakref.WeakSet()
         self.mws = weakref.WeakSet()
@@ -68,6 +80,10 @@ cdef class PD(PyverbsCM):
             raise PyverbsRDMAError('Failed to advise MR', rc)
         return rc
 
+    def unimport(self):
+        v.ibv_unimport_pd(self.pd)
+        self.close()
+
     def __dealloc__(self):
         """
         Closes the inner PD.
@@ -81,15 +97,18 @@ cdef class PD(PyverbsCM):
         PD may be deleted directly or indirectly by closing its context, which
         leaves the Python PD object without the underlying C object, so during
         destruction, need to check whether or not the C object exists.
+        In case of an imported PD no deallocation will be done, it's left for
+        the original PD, in order to prevent double dealloc by the GC.
         :return: None
         """
         if self.pd != NULL:
             self.logger.debug('Closing PD')
             close_weakrefs([self.parent_domains, self.qps, self.ahs, self.mws,
                             self.mrs, self.srqs])
-            rc = v.ibv_dealloc_pd(self.pd)
-            if rc != 0:
-                raise PyverbsRDMAError('Failed to dealloc PD', rc)
+            if not self._is_imported:
+                rc = v.ibv_dealloc_pd(self.pd)
+                if rc != 0:
+                    raise PyverbsRDMAError('Failed to dealloc PD', rc)
             self.pd = NULL
             self.ctx = None
 
@@ -109,6 +128,10 @@ cdef class PD(PyverbsCM):
         else:
             raise PyverbsError('Unrecognized object type')
 
+    @property
+    def handle(self):
+        return self.pd.handle
+
 
 cdef void *pd_alloc(v.ibv_pd *pd, void *pd_context, size_t size,
                   size_t alignment, v.uint64_t resource_type):
-- 
1.8.3.1

