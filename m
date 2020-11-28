Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5B2C7221
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Nov 2020 23:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgK1VuZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Nov 2020 16:50:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8527 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgK1Slj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Nov 2020 13:41:39 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CjnfC2fHczhXrS;
        Sat, 28 Nov 2020 18:24:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 18:24:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Fix 0-length sge calculation error
Date:   Sat, 28 Nov 2020 18:22:37 +0800
Message-ID: <1606558959-48510-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

One RC SQ WQE can store 2 sges but UD can't, so ignore 2 valid sges of
wr.sglist for RC which have been filled in WQE before setting extended sge.
Either of RC and UD can not contain 0-length sges, so these 0-length
sges should be skipped.

Fixes: 54d6638765b0 ("RDMA/hns: Optimize WQE buffer size calculating process")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1bd81fb..81f1155 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -214,25 +214,20 @@ static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
 	return 0;
 }
 
-static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
-			   unsigned int *sge_ind, unsigned int valid_num_sge)
+static void set_extend_sge(struct hns_roce_qp *qp, struct ib_sge *sge,
+			   unsigned int *sge_ind, unsigned int cnt)
 {
 	struct hns_roce_v2_wqe_data_seg *dseg;
-	unsigned int cnt = valid_num_sge;
-	struct ib_sge *sge = wr->sg_list;
 	unsigned int idx = *sge_ind;
 
-	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
-		cnt -= HNS_ROCE_SGE_IN_WQE;
-		sge += HNS_ROCE_SGE_IN_WQE;
-	}
-
 	while (cnt > 0) {
 		dseg = hns_roce_get_extend_sge(qp, idx & (qp->sge.sge_cnt - 1));
-		set_data_seg_v2(dseg, sge);
-		idx++;
+		if (likely(sge->length)) {
+			set_data_seg_v2(dseg, sge);
+			idx++;
+			cnt--;
+		}
 		sge++;
-		cnt--;
 	}
 
 	*sge_ind = idx;
@@ -340,7 +335,8 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			}
 		}
 
-		set_extend_sge(qp, wr, sge_ind, valid_num_sge);
+		set_extend_sge(qp, wr->sg_list + i, sge_ind,
+			       valid_num_sge - HNS_ROCE_SGE_IN_WQE);
 	}
 
 	roce_set_field(rc_sq_wqe->byte_16,
@@ -503,7 +499,7 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	if (ret)
 		return ret;
 
-	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
+	set_extend_sge(qp, wr->sg_list, &curr_idx, valid_num_sge);
 
 	/*
 	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
-- 
2.8.1

