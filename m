Return-Path: <linux-rdma+bounces-4721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6A969C75
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7B1F23FC5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B11B984D;
	Tue,  3 Sep 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HNh8AXmu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB391A42B8
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364305; cv=none; b=VIcExr6neQBQLioqqYjbEyyYkAyBuUDm6m8yEfsebydiZuwWFZCe4OfvdLSeNY+cOMF02anzY3m4fPOXRXsV1pu4Mm7GpKZUOA+FVc+rLV8UIGvpjG8BmRvd5GorE3woCabcEMtfQnGtrTINyhjZgTPlQQ0O5aLg6lyXvxQTV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364305; c=relaxed/simple;
	bh=bf3F/M2iqw1UMol7sLiPPyz1mQbt2AocyxwD/HkP3Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EpWRFdeyF9ni2spJPymnp51wfm7rodYZEgTitE9aCdCdla5oTEzkvQ16FzdEVaBDXut3i5uOclfRaNa40R3ssxD0aqfa68URuvCx1SPtNxhL3stq7LKQnHvZH5ts9YzEm+O3DqJYgn0P3CBMEzU1R+mHtDue8qqarQAKbHaCDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HNh8AXmu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202376301e6so39547065ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725364303; x=1725969103; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SKOpTbZbegrj30IyVrgcBYkKst6zTKpdZ4DN1uBg++I=;
        b=HNh8AXmuI1CGYoCjtmhTIunYAbxUIomTkZ+9m5HfgCoEMSsRtV24xkz0X3fGJKPgHq
         3CPwtonmPg3keumFz5Zn2fijdLYmZ3o3jXOSJKVmtpBMX7fjBODEGudvF3eyxo8edfRG
         a1fXLKkbBWo1XR22Ind2Vm0ZaTQjY0LrUZQwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364303; x=1725969103;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKOpTbZbegrj30IyVrgcBYkKst6zTKpdZ4DN1uBg++I=;
        b=pD9QpR9meeKsNQaI6MOXrtA2vv8jCG9xLGxhr31LUBOXOIwecjij8zvP9QkOogFNph
         m0ICLfRh4ddWzvfiqkY00U/X01CG9fOh4wx5aH/BfD003Uydc6R5TgkgJpQGALDol5ZI
         s19ZNq03nsRHHp51/7llpLmIN7wICk2cH1adGvEy75saLnycyiJI3rLfRzSFJvqqd+rG
         3V6bUy0HHJecNgxHijWXTHShXu55EkgRa7CpHbyLazmxggZTx0555zkp9MiLo10RHhCf
         4FTQC1edehJ2fZX+hO+CPP2e1IcowAWbqF15MXAPrRq/7EhBEo1YfrCneSl1hDlnn+e2
         LNjQ==
X-Gm-Message-State: AOJu0YxMkO6DQuhpUFG/9v6Ccp+IMDAowf+Hws9Vhq1+c+Ab2szWxPmQ
	Z939dUsDBfCwUFM6roNbbG96b7T6IE1htcRUMob/YcB4oZEgila/70tBAfAGuEzQ6qvr+3H73DH
	XxQ==
X-Google-Smtp-Source: AGHT+IHyeXEQszj32EhgXle4o/lMn7jXBPjkUNXh2FghzUNA/njibJ+8G1RIPvHdjRiLWfjximXFIg==
X-Received: by 2002:a17:902:ced2:b0:205:8b84:d60c with SMTP id d9443c01a7336-2058b84dab1mr52700205ad.35.1725364303273;
        Tue, 03 Sep 2024 04:51:43 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm62077335ad.226.2024.09.03.04.51.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:51:42 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Michael Chan <michael.chan@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Add FW async event support in driver
Date: Tue,  3 Sep 2024 04:30:48 -0700
Message-Id: <1725363051-19268-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Using the option provided by L2 driver, register for FW Async
event. Provide the ulp hook 'ulp_async_notifier' for receiving
the events for L2 driver.

Async events will be handled in follow on patches.

CC: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  1 +
 drivers/infiniband/hw/bnxt_re/main.c          | 47 +++++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 31 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  1 +
 5 files changed, 81 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2be9a62..b2ed557 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -198,6 +198,7 @@ struct bnxt_re_dev {
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
+	unsigned long			event_bitmap;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 16a84ca..0f86a34 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -300,6 +300,20 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
 	bnxt_re_dev_uninit(rdev);
 }
 
+static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *cmpl)
+{
+	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
+	u32 data1, data2;
+	u16 event_id;
+
+	event_id = le16_to_cpu(cmpl->event_id);
+	data1 = le32_to_cpu(cmpl->event_data1);
+	data2 = le32_to_cpu(cmpl->event_data2);
+
+	ibdev_dbg(&rdev->ibdev, "Async event_id = %d data1 = %d data2 = %d",
+		  event_id, data1, data2);
+}
+
 static void bnxt_re_stop_irq(void *handle)
 {
 	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
@@ -358,6 +372,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 }
 
 static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
+	.ulp_async_notifier = bnxt_re_async_notifier,
 	.ulp_irq_stop = bnxt_re_stop_irq,
 	.ulp_irq_restart = bnxt_re_start_irq
 };
@@ -1518,6 +1533,34 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 	return 0;
 }
 
+static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (rdev->is_virtfn)
+		return;
+
+	memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
+	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+}
+
+static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (rdev->is_virtfn)
+		return;
+
+	rdev->event_bitmap |= (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+}
+
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -1580,6 +1623,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	u8 type;
 	int rc;
 
+	bnxt_re_net_unregister_async_event(rdev);
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -1776,6 +1821,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
+	bnxt_re_net_register_async_event(rdev);
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 04a623b3..2c82a2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2787,6 +2787,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 	}
 	__bnxt_queue_sp_work(bp);
 async_event_process_exit:
+	bnxt_ulp_async_events(bp, cmpl);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b9e7d3e..9a55b06 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -339,6 +339,37 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 	}
 }
 
+void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
+{
+	u16 event_id = le16_to_cpu(cmpl->event_id);
+	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_ulp_ops *ops;
+	struct bnxt_ulp *ulp;
+
+	if (!bnxt_ulp_registered(edev))
+		return;
+	ulp = edev->ulp_tbl;
+
+	rcu_read_lock();
+
+	ops = rcu_dereference(ulp->ulp_ops);
+	if (!ops || !ops->ulp_async_notifier)
+		goto exit_unlock_rcu;
+	if (!ulp->async_events_bmap || event_id > ulp->max_async_event_id)
+		goto exit_unlock_rcu;
+
+	/* Read max_async_event_id first before testing the bitmap. */
+	smp_rmb();
+	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
+		goto exit_unlock_rcu;
+
+	if (test_bit(event_id, ulp->async_events_bmap))
+		ops->ulp_async_notifier(ulp->handle, cmpl);
+exit_unlock_rcu:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(bnxt_ulp_async_events);
+
 int bnxt_register_async_events(struct bnxt_en_dev *edev,
 			       unsigned long *events_bmap,
 			       u16 max_id)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 4eafe6e..5bba0d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -28,6 +28,7 @@ struct bnxt_msix_entry {
 };
 
 struct bnxt_ulp_ops {
+	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
 	void (*ulp_irq_stop)(void *);
 	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
 };
-- 
2.5.5


