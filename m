Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE947B87B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 03:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLUCtI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 21:49:08 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56781 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233671AbhLUCtI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 21:49:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.I-4wH_1640054946;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.I-4wH_1640054946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:49:06 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next 05/11] RDMA/erdma: Add event queue implementation
Date:   Tue, 21 Dec 2021 10:48:52 +0800
Message-Id: <20211221024858.25938-6-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20211221024858.25938-1-chengyou@linux.alibaba.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Event queue (EQ) is the main notifcaition way from erdma hardware to its
driver. Each erdma device contains 2 kinds EQs: asynchronous EQ (AEQ) and
completion EQ (CEQ). Per device has 1 AEQ, which used for RDMA async event
report, and max to 32 CEQs (numbered for CEQ0 to CEQ31). CEQ0 is used for
cmdq completion event report, and the reset CEQs are used for RDMA
completion event report.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_eq.c | 346 +++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c

diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
new file mode 100644
index 000000000000..67dae3a6a245
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Authors: Cheng Xu <chengyou@linux.alibaba.com>
+ *          Kai Shen <kaishen@linux.alibaba.com>
+ * Copyright (c) 2020-2021, Alibaba Group.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include <rdma/iw_cm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_user_verbs.h>
+
+#include "erdma.h"
+#include "erdma_cm.h"
+#include "erdma_hw.h"
+#include "erdma_verbs.h"
+
+static inline int
+erdma_poll_aeq_event(struct erdma_eq *aeq, void *out)
+{
+	struct erdma_aeqe *aeqe = (struct erdma_aeqe *)aeq->qbuf + (aeq->ci & (aeq->depth - 1));
+	u32 val;
+
+	val = le32_to_cpu(READ_ONCE(aeqe->hdr));
+	if (FIELD_GET(ERDMA_AEQE_HDR_O_MASK, val) == aeq->owner) {
+		dma_rmb();
+		aeq->ci++;
+		if ((aeq->ci & (aeq->depth - 1)) == 0)
+			aeq->owner = !aeq->owner;
+
+		atomic64_inc(&aeq->event_num);
+		if (out)
+			memcpy(out, aeqe, sizeof(struct erdma_aeqe));
+
+		return 1;
+	}
+
+	return 0;
+}
+
+void erdma_aeq_event_handler(struct erdma_dev *dev)
+{
+	struct erdma_aeqe aeqe;
+	u32 cqn, qpn;
+	struct erdma_qp *qp;
+	struct erdma_cq *cq;
+	struct ib_event event;
+
+	memset(&event, 0, sizeof(event));
+	while (erdma_poll_aeq_event(&dev->aeq.eq, &aeqe)) {
+		if (FIELD_GET(ERDMA_AEQE_HDR_TYPE_MASK, aeqe.hdr) == ERDMA_AE_TYPE_CQ_ERR) {
+			cqn = aeqe.event_data0;
+			cq = find_cq_by_cqn(dev, cqn);
+			if (!cq)
+				continue;
+			event.device = cq->ibcq.device;
+			event.element.cq = &cq->ibcq;
+			event.event = IB_EVENT_CQ_ERR;
+			if (cq->ibcq.event_handler)
+				cq->ibcq.event_handler(&event, cq->ibcq.cq_context);
+		} else {
+			qpn = aeqe.event_data0;
+			qp = find_qp_by_qpn(dev, qpn);
+			if (!qp)
+				continue;
+
+			event.device = qp->ibqp.device;
+			event.element.qp = &qp->ibqp;
+			event.event = IB_EVENT_QP_FATAL;
+			if (qp->ibqp.event_handler)
+				qp->ibqp.event_handler(&event, qp->ibqp.qp_context);
+		}
+	}
+
+	notify_eq(&dev->aeq.eq);
+}
+
+int erdma_aeq_init(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq.eq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+		&eq->qbuf_dma_addr, GFP_KERNEL);
+	if (!eq->qbuf)
+		return -ENOMEM;
+
+	eq->db_info = eq->qbuf + buf_size;
+
+	memset(eq->qbuf, 0, buf_size);
+	memset(eq->db_info, 0, 8);
+
+	spin_lock_init(&eq->lock);
+	atomic64_set(&eq->event_num, 0);
+	atomic64_set(&eq->notify_num, 0);
+
+	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
+	eq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_REGS_AEQ_DB_REG);
+	eq->ci = 0;
+
+	eq->owner = 1;
+	dev->aeq.dev = dev;
+
+	dev->aeq.ready = 1;
+
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG, upper_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_L_REG, lower_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
+	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG, eq->qbuf_dma_addr + buf_size);
+
+	return 0;
+}
+
+void erdma_aeq_destroy(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq.eq;
+	u32 buf_size  = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+
+	dev->aeq.ready = 0;
+
+	dma_free_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+		eq->qbuf, eq->qbuf_dma_addr);
+}
+
+
+#define MAX_POLL_CHUNK_SIZE 16
+void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
+{
+	int cqn;
+	struct erdma_cq *cq;
+	struct erdma_dev *dev = ceq_cb->dev;
+	u32 poll_cnt = 0;
+
+	if (!ceq_cb->ready)
+		return;
+
+	while ((cqn = erdma_poll_ceq_event(&ceq_cb->eq)) != -1) {
+		poll_cnt++;
+		if (cqn == 0)
+			continue;
+
+		cq = find_cq_by_cqn(dev, cqn);
+		if (!cq)
+			continue;
+
+		if (cq->ibcq.comp_handler)
+			cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
+		if (poll_cnt >= MAX_POLL_CHUNK_SIZE)
+			break;
+	}
+
+	notify_eq(&ceq_cb->eq);
+}
+
+
+static irqreturn_t erdma_intr_ceq_handler(int irq, void *data)
+{
+	struct erdma_eq_cb *ceq_cb = data;
+
+	tasklet_schedule(&ceq_cb->tasklet);
+
+	return IRQ_HANDLED;
+}
+
+void erdma_intr_ceq_task(unsigned long data)
+{
+	erdma_ceq_completion_handler((struct erdma_eq_cb *)data);
+}
+
+static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 eqn)
+{
+	u32 cpu;
+	int err;
+	struct erdma_irq_info *irq_info = &dev->ceqs[eqn - 1].irq_info;
+
+	snprintf(irq_info->name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
+		eqn - 1, pci_name(dev->pdev));
+	irq_info->handler = erdma_intr_ceq_handler;
+	irq_info->data = &dev->ceqs[eqn - 1];
+	irq_info->msix_vector = pci_irq_vector(dev->pdev, eqn);
+
+	tasklet_init(&dev->ceqs[eqn - 1].tasklet, erdma_intr_ceq_task,
+			(unsigned long)&dev->ceqs[eqn - 1]);
+
+	cpu = cpumask_local_spread(eqn, dev->numa_node);
+	irq_info->cpu = cpu;
+	cpumask_set_cpu(cpu, &irq_info->affinity_hint_mask);
+	dev_info(&dev->pdev->dev, "setup irq:%p vector:%d name:%s\n",
+		 irq_info,
+		 irq_info->msix_vector,
+		 irq_info->name);
+
+	err = request_irq(irq_info->msix_vector, irq_info->handler, 0,
+		irq_info->name, irq_info->data);
+	if (err) {
+		dev_err(&dev->pdev->dev, "failed to request_irq(%d)\n", err);
+		return err;
+	}
+
+	irq_set_affinity_hint(irq_info->msix_vector, &irq_info->affinity_hint_mask);
+
+	return 0;
+}
+
+
+static void erdma_free_ceq_irq(struct erdma_dev *dev, u16 eqn)
+{
+	struct erdma_irq_info *irq_info = &dev->ceqs[eqn - 1].irq_info;
+
+	irq_set_affinity_hint(irq_info->msix_vector, NULL);
+	free_irq(irq_info->msix_vector, irq_info->data);
+}
+
+static inline int
+create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
+{
+	int err;
+	struct erdma_cmdq_create_eq_req req;
+	dma_addr_t db_info_dma_addr;
+
+	ERDMA_CMDQ_BUILD_REQ_HDR(&req, CMDQ_SUBMOD_COMMON, CMDQ_OPCODE_CREATE_EQ);
+	req.eqn = eqn;
+	req.depth = ilog2(eq->depth);
+	req.qbuf_addr = eq->qbuf_dma_addr;
+	req.qtype = 1; /* CEQ */
+	/* Vector index is the same sa EQN. */
+	req.vector_idx = eqn;
+	db_info_dma_addr = eq->qbuf_dma_addr + (eq->depth << EQE_SHIFT);
+	req.db_dma_addr_l = lower_32_bits(db_info_dma_addr);
+	req.db_dma_addr_h = upper_32_bits(db_info_dma_addr);
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req,
+		sizeof(struct erdma_cmdq_create_eq_req), NULL, NULL);
+	if (err) {
+		dev_err(&dev->pdev->dev,
+			"ERROR: err code = %d, cmd of create eq failed.\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int erdma_ceq_init_one(struct erdma_dev *dev, u16 eqn)
+{
+	/* CEQ indexed from 1, 0 rsvd for CMDQ-EQ. */
+	struct erdma_eq *eq = &dev->ceqs[eqn - 1].eq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+	int ret;
+
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+		&eq->qbuf_dma_addr, GFP_KERNEL);
+	if (!eq->qbuf)
+		return -ENOMEM;
+
+	eq->db_info = eq->qbuf + ERDMA_EXTRA_BUFFER_SIZE;
+
+	memset(eq->qbuf, 0, buf_size);
+	memset(eq->db_info, 0, ERDMA_EXTRA_BUFFER_SIZE);
+
+	spin_lock_init(&eq->lock);
+	atomic64_set(&eq->event_num, 0);
+	atomic64_set(&eq->notify_num, 0);
+
+	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
+	eq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG + eqn * 8);
+	eq->ci = 0;
+	eq->owner = 1;
+	dev->ceqs[eqn - 1].dev = dev;
+
+	ret = create_eq_cmd(dev, eqn, eq);
+	if (ret) {
+		dev->ceqs[eqn - 1].ready = 0;
+		return ret;
+	}
+
+	dev->ceqs[eqn - 1].ready = 1;
+
+	return ret;
+}
+
+static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 eqn)
+{
+	struct erdma_eq *eq = &dev->ceqs[eqn - 1].eq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+	struct erdma_cmdq_destroy_eq_req req;
+	int err;
+
+	dev->ceqs[eqn - 1].ready = 0;
+
+	ERDMA_CMDQ_BUILD_REQ_HDR(&req, CMDQ_SUBMOD_COMMON, CMDQ_OPCODE_DESTROY_EQ);
+	req.eqn = eqn;
+	req.qtype = 1;
+	req.vector_idx = eqn;
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL, NULL);
+	if (err) {
+		dev_err(&dev->pdev->dev,
+			"ERROR: err code = %d, cmd of destroy eq failed.\n", err);
+		return;
+	}
+
+	dma_free_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+		eq->qbuf, eq->qbuf_dma_addr);
+}
+
+int erdma_ceqs_init(struct erdma_dev *dev)
+{
+	u32 i, j;
+	int err = 0;
+
+	for (i = 1; i < dev->irq_num; i++) {
+		err = erdma_ceq_init_one(dev, i);
+		if (err)
+			goto out_err;
+
+		err = erdma_set_ceq_irq(dev, i);
+		if (err) {
+			erdma_ceq_uninit_one(dev, i);
+			goto out_err;
+		}
+	}
+
+	return 0;
+
+out_err:
+	for (j = 1; j < i; j++) {
+		erdma_free_ceq_irq(dev, j);
+		erdma_ceq_uninit_one(dev, j);
+	}
+
+	return err;
+}
+
+void erdma_ceqs_uninit(struct erdma_dev *dev)
+{
+	u32 i;
+
+	for (i = 1; i < dev->irq_num; i++) {
+		erdma_free_ceq_irq(dev, i);
+		erdma_ceq_uninit_one(dev, i);
+	}
+}
-- 
2.27.0

