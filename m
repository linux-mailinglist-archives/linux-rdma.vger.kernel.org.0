Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E05E627C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiIVMeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiIVMeO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D302E721A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:11 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYF536TzszpTqV;
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
Subject: [PATCH for-next 09/12] RDMA/hns: Remove redundant 'max_srq_desc_sz' in caps
Date:   Thu, 22 Sep 2022 20:33:12 +0800
Message-ID: <20220922123315.3732205-10-xuhaoyue1@hisilicon.com>
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

The max_srq_desc_sz is defined in the code, but never used,
so delete this redundant variable.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 3 +--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index edd19970931d..aa859bf30774 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -735,7 +735,7 @@ struct hns_roce_caps {
 	u32		max_srq_sges;
 	u32		max_sq_desc_sz;
 	u32		max_rq_desc_sz;
-	u32		max_srq_desc_sz;
+	u32		rsv2;
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
 	u32		num_cqs;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f8b747cc4e79..31bfea15cdfc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1983,7 +1983,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
-	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
 	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
@@ -2277,7 +2276,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->num_other_vectors	     = resp_a->num_other_vectors;
 	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
 	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
-	caps->max_srq_desc_sz	     = resp_a->max_srq_desc_sz;
 	caps->cqe_sz		     = resp_a->cqe_sz;
 
 	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 7a613cbe2ad6..bd09109e4848 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -63,7 +63,6 @@
 #define HNS_ROCE_V2_MAX_QP_DEST_RDMA		128
 #define HNS_ROCE_V2_MAX_SQ_DESC_SZ		64
 #define HNS_ROCE_V2_MAX_RQ_DESC_SZ		16
-#define HNS_ROCE_V2_MAX_SRQ_DESC_SZ		64
 #define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
 #define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
 #define HNS_ROCE_V2_CQC_ENTRY_SZ		64
@@ -1181,7 +1180,7 @@ struct hns_roce_query_pf_caps_a {
 	u8 num_other_vectors;
 	u8 max_sq_desc_sz;
 	u8 max_rq_desc_sz;
-	u8 max_srq_desc_sz;
+	u8 rsv1;
 	u8 cqe_sz;
 };
 
-- 
2.30.0

