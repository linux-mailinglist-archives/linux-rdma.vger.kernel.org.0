Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA03CF604
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhGTHh4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:56 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:4928
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233651AbhGTHhi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNiKS5KD1Y57AtENJT9b8/EsGXkz+aBUI6xZAVk5oB3a+a58p1hdI1H34x7S8QvKeVqb/n6bHb4L1Q9FPziEg0OqGcWnJNk8a1YsroFa/WgdRocsGXaAGP+nIy/8Mh77lNV0UkmYlL+FjT4RHJEhdnBM01fZXvQk7i+p8jIWPNE/I2Q5fTIzl08OUY90Corvl6zKyMUN0FvZ6216YpPeLEwyFKxx5YAr3d+x8HJm3ITCSpRgzTAiYi1x929qbLkGyIsn3d9Vr8nc1C2i4tS9G46OuhrrRuDeczXIpqP5NZax1cNdG27ktMJHRKJSmpA/lsvZhQ1msvm45OzCG5pUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi54/Ce53DazpemAuL/gpeSi0oNOoKRmoWTKRS+rn3s=;
 b=CZ7lwMp0S7xY8qKVSAp6QGjOH+R0GzTVUvUBX3QoaG0F0KqVjKvodv/vwF91QekO0Jp7siPrL3hyMcZv1rtSx8GuKaLDV1lTAMF6C0TNd+kFPp5pCFc4ZjhFigfT88e+QcNjedknpc9W+/W2Pc74Bdiv908AqR+jh7CkShLDRypnM1XVUvd8PBlvzkFDIfKNSWfPZhsatv5ZS5bBIZlBcySyJNb1AGSJeLDz29pRcTXyldbXtXvOvMEv8hbr/FO/msrGuOW3JQDx/VtrmSOg7yn6zsJsXkDW/bU8iO3qya+0R+dG/n5tJBmiAkvIKUbOlPJshGtTeQKxH4sJHinIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi54/Ce53DazpemAuL/gpeSi0oNOoKRmoWTKRS+rn3s=;
 b=gv7Qxo0ou78PBRvKa5kjv63GiKh8zlPZQoXVHIC53WBOGSvMrY7Ua/1DiD+OHnaTJJxW2rY5Vzq+LFdsAJcSfp6NlMtRSm8fU6EqcNcl/H02exDohdVGWx9kXiPP8+BOfOE3ZHa9defFLTsoz07Wd/okxF3FjeXLMuiX0fgun0IIUS/A8yu3+KLkEb/HOt44z3Mfo8hK0JitW6Q9xx6buz6tFjtQ3Q3B6UTPBkObRzg3UhMRFQmcIq5vZvtVMjAYwpTvU1xc5nOx+QKksmfs9qmQDiDqsULXv6cScna4lAEeQVBOH53PgkZmE5T5cnmyYXMfhMHuJCNtf/6SRU8aiQ==
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by MN2PR12MB3184.namprd12.prod.outlook.com (2603:10b6:208:100::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 08:18:15 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::7d) by BN6PR19CA0053.outlook.office365.com
 (2603:10b6:404:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:15 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:18:14 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:12 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 20/27] pyverbs/mlx5: Support more DevX objects
Date:   Tue, 20 Jul 2021 11:16:40 +0300
Message-ID: <20210720081647.1980-21-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6480b7b0-f1b5-46cf-071e-08d94b56eca6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3184:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3184C21AA0F60BCC6F618120C3E29@MN2PR12MB3184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSQeoNuo8AdQZ6TNOqaGnNgqLQnPnZEHUVKihscTUzx9oOPABpsBZzBcQt9klOK9SwL7ZXOK0sG6p3XaVkEetDmD56xSMBWqK2WsU5duNO8GGfOO3oZxFISlM0afJ2jr6kEDuJfLptBN4z7iVbYkZlfr9xzxEnvBSyFeHTKHMlazy7z9MTv+xZh0NBdsjc/TtoJ8B+RXNETUPnZ6KrePq30XtCZyxnE2vJy8t7B3y6x6b6MGR4qmxntQpDXz0HtwxSqa3hMpRVcxa7vYM4rEfLupLEd6YZgDC7KN63Ku6iOWnLDj8vQuZZ83fIGLfn2hPqgRTrzMgnUXkHM6Q+Jqe9qRpAU89Dq6qfXeKcxXKPMfcFUhWnIGYbyPfP2tYTxePRmBQ/6wAGa0Y8Unl+dyWuKsNzXxve7y12XKye1RBdJGNY5qstmcxje60YpM5KF4Kl5ybSiDzqFlkTS2cOlHwR+vWgKRbgUgKPpVXqAzRSM+vc/+OJoyd1whBhHn/x5ELHEqRsKOxrqa0zYRmQkBQlsEpTkfr1GYDP5haUu7XFuTLKIQTBdhGIyUJBrPKgYQveIa1VEiRD2OKaYctDuLoJZatuw4rQSI4HE9x5Xg4ZS6P9dMC1UqIBltsNQjFoWT9JkGEj4jY/0qfK1YeGb1lz8+FU2JE4R0AQVUudrOwrHE3U6PVr1LG7QkdbVStMoIo4TE3TkNyVYUik0Oa9ZuHQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(107886003)(6666004)(86362001)(36860700001)(47076005)(316002)(1076003)(8936002)(36756003)(26005)(508600001)(336012)(5660300002)(54906003)(82310400003)(8676002)(7696005)(6916009)(426003)(70206006)(83380400001)(7636003)(2616005)(70586007)(186003)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:15.6901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480b7b0-f1b5-46cf-071e-08d94b56eca6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

A DevX object represents some underlay firmware object, the input
command to create it is some raw data given by the user application
which should match the device specification.

A new class Mlx5DevxObj was added that would present any DevX object
that could be creating using the create_obj DevX API.
The command's output is stored in the object's instance, and the object
can be modified/queried and destroyed.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 Documentation/pyverbs.md           |  34 ++++++++++++
 pyverbs/providers/mlx5/libmlx5.pxd |   7 +++
 pyverbs/providers/mlx5/mlx5dv.pxd  |   6 +++
 pyverbs/providers/mlx5/mlx5dv.pyx  | 103 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index c7fa761..bcbde05 100644
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -745,3 +745,37 @@ Below is the output when printing the spec.
     Dst mac         : de:de:de:00:de:de    mask: ff:ff:ff:ff:ff:ff
     Ether type      : 8451                 mask: 65535
     Vlan tag        : 8961                 mask: 65535
+
+
+##### MLX5 DevX Objects
+A DevX object represents some underlay firmware object, the input command to
+create it is some raw data given by the user application which should match the
+device specification.
+Upon successful creation, the output buffer includes the raw data from the device
+according to its specification and is stored in the Mlx5DevxObj instance. This
+data can be used as part of related firmware commands to this object.
+In addition to creation, the user can query/modify and destroy the object.
+
+Although weakrefs and DevX objects closure are added and handled by
+Pyverbs, the users must manually close these objects when finished, and
+should not let them be handled by the GC, or by closing the Mlx5Context directly,
+since there's no guarantee that the DevX objects are closed in the correct order,
+because Mlx5DevxObj is a general class that can be any of the device's available
+objects.
+But Pyverbs does guarantee to close DevX UARs and UMEMs in order, and after
+closing the other DevX objects.
+
+The following code snippet shows how to allocate and destroy a PD object over DevX.
+```python
+from pyverbs.providers.mlx5.mlx5dv import Mlx5Context, Mlx5DVContextAttr, Mlx5DevxObj
+import pyverbs.providers.mlx5.mlx5_enums as dve
+import struct
+
+attr = Mlx5DVContextAttr(dve.MLX5DV_CONTEXT_FLAGS_DEVX)
+ctx = Mlx5Context(attr, 'rocep8s0f0')
+MLX5_CMD_OP_ALLOC_PD = 0x800
+MLX5_CMD_OP_ALLOC_PD_OUTLEN = 0x10
+cmd_in = struct.pack('!H14s', MLX5_CMD_OP_ALLOC_PD, bytes(0))
+pd = Mlx5DevxObj(ctx, cmd_in, MLX5_CMD_OP_ALLOC_PD_OUTLEN)
+pd.close()
+```
diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index ba2c6ec..34691a9 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -319,6 +319,13 @@ cdef extern from 'infiniband/mlx5dv.h':
                                               mlx5dv_devx_umem_in *umem_in)
     int mlx5dv_devx_umem_dereg(mlx5dv_devx_umem *umem)
     int mlx5dv_devx_query_eqn(v.ibv_context *context, uint32_t vector, uint32_t *eqn)
+    mlx5dv_devx_obj *mlx5dv_devx_obj_create(v.ibv_context *context, const void *_in,
+                                            size_t inlen, void *out, size_t outlen)
+    int mlx5dv_devx_obj_query(mlx5dv_devx_obj *obj, const void *in_,
+                              size_t inlen, void *out, size_t outlen)
+    int mlx5dv_devx_obj_modify(mlx5dv_devx_obj *obj, const void *in_,
+                               size_t inlen, void *out, size_t outlen)
+    int mlx5dv_devx_obj_destroy(mlx5dv_devx_obj *obj)
 
     # Mkey setters
     void mlx5dv_wr_mkey_configure(mlx5dv_qp_ex *mqp, mlx5dv_mkey *mkey,
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx5dv.pxd
index 154a117..2b758fe 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -12,6 +12,7 @@ from pyverbs.cq cimport CQEX
 
 cdef class Mlx5Context(Context):
     cdef object devx_umems
+    cdef object devx_objs
     cdef add_ref(self, obj)
     cpdef close(self)
 
@@ -77,3 +78,8 @@ cdef class Mlx5UMEM(PyverbsCM):
     cdef Context context
     cdef void *addr
     cdef object is_user_addr
+
+cdef class Mlx5DevxObj(PyverbsCM):
+    cdef dv.mlx5dv_devx_obj *obj
+    cdef Context context
+    cdef object out_view
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx5dv.pyx
index 2c47cb6..ab0bd4a 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -140,6 +140,104 @@ cdef class Mlx5DVContextAttr(PyverbsObject):
         self.attr.comp_mask = val
 
 
+cdef class Mlx5DevxObj(PyverbsCM):
+    """
+    Represents mlx5dv_devx_obj C struct.
+    """
+    def __init__(self, Context context, in_, outlen):
+        """
+        Creates a DevX object.
+        If the object was successfully created, the command's output would be
+        stored as a memoryview in self.out_view.
+        :param in_: Bytes of the obj_create command's input data provided in a
+                    device specification format.
+                    (Stream of bytes or __bytes__ is implemented)
+        :param outlen: Expected output length in bytes
+        """
+        super().__init__()
+        in_bytes = bytes(in_)
+        cdef char *in_mailbox = _prepare_devx_inbox(in_bytes)
+        cdef char *out_mailbox = _prepare_devx_outbox(outlen)
+        self.obj = dv.mlx5dv_devx_obj_create(context.context, in_mailbox,
+                                             len(in_bytes), out_mailbox, outlen)
+        try:
+            if self.obj == NULL:
+                raise PyverbsRDMAErrno('Failed to create DevX object')
+            self.out_view = memoryview(out_mailbox[:outlen])
+            status = hex(self.out_view[0])
+            syndrome = self.out_view[4:8].hex()
+            if status != hex(0):
+                raise PyverbsRDMAError('Failed to create DevX object with status'
+                                       f'({status}) and syndrome (0x{syndrome})')
+        finally:
+            free(in_mailbox)
+            free(out_mailbox)
+        self.context = context
+        self.context.add_ref(self)
+
+    def query(self, in_, outlen):
+        """
+        Queries the DevX object.
+        :param in_: Bytes of the obj_query command's input data provided in a
+                    device specification format.
+                    (Stream of bytes or __bytes__ is implemented)
+        :param outlen: Expected output length in bytes
+        :return: Bytes of the command's output
+        """
+        in_bytes = bytes(in_)
+        cdef char *in_mailbox = _prepare_devx_inbox(in_bytes)
+        cdef char *out_mailbox = _prepare_devx_outbox(outlen)
+        rc = dv.mlx5dv_devx_obj_query(self.obj, in_mailbox, len(in_bytes),
+                                      out_mailbox, outlen)
+        try:
+            if rc:
+                raise PyverbsRDMAError('Failed to query DevX object', rc)
+            out = <bytes>out_mailbox[:outlen]
+        finally:
+            free(in_mailbox)
+            free(out_mailbox)
+        return out
+
+    def modify(self, in_, outlen):
+        """
+        Modifies the DevX object.
+        :param in_: Bytes of the obj_modify command's input data provided in a
+                    device specification format.
+                    (Stream of bytes or __bytes__ is implemented)
+        :param outlen: Expected output length in bytes
+        :return: Bytes of the command's output
+        """
+        in_bytes = bytes(in_)
+        cdef char *in_mailbox = _prepare_devx_inbox(in_bytes)
+        cdef char *out_mailbox = _prepare_devx_outbox(outlen)
+        rc = dv.mlx5dv_devx_obj_modify(self.obj, in_mailbox, len(in_bytes),
+                                       out_mailbox, outlen)
+        try:
+            if rc:
+                raise PyverbsRDMAError('Failed to modify DevX object', rc)
+            out = <bytes>out_mailbox[:outlen]
+        finally:
+            free(in_mailbox)
+            free(out_mailbox)
+        return out
+
+    @property
+    def out_view(self):
+        return self.out_view
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        if self.obj != NULL:
+            self.logger.debug('Closing Mlx5DvexObj')
+            rc = dv.mlx5dv_devx_obj_destroy(self.obj)
+            if rc:
+                raise PyverbsRDMAError('Failed to destroy a DevX object', rc)
+            self.obj = NULL
+            self.context = None
+
+
 cdef class Mlx5Context(Context):
     """
     Represent mlx5 context, which extends Context.
@@ -159,6 +257,7 @@ cdef class Mlx5Context(Context):
             raise PyverbsRDMAErrno('Failed to open mlx5 context on {dev}'
                                    .format(dev=self.name))
         self.devx_umems = weakref.WeakSet()
+        self.devx_objs = weakref.WeakSet()
 
     def query_mlx5_device(self, comp_mask=-1):
         """
@@ -280,6 +379,8 @@ cdef class Mlx5Context(Context):
         except PyverbsError:
             if isinstance(obj, Mlx5UMEM):
                 self.devx_umems.add(obj)
+            elif isinstance(obj, Mlx5DevxObj):
+                self.devx_objs.add(obj)
             else:
                 raise PyverbsError('Unrecognized object type')
 
@@ -288,7 +389,7 @@ cdef class Mlx5Context(Context):
 
     cpdef close(self):
         if self.context != NULL:
-            close_weakrefs([self.pps, self.devx_umems])
+            close_weakrefs([self.pps, self.devx_objs, self.devx_umems])
             super(Mlx5Context, self).close()
 
 
-- 
1.8.3.1

