Return-Path: <linux-rdma+bounces-3380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F299C9119FF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EF3B238E5
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64C155C82;
	Fri, 21 Jun 2024 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG0D9NSV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BF23A6;
	Fri, 21 Jun 2024 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946347; cv=none; b=ZI8dyL87IB4ILLhGIZ0dPQjHIa71OlUaQWpUyuEmLoSWIiBK4cON8zxWz7At+EhdQxf2clIreJvz9oju6HFTdjmXGkGWDuq/j6L53opduwaL4EWsrEaQVTDJvO3FdLId4dV0KtVf4Xu3wWB1qLBVsonIQ0q6rzu08bkPjisuzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946347; c=relaxed/simple;
	bh=0lVjZMbqARbw7gbAYzWGubSXpkB35s6c9hWX6BwHW18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBt7ff4JmuNtD9e0QyqAkTqM9XcD8KaNwuRO04NTCo7SA4L2pZ5jBWBVDqwR18JfWa+ypJikV5rVD7zrS7sVd69qIkvdrOzFovnT9z+D/QtqqHhCN0/AppPCBV0O3Z0f4z2vwAZQxCLp1Av8S/M3DMX5XjmohaDeH8g1xcIWTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG0D9NSV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1275577a12.2;
        Thu, 20 Jun 2024 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946345; x=1719551145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=ZG0D9NSVZBz7s4VmB5sdA5XQ+TRI/0WZ56EBORY10efu8hmSX2rNiLuzlE9TsEKVzw
         YZCPuBjTKnjSZoHwdYrJkVMzeu409IoIxG68W9Dk8Ov0S5Qx5y1ArPOXWi7GkzpQlI+z
         huUeMxmKJ4LHceEDsgOGrcNE1dmZ1t+uUxB8p4CtDscfl/O8m4xTV3okYz+CidnP/L5O
         cN6pv/Gimei4DUQeRoe059LEffZQYZhWigOwDH4F5jOuKEg/VRXqiP+FhDK19eRCnMFS
         lNmmMCQcsr6ayllNoI5luNsNzdD0MZHn2/RlgSf9BQnnlMjezU/qsY1e3GnVlNO7pO34
         GrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946345; x=1719551145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYc7brdTKERYILuKkf0RRNv0Il2mQiysyxHJxGPSiB4=;
        b=HFuncynkjJ4FSBW6QVmRi0NgAjDOdssgRDWOKi+M6GsTFscZt0BKsJ2N7TYxQz7vJC
         SQP5WKq4Y7qVKhxAYlTfuYDaWG+DzgfJVfdqi92amzvdMPer3d+4Fpfa2SKPwXxHtPKh
         C7uwNKMiWbRVr2L8MU4nWNt/joUDxHSrsMCnY4DRnysfmH2jJRSfNv4jk46TT43NmWJ3
         2FsvifBvGBzGKVVB/ZgKJIO+WoZI9CgU+/ErzUZ07jNBSZsqe6kSdZ7VuScwRq1J3knH
         4pp++md7E8F9mn21efI5h29lw7A+GjL8A61RLEs8QHDrgj1TiD1D1+dnKoC4D1qiCTyN
         oWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVXLFf1rLaZRunOEQnY4JT4C9Zmo44AfaHq1bs0gmVied3F7uNHFvi1Vh28/kYz2syI95W1scDJCj5NNp3hK7lLzieFNBRU7zIOW0mvBCfdigFHMQF95znewqs0NKGP7LilBMWHhuUaA8B2EuBELTZvuviONzMGBpe2xClzc5gCHQ==
X-Gm-Message-State: AOJu0YyBGOVr3uj0b4CVg0A5GY+Vs5ZvI60S3Wg1rpVvADY+SUR86sCC
	xCbtdxBoLefPgUgdvsfPXoECFV7pjmqs4CnLXizSxbZ7OKGs0Inr
X-Google-Smtp-Source: AGHT+IHYAJXxWZVMfjWxNbi3UugHkou19VoY9+TyivjErZNQu4x7I1j8JUOv3Dq0XmIXZA/nVjVyHQ==
X-Received: by 2002:a17:90a:1bc8:b0:2c5:32c3:a777 with SMTP id 98e67ed59e1d1-2c7b5c8ffccmr7374530a91.28.1718946345256;
        Thu, 20 Jun 2024 22:05:45 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:45 -0700 (PDT)
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
	Allen Pais <allen.lkml@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 03/15] net: cnic: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:13 -0700
Message-Id: <20240621050525.3720069-4-allen.lkml@gmail.com>
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


