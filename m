Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC082BA739
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKTKTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 05:19:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7662 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKTKTI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 05:19:08 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ccsvq3ltKz15MVG;
        Fri, 20 Nov 2020 18:18:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 18:18:57 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 2/2] RDMA/hns: Add support for QP stash
Date:   Fri, 20 Nov 2020 18:17:20 +0800
Message-ID: <1605867440-2413-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
References: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index da7f909..00c67d6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3986,6 +3986,12 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	hr_qp->access_flags = attr->qp_access_flags;
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
+
+	if (hr_dev->caps.qpc_sz < HNS_ROCE_V3_QPC_SZ)
+		return;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_enable(context->ext, QPCEX_STASH);
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 50a5187..4679afb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -898,6 +898,8 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_256_SQ_FLUSH_IDX_S 16
 #define V2_QPC_BYTE_256_SQ_FLUSH_IDX_M GENMASK(31, 16)
 
+#define QPCEX_STASH FIELD_LOC(82, 82)
+
 #define	V2_QP_RWE_S 1 /* rdma write enable */
 #define	V2_QP_RRE_S 2 /* rdma read enable */
 #define	V2_QP_ATE_S 3 /* rdma atomic enable */
-- 
2.8.1

