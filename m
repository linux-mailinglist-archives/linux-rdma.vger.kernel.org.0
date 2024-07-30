Return-Path: <linux-rdma+bounces-4120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7D941FC4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ADD28425E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7C18C92D;
	Tue, 30 Jul 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs7BynC8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6731A7F94;
	Tue, 30 Jul 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364486; cv=none; b=MtXFPdT8xJca97e/SgjAUorDJXQNZT4dk6FN8iADASobhThfAcRhZX2mssFQwspV5kHxRkfRGbz0L7d6rBR29H9sPVgXDyMMu8Lip2hTpGaAkwgzlWWx25nRIj6+XEF1Rp28r9kpv+4IayxXHGY63YKauzx3RfxieaSdOChfFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364486; c=relaxed/simple;
	bh=deS3mafeOZtc6o394hOxUHa0kJK4MmCbZnzACvGXWHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQjwSxNg2N5dl6fQYTHhfBMNlwSRXY6CTmj7J/YtrP8W/d4EVJ/87WRjXVV7U2YtgRfFeOOfG8RpiuGIjR0gfLauVEFgiJsBiP9YonF3NgzIUCLvoqu70Ka5sdaP+1IeX4Zevclko6fO3ptUvO2icr1Dv3aMcjZusYZDgNCefNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs7BynC8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so3646498b3a.2;
        Tue, 30 Jul 2024 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364484; x=1722969284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4IhuhN76x48NFIaGWh3almHhHQ4sS1Iy4QAIkMSA2s=;
        b=fs7BynC89xexAQ/6zr9dKBcV+nBTzGqszVpm/4vy8CkP41x/Q4EZVKaurbweAa+qcb
         HmkAo8B9LJK6PUUd1kPkGOj6lpZhs7Tb+snleS3cVYtjccGKWtxk7TZyC7G2z4q7mg5W
         2/IhrKVqlVDgE5usXhsOMTi1jT7JsLB/7/Rywv7t6dNhc3+zZNcnQkIlFnsqsBXu2xwx
         tN8XP98VH9bFR7VIWzRos/A5hGJqPDHxSsxSibkYjsd/CZ6qUdBB66ih93Oy6YtM21nM
         WoAquD6RPDkE9ICuCChYsNCLVmc5OvuOQ3XnfmzIGzXYw4fsrm/pzWXj0qqDHvrUYEEw
         lAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364484; x=1722969284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4IhuhN76x48NFIaGWh3almHhHQ4sS1Iy4QAIkMSA2s=;
        b=Nq/abbAqcpR8LRR3cJsFq7ynAaoOGB880Ab5gXX+RnybPyksxa4stLjsYLc07lobk7
         P43kCYzhbi6TW+0YSDEH6T6oPC5xMXEXTJc7CYUTUTaCUkttogdINsiDpDfxHUMbZ9/G
         OhjueIqkKuvLg9rIYp5KcQyTye8hJnDpxPV3RSztLifWIB2IwqwVz+WsyiVKDGYRzLr1
         qwK2sSnNDfATGzLsN+dUwXwhyhsivq794/Nbc8W5qdGSyPhoEV1U5erSf3hwl0RTUSBJ
         BWnM5jUxa6fPN1WnBWXw0zufDtA5870/pdzZQAudMV42FLbzsKpEOH5+R3coEHrc4xrO
         TKnA==
X-Forwarded-Encrypted: i=1; AJvYcCX4jOmp0LvF0Lth65SNBUFu/nMP957hWqF/J+N8IIT9/DK9aEdA5SdnddVvMlq+ENwELPwfmoJ+LwMYFhkaX8wl41jHZqzcz8CiWN4XxrNFLRpVFXO5L2jyiI1xCgFg6tniWi1t6LiGMxpwb9Byq3xlCqredwkRS+oFajfhaonKNA==
X-Gm-Message-State: AOJu0YxQQGM8OA2uNQxIcCglNwQ9L4olaxHKjMt4ddWg2SdpQpHKKkf4
	HO4PCxzAlh6oeIhhlZXFlBdBYsT7YXJ0XiXLA26ApwHPCkxGmtka
X-Google-Smtp-Source: AGHT+IG88geK142qz/ueS6a+nSgNU9iKp3YcNv0ScHzsZKu/ThRnN9UisAwSywOnQSL0Ilsld4j4rg==
X-Received: by 2002:a05:6a21:32a9:b0:1c0:f590:f77f with SMTP id adf61e73a8af0-1c4a0e03d56mr17146966637.0.1722364483829;
        Tue, 30 Jul 2024 11:34:43 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:43 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 13/15] net: jme: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:34:01 -0700
Message-Id: <20240730183403.4176544-14-allen.lkml@gmail.com>
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
APIs throughout the jme driver. This transition ensures compatibility
with the latest design and enhances performance.

We should queue the work only if it was queued at cancel time.
Introduce rxempty_bh_work_queued, suggested by Paolo Abeni.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/jme.c | 80 +++++++++++++++++++++-----------------
 drivers/net/ethernet/jme.h |  9 +++--
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..bdaeaeb477e4 100644
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
+	jme->rxempty_bh_work_queued = disable_work_sync(&jme->rxempty_bh_work);
 
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
@@ -1326,22 +1326,26 @@ static void jme_link_change_work(struct work_struct *work)
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
+	if (jme->rxempty_bh_work_queued)
+		enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
+	else
+		enable_work(&jme->rxempty_bh_work);
+
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
@@ -1374,9 +1378,9 @@ jme_poll(JME_NAPI_HOLDER(holder), JME_NAPI_WEIGHT(budget))
 }
 
 static void
-jme_rx_empty_tasklet(struct tasklet_struct *t)
+jme_rx_empty_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, rxempty_task);
+	struct jme_adapter *jme = from_work(jme, work, rxempty_bh_work);
 
 	if (unlikely(atomic_read(&jme->link_changing) != 1))
 		return;
@@ -1386,7 +1390,7 @@ jme_rx_empty_tasklet(struct tasklet_struct *t)
 
 	netif_info(jme, rx_status, jme->dev, "RX Queue Full!\n");
 
-	jme_rx_clean_tasklet(&jme->rxclean_task);
+	jme_rx_clean_bh_work(&jme->rxclean_bh_work);
 
 	while (atomic_read(&jme->rx_empty) > 0) {
 		atomic_dec(&jme->rx_empty);
@@ -1410,9 +1414,9 @@ jme_wake_queue_if_stopped(struct jme_adapter *jme)
 
 }
 
-static void jme_tx_clean_tasklet(struct tasklet_struct *t)
+static void jme_tx_clean_bh_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, txclean_task);
+	struct jme_adapter *jme = from_work(jme, work, txclean_bh_work);
 	struct jme_ring *txring = &(jme->txring[0]);
 	struct txdesc *txdesc = txring->desc;
 	struct jme_buffer_info *txbi = txring->bufinf, *ctxbi, *ttxbi;
@@ -1510,12 +1514,12 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 
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
@@ -1538,9 +1542,9 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
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
 
@@ -1826,9 +1830,9 @@ jme_open(struct net_device *netdev)
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
@@ -1914,9 +1918,10 @@ jme_close(struct net_device *netdev)
 	JME_NAPI_DISABLE(jme);
 
 	cancel_work_sync(&jme->linkch_task);
-	tasklet_kill(&jme->txclean_task);
-	tasklet_kill(&jme->rxclean_task);
-	tasklet_kill(&jme->rxempty_task);
+	cancel_work_sync(&jme->txclean_bh_work);
+	cancel_work_sync(&jme->rxclean_bh_work);
+	jme->rxempty_bh_work_queued = false;
+	cancel_work_sync(&jme->rxempty_bh_work);
 
 	jme_disable_rx_engine(jme);
 	jme_disable_tx_engine(jme);
@@ -3020,7 +3025,7 @@ jme_init_one(struct pci_dev *pdev,
 	atomic_set(&jme->tx_cleaning, 1);
 	atomic_set(&jme->rx_empty, 1);
 
-	tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+	INIT_WORK(&jme->pcc_bh_work, jme_pcc_bh_work);
 	INIT_WORK(&jme->linkch_task, jme_link_change_work);
 	jme->dpi.cur = PCC_P1;
 
@@ -3180,9 +3185,9 @@ jme_suspend(struct device *dev)
 	netif_stop_queue(netdev);
 	jme_stop_irq(jme);
 
-	tasklet_disable(&jme->txclean_task);
-	tasklet_disable(&jme->rxclean_task);
-	tasklet_disable(&jme->rxempty_task);
+	disable_work_sync(&jme->txclean_bh_work);
+	disable_work_sync(&jme->rxclean_bh_work);
+	jme->rxempty_bh_work_queued = disable_work_sync(&jme->rxempty_bh_work);
 
 	if (netif_carrier_ok(netdev)) {
 		if (test_bit(JME_FLAG_POLL, &jme->flags))
@@ -3198,9 +3203,12 @@ jme_suspend(struct device *dev)
 		jme->phylink = 0;
 	}
 
-	tasklet_enable(&jme->txclean_task);
-	tasklet_enable(&jme->rxclean_task);
-	tasklet_enable(&jme->rxempty_task);
+	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+	if (jme->rxempty_bh_work_queued)
+		enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
+	else
+		enable_work(&jme->rxempty_bh_work);
 
 	jme_powersave_phy(jme);
 
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index 860494ff3714..44aaf7625dc3 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -406,11 +406,12 @@ struct jme_adapter {
 	spinlock_t		phy_lock;
 	spinlock_t		macaddr_lock;
 	spinlock_t		rxmcs_lock;
-	struct tasklet_struct	rxempty_task;
-	struct tasklet_struct	rxclean_task;
-	struct tasklet_struct	txclean_task;
+	struct work_struct	rxempty_bh_work;
+	struct work_struct	rxclean_bh_work;
+	struct work_struct	txclean_bh_work;
+	bool			rxempty_bh_work_queued;
 	struct work_struct	linkch_task;
-	struct tasklet_struct	pcc_task;
+	struct work_struct	pcc_bh_work;
 	unsigned long		flags;
 	u32			reg_txcs;
 	u32			reg_txpfc;
-- 
2.34.1


