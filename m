Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD03CF60B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhGTHiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:10 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:3841
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234648AbhGTHiG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZv5dNvikBD8g9GnBzjTp8VzCXAXUdc5xZNshxMtTUZIgt5miu2Wr6GB9ofSiFV1EQF16dQQuYrSHiwTdeXSi5VGFePlgkT66C0CUJENpZZt3Ct3iJgQdQnb501QN2SkZcP79QSjDBw+Xicxi6DJ7IU6osfxuhalcxbs4bG66b2VoYAz++F3N/Qg6NQ1el+ilJyj2DKZECP9QJmstiQ/gvD0E1sKFClrt6yYSNTwCgjMcr+tWH4VknePDrPqtJ7qtcSDqGFrIo20LtjqXQrnwfnIaeAgMvg2g1UyWOGsUmUhl4Iz3gYsddVfV1/1eRK7Gwco7QqIIAUen+rL815Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id7lpvLMnduopD+bYyY6OInt2GROwLIcHzaO95PIebs=;
 b=LHcl95tHn1nIJnytELYMIY+0B2MZu6HtenF9Vdp+tXcMpt/yqjtkb44s56AM4P3rNUxZUD5fuBJtVH2gdbgW1cAPhEdaez5KqCpWJo8j6+BbcUjhFiZerItEvHRprGmmH/LQYbKR+RMwXHfnX+GmIaSR9BfjEYOHIaG5gAaaiuylzhHplf7txP0v6J6q5biNUTH8j0l+wTx0yNnX4jv76mcCEu+sibjvDq3FKI6yZtG9GLvwSCB47XlXS7p+oRGuby7ktdvWcuk8TqmdJOF9CFQmiJ/rioAmc7Auu7oeynPzB4+KZa3ycm0lnk+lrw3q9sy9LzanYrj9InlmN/ryAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id7lpvLMnduopD+bYyY6OInt2GROwLIcHzaO95PIebs=;
 b=KGlBOWmhGduowv6tncMM2KDxUa143MIwaqMmKPnJBiAdfTEt1fdeH4wkihD3RBEkeT4BMKbDCBwt/uGNMg8Pc961LwDxO+X8HZJxil7UL9oQfKWply/StO1XA8pdVTXIOTzMZrHE2dt54FqmacMKm+iY4zs3gByH2Os8hqJ4c8FIQwih7q2+hEqDaoywa10q3Pj3FLQJMx0FSHiRrKsZHC8zv7gNv55VBRZk9nvU+pg0wdmDQ82a6vMA2wTPLhR92LPn8RmSMy6yIywlKPnpbCbRaHCJ+jm1YxhcxGC2tTkPz0nBXQDF6C6eyj+FDekXvGbubFjoZ29rZQFTMA468Q==
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by BL0PR12MB2819.namprd12.prod.outlook.com (2603:10b6:208:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 08:18:44 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::d8) by BN6PR19CA0053.outlook.office365.com
 (2603:10b6:404:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:43 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:25 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:22 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 23/27] pyverbs/mlx5: Wrap mlx5_cqe64 struct and add enums
Date:   Tue, 20 Jul 2021 11:16:43 +0300
Message-ID: <20210720081647.1980-24-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a94a278-6d82-4df6-2941-08d94b56fd68
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2819F6E1DACD6FDDAEA48D4FC3E29@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sHMo1Or8GXWWv2/zc84UFO+xtBOW6EyoXwV/7mDQbYsPEizW7kKWRFz+joh+P2b1c5BGinX0ZEJqQoURYsA2g03JJlvPti1HWyyQw8sg6qN+yW206NJldKWvDoyZmBc/LVDuPYzLFTWcP0nGaQGr4qgTqeK0coApIU1yUAhmzBYrVe4+6ve4frkv8NT+y1IxaxFhk5sdmoYokf9BGn+Hh6IQbT268erhfnlJYbp3vwLtiz/6vI8JsuMfywXfSdt/9dwxoMC7Vp4p+dj5jKO9ywULHz+RvBJDxSz6nEqCfKSs3ZCGdkE7Od19apquovtxa7SfHFiLHecbUlTvA0aQbFNa8rzmdUmn4xheCM/5VxW3FwTDCOnbSEbfcq0hGcHBk/biZFFywnxRPMELyrzlwigJEgd7f6DNbrYGK5XAo6NHiH/P8YXjIVFzN5VXIndD5GkweaRxfQUfIpior8Vq5RPYszU9m8SsBprd5hGPX46Lf8bTtgYrHxiMUmEtikJgnT+kcYqYwE9nWXR5CaNUj4bkURFtTcRKXGXI+uPouqgwggaCxhVLYxIhv+6j/1cs6+Na6CPp7eBvfOAocBeML2lh85WagwdduvQ6KwrT651Sl9bLVQDCpCNd5l4X0FsnHBUPmIA4l32O6KLinli3BcDNErXvzDBxwHzeBkqfdUj4IxjO5wj3Yin04mZoN1PIAWyeWEQdcpvLW54XpVR8w==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(478600001)(70586007)(336012)(2906002)(107886003)(2616005)(70206006)(36906005)(426003)(82310400003)(36756003)(86362001)(316002)(82740400003)(186003)(26005)(47076005)(4326008)(8936002)(7696005)(36860700001)(8676002)(356005)(6916009)(1076003)(54906003)(6666004)(5660300002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:43.8699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a94a278-6d82-4df6-2941-08d94b56fd68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add a Mlx5Cqe64 class that wraps mlx5_cqe64 C struct, and provide an
easy way to users to get/set its fields.
In addition expose related enums.
Both are relevant and necessary for DevX data path.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 pyverbs/providers/mlx5/libmlx5.pxd      | 14 +++++++
 pyverbs/providers/mlx5/mlx5dv.pxd       |  3 ++
 pyverbs/providers/mlx5/mlx5dv.pyx       | 71 +++++++++++++++++++++++++++++++++
 pyverbs/providers/mlx5/mlx5dv_enums.pxd | 22 ++++++++++
 4 files changed, 110 insertions(+)

diff --git a/pyverbs/providers/mlx5/libmlx5.pxd b/pyverbs/providers/mlx5/libmlx5.pxd
index de4008d..af034ad 100644
--- a/pyverbs/providers/mlx5/libmlx5.pxd
+++ b/pyverbs/providers/mlx5/libmlx5.pxd
@@ -273,12 +273,26 @@ cdef extern from 'infiniband/mlx5dv.h':
         qp  qp
         srq srq
 
+    cdef struct mlx5_cqe64:
+        uint16_t    wqe_id
+        uint32_t    imm_inval_pkey
+        uint32_t    byte_cnt
+        uint64_t    timestamp
+        uint16_t    wqe_counter
+        uint8_t     signature
+        uint8_t     op_own
+
 
     void mlx5dv_set_ctrl_seg(mlx5_wqe_ctrl_seg *seg, uint16_t pi, uint8_t opcode,
                              uint8_t opmod, uint32_t qp_num, uint8_t fm_ce_se,
                              uint8_t ds, uint8_t signature, uint32_t imm)
     void mlx5dv_set_data_seg(mlx5_wqe_data_seg *seg, uint32_t length,
                              uint32_t lkey, uintptr_t address)
+    uint8_t mlx5dv_get_cqe_owner(mlx5_cqe64 *cqe)
+    void mlx5dv_set_cqe_owner(mlx5_cqe64 *cqe, uint8_t val)
+    uint8_t mlx5dv_get_cqe_se(mlx5_cqe64 *cqe)
+    uint8_t mlx5dv_get_cqe_format(mlx5_cqe64 *cqe)
+    uint8_t mlx5dv_get_cqe_opcode(mlx5_cqe64 *cqe)
     bool mlx5dv_is_supported(v.ibv_device *device)
     v.ibv_context* mlx5dv_open_device(v.ibv_device *device,
                                       mlx5dv_context_attr *attr)
diff --git a/pyverbs/providers/mlx5/mlx5dv.pxd b/pyverbs/providers/mlx5/mlx5dv.pxd
index 2b758fe..968cbdb 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv.pxd
@@ -83,3 +83,6 @@ cdef class Mlx5DevxObj(PyverbsCM):
     cdef dv.mlx5dv_devx_obj *obj
     cdef Context context
     cdef object out_view
+
+cdef class Mlx5Cqe64(PyverbsObject):
+    cdef dv.mlx5_cqe64 *cqe
diff --git a/pyverbs/providers/mlx5/mlx5dv.pyx b/pyverbs/providers/mlx5/mlx5dv.pyx
index ab0bd4a..8d6bae0 100644
--- a/pyverbs/providers/mlx5/mlx5dv.pyx
+++ b/pyverbs/providers/mlx5/mlx5dv.pyx
@@ -1507,3 +1507,74 @@ cdef class Mlx5UMEM(PyverbsCM):
     def umem_addr(self):
         if self.addr:
             return <uintptr_t><void*>self.addr
+
+
+cdef class Mlx5Cqe64(PyverbsObject):
+    def __init__(self, addr):
+        self.cqe = <dv.mlx5_cqe64*><uintptr_t> addr
+
+    def dump(self):
+        dump_format = '{:08x} {:08x} {:08x} {:08x}\n'
+        str = ''
+        for i in range(0, 16, 4):
+            str += dump_format.format(be32toh((<uint32_t*>self.cqe)[i]),
+                                      be32toh((<uint32_t*>self.cqe)[i + 1]),
+                                      be32toh((<uint32_t*>self.cqe)[i + 2]),
+                                      be32toh((<uint32_t*>self.cqe)[i + 3]))
+        return str
+
+    def is_empty(self):
+        for i in range(16):
+            if be32toh((<uint32_t*>self.cqe)[i]) != 0:
+                return False
+        return True
+
+    @property
+    def owner(self):
+        return dv.mlx5dv_get_cqe_owner(self.cqe)
+    @owner.setter
+    def owner(self, val):
+        dv.mlx5dv_set_cqe_owner(self.cqe, <uint8_t> val)
+
+    @property
+    def se(self):
+        return dv.mlx5dv_get_cqe_se(self.cqe)
+
+    @property
+    def format(self):
+        return dv.mlx5dv_get_cqe_format(self.cqe)
+
+    @property
+    def opcode(self):
+        return dv.mlx5dv_get_cqe_opcode(self.cqe)
+
+    @property
+    def imm_inval_pkey(self):
+        return be32toh(self.cqe.imm_inval_pkey)
+
+    @property
+    def wqe_id(self):
+        return be16toh(self.cqe.wqe_id)
+
+    @property
+    def byte_cnt(self):
+        return be32toh(self.cqe.byte_cnt)
+
+    @property
+    def timestamp(self):
+        return be64toh(self.cqe.timestamp)
+
+    @property
+    def wqe_counter(self):
+        return be16toh(self.cqe.wqe_counter)
+
+    @property
+    def signature(self):
+        return self.cqe.signature
+
+    @property
+    def op_own(self):
+        return self.cqe.op_own
+
+    def __str__(self):
+        return (<dv.mlx5_cqe64>((<dv.mlx5_cqe64*>self.cqe)[0])).__str__()
diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
index 9f8d1a1..60713e8 100644
--- a/pyverbs/providers/mlx5/mlx5dv_enums.pxd
+++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
@@ -193,6 +193,28 @@ cdef extern from 'infiniband/mlx5dv.h':
         MLX5DV_OBJ_AH
         MLX5DV_OBJ_PD
 
+    cpdef enum:
+        MLX5_RCV_DBR
+        MLX5_SND_DBR
+
+    cpdef enum:
+        MLX5_CQE_OWNER_MASK
+        MLX5_CQE_REQ
+        MLX5_CQE_RESP_WR_IMM
+        MLX5_CQE_RESP_SEND
+        MLX5_CQE_RESP_SEND_IMM
+        MLX5_CQE_RESP_SEND_INV
+        MLX5_CQE_RESIZE_CQ
+        MLX5_CQE_NO_PACKET
+        MLX5_CQE_SIG_ERR
+        MLX5_CQE_REQ_ERR
+        MLX5_CQE_RESP_ERR
+        MLX5_CQE_INVALID
+
+    cpdef enum:
+        MLX5_SEND_WQE_BB
+        MLX5_SEND_WQE_SHIFT
+
     cpdef unsigned long long MLX5DV_RES_TYPE_QP
     cpdef unsigned long long MLX5DV_RES_TYPE_RWQ
     cpdef unsigned long long MLX5DV_RES_TYPE_DBR
-- 
1.8.3.1

