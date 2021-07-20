Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875063CF60F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhGTHkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:40:16 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:33312
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231295AbhGTHkP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3uDOs5nUFmNopAmmIEpy4HAKmoCTX2Qc+PMQJAOxUCNhKd4O6Qiya3vKpwZDgHzClan8+8eLfU8DHoH4nhWoKFhnbIU0uLi6nN9uDFrFJF60rPNreyZqmTQjDrGs/E3ajgj/URzDEJR16J24WSQJUb4gq3OrGrplfJwQB3zkcQwHN532P7sp9qsSSjvOFusouCwWLk8GUcftbCBLTPWHbQtVf7YwzxJ9Ukq3HC2iirGd+dLwMhwedPPM5tahJeBE0bLvdaXQakHR0Pn9s7Seb+KEVRMSuBSncDGjU43Q8SJrX6WnK62tt2jVvHKJjde0wS/YiE0gcx5PyqK4K9xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1zDS6fd2cGwjmMaU2LyfZT0DH0hsWdMt+E0TSwa65A=;
 b=S69w7rnosVzOtgK0YDuXlzmhxhHSdl25bIOeHuL3hboOPckCYOqwLIsX5QbJynRNi/YfHPJnPbE4R36gBW5xDWxGX2vbSjcxGfsz0euWKwmopI1awLRcxv6vXtk5f3f1eOf7lJeo8VL3N1tDQPBPW8sgVOlD6TntyraZDRkXJkk6cnpAhVs4GSt1X3jDfwMcAldEo4DXdtqaBRJ+31edhXywobu2ysqk7EmR41OxoaifklOzgiwsKmNqwNAXNIp7lXJWOhgpD+9dbOowNsS87RvcLlHnjsEui0O3XZ5I4V77cEnnYESiiJHBVFREHCGxYKL8gk00pRFm+5oZ4k7peQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1zDS6fd2cGwjmMaU2LyfZT0DH0hsWdMt+E0TSwa65A=;
 b=FqBo8OorhYXAfynoj2w28qF1XGiyQqfa76JJDIKPDHDWsnH6VAEscUYUIXhPP72Vyx5nWvh5vll9VQicwV6Cz+L8M2RGb/UsT/++S2ye7WHNbBda+QZrE2lQDDypeHn6kEVmPIIfvsu7konoIZp5HK9u4chDgtWMh4kzrG64uBHoHo9FkpkDt3v7+S/wERVz+oq4DhFoJrmaGM9ZmVlPt6LO/P7dkO337Mck3SB4cP5gFCn7t3+jsZAP+hpse2fx4eL4J9kZZn68Sg0A0xExjLrRto8DOzfwIk7Hz47GVug/Glm3zVfSi6IJEFWcrnmfW//3Lv0qvR++JFzBb+Adsg==
Received: from CO2PR04CA0108.namprd04.prod.outlook.com (2603:10b6:104:6::34)
 by CY4PR12MB1591.namprd12.prod.outlook.com (2603:10b6:910:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:20:48 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::89) by CO2PR04CA0108.outlook.office365.com
 (2603:10b6:104:6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:10 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:09 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:07 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 18/27] pyverbs: Support DevX UMEM registration
Date:   Tue, 20 Jul 2021 11:16:38 +0300
Message-ID: <20210720081647.1980-19-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf93589-48cf-41b8-641d-08d94b56e94e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1591718C9F1711AB947069C1C3E29@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wbo+B8KMfvFwO5bZ0HruIBMp8qO2zs8abQ5lhfctdf161Yze2NNImGWHhki7a/24dNAdDfmrTLfE3wSqH5IZqN0nbNHhURHy7G0U28/go0Leszjmjw09Xp294JWDHJYVuf8qdvrwttDp3gatvPcOPIWd3vtMD+RFkx/qI4CdI91InPeALj9A6Qao84MzZBz/WdL8Pl94yLcu2XDKZocjthYjZ02E/NOKD2HSvqMUM4ScA+JapdU65JgVzJWHATNjPWVIuwleJMtV+B5U4vPHREAEQYp6L1rgiSsdCqbEbvTdef64J8TMsvgKPPhNn9m8RICQzSispd/wij6PgQRebMDzXKEYyny9zf9je/gktqNUrJn5bZEwC/p9oRTqpNzSRuNS3uJUwLSaZyXKFILbj4Sipbb+xM3fiRE3G6dCVOBcNFvxOxvLZHLG3eFPJbmRtmIrBkaOgSspfumx8WbCxLru+rNKYLiKmZPtYyMkSQjG0G66uiUdrv+8pcmvNtaTNHbRSh690/RE+08uNdrPqKCnz4ds9wsR56jzu5LzGrAT08eDLX7MKkXk9YADJyAnK+dBu/0YR5GUKZImpCtMgQe77ADBj3aO6N6yyyBD4jQuJv9A+tDhoo4zQA6i1qfuJT7i9SAw+usi3HXpSBmRjp5mC81Yxp03HBmX1NKug/KGmF7aETJLF86dH7Za/3tC5jsiYxegLZiXMpm5DlJmMw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(82740400003)(70586007)(5660300002)(336012)(70206006)(356005)(36756003)(107886003)(54906003)(7696005)(4326008)(2616005)(36860700001)(6916009)(82310400003)(7636003)(1076003)(86362001)(478600001)(47076005)(426003)(36906005)(83380400001)(316002)(2906002)(186003)(8936002)(6666004)(8676002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:10.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf93589-48cf-41b8-641d-08d94b56e94e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add support to register a DevX UMEM and UMEM extended, a user memory to
be used by the DevX interface for DMA.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/providers/mlx5/libmlx5.pxd | 21 +++++++--
 pyverbs/providers/mlx5/mlx5dv.pxd  |  8 ++++
 pyverbs/providers/mlx5/mlx5dv.pyx  | 93 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index 8dd0141..66b8705 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -212,6 +212,17 @@ cdef extern from 'infiniband/mlx5dv.h':
         uint8_t     fm_ce_se
         uint32_t    imm
 
+    cdef struct mlx5dv_devx_umem:
+        uint32_t umem_id;
+
+    cdef struct mlx5dv_devx_umem_in:
+        void        *addr
+        size_t      size
+        uint32_t    access
+        uint64_t    pgsz_bitmap
+        uint64_t    comp_mask
+
+
     void mlx5dv_set_ctrl_seg(mlx5_wqe_ctrl_seg *seg, uint16_t pi, uint8_t opcode,
                              uint8_t opmod, uint32_t qp_num, uint8_t fm_ce_se,
                              uint8_t ds, uint8_t signature, uint32_t imm)
@@ -298,11 +309,15 @@ cdef extern from 'infiniband/mlx5dv.h':
     int mlx5dv_map_ah_to_qp(v.ibv_ah *ah, uint32_t qp_num)
 
     # DevX APIs
-    mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(v.ibv_context *context,
-                                           uint32_t flags)
+    mlx5dv_devx_uar *mlx5dv_devx_alloc_uar(v.ibv_context *context, uint32_t flags)
     void mlx5dv_devx_free_uar(mlx5dv_devx_uar *devx_uar)
     int mlx5dv_devx_general_cmd(v.ibv_context *context, const void *in_,
-                                size_t inlen, void *out, size_t outlen);
+                                size_t inlen, void *out, size_t outlen)
+    mlx5dv_devx_umem *mlx5dv_devx_umem_reg(v.ibv_context *ctx, void *addr,
+                                           size_t size, unsigned long access)
+    mlx5dv_devx_umem *mlx5dv_devx_umem_reg_ex(v.ibv_context *ctx,
+                                              mlx5dv_devx_umem_in *umem_in)
+    int mlx5dv_devx_umem_dereg(mlx5dv_devx_umem *umem)
 
     # Mkey setters
     void mlx5dv_wr_mkey_configure(mlx5dv_qp_ex *mqp, mlx5dv_mkey *mkey,
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx5dv.pxd
index 18b208e..154a117 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -11,6 +11,8 @@ from pyverbs.cq cimport CQEX
 
 
 cdef class Mlx5Context(Context):
+    cdef object devx_umems
+    cdef add_ref(self, obj)
     cpdef close(self)
 
 cdef class Mlx5DVContextAttr(PyverbsObject):
@@ -69,3 +71,9 @@ cdef class Wqe(PyverbsCM):
     cdef void *addr
     cdef int is_user_addr
     cdef object segments
+
+cdef class Mlx5UMEM(PyverbsCM):
+    cdef dv.mlx5dv_devx_umem *umem
+    cdef Context context
+    cdef void *addr
+    cdef object is_user_addr
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx5dv.pyx
index 07dd7db..d16aed1 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -2,10 +2,11 @@
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 
 from libc.stdint cimport uintptr_t, uint8_t, uint16_t, uint32_t
-from libc.stdlib cimport calloc, free, malloc
-from libc.string cimport memcpy
+from libc.string cimport memcpy, memset
+from libc.stdlib cimport calloc, free
 from posix.mman cimport munmap
 import logging
+import weakref
 
 from pyverbs.providers.mlx5.mlx5dv_mkey cimport Mlx5MrInterleaved, Mlx5Mkey, \
     Mlx5MkeyConfAttr, Mlx5SigBlockAttr
@@ -13,6 +14,7 @@ from pyverbs.pyverbs_error import PyverbsUserError, PyverbsRDMAError, PyverbsErr
 from pyverbs.providers.mlx5.mlx5dv_sched cimport Mlx5dvSchedLeaf
 cimport pyverbs.providers.mlx5.mlx5dv_enums as dve
 cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.mem_alloc import posix_memalign
 from pyverbs.qp cimport QPInitAttrEx, QPEx
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.base cimport close_weakrefs
@@ -156,6 +158,7 @@ cdef class Mlx5Context(Context):
         if self.context == NULL:
             raise PyverbsRDMAErrno('Failed to open mlx5 context on {dev}'
                                    .format(dev=self.name))
+        self.devx_umems = weakref.WeakSet()
 
     def query_mlx5_device(self, comp_mask=-1):
         """
@@ -259,12 +262,21 @@ cdef class Mlx5Context(Context):
         free(clock_info)
         return ns_time
 
+    cdef add_ref(self, obj):
+        try:
+            Context.add_ref(self, obj)
+        except PyverbsError:
+            if isinstance(obj, Mlx5UMEM):
+                self.devx_umems.add(obj)
+            else:
+                raise PyverbsError('Unrecognized object type')
+
     def __dealloc__(self):
         self.close()
 
     cpdef close(self):
         if self.context != NULL:
-            close_weakrefs([self.pps])
+            close_weakrefs([self.pps, self.devx_umems])
             super(Mlx5Context, self).close()
 
 
@@ -1307,3 +1319,78 @@ cdef class Wqe(PyverbsCM):
             if not self.is_user_addr:
                 free(self.addr)
             self.addr = NULL
+
+
+cdef class Mlx5UMEM(PyverbsCM):
+    def __init__(self, Context context not None, size, addr=None, alignment=64,
+                 access=0, pgsz_bitmap=0, comp_mask=0):
+        """
+        User memory object to be used by the DevX interface.
+        If pgsz_bitmap or comp_mask were passed, the extended umem registration
+        will be used.
+        :param context: RDMA device context to create the action on
+        :param size: The size of the addr buffer (or the internal buffer to be
+                     allocated if addr is None)
+        :param alignment: The alignment of the internally allocated buffer
+                          (Valid if addr is None)
+        :param addr: The memory start address to register (if None, the address
+                     will be allocated internally)
+        :param access: The desired memory protection attributes (default: 0)
+        :param pgsz_bitmap: Represents the required page sizes
+        :param comp_mask: Compatibility mask
+        """
+        super().__init__()
+        cdef dv.mlx5dv_devx_umem_in umem_in
+
+        if addr is not None:
+            self.addr = <void*><uintptr_t>addr
+            self.is_user_addr = True
+        else:
+            self.addr = <void*><uintptr_t>posix_memalign(size, alignment)
+            memset(self.addr, 0, size)
+            self.is_user_addr = False
+
+        if pgsz_bitmap or comp_mask:
+            umem_in.addr = self.addr
+            umem_in.size = size
+            umem_in.access = access
+            umem_in.pgsz_bitmap = pgsz_bitmap
+            umem_in.comp_mask = comp_mask
+            self.umem = dv.mlx5dv_devx_umem_reg_ex(context.context, &umem_in)
+        else:
+            self.umem = dv.mlx5dv_devx_umem_reg(context.context, self.addr,
+                                                size, access)
+        if self.umem == NULL:
+            raise PyverbsRDMAErrno("Failed to register a UMEM.")
+        self.context = context
+        self.context.add_ref(self)
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        if self.umem != NULL:
+            self.logger.debug('Closing Mlx5UMEM')
+            rc = dv.mlx5dv_devx_umem_dereg(self.umem)
+            try:
+                if rc:
+                    raise PyverbsError("Failed to dereg UMEM.", rc)
+            finally:
+                if not self.is_user_addr:
+                    free(self.addr)
+            self.umem = NULL
+            self.context = None
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        return print_format.format('umem id', self.umem_id) + \
+               print_format.format('reg addr', self.umem_addr)
+
+    @property
+    def umem_id(self):
+        return self.umem.umem_id
+
+    @property
+    def umem_addr(self):
+        if self.addr:
+            return <uintptr_t><void*>self.addr
-- 
1.8.3.1

