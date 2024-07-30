Return-Path: <linux-rdma+bounces-4115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72271941FB4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F8F286372
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C93DAC1F;
	Tue, 30 Jul 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmbxP6/r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424861BD4E5;
	Tue, 30 Jul 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364473; cv=none; b=Qrjv0rW/5Mg2JUOjZcxZFMYwj0su9ibH4lk+CoJBDOLWRRW96rHwTN75KJ1jGBAKZkPduPJRVmNEPwDCNmP7mKOXDcRtN7NVbEKUJxspXZlEyiapJYqeJdXB8MP71A/TZ8eSZIwnT4FLZSXARMm5T0Ie6FSbkdRcmmRZ0LbUZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364473; c=relaxed/simple;
	bh=WtNE/dmbZmq1ThtIDUkgFnTonDnp8MMPvTwAHTwhhpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIpwAeyqQH5AN+k44RYzkPL+YoIAaFYQ77Uos8VFp8ehbdf7CkBTYEXR3QY6aqRY+yj2H5Xp44Mio3+mw005sw5vRnCpSicTGBUAok1VqY8j8DxRB6cAyiGYCQQGBrxPbkBRAsepR/8/vbsl3Dvh6mkOvi45meq07viV7yRFNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmbxP6/r; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db16b2c1d2so3527715b6e.2;
        Tue, 30 Jul 2024 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364470; x=1722969270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHsWDKW4hHN8DyEjz7y8O8xUw7bLEPYBA03SJ52fByU=;
        b=fmbxP6/rWQmcD38w5LjZpoZaQnRy6R2eTg1jVponMc/4XNayzPnP5ufmPTATwH37OF
         +8baGkjs8T2a213A281qmzjzGGeckcKTTyfFLNdKU00XdQFB3sIzMwANjRRRapMBZ7N8
         8vRFUYNFWDD3ZWqiWlQbHLPAzSYSnd9yBbobt4jPFMaFRpxdnE3n5Zr7dIPEZuQ+Lm8M
         o1dUnA+iGa60VswKlNbDRCunnOxNRXdazNCYCZz0ITz/9j7cdqk+GDlfEgICdAJuzvW6
         QtWn8TwT9/WCJsgKTqCzUVKPNXgqWbFeG8RAb+VN+tJgyDQOG6V4IcUitj5taLtICGnO
         VOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364470; x=1722969270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHsWDKW4hHN8DyEjz7y8O8xUw7bLEPYBA03SJ52fByU=;
        b=hHe+0IlDkrU/66PIF4JFk7cq9Djm5DDj3N+biRNn9T93EcMv9wu1hCZgByryNe2slT
         on51gp4u/3IMdSXrAh59AY0NoDlPaV7k4Ki+ZpqyfPH1oYpACtytLcRl4uhB6TPQ0DoA
         W1/oHGB93LBVPd6yp6FOkwWeFPTvdQSEBt6t+VsTuHh0d6YKNjv9UGzhQwt19vPp9VZB
         Vg2TWDnMIdGk06dVMQ+Rwt4pbE0rXNEIpxlTXZSk1IQIpUBnVJq8lxOWAADUkn/dGbqc
         4Z8v1C2eWnlMOrqobBulaPGS9KDpUxBGKNpyoYFtyQLpSoufZGdIxAbAKv3NOfQVASVd
         klfg==
X-Forwarded-Encrypted: i=1; AJvYcCWE31aWeYnZ1JzKxZA5Va/tBVsDWEXBzq0mOyfAlhf/HSKF+EwqCDpkHpv1xsIs4lqYT1iQ3kmKBgVnDBzSLB2RxtIUcbA0yoQHirjm0806zdS3Lnn9sz09jkMLqMvOOq3qumtzgAhDLJPm6/OQ5Pet4bV4ixLb27P5c/TYK+VMGw==
X-Gm-Message-State: AOJu0YwffHp6vU/w/I/+2A6u9ZmHjIjoX1exP0UxahpQ7eIM+V04by9G
	8vkBgI2hVjtJ+ru7CjWYSK9pcFY2tpI8YefzbehT06vzYnkGFYNC
X-Google-Smtp-Source: AGHT+IFjKAYED3/vuEz7A8UASYPs6YorgrdUyrQaWZQZz08P7/46riBLlqI+PSaBWWESKO+XW1zBLQ==
X-Received: by 2002:a05:6808:1827:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db23a3b32dmr15286599b6e.27.1722364470106;
        Tue, 30 Jul 2024 11:34:30 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:29 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 08/15] net: chelsio: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:56 -0700
Message-Id: <20240730183403.4176544-9-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730183403.4176544-1-allen.lkml@gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the chelsio driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++++-----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +++--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++++++----------
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +--
 7 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index 861edff5ed89..4dab9b0dca86 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -229,11 +229,11 @@ struct sched {
 	unsigned int	port;		/* port index (round robin ports) */
 	unsigned int	num;		/* num skbs in per port queues */
 	struct sched_port p[MAX_NPORTS];
-	struct tasklet_struct sched_tsk;/* tasklet used to run scheduler */
+	struct work_struct sched_bh_work;/* bh_work used to run scheduler */
 	struct sge *sge;
 };
 
-static void restart_sched(struct tasklet_struct *t);
+static void restart_sched(struct work_struct *work);
 
 
 /*
@@ -270,14 +270,14 @@ static const u8 ch_mac_addr[ETH_ALEN] = {
 };
 
 /*
- * stop tasklet and free all pending skb's
+ * stop bh_work and free all pending skb's
  */
 static void tx_sched_stop(struct sge *sge)
 {
 	struct sched *s = sge->tx_sched;
 	int i;
 
-	tasklet_kill(&s->sched_tsk);
+	cancel_work_sync(&s->sched_bh_work);
 
 	for (i = 0; i < MAX_NPORTS; i++)
 		__skb_queue_purge(&s->p[s->port].skbq);
@@ -371,7 +371,7 @@ static int tx_sched_init(struct sge *sge)
 		return -ENOMEM;
 
 	pr_debug("tx_sched_init\n");
-	tasklet_setup(&s->sched_tsk, restart_sched);
+	INIT_WORK(&s->sched_bh_work, restart_sched);
 	s->sge = sge;
 	sge->tx_sched = s;
 
@@ -1300,12 +1300,12 @@ static inline void reclaim_completed_tx(struct sge *sge, struct cmdQ *q)
 }
 
 /*
- * Called from tasklet. Checks the scheduler for any
+ * Called from bh context. Checks the scheduler for any
  * pending skbs that can be sent.
  */
-static void restart_sched(struct tasklet_struct *t)
+static void restart_sched(struct work_struct *work)
 {
-	struct sched *s = from_tasklet(s, t, sched_tsk);
+	struct sched *s = from_work(s, work, sched_bh_work);
 	struct sge *sge = s->sge;
 	struct adapter *adapter = sge->adapter;
 	struct cmdQ *q = &sge->cmdQ[0];
@@ -1451,7 +1451,8 @@ static unsigned int update_tx_info(struct adapter *adapter,
 			writel(F_CMDQ0_ENABLE, adapter->regs + A_SG_DOORBELL);
 		}
 		if (sge->tx_sched)
-			tasklet_hi_schedule(&sge->tx_sched->sched_tsk);
+			queue_work(system_bh_highpri_wq,
+				   &sge->tx_sched->sched_bh_work);
 
 		flags &= ~F_CMDQ0_ENABLE;
 	}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index fca9533bc011..846040f5e638 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -53,6 +53,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_classify.h>
 #include <linux/crash_dump.h>
+#include <linux/workqueue.h>
 #include <linux/thermal.h>
 #include <asm/io.h>
 #include "t4_chip_type.h"
@@ -880,7 +881,7 @@ struct sge_uld_txq {               /* state for an SGE offload Tx queue */
 	struct sge_txq q;
 	struct adapter *adap;
 	struct sk_buff_head sendq;  /* list of backpressured packets */
-	struct tasklet_struct qresume_tsk; /* restarts the queue */
+	struct work_struct qresume_bh_work; /* restarts the queue */
 	bool service_ofldq_running; /* service_ofldq() is processing sendq */
 	u8 full;                    /* the Tx ring is full */
 	unsigned long mapping_err;  /* # of I/O MMU packet mapping errors */
@@ -890,7 +891,7 @@ struct sge_ctrl_txq {               /* state for an SGE control Tx queue */
 	struct sge_txq q;
 	struct adapter *adap;
 	struct sk_buff_head sendq;  /* list of backpressured packets */
-	struct tasklet_struct qresume_tsk; /* restarts the queue */
+	struct work_struct qresume_bh_work; /* restarts the queue */
 	u8 full;                    /* the Tx ring is full */
 } ____cacheline_aligned_in_smp;
 
@@ -946,7 +947,7 @@ struct sge_eosw_txq {
 
 	u32 hwqid; /* Underlying hardware queue index */
 	struct net_device *netdev; /* Pointer to netdevice */
-	struct tasklet_struct qresume_tsk; /* Restarts the queue */
+	struct work_struct qresume_bh_work; /* Restarts the queue */
 	struct completion completion; /* completion for FLOWC rendezvous */
 };
 
@@ -2107,7 +2108,7 @@ void free_tx_desc(struct adapter *adap, struct sge_txq *q,
 void cxgb4_eosw_txq_free_desc(struct adapter *adap, struct sge_eosw_txq *txq,
 			      u32 ndesc);
 int cxgb4_ethofld_send_flowc(struct net_device *dev, u32 eotid, u32 tc);
-void cxgb4_ethofld_restart(struct tasklet_struct *t);
+void cxgb4_ethofld_restart(struct work_struct *work);
 int cxgb4_ethofld_rx_handler(struct sge_rspq *q, const __be64 *rsp,
 			     const struct pkt_gl *si);
 void free_txq(struct adapter *adap, struct sge_txq *q);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2418645c8823..179517e90da7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -589,7 +589,7 @@ static int fwevtq_handler(struct sge_rspq *q, const __be64 *rsp,
 			struct sge_uld_txq *oq;
 
 			oq = container_of(txq, struct sge_uld_txq, q);
-			tasklet_schedule(&oq->qresume_tsk);
+			queue_work(system_bh_wq, &oq->qresume_bh_work);
 		}
 	} else if (opcode == CPL_FW6_MSG || opcode == CPL_FW4_MSG) {
 		const struct cpl_fw6_msg *p = (void *)rsp;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
index 338b04f339b3..c165d3393e6e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
@@ -114,7 +114,7 @@ static int cxgb4_init_eosw_txq(struct net_device *dev,
 	eosw_txq->cred = adap->params.ofldq_wr_cred;
 	eosw_txq->hwqid = hwqid;
 	eosw_txq->netdev = dev;
-	tasklet_setup(&eosw_txq->qresume_tsk, cxgb4_ethofld_restart);
+	INIT_WORK(&eosw_txq->qresume_bh_work, cxgb4_ethofld_restart);
 	return 0;
 }
 
@@ -143,7 +143,7 @@ static void cxgb4_free_eosw_txq(struct net_device *dev,
 	cxgb4_clean_eosw_txq(dev, eosw_txq);
 	kfree(eosw_txq->desc);
 	spin_unlock_bh(&eosw_txq->lock);
-	tasklet_kill(&eosw_txq->qresume_tsk);
+	cancel_work_sync(&eosw_txq->qresume_bh_work);
 }
 
 static int cxgb4_mqprio_alloc_hw_resources(struct net_device *dev)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
index 5c13bcb4550d..d9bdf0b1eb69 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
@@ -407,7 +407,7 @@ free_sge_txq_uld(struct adapter *adap, struct sge_uld_txq_info *txq_info)
 		struct sge_uld_txq *txq = &txq_info->uldtxq[i];
 
 		if (txq->q.desc) {
-			tasklet_kill(&txq->qresume_tsk);
+			cancel_work_sync(&txq->qresume_bh_work);
 			t4_ofld_eq_free(adap, adap->mbox, adap->pf, 0,
 					txq->q.cntxt_id);
 			free_tx_desc(adap, &txq->q, txq->q.in_use, false);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index de52bcb884c4..d054979ef850 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2769,15 +2769,15 @@ static int ctrl_xmit(struct sge_ctrl_txq *q, struct sk_buff *skb)
 
 /**
  *	restart_ctrlq - restart a suspended control queue
- *	@t: pointer to the tasklet associated with this handler
+ *	@work: pointer to the work struct associated with this handler
  *
  *	Resumes transmission on a suspended Tx control queue.
  */
-static void restart_ctrlq(struct tasklet_struct *t)
+static void restart_ctrlq(struct work_struct *work)
 {
 	struct sk_buff *skb;
 	unsigned int written = 0;
-	struct sge_ctrl_txq *q = from_tasklet(q, t, qresume_tsk);
+	struct sge_ctrl_txq *q = from_work(q, work, qresume_bh_work);
 
 	spin_lock(&q->sendq.lock);
 	reclaim_completed_tx_imm(&q->q);
@@ -3075,13 +3075,13 @@ static int ofld_xmit(struct sge_uld_txq *q, struct sk_buff *skb)
 
 /**
  *	restart_ofldq - restart a suspended offload queue
- *	@t: pointer to the tasklet associated with this handler
+ *	@work: pointer to the work struct associated with this handler
  *
  *	Resumes transmission on a suspended Tx offload queue.
  */
-static void restart_ofldq(struct tasklet_struct *t)
+static void restart_ofldq(struct work_struct *work)
 {
-	struct sge_uld_txq *q = from_tasklet(q, t, qresume_tsk);
+	struct sge_uld_txq *q = from_work(q, work, qresume_bh_work);
 
 	spin_lock(&q->sendq.lock);
 	q->full = 0;            /* the queue actually is completely empty now */
@@ -4020,10 +4020,10 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-void cxgb4_ethofld_restart(struct tasklet_struct *t)
+void cxgb4_ethofld_restart(struct work_struct *work)
 {
-	struct sge_eosw_txq *eosw_txq = from_tasklet(eosw_txq, t,
-						     qresume_tsk);
+	struct sge_eosw_txq *eosw_txq = from_work(eosw_txq, work,
+						     qresume_bh_work);
 	int pktcount;
 
 	spin_lock(&eosw_txq->lock);
@@ -4050,7 +4050,7 @@ void cxgb4_ethofld_restart(struct tasklet_struct *t)
  * @si: the gather list of packet fragments
  *
  * Process a ETHOFLD Tx completion. Increment the cidx here, but
- * free up the descriptors in a tasklet later.
+ * free up the descriptors later in bh_work.
  */
 int cxgb4_ethofld_rx_handler(struct sge_rspq *q, const __be64 *rsp,
 			     const struct pkt_gl *si)
@@ -4117,10 +4117,10 @@ int cxgb4_ethofld_rx_handler(struct sge_rspq *q, const __be64 *rsp,
 
 		spin_unlock(&eosw_txq->lock);
 
-		/* Schedule a tasklet to reclaim SKBs and restart ETHOFLD Tx,
+		/* Schedule a bh work to reclaim SKBs and restart ETHOFLD Tx,
 		 * if there were packets waiting for completion.
 		 */
-		tasklet_schedule(&eosw_txq->qresume_tsk);
+		queue_work(system_bh_wq, &eosw_txq->qresume_bh_work);
 	}
 
 out_done:
@@ -4279,7 +4279,7 @@ static void sge_tx_timer_cb(struct timer_list *t)
 			struct sge_uld_txq *txq = s->egr_map[id];
 
 			clear_bit(id, s->txq_maperr);
-			tasklet_schedule(&txq->qresume_tsk);
+			queue_work(system_bh_wq, &txq->qresume_bh_work);
 		}
 
 	if (!is_t4(adap->params.chip)) {
@@ -4719,7 +4719,7 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 	init_txq(adap, &txq->q, FW_EQ_CTRL_CMD_EQID_G(ntohl(c.cmpliqid_eqid)));
 	txq->adap = adap;
 	skb_queue_head_init(&txq->sendq);
-	tasklet_setup(&txq->qresume_tsk, restart_ctrlq);
+	INIT_WORK(&txq->qresume_bh_work, restart_ctrlq);
 	txq->full = 0;
 	return 0;
 }
@@ -4809,7 +4809,7 @@ int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
 	txq->q.q_type = CXGB4_TXQ_ULD;
 	txq->adap = adap;
 	skb_queue_head_init(&txq->sendq);
-	tasklet_setup(&txq->qresume_tsk, restart_ofldq);
+	INIT_WORK(&txq->qresume_bh_work, restart_ofldq);
 	txq->full = 0;
 	txq->mapping_err = 0;
 	return 0;
@@ -4952,7 +4952,7 @@ void t4_free_sge_resources(struct adapter *adap)
 		struct sge_ctrl_txq *cq = &adap->sge.ctrlq[i];
 
 		if (cq->q.desc) {
-			tasklet_kill(&cq->qresume_tsk);
+			cancel_work_sync(&cq->qresume_bh_work);
 			t4_ctrl_eq_free(adap, adap->mbox, adap->pf, 0,
 					cq->q.cntxt_id);
 			__skb_queue_purge(&cq->sendq);
@@ -5002,7 +5002,7 @@ void t4_sge_start(struct adapter *adap)
  *	t4_sge_stop - disable SGE operation
  *	@adap: the adapter
  *
- *	Stop tasklets and timers associated with the DMA engine.  Note that
+ *	Stop bh works and timers associated with the DMA engine.  Note that
  *	this is effective only if measures have been taken to disable any HW
  *	events that may restart them.
  */
@@ -5025,7 +5025,7 @@ void t4_sge_stop(struct adapter *adap)
 
 			for_each_ofldtxq(&adap->sge, i) {
 				if (txq->q.desc)
-					tasklet_kill(&txq->qresume_tsk);
+					cancel_work_sync(&txq->qresume_bh_work);
 			}
 		}
 	}
@@ -5039,7 +5039,7 @@ void t4_sge_stop(struct adapter *adap)
 
 			for_each_ofldtxq(&adap->sge, i) {
 				if (txq->q.desc)
-					tasklet_kill(&txq->qresume_tsk);
+					cancel_work_sync(&txq->qresume_bh_work);
 			}
 		}
 	}
@@ -5048,7 +5048,7 @@ void t4_sge_stop(struct adapter *adap)
 		struct sge_ctrl_txq *cq = &s->ctrlq[i];
 
 		if (cq->q.desc)
-			tasklet_kill(&cq->qresume_tsk);
+			cancel_work_sync(&cq->qresume_bh_work);
 	}
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index 5b1d746e6563..1f4628178d28 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2587,7 +2587,7 @@ void t4vf_free_sge_resources(struct adapter *adapter)
  *	t4vf_sge_start - enable SGE operation
  *	@adapter: the adapter
  *
- *	Start tasklets and timers associated with the DMA engine.
+ *	Start bh work and timers associated with the DMA engine.
  */
 void t4vf_sge_start(struct adapter *adapter)
 {
@@ -2600,7 +2600,7 @@ void t4vf_sge_start(struct adapter *adapter)
  *	t4vf_sge_stop - disable SGE operation
  *	@adapter: the adapter
  *
- *	Stop tasklets and timers associated with the DMA engine.  Note that
+ *	Stop bh works and timers associated with the DMA engine.  Note that
  *	this is effective only if measures have been taken to disable any HW
  *	events that may restart them.
  */
@@ -2692,7 +2692,7 @@ int t4vf_sge_init(struct adapter *adapter)
 	s->fl_starve_thres = s->fl_starve_thres * 2 + 1;
 
 	/*
-	 * Set up tasklet timers.
+	 * Set up bh work timers.
 	 */
 	timer_setup(&s->rx_timer, sge_rx_timer_cb, 0);
 	timer_setup(&s->tx_timer, sge_tx_timer_cb, 0);
-- 
2.34.1


