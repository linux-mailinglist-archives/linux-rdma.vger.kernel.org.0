Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286C5215713
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgGFMNu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:13:50 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:15196 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727896AbgGFMNu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 08:13:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066C6QrS010544;
        Mon, 6 Jul 2020 05:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=5TP/tubfFp3zO7rxzv4CzmJz3VlQpDquZ9NurPQvnGk=;
 b=L1HbRw6TUrb0pv0TQ41lpLhZyzu/RWlFEerMNpg9lmr91ZzOX7rhNSUxaX5+HNtSXuYp
 uwoGGs6JDj7YFmPG2cRKCPWIm8AuTVeFv8BsbX1j4JstR/821FkhHxMUr3kQmXHvKIA8
 Y9rIZpmJQLqVLAJAr7t5DehbviE1v4ruRZ873hqX1p5WLziR08sR0cSC1VKN5934QkmT
 qxMCkRzMLbYuPeQzBokdl8cNY42CdYQN0LzzIU0AeDxGVhqQB3Ze9dO2X13DmIbSC5TB
 qKy0jbZKs7Y8pKzg/7oLi0Z3B5Z7lgK6PBhn6UsSJwpzUgc9gcKKE9XJnfFnim/TRMLy FA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n68xs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 05:13:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 05:13:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 05:13:43 -0700
Received: from lb-tlvb-ybason.il.qlogic.org (unknown [10.5.221.176])
        by maili.marvell.com (Postfix) with ESMTP id DE5D03F703F;
        Mon,  6 Jul 2020 05:13:41 -0700 (PDT)
From:   Yuval Basson <ybason@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Yuval Basson <ybason@marvell.com>,
        "Michal Kalderon" <mkalderon@marvell.com>
Subject: [PATCH rdma-next] RDMA/qedr: SRQ's bug fixes
Date:   Mon, 6 Jul 2020 14:13:52 +0300
Message-ID: <20200706111352.21667-1-ybason@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_09:2020-07-06,2020-07-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QP's with the same SRQ, working on different CQs and running in parallel
on different CPUs could lead to a race when maintaining the SRQ consumer
count, and leads to FW running out of SRQs. Update the consumer atomically.
Make sure the wqe_prod is updated after the sge_prod due to FW
requirements.

Fixes: 3491c9e799fb9 ("RDMA/qedr: Add support for kernel mode SRQ's")
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Yuval Basson <ybason@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr.h  |  4 ++--
 drivers/infiniband/hw/qedr/verbs.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index fdf90ec..aa33202 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -344,10 +344,10 @@ struct qedr_srq_hwq_info {
 	u32 wqe_prod;
 	u32 sge_prod;
 	u32 wr_prod_cnt;
-	u32 wr_cons_cnt;
+	atomic_t wr_cons_cnt;
 	u32 num_elems;
 
-	u32 *virt_prod_pair_addr;
+	struct rdma_srq_producers *virt_prod_pair_addr;
 	dma_addr_t phy_prod_pair_addr;
 };
 
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 9b9e802..394adbd 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1510,6 +1510,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	srq->dev = dev;
 	hw_srq = &srq->hw_srq;
 	spin_lock_init(&srq->lock);
+	atomic_set(&hw_srq->wr_cons_cnt, 0);
 
 	hw_srq->max_wr = init_attr->attr.max_wr;
 	hw_srq->max_sges = init_attr->attr.max_sge;
@@ -3686,7 +3687,7 @@ static u32 qedr_srq_elem_left(struct qedr_srq_hwq_info *hw_srq)
 	 * count and consumer count and subtract it from max
 	 * work request supported so that we get elements left.
 	 */
-	used = hw_srq->wr_prod_cnt - hw_srq->wr_cons_cnt;
+	used = hw_srq->wr_prod_cnt - (u32)atomic_read(&hw_srq->wr_cons_cnt);
 
 	return hw_srq->max_wr - used;
 }
@@ -3701,7 +3702,6 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 	unsigned long flags;
 	int status = 0;
 	u32 num_sge;
-	u32 offset;
 
 	spin_lock_irqsave(&srq->lock, flags);
 
@@ -3714,7 +3714,8 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		if (!qedr_srq_elem_left(hw_srq) ||
 		    wr->num_sge > srq->hw_srq.max_sges) {
 			DP_ERR(dev, "Can't post WR  (%d,%d) || (%d > %d)\n",
-			       hw_srq->wr_prod_cnt, hw_srq->wr_cons_cnt,
+			       hw_srq->wr_prod_cnt,
+			       atomic_read(&hw_srq->wr_cons_cnt),
 			       wr->num_sge, srq->hw_srq.max_sges);
 			status = -ENOMEM;
 			*bad_wr = wr;
@@ -3748,22 +3749,22 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			hw_srq->sge_prod++;
 		}
 
-		/* Flush WQE and SGE information before
+		/* Update WQE and SGE information before
 		 * updating producer.
 		 */
-		wmb();
+		dma_wmb();
 
 		/* SRQ producer is 8 bytes. Need to update SGE producer index
 		 * in first 4 bytes and need to update WQE producer in
 		 * next 4 bytes.
 		 */
-		*srq->hw_srq.virt_prod_pair_addr = hw_srq->sge_prod;
-		offset = offsetof(struct rdma_srq_producers, wqe_prod);
-		*((u8 *)srq->hw_srq.virt_prod_pair_addr + offset) =
-			hw_srq->wqe_prod;
+		srq->hw_srq.virt_prod_pair_addr->sge_prod = hw_srq->sge_prod;
+		/* Make sure sge producer is updated first */
+		barrier();
+		srq->hw_srq.virt_prod_pair_addr->wqe_prod = hw_srq->wqe_prod;
 
 		/* Flush producer after updating it. */
-		wmb();
+		dma_wmb();
 		wr = wr->next;
 	}
 
@@ -4182,7 +4183,7 @@ static int process_resp_one_srq(struct qedr_dev *dev, struct qedr_qp *qp,
 	} else {
 		__process_resp_one(dev, qp, cq, wc, resp, wr_id);
 	}
-	srq->hw_srq.wr_cons_cnt++;
+	atomic_inc(&srq->hw_srq.wr_cons_cnt);
 
 	return 1;
 }
-- 
1.8.3.1

