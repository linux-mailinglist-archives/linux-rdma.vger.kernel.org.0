Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027B53CF602
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhGTHhy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:54 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:13189
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234127AbhGTHhs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og7zyZ9wJErclKbqhcP46Zd/z3D+nnp0oi6kAUDedqQr+U0UzvzK/EgPcZ7tX4yKSy6bbuXFOSDJMGvaHudgrRR1nBnv1wgSK8wLF1AKGF+we0VVaQRIVAMyPo2yHhnI89JBctZDHDLZp2bt55Y5UCKedIAbTwGrILyhBsbsJ77A7oAmBvxn6SCV6GQutTNsP5SwihCwI8oycHpgALWVs+0ApSTPHRcWtzDHRIAY1nb7xhtIE50/BPjC1UA8wOE2XRFpnX3QiQR31GYUuekBMxCcgJBZSJ1LtFv54XOnknNsUvsteIeYLRf/VSIaC3lj2uvaPq0/vUcdOxy3puLcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha8f2stawfGtzRUdxhLQUT1RjpEbCIKF6Mg7FUIgkSY=;
 b=YXu1T3OLmkSxnWGrYFR5F+JJuCne4eIeMSAihT3TIi6oShcsPe6d9FYv0or1KWxTA2yNh9mRB2uOtmuLwOP+UkYGW8XSkEXqXfDAOtYcBbt7R332gHTPplnDMFg2jRn4fv5w3uGEdfqpN/4ZAjyoyNaL3vhkGklxHg4xtRt0jvi8B9OrezhIdd/9UM0pruQAVCyY5swxcLxicdx2pG9RfDnsV8PGfSv2JPNYOJ6Y1KjUM1uzhaBkN5EXyVCD1VfbF54jO0lFpJ+27Z+x+0ntl4mg362g04Y4bXxOa/W3mONvShc9gBHriabghPXJSenabKJDf0rHRarDzFBGYKSGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha8f2stawfGtzRUdxhLQUT1RjpEbCIKF6Mg7FUIgkSY=;
 b=gizIHOTlFY8J9k01m9lB2fIE7MEnVHZGQikkgO0IzvUuYT1SDDbLMDexoYGirX29h3Y/eh0T0IMgmnS6KTz4nSgDKHKWMxfxD0zmMTbH3VLLAG6OeO2YGPC0Q/VkOOBqpn2CugVZKoDPLSzxRc5pKRv+eHanQIay0a9oTd8kHCYH5x328x2e+6MCNn+bN6STQ9kXc8iuZ640UMrGFCPt76272HineSl6ZQq81jxs2QHvoS6bLpAK9VA0ke3/CD04O5hPRjhTDCDk++t8cCsZtV3BBcj/J2qW7mAEDXyNr1nyQwkbOYQFjUm0wnsg28noVei+NTJkwv3NM78+ylemcA==
Received: from BN6PR19CA0054.namprd19.prod.outlook.com (2603:10b6:404:e3::16)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Tue, 20 Jul
 2021 08:18:25 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::53) by BN6PR19CA0054.outlook.office365.com
 (2603:10b6:404:e3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:21 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:21 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:18 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 22/27] pyverbs/mlx5: Add support to extract mlx5dv objects
Date:   Tue, 20 Jul 2021 11:16:42 +0300
Message-ID: <20210720081647.1980-23-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9469bff3-b0b0-49c8-c86a-08d94b56f256
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30177E8292704C59B5F06195C3E29@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70zR/3KLcZ1CFg7+rs0Ts3afBkAiZozyYT4sQcQx69Heezu5Sivpy6HVzM3rOPvGnrVFv5rhqjlbyxwngPHfjnmUygXRRjwcf26Q3SAqnqyZ4kWc70omgjZa5TtP0QAIARzBI8E5Qzj14zcH4nWDp3Gy7GnbKNe0ChoqFL67Gv1hpQm855wYm1Kx2G7LRBQM6KPus3cH/Loe51G0Pi3cr88so9t64bJUB5dz0377et8m9CMcamLubXMQ2dVBNGFI94kEcDahNZ/5ON5DOh523exW7O9eZfmSNyzgP6+vUDTKEHBJIZTt7OUR/AzD1IZx+hWXbGKi7mffxnf9xdXKRwFKl/A3j6FOQETBYpfwKlJALMjVwMzkjgwG/jy12VTQzYzvHkzVUVmi4EwtTLJEzkshc3zLKSPY8+NN6jaSbP5q4+h74pWuAMv6Rjth5jGAKomLOvJszgNf3YNEiKEGEjyywcNWgntIzk3MeLmzbVSly9qQZk7SkFf5SQcSCXHXNN/1zX60ojRB150zFlLXzT5ylCNcuHoMXHW2+p8Zpyk6QEoV7I0TgmlwkyK/2y2JHBdFFYBj60Lp9L786R/Z3WW+kWBA5YcroUl6BZNFDQWqs0NJW1E/zwiC1BBhBQ8zMLvxttJoxoWkJgMBzDXI7XfJHnTxFZChw3Rc4bD6/oXpTAHJUdzV6f9jVMWieB6wrjWchv8vq6fk711+HTJMWWfZTfWXBl1Lo12hr6loRu8i/PYgHASjNIbYionGQ946
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(336012)(82740400003)(8676002)(4326008)(316002)(426003)(54906003)(86362001)(30864003)(2906002)(6916009)(107886003)(7636003)(82310400003)(7696005)(26005)(36906005)(186003)(70206006)(2616005)(5660300002)(36860700001)(19627235002)(6666004)(70586007)(83380400001)(478600001)(36756003)(356005)(1076003)(47076005)(8936002)(42413003)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:25.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9469bff3-b0b0-49c8-c86a-08d94b56f256
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Support extraction of mlx5dv objects from ibv objects.
This allows the users to access the object numbers and much more
attributes needed for some usage such as DevX.
Currently there's a support for the following objects: PD, CQ, QP and
SRQ.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/pd.pyx                            |   4 +
 pyverbs/providers/mlx5/CMakeLists.txt     |   1 +
 pyverbs/providers/mlx5/libmlx5.pxd        |  52 ++++++++
 pyverbs/providers/mlx5/mlx5dv_enums.pxd   |  17 +++
 pyverbs/providers/mlx5/mlx5dv_objects.pxd |  28 ++++
 pyverbs/providers/mlx5/mlx5dv_objects.pyx | 214 ++++++++++++++++++++++++++++++
 6 files changed, 316 insertions(+)
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pyx

diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 2c0c424..e8d3e1d 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -139,6 +139,10 @@ cdef class PD(PyverbsCM):
     def handle(self):
         return self.pd.handle
 
+    @property
+    def pd(self):
+        return <object>self.pd
+
 
 cdef void *pd_alloc(v.ibv_pd *pd, void *pd_context, size_t size,
                   size_t alignment, v.uint64_t resource_type):
diff --git a/pyverbs/providers/mlx5/CMakeLists.txt b/pyverbs/providers/mlx5/CMakeLists.txt
index cdb6be2..4763c61 100644
--- a/pyverbs/providers/mlx5/CMakeLists.txt
+++ b/pyverbs/providers/mlx5/CMakeLists.txt
@@ -11,5 +11,6 @@ rdma_cython_module(pyverbs/providers/mlx5 mlx5
   mlx5_enums.pyx
   mlx5dv_flow.pyx
   mlx5dv_mkey.pyx
+  mlx5dv_objects.pyx
   mlx5dv_sched.pyx
 )
diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index 34691a9..de4008d 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -4,6 +4,7 @@
 include 'mlx5dv_enums.pxd'
 
 from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t, uintptr_t
+from posix.types cimport off_t
 from libcpp cimport bool
 
 cimport pyverbs.libibverbs as v
@@ -222,6 +223,56 @@ cdef extern from 'infiniband/mlx5dv.h':
         uint64_t    pgsz_bitmap
         uint64_t    comp_mask
 
+    cdef struct mlx5dv_pd:
+        uint32_t    pdn
+        uint64_t    comp_mask
+
+    cdef struct mlx5dv_cq:
+        void        *buf
+        uint32_t    *dbrec
+        uint32_t    cqe_cnt
+        uint32_t    cqe_size
+        void        *cq_uar
+        uint32_t    cqn
+        uint64_t    comp_mask
+
+    cdef struct mlx5dv_qp:
+        uint64_t    comp_mask
+        off_t       uar_mmap_offset
+        uint32_t    tirn
+        uint32_t    tisn
+        uint32_t    rqn
+        uint32_t    sqn
+
+    cdef struct mlx5dv_srq:
+        uint32_t    stride
+        uint32_t    head
+        uint32_t    tail
+        uint64_t    comp_mask
+        uint32_t    srqn
+
+    cdef struct pd:
+        v.ibv_pd    *in_ "in"
+        mlx5dv_pd   *out
+
+    cdef struct cq:
+        v.ibv_cq    *in_ "in"
+        mlx5dv_cq   *out
+
+    cdef struct qp:
+        v.ibv_qp    *in_ "in"
+        mlx5dv_qp   *out
+
+    cdef struct srq:
+        v.ibv_srq   *in_ "in"
+        mlx5dv_srq  *out
+
+    cdef struct mlx5dv_obj:
+        pd  pd
+        cq  cq
+        qp  qp
+        srq srq
+
 
     void mlx5dv_set_ctrl_seg(mlx5_wqe_ctrl_seg *seg, uint16_t pi, uint8_t opcode,
                              uint8_t opmod, uint32_t qp_num, uint8_t fm_ce_se,
@@ -326,6 +377,7 @@ cdef extern from 'infiniband/mlx5dv.h':
     int mlx5dv_devx_obj_modify(mlx5dv_devx_obj *obj, const void *in_,
                                size_t inlen, void *out, size_t outlen)
     int mlx5dv_devx_obj_destroy(mlx5dv_devx_obj *obj)
+    int mlx5dv_init_obj(mlx5dv_obj *obj, uint64_t obj_type)
 
     # Mkey setters
     void mlx5dv_wr_mkey_configure(mlx5dv_qp_ex *mqp, mlx5dv_mkey *mkey,
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
index d0a29bc..9f8d1a1 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -176,6 +176,23 @@ cdef extern from 'infiniband/mlx5dv.h':
         MLX5DV_DR_DOMAIN_TYPE_NIC_TX
         MLX5DV_DR_DOMAIN_TYPE_FDB
 
+    cpdef enum mlx5dv_qp_comp_mask:
+        MLX5DV_QP_MASK_UAR_MMAP_OFFSET
+        MLX5DV_QP_MASK_RAW_QP_HANDLES
+        MLX5DV_QP_MASK_RAW_QP_TIR_ADDR
+
+    cpdef enum mlx5dv_srq_comp_mask:
+        MLX5DV_SRQ_MASK_SRQN
+
+    cpdef enum mlx5dv_obj_type:
+        MLX5DV_OBJ_QP
+        MLX5DV_OBJ_CQ
+        MLX5DV_OBJ_SRQ
+        MLX5DV_OBJ_RWQ
+        MLX5DV_OBJ_DM
+        MLX5DV_OBJ_AH
+        MLX5DV_OBJ_PD
+
     cpdef unsigned long long MLX5DV_RES_TYPE_QP
     cpdef unsigned long long MLX5DV_RES_TYPE_RWQ
     cpdef unsigned long long MLX5DV_RES_TYPE_DBR
diff --git a/pyverbs/providers/mlx5/mlx5dv_objects.pxd b/pyverbs/providers/mlx5/mlx5dv_objects.pxd
new file mode 100644
index 0000000..e8eab84
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5dv_objects.pxd
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+
+#cython: language_level=3
+
+cimport pyverbs.providers.mlx5.libmlx5 as dv
+from pyverbs.base cimport PyverbsObject
+
+
+cdef class Mlx5DvPD(PyverbsObject):
+    cdef dv.mlx5dv_pd dv_pd
+
+cdef class Mlx5DvCQ(PyverbsObject):
+    cdef dv.mlx5dv_cq dv_cq
+
+cdef class Mlx5DvQP(PyverbsObject):
+    cdef dv.mlx5dv_qp dv_qp
+
+cdef class Mlx5DvSRQ(PyverbsObject):
+    cdef dv.mlx5dv_srq dv_srq
+
+cdef class Mlx5DvObj(PyverbsObject):
+    cdef dv.mlx5dv_obj obj
+    cdef Mlx5DvCQ dv_cq
+    cdef Mlx5DvQP dv_qp
+    cdef Mlx5DvPD dv_pd
+    cdef Mlx5DvSRQ dv_srq
+
diff --git a/pyverbs/providers/mlx5/mlx5dv_objects.pyx b/pyverbs/providers/mlx5/mlx5dv_objects.pyx
new file mode 100644
index 0000000..ec6eeb6
--- /dev/null
+++ b/pyverbs/providers/mlx5/mlx5dv_objects.pyx
@@ -0,0 +1,214 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+"""
+This module wraps mlx5dv_<obj> C structs, such as mlx5dv_cq, mlx5dv_qp etc.
+It exposes to the users the mlx5 driver-specific attributes for ibv objects by
+extracting them via mlx5dv_init_obj() API by using Mlx5DvObj class, which holds
+all the (currently) supported Mlx5Dv<Obj> objects.
+Note: This is not be confused with Mlx5<Obj> which holds the ibv_<obj>_ex that
+      was created using mlx5dv_create_<obj>().
+"""
+
+from libc.stdint cimport uintptr_t, uint32_t
+
+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsRDMAError
+cimport pyverbs.providers.mlx5.mlx5dv_enums as dve
+cimport pyverbs.libibverbs as v
+
+
+cdef class Mlx5DvPD(PyverbsObject):
+
+    @property
+    def pdn(self):
+        """ The protection domain object number """
+        return self.dv_pd.pdn
+
+    @property
+    def comp_mask(self):
+        return self.dv_pd.comp_mask
+
+
+cdef class Mlx5DvCQ(PyverbsObject):
+
+    @property
+    def cqe_size(self):
+        return self.dv_cq.cqe_size
+
+    @property
+    def comp_mask(self):
+        return self.dv_cq.comp_mask
+
+    @property
+    def cqn(self):
+        return self.dv_cq.cqn
+
+    @property
+    def buf(self):
+        return <uintptr_t><void*>self.dv_cq.buf
+
+    @property
+    def cq_uar(self):
+        return <uintptr_t><void*>self.dv_cq.cq_uar
+
+    @property
+    def dbrec(self):
+        return <uintptr_t><uint32_t*>self.dv_cq.dbrec
+
+    @property
+    def cqe_cnt(self):
+        return self.dv_cq.cqe_cnt
+
+
+cdef class Mlx5DvQP(PyverbsObject):
+
+    @property
+    def rqn(self):
+        """ The receive queue number of the QP"""
+        return self.dv_qp.rqn
+
+    @property
+    def sqn(self):
+        """ The send queue number of the QP"""
+        return self.dv_qp.sqn
+
+    @property
+    def tirn(self):
+        """
+        The number of the transport interface receive object that attached
+        to the RQ of the QP
+        """
+        return self.dv_qp.tirn
+
+    @property
+    def tisn(self):
+        """
+        The number of the transport interface send object that attached
+        to the SQ of the QP
+        """
+        return self.dv_qp.tisn
+
+    @property
+    def comp_mask(self):
+        return self.dv_qp.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.dv_qp.comp_mask = val
+
+    @property
+    def uar_mmap_offset(self):
+        return self.uar_mmap_offset
+
+
+cdef class Mlx5DvSRQ(PyverbsObject):
+
+    @property
+    def stride(self):
+        return self.dv_srq.stride
+
+    @property
+    def head(self):
+        return self.dv_srq.stride
+
+    @property
+    def tail(self):
+        return self.dv_srq.stride
+
+    @property
+    def comp_mask(self):
+        return self.dv_srq.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.dv_srq.comp_mask = val
+
+    @property
+    def srqn(self):
+        """ The shared receive queue object number """
+        return self.dv_srq.srqn
+
+
+cdef class Mlx5DvObj(PyverbsObject):
+    """
+    Mlx5DvObj represents mlx5dv_obj C struct.
+    """
+    def __init__(self, obj_type=None, **kwargs):
+        """
+        Retrieves DV objects from ibv object to be able to extract attributes
+        (such as cqe_size of a CQ).
+        Currently supports CQ, QP, PD and SRQ objects.
+        The initialized objects can be accessed using self.dvobj (e.g. self.dvcq).
+        :param obj_type: Bitmask which defines what objects was provided.
+                         Currently it supports: MLX5DV_OBJ_CQ, MLX5DV_OBJ_QP,
+                         MLX5DV_OBJ_SRQ and MLX5DV_OBJ_PD.
+        :param kwargs: List of objects (cq, qp, pd, srq) from which to extract
+                       data and their comp_masks if applicable. If comp_mask is
+                       not provided by user, mask all by default.
+        """
+        self.dv_pd = self.dv_cq = self.dv_qp = self.dv_srq = None
+        if obj_type is None:
+            return
+        self.init_obj(obj_type, **kwargs)
+
+    def init_obj(self, obj_type, **kwargs):
+        """
+        Initialize DV objects.
+        The objects are re-initialized if they're already extracted.
+        """
+        supported_obj_types = dve.MLX5DV_OBJ_CQ | dve.MLX5DV_OBJ_QP | \
+                         dve.MLX5DV_OBJ_PD | dve.MLX5DV_OBJ_SRQ
+        if obj_type & supported_obj_types is False:
+            raise PyverbsUserError('Invalid obj_type was provided')
+
+        cq = kwargs.get('cq') if obj_type | dve.MLX5DV_OBJ_CQ else None
+        qp = kwargs.get('qp') if obj_type | dve.MLX5DV_OBJ_QP else None
+        pd = kwargs.get('pd') if obj_type | dve.MLX5DV_OBJ_PD else None
+        srq = kwargs.get('srq') if obj_type | dve.MLX5DV_OBJ_SRQ else None
+        if cq is qp is pd is srq is None:
+            raise PyverbsUserError("No supported object was provided.")
+
+        if cq:
+            dv_cq = Mlx5DvCQ()
+            self.obj.cq.in_ = <v.ibv_cq*>cq.cq
+            self.obj.cq.out = &(dv_cq.dv_cq)
+            self.dv_cq = dv_cq
+        if qp:
+            dv_qp = Mlx5DvQP()
+            comp_mask = kwargs.get('qp_comp_mask')
+            dv_qp.comp_mask = comp_mask if comp_mask else \
+                dv.MLX5DV_QP_MASK_UAR_MMAP_OFFSET | \
+                dv.MLX5DV_QP_MASK_RAW_QP_HANDLES | \
+                dv.MLX5DV_QP_MASK_RAW_QP_TIR_ADDR
+            self.obj.qp.in_ = <v.ibv_qp*>qp.qp
+            self.obj.qp.out = &(dv_qp.dv_qp)
+            self.dv_qp = dv_qp
+        if pd:
+            dv_pd = Mlx5DvPD()
+            self.obj.pd.in_ = <v.ibv_pd*>pd.pd
+            self.obj.pd.out = &(dv_pd.dv_pd)
+            self.dv_pd = dv_pd
+        if srq:
+            dv_srq = Mlx5DvSRQ()
+            comp_mask = kwargs.get('srq_comp_mask')
+            dv_srq.comp_mask = comp_mask if comp_mask else dv.MLX5DV_SRQ_MASK_SRQN
+            self.obj.srq.in_ = <v.ibv_srq*>srq.srq
+            self.obj.srq.out = &(dv_srq.dv_srq)
+            self.dv_srq = dv_srq
+
+        rc = dv.mlx5dv_init_obj(&self.obj, obj_type)
+        if rc != 0:
+            raise PyverbsRDMAError("Failed to initialize Mlx5DvObj", rc)
+
+    @property
+    def dvcq(self):
+        return self.dv_cq
+
+    @property
+    def dvqp(self):
+        return self.dv_qp
+
+    @property
+    def dvpd(self):
+        return self.dv_pd
+
+    @property
+    def dvsrq(self):
+        return self.dv_srq
-- 
1.8.3.1

