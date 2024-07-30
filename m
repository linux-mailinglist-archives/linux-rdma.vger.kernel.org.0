Return-Path: <linux-rdma+bounces-4110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96902941FA3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CFC1F24D97
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62518E050;
	Tue, 30 Jul 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvpfcwcD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24018B49D;
	Tue, 30 Jul 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364460; cv=none; b=kmNXxKHW7L3HbH1ZHCEUWELMIWmtSUEtZSkqqDnh6DGnsf0sgfFyvoTrkgmlVQGLQZwWcOqQqXgNofcepKoottrZDaD2lOCIIggnb4S03JiUVNAhYRWZerXRE2t4C/ZUTK2SABEHnmz/kvBdiXbC5rhL1WXzSqj2Ni9+z049UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364460; c=relaxed/simple;
	bh=0lVjZMbqARbw7gbAYzWGubSXpkB35s6c9hWX6BwHW18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKnRFWYUKe1yeWbSdCySjMXb6VKfvlphOYgOKWufM0Wq606Ahmsm9U/e9Pv9YHqt//XlFVI8kKLuA6cEVE7I7plxvreSyKp2m+AxJszQ13G/D6EVn4wtFS9Sab0B0DS3KQd/cDV+WGVHShDGOGXYywO6pf4XVWoHI+fynDwEGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvpfcwcD; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9e13ef8edso3281263b6e.2;
        Tue, 30 Jul 2024 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364457; x=1722969257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=AvpfcwcD21BBb7SXRzQF4KPf3b1KSBORFvPMmJ2yW3locfF7Ux4hC5pTDIuaSusnvN
         3M86bCBpdfsb380ppOYehZTVhWB93geadIiZhLTq9vCyzKz2tSzcauxMGKQW/vrFO4yB
         GSVkssIHrcMAaofPqhdBHsXfpupXf92Ljlmeuf1RIrbm77mDcJ4hcoaXnO9KbE0NhCUW
         Uk9ctr6p0MGX7UjZYAhTW+iQsLjqYk7qB5RVIBhqOcWIAhFJ105EfA3UDWNeR4okASCx
         VkWPngG0I4z1aHWWwYBfrtojfa9euxynv08RaLGXXBGCROnlfkdr8gVcbXiKefRAuYmQ
         Q08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364457; x=1722969257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=aOcrxRjoJ/BKB66a+D3zOBiV+J23ItL3Xvsp9DoJqU9uPtAHItWz8gAKsnuQoM3j4Z
         BZeOa7xo9viqpHm8ekm7xRS2hV4zY3AjsWZ5gTj7uZ/Lo5W6lylbAG2dzbiEroDen1fh
         I8+BTbNfR7oJ37DSnGqnQtGJ7fN+v2zbav7qJ3xe+k33vhNPQBb8oVR91OtYAcVSF9qW
         69ZpgzaBBsFChlRVgJuj3HCTu5wlwTMFBPdcI8eaQCRd4G5naMEIslLTvPUN1DT99s8d
         /xMo7BSlwF9u278qoP9B+pyUXdim96EicDDTKMez14sVrZx9K76Lbde7Tuwi5zdq3qDY
         V8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVup1TNGYTP81NUwTTAJJveVHbyzd3CK4WP+77021ETUCuOmOa0AJQG+0yiZKT/qZipO4sWLeDZycB57XX19YcdPlWBUTk7MVZJXJGVpQ44iwiAMR6hF7Z16dfQ7UqRDYfZBgukaHbzNGA+NB41Mo9UCxNuiyMntbfNxN+/P8TaEA==
X-Gm-Message-State: AOJu0YyaIipsAfYNTY7zkOgL+lFGwrfPpltn6nX0eWR/DJwEPUK15xLo
	nDU7xtn2qlO1+amjYPt1Mj4XD2pFtyzp9uB4wAaA5ZfOOgPPGjYB
X-Google-Smtp-Source: AGHT+IGkxO8m4elnJWTAgkvC2oDhhS4zPbvjuafdt7rYO9m145PA1WYmoB5E1XzY8GmRLJ4E5hhiQA==
X-Received: by 2002:a05:6808:211a:b0:3db:ae5:9bf3 with SMTP id 5614622812f47-3db236a06e1mr13020392b6e.15.1722364457302;
        Tue, 30 Jul 2024 11:34:17 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:16 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
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
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 03/15] net: cnic: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:51 -0700
Message-Id: <20240730183403.4176544-4-allen.lkml@gmail.com>
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
APIs throughout the cnic driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/broadcom/cnic.c | 19 ++++++++++---------
 drivers/net/ethernet/broadcom/cnic.h |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index c2b4188a1ef1..a9040c42d2ff 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -31,6 +31,7 @@
 #include <linux/if_vlan.h>
 #include <linux/prefetch.h>
 #include <linux/random.h>
+#include <linux/workqueue.h>
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 #define BCM_VLAN 1
 #endif
@@ -3015,9 +3016,9 @@ static int cnic_service_bnx2(void *data, void *status_blk)
 	return cnic_service_bnx2_queues(dev);
 }
 
-static void cnic_service_bnx2_msix(struct tasklet_struct *t)
+static void cnic_service_bnx2_msix(struct work_struct *work)
 {
-	struct cnic_local *cp = from_tasklet(cp, t, cnic_irq_task);
+	struct cnic_local *cp = from_work(cp, work, cnic_irq_bh_work);
 	struct cnic_dev *dev = cp->dev;
 
 	cp->last_status_idx = cnic_service_bnx2_queues(dev);
@@ -3036,7 +3037,7 @@ static void cnic_doirq(struct cnic_dev *dev)
 		prefetch(cp->status_blk.gen);
 		prefetch(&cp->kcq1.kcq[KCQ_PG(prod)][KCQ_IDX(prod)]);
 
-		tasklet_schedule(&cp->cnic_irq_task);
+		queue_work(system_bh_wq, &cp->cnic_irq_bh_work);
 	}
 }
 
@@ -3140,9 +3141,9 @@ static u32 cnic_service_bnx2x_kcq(struct cnic_dev *dev, struct kcq_info *info)
 	return last_status;
 }
 
-static void cnic_service_bnx2x_bh(struct tasklet_struct *t)
+static void cnic_service_bnx2x_bh_work(struct work_struct *work)
 {
-	struct cnic_local *cp = from_tasklet(cp, t, cnic_irq_task);
+	struct cnic_local *cp = from_work(cp, work, cnic_irq_bh_work);
 	struct cnic_dev *dev = cp->dev;
 	struct bnx2x *bp = netdev_priv(dev->netdev);
 	u32 status_idx, new_status_idx;
@@ -4428,7 +4429,7 @@ static void cnic_free_irq(struct cnic_dev *dev)
 
 	if (ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX) {
 		cp->disable_int_sync(dev);
-		tasklet_kill(&cp->cnic_irq_task);
+		cancel_work_sync(&cp->cnic_irq_bh_work);
 		free_irq(ethdev->irq_arr[0].vector, dev);
 	}
 }
@@ -4441,7 +4442,7 @@ static int cnic_request_irq(struct cnic_dev *dev)
 
 	err = request_irq(ethdev->irq_arr[0].vector, cnic_irq, 0, "cnic", dev);
 	if (err)
-		tasklet_disable(&cp->cnic_irq_task);
+		disable_work_sync(&cp->cnic_irq_bh_work);
 
 	return err;
 }
@@ -4464,7 +4465,7 @@ static int cnic_init_bnx2_irq(struct cnic_dev *dev)
 		CNIC_WR(dev, base + BNX2_HC_CMD_TICKS_OFF, (64 << 16) | 220);
 
 		cp->last_status_idx = cp->status_blk.bnx2->status_idx;
-		tasklet_setup(&cp->cnic_irq_task, cnic_service_bnx2_msix);
+		INIT_WORK(&cp->cnic_irq_bh_work, cnic_service_bnx2_msix);
 		err = cnic_request_irq(dev);
 		if (err)
 			return err;
@@ -4873,7 +4874,7 @@ static int cnic_init_bnx2x_irq(struct cnic_dev *dev)
 	struct cnic_eth_dev *ethdev = cp->ethdev;
 	int err = 0;
 
-	tasklet_setup(&cp->cnic_irq_task, cnic_service_bnx2x_bh);
+	INIT_WORK(&cp->cnic_irq_bh_work, cnic_service_bnx2x_bh_work);
 	if (ethdev->drv_state & CNIC_DRV_STATE_USING_MSIX)
 		err = cnic_request_irq(dev);
 
diff --git a/drivers/net/ethernet/broadcom/cnic.h b/drivers/net/ethernet/broadcom/cnic.h
index fedc84ada937..1a314a75d2d2 100644
--- a/drivers/net/ethernet/broadcom/cnic.h
+++ b/drivers/net/ethernet/broadcom/cnic.h
@@ -268,7 +268,7 @@ struct cnic_local {
 	u32				bnx2x_igu_sb_id;
 	u32				int_num;
 	u32				last_status_idx;
-	struct tasklet_struct		cnic_irq_task;
+	struct work_struct		cnic_irq_bh_work;
 
 	struct kcqe		*completed_kcq[MAX_COMPLETED_KCQE];
 
-- 
2.34.1


