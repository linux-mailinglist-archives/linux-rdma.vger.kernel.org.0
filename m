Return-Path: <linux-rdma+bounces-3390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7455911A20
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233F6B24791
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8816E887;
	Fri, 21 Jun 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWpfJ8Ci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0C16DED4;
	Fri, 21 Jun 2024 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946366; cv=none; b=oulRkUI5EXQn9KjgxYuU6huRxVOLxbfaXwh1/k9zqMGMugJnVMFDGrzMCjhaJitfwC3pAD79kjBMN6g6g05I/j9ozd2SVeS9PiWUu7hWlFZtHgaU26ZpERmPB+TP7LATWBYmpJGlDGCJenYm+ncvkrkPcKZ++M9eNea7lthbWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946366; c=relaxed/simple;
	bh=ZDz2LhFLQz9qCiesFC2yTihbYdhNV6oWS3LIkrpVToI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax68J8kOrGOolyzAMZWOKeQ0hkMw6014QBuzDgKQvcJZHc1DQ1dsPhuQO1OdH/oT291aanPMT5Ikhx7DHbJ6FPgoizV+4LoaEgoUTtfFtrqL3H1mWZ3nmYdv22GzYDzu6w8t6dc+FqXtsI4RAIVEbKLuPBQgXejcieJVGkl8Il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWpfJ8Ci; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9b4d69f53so855088a34.0;
        Thu, 20 Jun 2024 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946364; x=1719551164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbaKAp4rBypUxqcKQTtYdGFIU8vf1Ad+mxOnv6tDJnw=;
        b=dWpfJ8CinP2PJphGYSJfJv3d4QeFOnJjdPdJfIQuyULxMvje7IO6qzBYkLY/xoG024
         0jPNk1V284eJ/c3KtBZzaaxwd9w8kvgQsS0kUEvZYe4sZT2eukDubwIdhz+yT6+CY4Uk
         cB6REfKVR+kIGN/GpJfwlPyKbwGt80dLjmJo6T5de5LXEbxOcgpeMDm3zbx7W88YnQy2
         P8J/kHiPxBKT+jsCO73Z1KRbRTlhWYo/GCGM4+7eeCYcaMKw70IUUcJuFH9h9Q9zsoDc
         FXl8JMpUSpAtDMw0iyS9yAONqcxiIhTRtoU7ImmEtfS4oVtGOpRC8aI6vCr4xzfwUFJO
         iwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946364; x=1719551164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbaKAp4rBypUxqcKQTtYdGFIU8vf1Ad+mxOnv6tDJnw=;
        b=BgNLPY1h4p49U2KAPJ2IAR+2y9EcVR5kWHnEqihgb3zbqnzfC16TsmzIPyILSvMSgk
         JrQ19NSfiZCnzPgcwT1aLFd+kvR7eiROI3Pp2wFv5saUAVXBajWzpoRay00UtcMZNS2I
         LosbMqxXCxUpE15yhNIotVJvgm2WZfHTC3+0FSV6RSMcp7uYQMAIqC1F2G/Yw/8rA/EF
         rpoKq1xYmpjOCmunXC7oJ5s+iiL1YzXVxyJq9z6cg/XZsDpLJwXTzIj6rKNq6inlzMzx
         kB9aKu/uRug0zhNzgpgLYHmnU+oU5V+15TCFgtwkfIugp7ga7VuX6Vlqx8e/68PfxTBJ
         YPQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1sKDJNU360cpOB4PQhiU3HG04lV6oIYxrkqKnFouf/Jzb0OMwyuwLcrhu/7+2VR2nq4zaI8LZzaLloH6jwU2Xz/X9JzL1Uyv2CfvFyMO3N22LH3fxlnyKYMJzMjywutcQgyNcyoqo6ziw7663lFbwhASHf/QvWTbq7ZjrECbWtA==
X-Gm-Message-State: AOJu0YzeNiOCyyG+74TY53rrgzD2Is1cMb3ab8WS9a2CS1a8r/VeaDLr
	WYkEWa6GG9R31Qud++oym6b0wvhEG992GKh5T+ZI3vKfmRGJzyHg
X-Google-Smtp-Source: AGHT+IHpJWoyOgKjSQNeAeyQsc97SFuD4xHKSmRBj8Z2m00tZ3ggPULpelvaMwrLn3RSm6gMyiOWdA==
X-Received: by 2002:a9d:6558:0:b0:700:8eea:af41 with SMTP id 46e09a7af769-7008eeab075mr6158681a34.1.1718946363694;
        Thu, 20 Jun 2024 22:06:03 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:06:03 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Guo-Fu Tseng <cooldavid@cooldavid.org>,
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
	netdev@vger.kernel.org
Subject: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:23 -0700
Message-Id: <20240621050525.3720069-14-allen.lkml@gmail.com>
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
APIs throughout the jme driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/jme.c | 72 +++++++++++++++++++-------------------
 drivers/net/ethernet/jme.h |  8 ++---
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..b1a92b851b3b 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1141,7 +1141,7 @@ jme_dynamic_pcc(struct jme_adapter *jme)
 
 	if (unlikely(dpi->attempt != dpi->cur && dpi->cnt > 5)) {
 		if (dpi->attempt < dpi->cur)
-			tasklet_schedule(&jme->rxclean_task);
+			queue_work(system_bh_wq, &jme->rxclean_bh_work);
 		jme_set_rx_pcc(jme, dpi->attempt);
 		dpi->cur = dpi->attempt;
 		dpi->cnt = 0;
@@ -1182,9 +1182,9 @@ jme_shutdown_nic(struct jme_adapter *jme)
 }
 
 static void
-jme_pcc_tasklet(struct tasklet_struct *t)
+jme_pcc_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, pcc_task);
+	struct jme_adapter *jme = from_work(jme, work, pcc_bh_work);
 	struct net_device *netdev = jme->dev;
 
 	if (unlikely(test_bit(JME_FLAG_SHUTDOWN, &jme->flags))) {
@@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct *work)
 		jme_stop_shutdown_timer(jme);
 
 	jme_stop_pcc_timer(jme);
-	tasklet_disable(&jme->txclean_task);
-	tasklet_disable(&jme->rxclean_task);
-	tasklet_disable(&jme->rxempty_task);
+	disable_work_sync(&jme->txclean_bh_work);
+	disable_work_sync(&jme->rxclean_bh_work);
+	disable_work_sync(&jme->rxempty_bh_work);
 
 	if (netif_carrier_ok(netdev)) {
 		jme_disable_rx_engine(jme);
@@ -1304,7 +1304,7 @@ static void jme_link_change_work(struct work_struct *work)
 		rc = jme_setup_rx_resources(jme);
 		if (rc) {
 			pr_err("Allocating resources for RX error, Device STOPPED!\n");
-			goto out_enable_tasklet;
+			goto out_enable_bh_work;
 		}
 
 		rc = jme_setup_tx_resources(jme);
@@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_struct *work)
 		jme_start_shutdown_timer(jme);
 	}
 
-	goto out_enable_tasklet;
+	goto out_enable_bh_work;
 
 err_out_free_rx_resources:
 	jme_free_rx_resources(jme);
-out_enable_tasklet:
-	tasklet_enable(&jme->txclean_task);
-	tasklet_enable(&jme->rxclean_task);
-	tasklet_enable(&jme->rxempty_task);
+out_enable_bh_work:
+	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
 out:
 	atomic_inc(&jme->link_changing);
 }
 
 static void
-jme_rx_clean_tasklet(struct tasklet_struct *t)
+jme_rx_clean_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, rxclean_task);
+	struct jme_adapter *jme = from_work(jme, work, rxclean_bh_work);
 	struct dynpcc_info *dpi = &(jme->dpi);
 
 	jme_process_receive(jme, jme->rx_ring_size);
@@ -1374,9 +1374,9 @@ jme_poll(JME_NAPI_HOLDER(holder), JME_NAPI_WEIGHT(budget))
 }
 
 static void
-jme_rx_empty_tasklet(struct tasklet_struct *t)
+jme_rx_empty_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, rxempty_task);
+	struct jme_adapter *jme = from_work(jme, work, rxempty_bh_work);
 
 	if (unlikely(atomic_read(&jme->link_changing) != 1))
 		return;
@@ -1386,7 +1386,7 @@ jme_rx_empty_tasklet(struct tasklet_struct *t)
 
 	netif_info(jme, rx_status, jme->dev, "RX Queue Full!\n");
 
-	jme_rx_clean_tasklet(&jme->rxclean_task);
+	jme_rx_clean_bh_work(&jme->rxclean_bh_work);
 
 	while (atomic_read(&jme->rx_empty) > 0) {
 		atomic_dec(&jme->rx_empty);
@@ -1410,9 +1410,9 @@ jme_wake_queue_if_stopped(struct jme_adapter *jme)
 
 }
 
-static void jme_tx_clean_tasklet(struct tasklet_struct *t)
+static void jme_tx_clean_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, txclean_task);
+	struct jme_adapter *jme = from_work(jme, work, txclean_bh_work);
 	struct jme_ring *txring = &(jme->txring[0]);
 	struct txdesc *txdesc = txring->desc;
 	struct jme_buffer_info *txbi = txring->bufinf, *ctxbi, *ttxbi;
@@ -1510,12 +1510,12 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 
 	if (intrstat & INTR_TMINTR) {
 		jwrite32(jme, JME_IEVE, INTR_TMINTR);
-		tasklet_schedule(&jme->pcc_task);
+		queue_work(system_bh_wq, &jme->pcc_bh_work);
 	}
 
 	if (intrstat & (INTR_PCCTXTO | INTR_PCCTX)) {
 		jwrite32(jme, JME_IEVE, INTR_PCCTXTO | INTR_PCCTX | INTR_TX0);
-		tasklet_schedule(&jme->txclean_task);
+		queue_work(system_bh_wq, &jme->txclean_bh_work);
 	}
 
 	if ((intrstat & (INTR_PCCRX0TO | INTR_PCCRX0 | INTR_RX0EMP))) {
@@ -1538,9 +1538,9 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 	} else {
 		if (intrstat & INTR_RX0EMP) {
 			atomic_inc(&jme->rx_empty);
-			tasklet_hi_schedule(&jme->rxempty_task);
+			queue_work(system_bh_highpri_wq, &jme->rxempty_bh_work);
 		} else if (intrstat & (INTR_PCCRX0TO | INTR_PCCRX0)) {
-			tasklet_hi_schedule(&jme->rxclean_task);
+			queue_work(system_bh_highpri_wq, &jme->rxclean_bh_work);
 		}
 	}
 
@@ -1826,9 +1826,9 @@ jme_open(struct net_device *netdev)
 	jme_clear_pm_disable_wol(jme);
 	JME_NAPI_ENABLE(jme);
 
-	tasklet_setup(&jme->txclean_task, jme_tx_clean_tasklet);
-	tasklet_setup(&jme->rxclean_task, jme_rx_clean_tasklet);
-	tasklet_setup(&jme->rxempty_task, jme_rx_empty_tasklet);
+	INIT_WORK(&jme->txclean_bh_work, jme_tx_clean_bh_work);
+	INIT_WORK(&jme->rxclean_bh_work, jme_rx_clean_bh_work);
+	INIT_WORK(&jme->rxempty_bh_work, jme_rx_empty_bh_work);
 
 	rc = jme_request_irq(jme);
 	if (rc)
@@ -1914,9 +1914,9 @@ jme_close(struct net_device *netdev)
 	JME_NAPI_DISABLE(jme);
 
 	cancel_work_sync(&jme->linkch_task);
-	tasklet_kill(&jme->txclean_task);
-	tasklet_kill(&jme->rxclean_task);
-	tasklet_kill(&jme->rxempty_task);
+	cancel_work_sync(&jme->txclean_bh_work);
+	cancel_work_sync(&jme->rxclean_bh_work);
+	cancel_work_sync(&jme->rxempty_bh_work);
 
 	jme_disable_rx_engine(jme);
 	jme_disable_tx_engine(jme);
@@ -3020,7 +3020,7 @@ jme_init_one(struct pci_dev *pdev,
 	atomic_set(&jme->tx_cleaning, 1);
 	atomic_set(&jme->rx_empty, 1);
 
-	tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+	INIT_WORK(&jme->pcc_bh_work, jme_pcc_bh_work);
 	INIT_WORK(&jme->linkch_task, jme_link_change_work);
 	jme->dpi.cur = PCC_P1;
 
@@ -3180,9 +3180,9 @@ jme_suspend(struct device *dev)
 	netif_stop_queue(netdev);
 	jme_stop_irq(jme);
 
-	tasklet_disable(&jme->txclean_task);
-	tasklet_disable(&jme->rxclean_task);
-	tasklet_disable(&jme->rxempty_task);
+	disable_work_sync(&jme->txclean_bh_work);
+	disable_work_sync(&jme->rxclean_bh_work);
+	disable_work_sync(&jme->rxempty_bh_work);
 
 	if (netif_carrier_ok(netdev)) {
 		if (test_bit(JME_FLAG_POLL, &jme->flags))
@@ -3198,9 +3198,9 @@ jme_suspend(struct device *dev)
 		jme->phylink = 0;
 	}
 
-	tasklet_enable(&jme->txclean_task);
-	tasklet_enable(&jme->rxclean_task);
-	tasklet_enable(&jme->rxempty_task);
+	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
 
 	jme_powersave_phy(jme);
 
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index 860494ff3714..73a8a1438340 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -406,11 +406,11 @@ struct jme_adapter {
 	spinlock_t		phy_lock;
 	spinlock_t		macaddr_lock;
 	spinlock_t		rxmcs_lock;
-	struct tasklet_struct	rxempty_task;
-	struct tasklet_struct	rxclean_task;
-	struct tasklet_struct	txclean_task;
+	struct work_struct	rxempty_bh_work;
+	struct work_struct	rxclean_bh_work;
+	struct work_struct	txclean_bh_work;
 	struct work_struct	linkch_task;
-	struct tasklet_struct	pcc_task;
+	struct work_struct	pcc_bh_work;
 	unsigned long		flags;
 	u32			reg_txcs;
 	u32			reg_txpfc;
-- 
2.34.1


