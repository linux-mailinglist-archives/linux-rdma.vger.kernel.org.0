Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD527E540
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3Jfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:35:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728858AbgI3Jfk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 05:35:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57CB9A6D761E15B1D81B;
        Wed, 30 Sep 2020 17:35:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:35:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Add support for QP stash
Date:   Wed, 30 Sep 2020 17:34:12 +0800
Message-ID: <1601458452-55263-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
References: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Stash is a mechanism that uses the core information carried by the ARM AXI
bus to access the L3 cache. It can be used to improve the performance by
increasing the hit ratio of L3 cache. QPs need to enable stash by default.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 154afc0..d561e98 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3856,6 +3856,12 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	hr_qp->access_flags = attr->qp_access_flags;
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
+
+	if (hr_dev->caps.qpc_sz < HNS_ROCE_V3_QPC_SZ)
+		return;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_set(context->ext, QPCEX_STASH);
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cfa8caa..1692586 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -889,6 +889,9 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_256_SQ_FLUSH_IDX_S 16
 #define V2_QPC_BYTE_256_SQ_FLUSH_IDX_M GENMASK(31, 16)
 
+#define QPCEX_STASH 82
+#define QPCEX_STASH_W V3_GENMASK(82, 82)
+
 #define	V2_QP_RWE_S 1 /* rdma write enable */
 #define	V2_QP_RRE_S 2 /* rdma read enable */
 #define	V2_QP_ATE_S 3 /* rdma atomic enable */
-- 
2.8.1

