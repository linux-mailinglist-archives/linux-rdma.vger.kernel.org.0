Return-Path: <linux-rdma+bounces-15370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBAD0326F
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F73310EAB4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AFD3DA7C7;
	Thu,  8 Jan 2026 11:30:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B733D6F3C
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871843; cv=none; b=CZPNvHvs+L8nS3E48nCusrABFKleeHzofOnvi3heoldjYJbbMXoHibKCiSPzhmkjRhtLVhFu/UgcWvTBSR7pzUiebUCcTev+BeVNyZyYS9utEeOTgqFCqpTtnCmzqbxtp+R6/+02C0ELklsWN9nJNciv03MTr+RCYfaV45KAUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871843; c=relaxed/simple;
	bh=W4jDJZ3PZQfnSKKZcIKRnwIVMoDC0DhTS91sds5oX3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H+Ha7TdH4gAEA5pEzl/JVDEW4PdZwpHjLj8fUIJb3sX3BeXw0NsPAyyklzL/TZUfjsvi8fbW4uwfLZd4olP6ICUN41mG9ylfcu6CjvD1EHmocmpLaaav9n+AC1iNZhS2RGg/ktfauCAjH5qb18x4jx2j8ZqDFR1M2OpXvIRWvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dn2fx2Jgtz1T4GY;
	Thu,  8 Jan 2026 19:26:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D4DF04056A;
	Thu,  8 Jan 2026 19:30:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 8 Jan 2026 19:30:33 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Support drain SQ and RQ
Date: Thu, 8 Jan 2026 19:30:32 +0800
Message-ID: <20260108113032.856306-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Some ULPs, e.g. rpcrdma, rely on drain_qp() to ensure all outstanding
requests are completed before releasing related memory. If drain_qp()
fails, ULPs may release memory directly, and in-flight WRs may later be
flushed after the memory is freed, potentially leading to UAF.

drain_qp() failures can happen when HW enters an error state or is
reset. Add support to drain SQ and RQ in such cases by posting a
fake WR during reset, so the driver can process all remaining WRs in
sequence and generate corresponding completions.

Always invoke comp_handler() in drain process to ensure completions
are not lost under concurrency (e.g. concurrent post_send() and
reset, or QPs created during reset). If the CQ is already processed,
cancel any already scheduled comp_handler() to avoid concurrency
issues.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 166 +++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a2ae4f33e459..5233546ff330 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -876,6 +876,170 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	return ret;
 }
 
+static int hns_roce_push_drain_wr(struct hns_roce_wq *wq, struct ib_cq *cq,
+				  u64 wr_id)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&wq->lock, flags);
+	if (hns_roce_wq_overflow(wq, 1, cq)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	wq->wrid[wq->head & (wq->wqe_cnt - 1)] = wr_id;
+	wq->head++;
+
+out:
+	spin_unlock_irqrestore(&wq->lock, flags);
+	return ret;
+}
+
+struct hns_roce_drain_cqe {
+	struct ib_cqe cqe;
+	struct completion done;
+};
+
+static void hns_roce_drain_qp_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct hns_roce_drain_cqe *cqe = container_of(wc->wr_cqe,
+						      struct hns_roce_drain_cqe,
+						      cqe);
+	complete(&cqe->done);
+}
+
+static void handle_drain_completion(struct ib_cq *ibcq,
+				    struct hns_roce_drain_cqe *drain,
+				    struct hns_roce_dev *hr_dev)
+{
+#define TIMEOUT (HZ / 10)
+	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
+	unsigned long flags;
+	bool triggered;
+
+	if (ibcq->poll_ctx == IB_POLL_DIRECT) {
+		while (wait_for_completion_timeout(&drain->done, TIMEOUT) <= 0)
+			ib_process_cq_direct(ibcq, -1);
+		return;
+	}
+
+	if (hr_dev->state < HNS_ROCE_DEVICE_STATE_RST_DOWN)
+		goto waiting_done;
+
+	spin_lock_irqsave(&hr_cq->lock, flags);
+	triggered = hr_cq->is_armed;
+	hr_cq->is_armed = 1;
+	spin_unlock_irqrestore(&hr_cq->lock, flags);
+
+	/* Triggered means this cq is processing or has been processed
+	 * by hns_roce_handle_device_err() or this function. We need to
+	 * cancel the already invoked comp_handler() to avoid concurrency.
+	 * If it has not been triggered, we can directly invoke
+	 * comp_handler().
+	 */
+	if (triggered) {
+		switch (ibcq->poll_ctx) {
+		case IB_POLL_SOFTIRQ:
+			irq_poll_disable(&ibcq->iop);
+			irq_poll_enable(&ibcq->iop);
+			break;
+		case IB_POLL_WORKQUEUE:
+		case IB_POLL_UNBOUND_WORKQUEUE:
+			cancel_work_sync(&ibcq->work);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+		}
+	}
+
+	if (ibcq->comp_handler)
+		ibcq->comp_handler(ibcq, ibcq->cq_context);
+
+waiting_done:
+	if (ibcq->comp_handler)
+		wait_for_completion(&drain->done);
+}
+
+void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct hns_roce_drain_cqe rdrain = {};
+	const struct ib_recv_wr *bad_rwr;
+	struct ib_cq *cq = ibqp->recv_cq;
+	struct ib_recv_wr rwr = {};
+	int ret;
+
+	ret = ib_modify_qp(ibqp, &attr, IB_QP_STATE);
+	if (ret && hr_dev->state < HNS_ROCE_DEVICE_STATE_RST_DOWN) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to modify qp during drain rq, ret = %d.\n",
+				      ret);
+		return;
+	}
+
+	rwr.wr_cqe = &rdrain.cqe;
+	rdrain.cqe.done = hns_roce_drain_qp_done;
+	init_completion(&rdrain.done);
+
+	if (hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)
+		ret = hns_roce_push_drain_wr(&hr_qp->rq, cq, rwr.wr_id);
+	else
+		ret = hns_roce_v2_post_recv(ibqp, &rwr, &bad_rwr);
+	if (ret) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to post recv for drain rq, ret = %d.\n",
+				      ret);
+		return;
+	}
+
+	handle_drain_completion(cq, &rdrain, hr_dev);
+}
+
+void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct hns_roce_drain_cqe sdrain = {};
+	const struct ib_send_wr *bad_swr;
+	struct ib_cq *cq = ibqp->send_cq;
+	struct ib_rdma_wr swr = {
+		.wr = {
+			.next = NULL,
+			{ .wr_cqe	= &sdrain.cqe, },
+			.opcode	= IB_WR_RDMA_WRITE,
+		},
+	};
+	int ret;
+
+	ret = ib_modify_qp(ibqp, &attr, IB_QP_STATE);
+	if (ret && hr_dev->state < HNS_ROCE_DEVICE_STATE_RST_DOWN) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to modify qp during drain sq, ret = %d.\n",
+				      ret);
+		return;
+	}
+
+	sdrain.cqe.done = hns_roce_drain_qp_done;
+	init_completion(&sdrain.done);
+
+	if (hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)
+		ret = hns_roce_push_drain_wr(&hr_qp->sq, cq, swr.wr.wr_id);
+	else
+		ret = hns_roce_v2_post_send(ibqp, &swr.wr, &bad_swr);
+	if (ret) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to post send for drain sq, ret = %d.\n",
+				      ret);
+		return;
+	}
+
+	handle_drain_completion(cq, &sdrain, hr_dev);
+}
+
 static void *get_srq_wqe_buf(struct hns_roce_srq *srq, u32 n)
 {
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
@@ -7040,6 +7204,8 @@ static const struct ib_device_ops hns_roce_v2_dev_ops = {
 	.post_send = hns_roce_v2_post_send,
 	.query_qp = hns_roce_v2_query_qp,
 	.req_notify_cq = hns_roce_v2_req_notify_cq,
+	.drain_rq = hns_roce_v2_drain_rq,
+	.drain_sq = hns_roce_v2_drain_sq,
 };
 
 static const struct ib_device_ops hns_roce_v2_dev_srq_ops = {
-- 
2.33.0


