Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB031380DD
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 11:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgAKKgf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728861AbgAKKgf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E8172F1269EE2B7DE48;
        Sat, 11 Jan 2020 18:36:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 18:36:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Remove some redundant variables related to capabilities
Date:   Sat, 11 Jan 2020 18:32:39 +0800
Message-ID: <1578738761-3176-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
References: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In struct hns_roce_caps, max_srq_sg and max_srqwqes is unused, and
max_srqs has the same effect with num_srqs. So remove them from this
structrue.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 ---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 ---
 drivers/infiniband/hw/hns/hns_roce_main.c   | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 8d2bcd8..7459ebb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -800,10 +800,8 @@ struct hns_roce_caps {
 	int             reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
-	u32		max_srq_sg;
 	int		num_srqs;
 	u32		max_wqes;
-	u32		max_srqs;
 	u32		max_srq_wrs;
 	u32		max_srq_sges;
 	u32		max_sq_desc_sz;
@@ -817,7 +815,6 @@ struct hns_roce_caps {
 	u32		min_wqes;
 	int		reserved_cqs;
 	int		reserved_srqs;
-	u32		max_srqwqes;
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1e0ba6..3b13290 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1668,12 +1668,10 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	caps->num_srqs		= HNS_ROCE_V2_MAX_SRQ_NUM;
 	caps->min_cqes		= HNS_ROCE_MIN_CQE_NUM;
 	caps->max_cqes		= HNS_ROCE_V2_MAX_CQE_NUM;
-	caps->max_srqwqes	= HNS_ROCE_V2_MAX_SRQWQE_NUM;
 	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
 	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
 	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
 	caps->max_sq_inline	= HNS_ROCE_V2_MAX_SQ_INLINE;
-	caps->max_srq_sg	= HNS_ROCE_V2_MAX_SRQ_SGE_NUM;
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
 	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
 	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
@@ -1761,7 +1759,6 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	caps->local_ca_ack_delay = 0;
 	caps->max_mtu = IB_MTU_4096;
 
-	caps->max_srqs		= HNS_ROCE_V2_MAX_SRQ;
 	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
 	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6e589f2..d0031d5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -210,7 +210,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 	props->max_pkeys = 1;
 	props->local_ca_ack_delay = hr_dev->caps.local_ca_ack_delay;
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
-		props->max_srq = hr_dev->caps.max_srqs;
+		props->max_srq = hr_dev->caps.num_srqs;
 		props->max_srq_wr = hr_dev->caps.max_srq_wrs;
 		props->max_srq_sge = hr_dev->caps.max_srq_sges;
 	}
-- 
2.8.1

