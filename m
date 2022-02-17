Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0ED4B963C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiBQDBn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:01:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiBQDBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:01:43 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C865C2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:01:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4fpj0D_1645066883;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V4fpj0D_1645066883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 11:01:24 +0800
From:   Cheng Xu <chengyou.xc@alibaba-inc.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH for-next v3 06/12] RDMA/erdma: Add event queue implementation
Date:   Thu, 17 Feb 2022 11:01:10 +0800
Message-Id: <20220217030116.6324-7-chengyou.xc@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Cheng Xu <chengyou@linux.alibaba.com>

Event queue (EQ) is the main notifcaition way from erdma hardware to its
driver. Each erdma device contains 2 kinds EQs: asynchronous EQ (AEQ) and
completion EQ (CEQ). Per device has 1 AEQ, which used for RDMA async event
report, and max to 32 CEQs (numbered for CEQ0 to CEQ31). CEQ0 is used for
cmdq completion event report, and the reset CEQs are used for RDMA
completion event report.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_eq.c | 366 +++++++++++++++++++++++++
 1 file changed, 366 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c

diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
new file mode 100644
index 000000000000..2a2215710e94
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+
+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
+/*          Kai Shen <kaishen@linux.alibaba.com> */
+/* Copyright (c) 2020-2022, Alibaba Group. */
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
+void notify_eq(struct erdma_eq *eq)
+{
+	u64 db_data = FIELD_PREP(ERDMA_EQDB_CI_MASK, eq->ci) |
+		      FIELD_PREP(ERDMA_EQDB_ARM_MASK, 1);
+
+	*eq->db_record = db_data;
+	writeq(db_data, eq->db_addr);
+
+	atomic64_inc(&eq->notify_num);
+}
+
+static void *get_eq_entry(struct erdma_eq *eq, u16 idx)
+{
+	idx &= (eq->depth - 1);
+
+	return eq->qbuf + (idx << EQE_SHIFT);
+}
+
+static void *get_valid_eqe(struct erdma_eq *eq)
+{
+	u64 *eqe = (u64 *)get_eq_entry(eq, eq->ci);
+	u64 val = READ_ONCE(*eqe);
+
+	if (FIELD_GET(ERDMA_CEQE_HDR_O_MASK, val) == eq->owner) {
+		dma_rmb();
+		eq->ci++;
+		if ((eq->ci & (eq->depth - 1)) == 0)
+			eq->owner = !eq->owner;
+
+		atomic64_inc(&eq->event_num);
+		return eqe;
+	}
+
+	return NULL;
+}
+
+static int erdma_poll_aeq_event(struct erdma_eq *aeq, void *out)
+{
+	struct erdma_aeqe *aeqe;
+
+	aeqe = (struct erdma_aeqe *)get_valid_eqe(aeq);
+	if (aeqe && out) {
+		memcpy(out, aeqe, EQE_SIZE);
+		return 1;
+	}
+
+	return 0;
+}
+
+int erdma_poll_ceq_event(struct erdma_eq *ceq)
+{
+	u64 *ceqe;
+	u64 val;
+
+	ceqe = (u64 *)get_valid_eqe(ceq);
+	if (ceqe) {
+		val = READ_ONCE(*ceqe);
+		return FIELD_GET(ERDMA_CEQE_HDR_CQN_MASK, val);
+	}
+
+	return -1;
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
+	while (erdma_poll_aeq_event(&dev->aeq, &aeqe)) {
+		if (FIELD_GET(ERDMA_AEQE_HDR_TYPE_MASK, aeqe.hdr) ==
+		    ERDMA_AE_TYPE_CQ_ERR) {
+			cqn = aeqe.event_data0;
+			cq = find_cq_by_cqn(dev, cqn);
+			if (!cq)
+				continue;
+			event.device = cq->ibcq.device;
+			event.element.cq = &cq->ibcq;
+			event.event = IB_EVENT_CQ_ERR;
+			if (cq->ibcq.event_handler)
+				cq->ibcq.event_handler(&event,
+						       cq->ibcq.cq_context);
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
+				qp->ibqp.event_handler(&event,
+						       qp->ibqp.qp_context);
+		}
+	}
+
+	notify_eq(&dev->aeq);
+}
+
+int erdma_aeq_init(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
+				      WARPPED_BUFSIZE(buf_size),
+				      &eq->qbuf_dma_addr, GFP_KERNEL);
+	if (!eq->qbuf)
+		return -ENOMEM;
+
+	memset(eq->qbuf, 0, WARPPED_BUFSIZE(buf_size));
+
+	spin_lock_init(&eq->lock);
+	atomic64_set(&eq->event_num, 0);
+	atomic64_set(&eq->notify_num, 0);
+
+	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
+	eq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_REGS_AEQ_DB_REG);
+	eq->db_record = (u64 *)(eq->qbuf + buf_size);
+	eq->owner = 1;
+
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
+			  upper_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_L_REG,
+			  lower_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
+	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG,
+			  eq->qbuf_dma_addr + buf_size);
+
+	return 0;
+}
+
+void erdma_aeq_destroy(struct erdma_dev *dev)
+{
+	struct erdma_eq *eq = &dev->aeq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+
+	dma_free_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size), eq->qbuf,
+			  eq->qbuf_dma_addr);
+}
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
+		if (rdma_is_kernel_res(&cq->ibcq.res))
+			cq->kern_cq.cmdsn++;
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
+static irqreturn_t erdma_intr_ceq_handler(int irq, void *data)
+{
+	struct erdma_eq_cb *ceq_cb = data;
+
+	tasklet_schedule(&ceq_cb->tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void erdma_intr_ceq_task(unsigned long data)
+{
+	erdma_ceq_completion_handler((struct erdma_eq_cb *)data);
+}
+
+static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
+{
+	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
+	cpumask_t affinity_hint_mask;
+	u32 cpu;
+	int err;
+
+	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
+		ceqn, pci_name(dev->pdev));
+	eqc->msix_vector = pci_irq_vector(dev->pdev, ceqn + 1);
+
+	tasklet_init(&dev->ceqs[ceqn].tasklet, erdma_intr_ceq_task,
+		     (unsigned long)&dev->ceqs[ceqn]);
+
+	cpu = cpumask_local_spread(ceqn + 1, dev->attrs.numa_node);
+	cpumask_set_cpu(cpu, &affinity_hint_mask);
+
+	err = request_irq(eqc->msix_vector, erdma_intr_ceq_handler, 0,
+			  eqc->irq_name, eqc);
+	if (err) {
+		dev_err(&dev->pdev->dev, "failed to request_irq(%d)\n", err);
+		return err;
+	}
+
+	irq_set_affinity_hint(eqc->msix_vector, &affinity_hint_mask);
+
+	return 0;
+}
+
+static void erdma_free_ceq_irq(struct erdma_dev *dev, u16 ceqn)
+{
+	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
+
+	irq_set_affinity_hint(eqc->msix_vector, NULL);
+	free_irq(eqc->msix_vector, eqc);
+}
+
+static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
+{
+	struct erdma_cmdq_create_eq_req req;
+	dma_addr_t db_info_dma_addr;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_CREATE_EQ);
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
+	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req,
+				   sizeof(struct erdma_cmdq_create_eq_req),
+				   NULL, NULL);
+}
+
+static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
+{
+	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+	int ret;
+
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
+				      WARPPED_BUFSIZE(buf_size),
+				      &eq->qbuf_dma_addr, GFP_KERNEL);
+	if (!eq->qbuf)
+		return -ENOMEM;
+
+	memset(eq->qbuf, 0, WARPPED_BUFSIZE(buf_size));
+
+	spin_lock_init(&eq->lock);
+	atomic64_set(&eq->event_num, 0);
+	atomic64_set(&eq->notify_num, 0);
+
+	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
+	eq->db_addr = (u64 __iomem *)(dev->func_bar +
+				      ERDMA_REGS_CEQ_DB_BASE_REG +
+				      (ceqn + 1) * 8);
+	eq->db_record = (u64 *)(eq->qbuf + buf_size);
+	eq->ci = 0;
+	eq->owner = 1;
+	dev->ceqs[ceqn].dev = dev;
+
+	/* CEQ indexed from 1, 0 rsvd for CMDQ-EQ. */
+	ret = create_eq_cmd(dev, ceqn + 1, eq);
+	dev->ceqs[ceqn].ready = ret ? false : true;
+
+	return ret;
+}
+
+static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
+{
+	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
+	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
+	struct erdma_cmdq_destroy_eq_req req;
+	int err;
+
+	dev->ceqs[ceqn].ready = 0;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_DESTROY_EQ);
+	/* CEQ indexed from 1, 0 rsvd for CMDQ-EQ. */
+	req.eqn = ceqn + 1;
+	req.qtype = 1;
+	req.vector_idx = ceqn + 1;
+
+	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
+				  NULL);
+	if (err)
+		return;
+
+	dma_free_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size), eq->qbuf,
+			  eq->qbuf_dma_addr);
+}
+
+int erdma_ceqs_init(struct erdma_dev *dev)
+{
+	u32 i, j;
+	int err = 0;
+
+	for (i = 0; i < dev->attrs.irq_num - 1; i++) {
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
+	for (j = 0; j < i; j++) {
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
+	for (i = 0; i < dev->attrs.irq_num - 1; i++) {
+		erdma_free_ceq_irq(dev, i);
+		erdma_ceq_uninit_one(dev, i);
+	}
+}
-- 
2.27.0

