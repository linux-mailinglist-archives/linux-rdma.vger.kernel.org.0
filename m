Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5747B87A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 03:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhLUCtI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 21:49:08 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52946 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233646AbhLUCtI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 21:49:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.IQ3Pw_1640054944;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.IQ3Pw_1640054944)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:49:05 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next 04/11] RDMA/erdma: Add cmdq implementation
Date:   Tue, 21 Dec 2021 10:48:51 +0800
Message-Id: <20211221024858.25938-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20211221024858.25938-1-chengyou@linux.alibaba.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cmdq is the main control plane channel between erdma driver and hardware.
After erdma device is initialized, the cmdq channel will be active in the
whole lifecycle of this driver.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 489 +++++++++++++++++++++++
 1 file changed, 489 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c

diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
new file mode 100644
index 000000000000..3eca524fca24
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Authors: Cheng Xu <chengyou@linux.alibaba.com>
+ *          Kai Shen <kaishen@linux.alibaba.com>
+ * Copyright (c) 2020-2021, Alibaba Group.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "erdma.h"
+#include "erdma_hw.h"
+#include "erdma_verbs.h"
+
+static inline void arm_cmdq_cq(struct erdma_cmdq *cmdq)
+{
+	u64 db_data = FIELD_PREP(ERDMA_CQDB_CI_MASK, cmdq->cq.ci) |
+		FIELD_PREP(ERDMA_CQDB_ARM_MASK, 1);
+
+	*(u64 *)cmdq->cq.db_info = db_data;
+	writeq(db_data, cmdq->cq.db_addr);
+
+	atomic64_inc(&cmdq->cq.cq_armed_num);
+}
+
+static inline void kick_cmdq_db(struct erdma_cmdq *cmdq)
+{
+	u64 db_data = FIELD_PREP(ERDMA_CMD_HDR_WQEBB_INDEX_MASK, cmdq->sq.pi);
+
+	*(u64 *)cmdq->sq.db_info = db_data;
+	writeq(db_data, cmdq->sq.db_addr);
+}
+
+
+static struct erdma_comp_wait *get_comp_wait(struct erdma_cmdq *cmdq)
+{
+	int comp_idx;
+
+	spin_lock(&cmdq->lock);
+	comp_idx = find_first_zero_bit(cmdq->comp_wait_bitmap, cmdq->max_outstandings);
+	if (comp_idx == cmdq->max_outstandings) {
+		spin_unlock(&cmdq->lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	set_bit(comp_idx, cmdq->comp_wait_bitmap);
+	spin_unlock(&cmdq->lock);
+
+	return &cmdq->wait_pool[comp_idx];
+}
+
+static void put_comp_wait(struct erdma_cmdq *cmdq, struct erdma_comp_wait *comp_wait)
+{
+	int used;
+
+	cmdq->wait_pool[comp_wait->ctx_id].cmd_status = ERDMA_CMD_STATUS_INIT;
+	spin_lock(&cmdq->lock);
+	used = test_and_clear_bit(comp_wait->ctx_id, cmdq->comp_wait_bitmap);
+	spin_unlock(&cmdq->lock);
+
+	WARN_ON(!used);
+}
+
+static int erdma_cmdq_wait_res_init(struct erdma_dev *dev, struct erdma_cmdq *cmdq)
+{
+	int i;
+
+	cmdq->wait_pool = devm_kcalloc(&dev->pdev->dev, cmdq->max_outstandings,
+		sizeof(struct erdma_comp_wait), GFP_KERNEL);
+	if (!cmdq->wait_pool)
+		return -ENOMEM;
+
+	spin_lock_init(&cmdq->lock);
+	cmdq->comp_wait_bitmap = devm_kcalloc(&dev->pdev->dev,
+		BITS_TO_LONGS(cmdq->max_outstandings), sizeof(unsigned long), GFP_KERNEL);
+	if (!cmdq->comp_wait_bitmap) {
+		devm_kfree(&dev->pdev->dev, cmdq->wait_pool);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cmdq->max_outstandings; i++) {
+		init_completion(&cmdq->wait_pool[i].wait_event);
+		cmdq->wait_pool[i].ctx_id = i;
+	}
+
+	return 0;
+}
+
+static int erdma_cmdq_sq_init(struct erdma_dev *dev)
+{
+	struct erdma_cmdq *cmdq = &dev->cmdq;
+	struct erdma_cmdq_sq *sq = &cmdq->sq;
+	u32 buf_size;
+
+	sq->wqebb_cnt = SQEBB_COUNT(ERDMA_CMDQ_SQE_SIZE);
+	sq->depth = cmdq->max_outstandings * sq->wqebb_cnt;
+
+	buf_size = sq->depth << SQEBB_SHIFT;
+
+	sq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+		&sq->qbuf_dma_addr, GFP_KERNEL);
+	if (!sq->qbuf)
+		return -ENOMEM;
+
+	sq->db_info = sq->qbuf + buf_size;
+
+	spin_lock_init(&sq->lock);
+
+	sq->ci = 0;
+	sq->pi = 0;
+	sq->total_cmds = 0;
+	sq->total_comp_cmds = 0;
+
+	sq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_CMDQ_SQDB_REG);
+
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_SQ_ADDR_H_REG, upper_32_bits(sq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_SQ_ADDR_L_REG, lower_32_bits(sq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_DEPTH_REG, sq->depth);
+	erdma_reg_write64(dev, ERDMA_CMDQ_SQ_DB_HOST_ADDR_REG, sq->qbuf_dma_addr + buf_size);
+
+	return 0;
+}
+
+static int erdma_cmdq_cq_init(struct erdma_dev *dev)
+{
+	struct erdma_cmdq *cmdq = &dev->cmdq;
+	struct erdma_cmdq_cq *cq = &cmdq->cq;
+	u32 buf_size;
+
+	cq->depth = cmdq->max_outstandings * 2;
+	buf_size = cq->depth << CQE_SHIFT;
+
+	cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+			&cq->qbuf_dma_addr, GFP_KERNEL);
+	if (!cq->qbuf)
+		return -ENOMEM;
+
+	cq->db_info = cq->qbuf + buf_size;
+
+	memset(cq->qbuf, 0, buf_size + ERDMA_EXTRA_BUFFER_SIZE);
+
+	spin_lock_init(&cq->lock);
+
+	cq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_CMDQ_CQDB_REG);
+	cq->ci = 0;
+	cq->owner = 1;
+
+	atomic64_set(&cq->cq_armed_num, 0);
+
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_CQ_ADDR_H_REG, upper_32_bits(cq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_CQ_ADDR_L_REG, lower_32_bits(cq->qbuf_dma_addr));
+	erdma_reg_write64(dev, ERDMA_CMDQ_CQ_DB_HOST_ADDR_REG, cq->qbuf_dma_addr + buf_size);
+
+	return 0;
+}
+
+static int erdma_cmdq_eq_init(struct erdma_dev *dev)
+{
+	struct erdma_cmdq *cmdq = &dev->cmdq;
+	struct erdma_eq *eq = &cmdq->eq;
+	u32 buf_size;
+
+	eq->depth = cmdq->max_outstandings;
+	buf_size = eq->depth << EQE_SHIFT;
+
+	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, buf_size + ERDMA_EXTRA_BUFFER_SIZE,
+			&eq->qbuf_dma_addr, GFP_KERNEL);
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
+
+	eq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG);
+	eq->ci = 0;
+	eq->owner = 1;
+
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_H_REG, upper_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_L_REG, lower_32_bits(eq->qbuf_dma_addr));
+	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_DEPTH_REG, eq->depth);
+	erdma_reg_write64(dev, ERDMA_CMDQ_EQ_DB_HOST_ADDR_REG, eq->qbuf_dma_addr + buf_size);
+
+	return 0;
+}
+
+int erdma_cmdq_init(struct erdma_dev *dev)
+{
+	int err, i;
+	struct erdma_cmdq *cmdq = &dev->cmdq;
+	u32 status, ctrl;
+
+	cmdq->max_outstandings = ERDMA_CMDQ_MAX_OUTSTANDING;
+	cmdq->dev = dev;
+	cmdq->use_event = 0;
+
+	sema_init(&cmdq->credits, cmdq->max_outstandings);
+
+	err = erdma_cmdq_wait_res_init(dev, cmdq);
+	if (err)
+		return err;
+
+	err = erdma_cmdq_sq_init(dev);
+	if (err)
+		return err;
+
+	err = erdma_cmdq_cq_init(dev);
+	if (err)
+		goto err_destroy_sq;
+
+	err = erdma_cmdq_eq_init(dev);
+	if (err)
+		goto err_destroy_cq;
+
+	ctrl = FIELD_PREP(ERDMA_REG_DEV_CTRL_INIT_MASK, 1);
+	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG, ctrl);
+
+	for (i = 0; i < ERDMA_WAIT_DEV_DONE_CNT; i++) {
+		status = erdma_reg_read32_filed(dev, ERDMA_REGS_DEV_ST_REG,
+			ERDMA_REG_DEV_ST_INIT_DONE_MASK);
+		if (status)
+			break;
+
+		msleep(ERDMA_REG_ACCESS_WAIT_MS);
+	}
+
+	if (i == ERDMA_WAIT_DEV_DONE_CNT) {
+		dev_err(&dev->pdev->dev, "wait init done failed.\n");
+		err = -ETIMEDOUT;
+		goto err_destroy_eq;
+	}
+
+	set_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
+
+	return 0;
+
+err_destroy_eq:
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->eq.depth << EQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
+
+err_destroy_cq:
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->cq.depth << CQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
+
+err_destroy_sq:
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->sq.depth << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
+
+	return err;
+}
+
+void erdma_finish_cmdq_init(struct erdma_dev *dev)
+{
+	/* after device init successfully, change cmdq to event mode. */
+	dev->cmdq.use_event = true;
+	arm_cmdq_cq(&dev->cmdq);
+}
+
+void erdma_cmdq_destroy(struct erdma_dev *dev)
+{
+	struct erdma_cmdq *cmdq = &dev->cmdq;
+
+	clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
+
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->eq.depth << EQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->sq.depth << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
+	dma_free_coherent(&dev->pdev->dev,
+		(cmdq->cq.depth << CQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE,
+		cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
+}
+
+static inline void *get_cmdq_sqe(struct erdma_cmdq *cmdq, u16 idx)
+{
+	idx &= (cmdq->sq.depth - 1);
+	return cmdq->sq.qbuf + (idx << SQEBB_SHIFT);
+}
+
+static inline void *get_cmdq_cqe(struct erdma_cmdq *cmdq, u16 idx)
+{
+	idx &= (cmdq->cq.depth - 1);
+	return cmdq->cq.qbuf + (idx << CQE_SHIFT);
+}
+
+static void push_cmdq_sqe(struct erdma_cmdq *cmdq, u64 *req,
+			 size_t req_len, struct erdma_comp_wait *comp_wait)
+{
+	__le64 *wqe;
+	u64 hdr = *req;
+
+	comp_wait->cmd_status = ERDMA_CMD_STATUS_ISSUED;
+	reinit_completion(&comp_wait->wait_event);
+	comp_wait->sq_pi = cmdq->sq.pi;
+
+	wqe = get_cmdq_sqe(cmdq, cmdq->sq.pi);
+	memcpy(wqe, req, req_len);
+
+	cmdq->sq.pi += cmdq->sq.wqebb_cnt;
+	hdr |= FIELD_PREP(ERDMA_CMD_HDR_WQEBB_INDEX_MASK, cmdq->sq.pi);
+	hdr |= FIELD_PREP(ERDMA_CMD_HDR_CONTEXT_COOKIE, comp_wait->ctx_id);
+	hdr |= FIELD_PREP(ERDMA_CMD_HDR_WQEBB_CNT_MASK, cmdq->sq.wqebb_cnt - 1);
+	*wqe = hdr;
+
+	cmdq->sq.total_cmds++;
+
+	kick_cmdq_db(cmdq);
+}
+
+static void erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq, __be32 *cqe)
+{
+	struct erdma_comp_wait *comp_wait;
+	u16 sqe_idx, ctx_id;
+	u64 *sqe;
+	int i;
+	u32 hdr0 = __be32_to_cpu(*cqe);
+
+	sqe_idx = __be32_to_cpu(*(cqe + 1));
+	sqe = (u64 *)get_cmdq_sqe(cmdq, sqe_idx);
+
+	ctx_id = FIELD_GET(ERDMA_CMD_HDR_CONTEXT_COOKIE, *sqe);
+	comp_wait = &cmdq->wait_pool[ctx_id];
+	if (comp_wait->cmd_status != ERDMA_CMD_STATUS_ISSUED)
+		return;
+
+	comp_wait->cmd_status = ERDMA_CMD_STATUS_FINISHED;
+	comp_wait->comp_status = FIELD_GET(ERDMA_CQE_HDR_SYNDROME_MASK, hdr0);
+	cmdq->sq.ci += cmdq->sq.wqebb_cnt;
+
+	for (i = 0; i < 4; i++)
+		comp_wait->comp_data[i] = __be32_to_cpu(*(cqe + 2 + i));
+
+	if (cmdq->use_event)
+		complete(&comp_wait->wait_event);
+}
+
+static void erdma_polling_cmd_completions(struct erdma_cmdq *cmdq)
+{
+	u32 hdr;
+	__be32 *cqe;
+	unsigned long flags;
+	u16 comp_num = 0;
+	u8 owner, expect_owner;
+	u16 cqe_idx;
+
+	spin_lock_irqsave(&cmdq->cq.lock, flags);
+
+	expect_owner = cmdq->cq.owner;
+	cqe_idx = cmdq->cq.ci & (cmdq->cq.depth - 1);
+
+	while (1) {
+		cqe = (__be32 *)get_cmdq_cqe(cmdq, cqe_idx);
+		hdr = __be32_to_cpu(READ_ONCE(*cqe));
+
+		owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK, hdr);
+		if (owner != expect_owner)
+			break;
+
+		dma_rmb();
+		erdma_poll_single_cmd_completion(cmdq, cqe);
+		comp_num++;
+		if (cqe_idx == cmdq->cq.depth - 1) {
+			cqe_idx = 0;
+			expect_owner = !expect_owner;
+		} else {
+			cqe_idx++;
+		}
+	}
+
+	if (comp_num) {
+		cmdq->cq.ci += comp_num;
+		cmdq->cq.owner = expect_owner;
+		cmdq->sq.total_comp_cmds += comp_num;
+
+		if (cmdq->use_event)
+			arm_cmdq_cq(cmdq);
+	}
+
+	spin_unlock_irqrestore(&cmdq->cq.lock, flags);
+}
+
+void erdma_cmdq_completion_handler(struct erdma_dev *dev)
+{
+	int cqn, got_event = 0;
+
+	if (!test_bit(ERDMA_CMDQ_STATE_OK_BIT, &dev->cmdq.state) || !dev->cmdq.use_event)
+		return;
+
+	while ((cqn = erdma_poll_ceq_event(&dev->cmdq.eq)) != -1)
+		got_event++;
+
+	if (got_event)
+		erdma_polling_cmd_completions(&dev->cmdq);
+
+	notify_eq(&dev->cmdq.eq);
+}
+
+static int erdma_poll_cmd_completion(struct erdma_comp_wait *comp_ctx,
+				     struct erdma_cmdq *cmdq, u32 timeout)
+{
+	unsigned long comp_timeout = jiffies + msecs_to_jiffies(timeout);
+
+	while (1) {
+		erdma_polling_cmd_completions(cmdq);
+		if (comp_ctx->cmd_status != ERDMA_CMD_STATUS_ISSUED)
+			break;
+
+		if (time_is_before_jiffies(comp_timeout))
+			return -ETIME;
+
+		msleep(20);
+	}
+
+	return 0;
+}
+
+static int erdma_wait_cmd_completion(struct erdma_comp_wait *comp_ctx,
+				     struct erdma_cmdq *cmdq, u32 timeout)
+{
+	unsigned long flags = 0;
+
+	wait_for_completion_timeout(&comp_ctx->wait_event,
+		msecs_to_jiffies(timeout));
+
+	if (unlikely(comp_ctx->cmd_status != ERDMA_CMD_STATUS_FINISHED)) {
+		spin_lock_irqsave(&cmdq->cq.lock, flags);
+		comp_ctx->cmd_status = ERDMA_CMD_STATUS_TIMEOUT;
+		spin_unlock_irqrestore(&cmdq->cq.lock, flags);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size, u64 *resp0, u64 *resp1)
+{
+	struct erdma_comp_wait *comp_wait;
+	int ret;
+
+	if (!test_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state))
+		return -ENODEV;
+
+	down(&cmdq->credits);
+
+	comp_wait = get_comp_wait(cmdq);
+	if (IS_ERR(comp_wait)) {
+		clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
+		set_bit(ERDMA_CMDQ_STATE_CTX_ERR_BIT, &cmdq->state);
+		up(&cmdq->credits);
+		return PTR_ERR(comp_wait);
+	}
+
+	spin_lock(&cmdq->sq.lock);
+	push_cmdq_sqe(cmdq, req, req_size, comp_wait);
+	spin_unlock(&cmdq->sq.lock);
+
+	if (cmdq->use_event)
+		ret = erdma_wait_cmd_completion(comp_wait, cmdq, ERDMA_CMDQ_TIMEOUT_MS);
+	else
+		ret = erdma_poll_cmd_completion(comp_wait, cmdq, ERDMA_CMDQ_TIMEOUT_MS);
+
+	if (ret) {
+		set_bit(ERDMA_CMDQ_STATE_TIMEOUT_BIT, &cmdq->state);
+		clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
+		goto out;
+	}
+
+	ret = comp_wait->comp_status;
+
+	if (resp0 && resp1) {
+		*resp0 = *((u64 *)&comp_wait->comp_data[0]);
+		*resp1 = *((u64 *)&comp_wait->comp_data[2]);
+	}
+	put_comp_wait(cmdq, comp_wait);
+
+out:
+	up(&cmdq->credits);
+
+	return ret;
+}
-- 
2.27.0

