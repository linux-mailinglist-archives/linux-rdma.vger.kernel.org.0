Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282052A0484
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgJ3LlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 07:41:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7115 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgJ3LlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 07:41:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CN0kZ49TpzLr2L;
        Fri, 30 Oct 2020 19:41:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 19:41:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/8] RDMA/hns: Add check for the validity of sl configuration in UD SQ WQE
Date:   Fri, 30 Oct 2020 19:39:31 +0800
Message-ID: <1604057975-23388-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

According to the RoCE v1 specification, the sl (service level) 0-7 are
mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
driver should verify whether the value of sl is larger than 7, if so, an
exception should be returned.

Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a1d30f..69386a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -427,9 +427,10 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 			     void *wqe, unsigned int *sge_idx,
 			     unsigned int owner_bit)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
 	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
+	struct ib_device *ib_dev = qp->ibqp.device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
 	unsigned int curr_idx = *sge_idx;
 	int valid_num_sge;
 	u32 msg_len = 0;
@@ -489,6 +490,13 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
 		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
+
+	if (unlikely(ah->av.sl > MAX_SERVICE_LEVEL)) {
+		ibdev_err(ib_dev,
+			  "failed to fill ud av, ud sl (%d) shouldn't be larger than %d.\n",
+			  ah->av.sl, MAX_SERVICE_LEVEL);
+		return -EINVAL;
+	}
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
 		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_PORTN_M,
-- 
2.8.1

