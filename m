Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51005E6280
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiIVMeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiIVMeO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A581E7223
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:11 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYF535DH1zpTpC;
        Thu, 22 Sep 2022 20:31:19 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:09 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:04 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 08/12] RDMA/hns: Remove redundant 'num_mtt_segs' and 'max_extend_sg'
Date:   Thu, 22 Sep 2022 20:33:11 +0800
Message-ID: <20220922123315.3732205-9-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
References: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The num_mtt_segs and max_extend_sg used to be used for HIP06,
remove them since the HIP06 code has been removed.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 ---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 32cc116b3a6d..edd19970931d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -724,7 +724,7 @@ struct hns_roce_caps {
 	u32		max_sq_sg;
 	u32		max_sq_inline;
 	u32		max_rq_sg;
-	u32		max_extend_sg;
+	u32		rsv0;
 	u32		num_qps;
 	u32		num_pi_qps;
 	u32		reserved_qps;
@@ -748,7 +748,7 @@ struct hns_roce_caps {
 	int		num_comp_vectors;
 	int		num_other_vectors;
 	u32		num_mtpts;
-	u32		num_mtt_segs;
+	u32		rsv1;
 	u32		num_srqwqe_segs;
 	u32		num_idx_segs;
 	int		reserved_mrws;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4931f2a8a4af..f8b747cc4e79 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1966,7 +1966,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->min_cqes		= HNS_ROCE_MIN_CQE_NUM;
 	caps->max_cqes		= HNS_ROCE_V2_MAX_CQE_NUM;
 	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
-	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
 	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
 
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
@@ -2185,7 +2184,6 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
 	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
 
-	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
 	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
 
@@ -2272,7 +2270,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_inline	     = le16_to_cpu(resp_a->max_sq_inline);
 	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
 	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
-	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
 	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
 	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
 	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ca63463e7d4e..7a613cbe2ad6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -46,7 +46,6 @@
 #define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
 #define HNS_ROCE_V2_MAX_RQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
-#define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
 #define HNS_ROCE_V3_MAX_SQ_INLINE		0x400
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
@@ -55,7 +54,6 @@
 #define HNS_ROCE_V2_AEQE_VEC_NUM		1
 #define HNS_ROCE_V2_ABNORMAL_VEC_NUM		1
 #define HNS_ROCE_V2_MAX_MTPT_NUM		0x100000
-#define HNS_ROCE_V2_MAX_MTT_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_SRQWQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_IDX_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_PD_NUM			0x1000000
@@ -1175,7 +1173,7 @@ struct hns_roce_query_pf_caps_a {
 	__le16 max_sq_sg;
 	__le16 max_sq_inline;
 	__le16 max_rq_sg;
-	__le32 max_extend_sg;
+	__le32 rsv0;
 	__le16 num_qpc_timer;
 	__le16 num_cqc_timer;
 	__le16 max_srq_sges;
-- 
2.30.0

