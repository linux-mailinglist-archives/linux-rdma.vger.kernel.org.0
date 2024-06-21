Return-Path: <linux-rdma+bounces-3388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA1911A18
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142B81C23B83
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287716D9C5;
	Fri, 21 Jun 2024 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqTKYOYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F516D4E0;
	Fri, 21 Jun 2024 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946362; cv=none; b=oJeJhTS3uHC1c9VFi9iRQ/A+DmQgPTSlgi1ZQ3ubPTECx3MsS5JZ1TjFNiuRc7wPcgNuv/TxgDl4Ht6Fhnh0xMi1q0VBcAFqrfH9wy2xBkKlEV73Yc4b2ta+9ZSnT8QM99YRcN7AbPxpkviGaYg3CIVLZ3xBxilAsGnnGpSt/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946362; c=relaxed/simple;
	bh=5fDJtwutEEA5fJCM51lQrlFtqk5iBeZOuS616CxfH8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MoMK0SPHrHUsnb25Wszk9Y+u+hvxS3q/GXgtSH77mS3nsKGZxYdnEzcK58lRsQzFhP2Y289d68fzcSsyjmn9kaBFWdx9xV/j7jrwh2Y8K2dGYqoKtqGw1IpVHynjS70h1tHcqwRQ+rDMEretd5HoecFij3Ghzw713IAug+NUP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqTKYOYT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7023b6d810bso1251581b3a.3;
        Thu, 20 Jun 2024 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946360; x=1719551160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=TqTKYOYTPgeWRO1T2L0ypRCLJsYaE+3kSsASJSAIt6JELEUzBiLmDon3B9YuV93hoz
         DawFIC8url5Z+yqfX4i8EbziDtK0nrXZSaW5DgvM2i3DY+Lx73ZXy8Vcrs9dtlamjkGb
         jn3gpvW2U775uiTvvLOiYUDuS/9n9N0+PK2uGSlFiG9VWwKHCkv9GnfKyeQnq50hXY9g
         TzUKX0lsSATedNC+uINJiO8KCH8ffJ4x4n+MNqzE0fEneTg0nGrkN4/yrN5jY9Uql941
         otGuL/Htn0XETlnJVIhuEjmx+szjID8sgm7dTtD26cyT4QFYe45qW97CHki+1OlgNzJ2
         vHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946360; x=1719551160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=n6E5WKJVMipW2e5uZgNmAhEat5ldUdM9/fq/zOsQtWzPC1O9SLRQnQGbUPqY+KdAVJ
         CbFN0dgVQ16GNCKVdU76ZNeSVTyPrw/0vSF12wJo+I/nMmBT8k4FJFghX3OG4KkDIfzR
         CwCwze8iVCreuvgYwycPQFjlIcPwomoZfGZRb+9PXmSL+8UyYYi8rIAraxV2pFgjVKhh
         cIMCxRtESDKKG5D6LPVTbcxe8sAZBBPJpw/fUsj8eVrP2SuheW5pmRA9XXgZXBT92q37
         feT5lqUxw4If32G+lQjR+R9BSGPjrNNLE0GPQHMJiQKUHPmFE1X7DT9AMiicIs+s6FQK
         a2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBWrBvuZck6UcAyf5eVOtBDsQN3XApr3Hj1nuBXESPpv6J5/Sfv8vr1682EZ0EowpjsiTqjAN7QBhwdj0zopM4TRgm3PzEBmqSzlAnK0d3Z79jPZjrC8gikMpdaCjWcAGm/8TTo0I5fnBeRkL9KdTvvnx9yEorEbDG0aGTfPRERg==
X-Gm-Message-State: AOJu0Yx+aANcIF2hl2a2+d/rGdwfcO0i8UVNvsfTAUpXiSGPr/d6Kjpf
	EjYmkv/kLaAf1dZzJDc11ABZl9jqeiwj77q9y/hG7E1O88zW/d/G
X-Google-Smtp-Source: AGHT+IEVOdj0RXoWiJFMYJI3sqR93h6FlwoyW52g7W54MYrEVDJaXXjVVjRyUme5vG156RMqKoKpRQ==
X-Received: by 2002:a05:6a00:982:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-70629c1f982mr9111181b3a.2.1718946360102;
        Thu, 20 Jun 2024 22:06:00 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:59 -0700 (PDT)
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
Subject: [PATCH 11/15] net: ehea: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:21 -0700
Message-Id: <20240621050525.3720069-12-allen.lkml@gmail.com>
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
APIs throughout the ehea driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/ibm/ehea/ehea.h      |  3 ++-
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea.h b/drivers/net/ethernet/ibm/ehea/ehea.h
index 208c440a602b..c1e7e22884fa 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea.h
+++ b/drivers/net/ethernet/ibm/ehea/ehea.h
@@ -19,6 +19,7 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/if_vlan.h>
+#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <asm/ibmebus.h>
@@ -381,7 +382,7 @@ struct ehea_adapter {
 	struct platform_device *ofdev;
 	struct ehea_port *port[EHEA_MAX_PORTS];
 	struct ehea_eq *neq;       /* notification event queue */
-	struct tasklet_struct neq_tasklet;
+	struct work_struct neq_bh_work;
 	struct ehea_mr mr;
 	u32 pd;                    /* protection domain */
 	u64 max_mc_mac;            /* max number of multicast mac addresses */
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 1e29e5c9a2df..6960d06805f6 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -976,7 +976,7 @@ int ehea_sense_port_attr(struct ehea_port *port)
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	/* may be called via ehea_neq_tasklet() */
+	/* may be called via ehea_neq_bh_work() */
 	cb0 = (void *)get_zeroed_page(GFP_ATOMIC);
 	if (!cb0) {
 		pr_err("no mem for cb0\n");
@@ -1216,9 +1216,9 @@ static void ehea_parse_eqe(struct ehea_adapter *adapter, u64 eqe)
 	}
 }
 
-static void ehea_neq_tasklet(struct tasklet_struct *t)
+static void ehea_neq_bh_work(struct work_struct *work)
 {
-	struct ehea_adapter *adapter = from_tasklet(adapter, t, neq_tasklet);
+	struct ehea_adapter *adapter = from_work(adapter, work, neq_bh_work);
 	struct ehea_eqe *eqe;
 	u64 event_mask;
 
@@ -1243,7 +1243,7 @@ static void ehea_neq_tasklet(struct tasklet_struct *t)
 static irqreturn_t ehea_interrupt_neq(int irq, void *param)
 {
 	struct ehea_adapter *adapter = param;
-	tasklet_hi_schedule(&adapter->neq_tasklet);
+	queue_work(system_bh_highpri_wq, &adapter->neq_bh_work);
 	return IRQ_HANDLED;
 }
 
@@ -3423,7 +3423,7 @@ static int ehea_probe_adapter(struct platform_device *dev)
 		goto out_free_ad;
 	}
 
-	tasklet_setup(&adapter->neq_tasklet, ehea_neq_tasklet);
+	INIT_WORK(&adapter->neq_bh_work, ehea_neq_bh_work);
 
 	ret = ehea_create_device_sysfs(dev);
 	if (ret)
@@ -3444,7 +3444,7 @@ static int ehea_probe_adapter(struct platform_device *dev)
 	}
 
 	/* Handle any events that might be pending. */
-	tasklet_hi_schedule(&adapter->neq_tasklet);
+	queue_work(system_bh_highpri_wq, &adapter->neq_bh_work);
 
 	ret = 0;
 	goto out;
@@ -3485,7 +3485,7 @@ static void ehea_remove(struct platform_device *dev)
 	ehea_remove_device_sysfs(dev);
 
 	ibmebus_free_irq(adapter->neq->attr.ist1, adapter);
-	tasklet_kill(&adapter->neq_tasklet);
+	cancel_work_sync(&adapter->neq_bh_work);
 
 	ehea_destroy_eq(adapter->neq);
 	ehea_remove_adapter_mr(adapter);
-- 
2.34.1


