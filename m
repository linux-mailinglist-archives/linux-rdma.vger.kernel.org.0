Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF5352845
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhDBJKX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:10:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhDBJKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:10:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ2H4YK1znYCM;
        Fri,  2 Apr 2021 17:07:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:10:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Delete unused members in the structure hns_roce_hw
Date:   Fri, 2 Apr 2021 17:07:30 +0800
Message-ID: <1617354454-47840-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

Some structure members in hns_roce_hw have never been used and need to be
deleted.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Fixes: b156269d88e4 ("RDMA/hns: Add modify CQ support for hip08")
Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 16 ----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  6 ------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 ----------
 3 files changed, 32 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 55cbbd5..bf44b8b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -914,33 +914,17 @@ struct hns_roce_hw {
 	int (*clear_hem)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_hem_table *table, int obj,
 			 int step_idx);
-	int (*query_qp)(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
-			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
 			 enum ib_qp_state new_state);
-	int (*destroy_qp)(struct ib_qp *ibqp, struct ib_udata *udata);
 	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
-	int (*post_send)(struct ib_qp *ibqp, const struct ib_send_wr *wr,
-			 const struct ib_send_wr **bad_wr);
-	int (*post_recv)(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
-			 const struct ib_recv_wr **bad_recv_wr);
-	int (*req_notify_cq)(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
-	int (*poll_cq)(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 	int (*dereg_mr)(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 			struct ib_udata *udata);
 	int (*destroy_cq)(struct ib_cq *ibcq, struct ib_udata *udata);
-	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
-	int (*modify_srq)(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
-		       enum ib_srq_attr_mask srq_attr_mask,
-		       struct ib_udata *udata);
-	int (*query_srq)(struct ib_srq *ibsrq, struct ib_srq_attr *attr);
-	int (*post_srq_recv)(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
-			     const struct ib_recv_wr **bad_wr);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index a7a3148..e5f7c2e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4357,12 +4357,6 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.write_cqc = hns_roce_v1_write_cqc,
 	.clear_hem = hns_roce_v1_clear_hem,
 	.modify_qp = hns_roce_v1_modify_qp,
-	.query_qp = hns_roce_v1_query_qp,
-	.destroy_qp = hns_roce_v1_destroy_qp,
-	.post_send = hns_roce_v1_post_send,
-	.post_recv = hns_roce_v1_post_recv,
-	.req_notify_cq = hns_roce_v1_req_notify_cq,
-	.poll_cq = hns_roce_v1_poll_cq,
 	.dereg_mr = hns_roce_v1_dereg_mr,
 	.destroy_cq = hns_roce_v1_destroy_cq,
 	.init_eq = hns_roce_v1_init_eq_table,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4240aea..a0d2448 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6514,20 +6514,10 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
 	.modify_qp = hns_roce_v2_modify_qp,
-	.query_qp = hns_roce_v2_query_qp,
-	.destroy_qp = hns_roce_v2_destroy_qp,
 	.qp_flow_control_init = hns_roce_v2_qp_flow_control_init,
-	.modify_cq = hns_roce_v2_modify_cq,
-	.post_send = hns_roce_v2_post_send,
-	.post_recv = hns_roce_v2_post_recv,
-	.req_notify_cq = hns_roce_v2_req_notify_cq,
-	.poll_cq = hns_roce_v2_poll_cq,
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
 	.write_srqc = hns_roce_v2_write_srqc,
-	.modify_srq = hns_roce_v2_modify_srq,
-	.query_srq = hns_roce_v2_query_srq,
-	.post_srq_recv = hns_roce_v2_post_srq_recv,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
-- 
2.8.1

