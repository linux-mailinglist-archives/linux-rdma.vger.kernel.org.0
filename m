Return-Path: <linux-rdma+bounces-4114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC3941FB2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE19B249C3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120918C907;
	Tue, 30 Jul 2024 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOKsgbGz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209A1A4B38;
	Tue, 30 Jul 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364469; cv=none; b=Ec0x87/nDh+pDWvvKpDSDaUQwp44wdin6V06UPEajssWk5hfMJBZFeEgkyOmeGEUsxYNq8DYToOMZxOnRsY0ZIahwIyieJM1oXnoGTF2Ldz3XpktJP3y9KAtYIRGWeTadT9dA21bTBPpE9EqS5ds4UkKOeVadJ3GuEv5Ry47He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364469; c=relaxed/simple;
	bh=YYqqPZRCkNJn0vuIumHHz/AM1x5zWpf+RFUKWaHos6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOLfJh7WbXFFIj/T5yK2/Hch0aek0E74UhuGQEZ6zyMJ3dRkxIc2ejF0OPnA4gBX9EY1k/RieNO9Rlh/y2EGZtrMme1fJ8zcEu2JF6laebdoxowFyen/StxPVDFe0dQ024r4cvtfJLY/dO4K1AZG/q99PEVYw9HHkihlV+aKXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOKsgbGz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3042602a12.1;
        Tue, 30 Jul 2024 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364467; x=1722969267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJet9BwGTsiRkCm4isnF6ncb/nhFhGOxt0nK/Q3v+7o=;
        b=aOKsgbGzdEz4sbFg/IR6PT7pne78NhlK7X0b4bueG7WxHCp9MejK3kDRVvebB7jO16
         uqHpj/jCqnHrAN11GH3DEvjXQVG5/sL9weGUQSR4UAN9mVzfQ6keULkl/QhSDHKSRZij
         wE8A9FGBjhdgpIFghUfbwHU7Teb8QiEA+QbgfSdEEhsIh1FQEB8GOu3VcYKpGyhqQm3G
         rlI5Rmyj8vIKSqvqpgCf5KR4LN6dihLSeCzga2LFhinLafPJUrKPPHExzQ6vqzGkwLRs
         gGQrjhF1JHzasUM6bz02YNeT69OHi413SBB8WL9yvbSPo/ye8Nfbxlgj2OSdkNfwmbpI
         r82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364467; x=1722969267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJet9BwGTsiRkCm4isnF6ncb/nhFhGOxt0nK/Q3v+7o=;
        b=ixKf0wi0SqJP2KDQcvkFyhrTQPGQ+C08ACqdHWZyqwI7YbadLU1+zjyVjPoNxSrAfL
         VXqDj7hkA3pbQ/OfJpvNZJDs9FcwohcuOn5dTQSBmCoM9Fxuc3RHtwAm64E+Ia/nqUQx
         MMDCHNeHL3wbKq1QDcarEAEISKba1Wb5pbsRacJoLMlTMt8V9CYxHsZ8cyFgQoY6bwfu
         G5Vb0qXyWXt6OjcOd5vQG6WswAMDT/1KFXyjwetMWa96bNl31WlPuhVAZCsjdSmmTGdm
         QILqxQ/R56x7OrRwxQGCMdHce7cs/iR0575ilbQfjYTogpofAurGfR5IKjdH+zdeusbp
         2Oqw==
X-Forwarded-Encrypted: i=1; AJvYcCXdtRTLM173nxcMNmZyEYnwWAOs8/Wy/za468EmoIwgbZOdz+HkQ5mDrIG0vRP1D1qXJeexIpwACoOzNtdc4f3be5xN2d4ggeNEHxNvRBRN2rOe8sH3Dslggk7bhycisDdUL5hnD9ZNpMVLgG75kKqvw8gqB44oC2HZ+fTEs+feQg==
X-Gm-Message-State: AOJu0YxubHImlKNLE4rkrgWOOXDZgClExVEapYUKkgYWhSv3z0HgkBxu
	FIbdc6AfJjiUdycudy42O1nr6QSTGkPB79eKIIiYZyzWdPvQ7sTx
X-Google-Smtp-Source: AGHT+IGgF9xUzhoSsyAmcfnDOvxTdaMEnsGXOm516gr3MmxOJWQ9CxoA/oJ6bYQKfm6HPOJaEuM+ZA==
X-Received: by 2002:a05:6a20:12d3:b0:1c2:905c:dba with SMTP id adf61e73a8af0-1c4a153356amr10354060637.54.1722364466988;
        Tue, 30 Jul 2024 11:34:26 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:26 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
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
	Allen Pais <allen.lkml@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [net-next v3 07/15] net: thunderx: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:55 -0700
Message-Id: <20240730183403.4176544-8-allen.lkml@gmail.com>
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
APIs throughout the cavium/thunderx driver. This transition ensures
compatibility with the latest design and enhances performance.

Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 ++--
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++++++++----------
 .../ethernet/cavium/thunder/nicvf_queues.c    |  4 ++--
 .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 090d6b83982a..ecc175b6e7fa 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -8,6 +8,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <linux/pci.h>
 #include "thunder_bgx.h"
 
@@ -295,7 +296,7 @@ struct nicvf {
 	bool			rb_work_scheduled;
 	struct page		*rb_page;
 	struct delayed_work	rbdr_work;
-	struct tasklet_struct	rbdr_task;
+	struct work_struct	rbdr_bh_work;
 
 	/* Secondary Qset */
 	u8			sqs_count;
@@ -319,7 +320,7 @@ struct nicvf {
 	bool			loopback_supported;
 	struct nicvf_rss_info	rss_info;
 	struct nicvf_pfc	pfc;
-	struct tasklet_struct	qs_err_task;
+	struct work_struct	qs_err_bh_work;
 	struct work_struct	reset_task;
 	struct nicvf_work       rx_mode_work;
 	/* spinlock to protect workqueue arguments from concurrent access */
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6e..b0878bd25cf0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -982,9 +982,9 @@ static int nicvf_poll(struct napi_struct *napi, int budget)
  *
  * As of now only CQ errors are handled
  */
-static void nicvf_handle_qs_err(struct tasklet_struct *t)
+static void nicvf_handle_qs_err(struct work_struct *work)
 {
-	struct nicvf *nic = from_tasklet(nic, t, qs_err_task);
+	struct nicvf *nic = from_work(nic, work, qs_err_bh_work);
 	struct queue_set *qs = nic->qs;
 	int qidx;
 	u64 status;
@@ -1069,7 +1069,7 @@ static irqreturn_t nicvf_rbdr_intr_handler(int irq, void *nicvf_irq)
 		if (!nicvf_is_intr_enabled(nic, NICVF_INTR_RBDR, qidx))
 			continue;
 		nicvf_disable_intr(nic, NICVF_INTR_RBDR, qidx);
-		tasklet_hi_schedule(&nic->rbdr_task);
+		queue_work(system_bh_highpri_wq, &nic->rbdr_bh_work);
 		/* Clear interrupt */
 		nicvf_clear_intr(nic, NICVF_INTR_RBDR, qidx);
 	}
@@ -1085,7 +1085,7 @@ static irqreturn_t nicvf_qs_err_intr_handler(int irq, void *nicvf_irq)
 
 	/* Disable Qset err interrupt and schedule softirq */
 	nicvf_disable_intr(nic, NICVF_INTR_QS_ERR, 0);
-	tasklet_hi_schedule(&nic->qs_err_task);
+	queue_work(system_bh_highpri_wq, &nic->qs_err_bh_work);
 	nicvf_clear_intr(nic, NICVF_INTR_QS_ERR, 0);
 
 	return IRQ_HANDLED;
@@ -1364,8 +1364,8 @@ int nicvf_stop(struct net_device *netdev)
 	for (irq = 0; irq < nic->num_vec; irq++)
 		synchronize_irq(pci_irq_vector(nic->pdev, irq));
 
-	tasklet_kill(&nic->rbdr_task);
-	tasklet_kill(&nic->qs_err_task);
+	cancel_work_sync(&nic->rbdr_bh_work);
+	cancel_work_sync(&nic->qs_err_bh_work);
 	if (nic->rb_work_scheduled)
 		cancel_delayed_work_sync(&nic->rbdr_work);
 
@@ -1488,11 +1488,11 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_hw_set_mac_addr(nic, netdev);
 	}
 
-	/* Init tasklet for handling Qset err interrupt */
-	tasklet_setup(&nic->qs_err_task, nicvf_handle_qs_err);
+	/* Init bh_work for handling Qset err interrupt */
+	INIT_WORK(&nic->qs_err_bh_work, nicvf_handle_qs_err);
 
-	/* Init RBDR tasklet which will refill RBDR */
-	tasklet_setup(&nic->rbdr_task, nicvf_rbdr_task);
+	/* Init RBDR bh_work which will refill RBDR */
+	INIT_WORK(&nic->rbdr_bh_work, nicvf_rbdr_bh_work);
 	INIT_DELAYED_WORK(&nic->rbdr_work, nicvf_rbdr_work);
 
 	/* Configure CPI alorithm */
@@ -1561,8 +1561,8 @@ int nicvf_open(struct net_device *netdev)
 cleanup:
 	nicvf_disable_intr(nic, NICVF_INTR_MBOX, 0);
 	nicvf_unregister_interrupts(nic);
-	tasklet_kill(&nic->qs_err_task);
-	tasklet_kill(&nic->rbdr_task);
+	cancel_work_sync(&nic->qs_err_bh_work);
+	cancel_work_sync(&nic->rbdr_bh_work);
 napi_del:
 	for (qidx = 0; qidx < qs->cq_cnt; qidx++) {
 		cq_poll = nic->napi[qidx];
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 06397cc8bb36..ad71160879e4 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -461,9 +461,9 @@ void nicvf_rbdr_work(struct work_struct *work)
 }
 
 /* In Softirq context, alloc rcv buffers in atomic mode */
-void nicvf_rbdr_task(struct tasklet_struct *t)
+void nicvf_rbdr_bh_work(struct work_struct *work)
 {
-	struct nicvf *nic = from_tasklet(nic, t, rbdr_task);
+	struct nicvf *nic = from_work(nic, work, rbdr_bh_work);
 
 	nicvf_refill_rbdr(nic, GFP_ATOMIC);
 	if (nic->rb_alloc_fail) {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 8453defc296c..c6f18fb7c50e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -348,7 +348,7 @@ void nicvf_xdp_sq_doorbell(struct nicvf *nic, struct snd_queue *sq, int sq_num);
 
 struct sk_buff *nicvf_get_rcv_skb(struct nicvf *nic,
 				  struct cqe_rx_t *cqe_rx, bool xdp);
-void nicvf_rbdr_task(struct tasklet_struct *t);
+void nicvf_rbdr_bh_work(struct work_struct *work);
 void nicvf_rbdr_work(struct work_struct *work);
 
 void nicvf_enable_intr(struct nicvf *nic, int int_type, int q_idx);
-- 
2.34.1


