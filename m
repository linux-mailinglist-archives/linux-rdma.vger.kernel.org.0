Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A12229998
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbgGVN4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 09:56:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39371 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbgGVN4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 09:56:32 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 22 Jul 2020 16:56:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06MDuTPo026773;
        Wed, 22 Jul 2020 16:56:30 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, yaminf@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org, bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 3/3] IB/srpt: use new shared CQ mechanism
Date:   Wed, 22 Jul 2020 16:56:29 +0300
Message-Id: <20200722135629.49467-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722135629.49467-1-maxg@mellanox.com>
References: <20200722135629.49467-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Has the driver use shared CQs provided by the rdma core driver.
This provides an advantage of improved efficiency handling interrupts.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 17 +++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index ef7fcd3..7a4884c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -869,7 +869,7 @@ static int srpt_zerolength_write(struct srpt_rdma_ch *ch)
 
 static void srpt_zerolength_write_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct srpt_rdma_ch *ch = cq->cq_context;
+	struct srpt_rdma_ch *ch = wc->qp->qp_context;
 
 	pr_debug("%s-%d wc->status %d\n", ch->sess_name, ch->qp->qp_num,
 		 wc->status);
@@ -1322,7 +1322,7 @@ static int srpt_abort_cmd(struct srpt_send_ioctx *ioctx)
  */
 static void srpt_rdma_read_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct srpt_rdma_ch *ch = cq->cq_context;
+	struct srpt_rdma_ch *ch = wc->qp->qp_context;
 	struct srpt_send_ioctx *ioctx =
 		container_of(wc->wr_cqe, struct srpt_send_ioctx, rdma_cqe);
 
@@ -1683,7 +1683,7 @@ static void srpt_handle_tsk_mgmt(struct srpt_rdma_ch *ch,
 
 static void srpt_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct srpt_rdma_ch *ch = cq->cq_context;
+	struct srpt_rdma_ch *ch = wc->qp->qp_context;
 	struct srpt_recv_ioctx *ioctx =
 		container_of(wc->wr_cqe, struct srpt_recv_ioctx, ioctx.cqe);
 
@@ -1744,7 +1744,7 @@ static void srpt_process_wait_list(struct srpt_rdma_ch *ch)
  */
 static void srpt_send_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct srpt_rdma_ch *ch = cq->cq_context;
+	struct srpt_rdma_ch *ch = wc->qp->qp_context;
 	struct srpt_send_ioctx *ioctx =
 		container_of(wc->wr_cqe, struct srpt_send_ioctx, ioctx.cqe);
 	enum srpt_command_state state;
@@ -1791,7 +1791,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 		goto out;
 
 retry:
-	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
+	ch->cq = ib_cq_pool_get(sdev->device, ch->rq_size + sq_size, -1,
 				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(ch->cq)) {
 		ret = PTR_ERR(ch->cq);
@@ -1799,6 +1799,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 		       ch->rq_size + sq_size, ret);
 		goto out;
 	}
+	ch->cq_size = ch->rq_size + sq_size;
 
 	qp_init->qp_context = (void *)ch;
 	qp_init->event_handler
@@ -1843,7 +1844,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 		if (retry) {
 			pr_debug("failed to create queue pair with sq_size = %d (%d) - retrying\n",
 				 sq_size, ret);
-			ib_free_cq(ch->cq);
+			ib_cq_pool_put(ch->cq, ch->cq_size);
 			sq_size = max(sq_size / 2, MIN_SRPT_SQ_SIZE);
 			goto retry;
 		} else {
@@ -1869,14 +1870,14 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 
 err_destroy_cq:
 	ch->qp = NULL;
-	ib_free_cq(ch->cq);
+	ib_cq_pool_put(ch->cq, ch->cq_size);
 	goto out;
 }
 
 static void srpt_destroy_ch_ib(struct srpt_rdma_ch *ch)
 {
 	ib_destroy_qp(ch->qp);
-	ib_free_cq(ch->cq);
+	ib_cq_pool_put(ch->cq, ch->cq_size);
 }
 
 /**
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index f31c349..41435a6 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -300,6 +300,7 @@ struct srpt_rdma_ch {
 		} rdma_cm;
 	};
 	struct ib_cq		*cq;
+	u32			cq_size;
 	struct ib_cqe		zw_cqe;
 	struct rcu_head		rcu;
 	struct kref		kref;
-- 
1.8.3.1

