Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E425FBB4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgIGNyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 09:54:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729713AbgIGNyN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 09:54:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF8A3AD2E54842CA7864;
        Mon,  7 Sep 2020 21:38:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:37:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Add check for the validity of sl configuration
Date:   Mon, 7 Sep 2020 21:36:44 +0800
Message-ID: <1599485808-29940-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
References: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

According to the RoCE v1 specification, the sl (service level) 0-7 are
mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
driver should verify whether the the value of sl is larger than 7, if so,
an exception should be returned.

Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4a88d41..07e3e3c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4299,11 +4299,19 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_28_FL_S, 0);
 	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
+
+	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
+		ibdev_err(ibdev,
+			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
+			  hr_qp->sl, MAX_SERVICE_LEVEL);
+		return -EINVAL;
+	}
+
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
-		       V2_QPC_BYTE_28_SL_S, rdma_ah_get_sl(&attr->ah_attr));
+		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);
 	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
 		       V2_QPC_BYTE_28_SL_S, 0);
-	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ac29be4..17f35f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1941,6 +1941,8 @@ struct hns_roce_eq_context {
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S 0
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M GENMASK(23, 0)
 
+#define MAX_SERVICE_LEVEL 0x7
+
 struct hns_roce_wqe_atomic_seg {
 	__le64          fetchadd_swap_data;
 	__le64          cmp_data;
-- 
2.8.1

