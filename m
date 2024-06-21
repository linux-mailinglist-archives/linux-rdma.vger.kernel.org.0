Return-Path: <linux-rdma+bounces-3384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E462F911A0B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298EF1C22221
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C616C84F;
	Fri, 21 Jun 2024 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjvcKiKA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1C16C698;
	Fri, 21 Jun 2024 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946355; cv=none; b=Fs5tnSHXhekazZUQAagbgrNOdiMVhcKBGL7rAwGfoG9YqXqwKFHzJ7hdJcMmPE2zJagzawCGswc3BXPf87WSJTUQEshbNu1KXvnABGGRkeOzlSZt/YaxCGbd2gVdJo2YEmr7jI7c07PVPG/i7F9YJ4CuTgrAj2Htx+tJBEMCHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946355; c=relaxed/simple;
	bh=RHIQ1ZK7HhrkITryP32SV1M7i6oMh9uMx3UMrh72w6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzIOHZUb5dQjIukmgllO8aMLXdmHXSHBieXkZfvWyISJ/Z73VIkTvS1BTJgEU916SLiQCslJkrrOxMt+4PRbukMd5PKDTnYkdp+yH5C9zSCHARD/WVnyqV/aV0KeegcVFZ3c1loWBeZdbMtSwlev6IsiYfc/iB+83blzO5k8QqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjvcKiKA; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9778bb7c8so777249eaf.3;
        Thu, 20 Jun 2024 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946352; x=1719551152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7B644WJji2EeDQXIp+qb+T3U50yFIygDXuUoanjxuY=;
        b=GjvcKiKAg3/8luYqiGZ75Ou0okowRiK8gixypPysvrHk5u+Eaxdq0O+/CRHjzOi94K
         K/MqpKXL37Hn9zPWDOJHCVoQ2B2oINmx8K5SSoAnf3DOJGxGIDCWNwe/rNcN1fskHROp
         M/9TOZHwam3bVCN/fCji7fzZyBFLs6bH6LysZdNbqW95f2Q2+fhjH2wK1akdqo9DhGie
         zcafdZTr/EB9VZYtsfFqxPWOltJ3Okhp1Zr8WbMlSNMiLiPtPbuO1ZyIJn5+bZK7Rh+2
         5XZM5U/Rsf5aGFRp1sFfBzEY/mrC9iDHGuSC5gU2Rwp47sVcaH2ThK9P2m9TsGapyFID
         ncRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946352; x=1719551152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7B644WJji2EeDQXIp+qb+T3U50yFIygDXuUoanjxuY=;
        b=qd7BY42fYmFkQDAFInbIdwC9quJq63Yu9MqcXDgFNATGjaG0wzytgfQjKnJxGfuz0C
         haNzzCcOwPNVi8PzmnZyiiWjRC1GMN/iKmViCcCh6DjyowWr+k4sdkDOVRoid33P4J+s
         +OeJU/66p98uxoB7m4NvezgVMR4kT21+p88lCYkSzvuacwSOKYs63PhdvO0YveCoa30o
         Tt1QJibVoMO2wPME6VuD7bVdZSbPyAoU/hAfxgfBlv+9rAKoAUo3k6nwvGETLg+mVcd6
         hKYjeBU4LQxx4KUXZiy3GqfcZx6MRCDnwq8mfpbnx6iGbhcyovu06LYpDRX3vFvWSLqp
         zXSg==
X-Forwarded-Encrypted: i=1; AJvYcCXr0Z36eG+ofgvY0HcWOeZ/U0yj7xxSScSfropGki+W0Ef8FRfdvuGm46Vs0O6AEWlb3eJEy8nRMrNAgn9C9MjjuaONqnqFt+29OXgkm+DqOAB3xSqUb3fl9XeFvTEnr/aJFjqy+KsR2ueuCJloN7z97ZMseiHHV1PdXIfQzBup1A==
X-Gm-Message-State: AOJu0YxnplXruFPONLW3NVXG8HE0vGSr9Bby3c7jR0gS3tZL27sYzvtt
	j8mXCFsHrizrGe4jLLWtn5LUI+ucrRW5zRfgBMZu19QTUSd6KpDh
X-Google-Smtp-Source: AGHT+IGZar/opqQUcuItaXuxxIwbAvWDnKX9EGrfatjDViIRrCPB4a9s+Z6quwYramSKiqkj+FmKtQ==
X-Received: by 2002:a05:6358:5e08:b0:19f:4a60:e6fc with SMTP id e5c5f4694b2df-1a1fd57ea2amr962858555d.25.1718946352503;
        Thu, 20 Jun 2024 22:05:52 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:52 -0700 (PDT)
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
	Allen Pais <allen.lkml@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH 07/15] net: thunderx: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:17 -0700
Message-Id: <20240621050525.3720069-8-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
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


