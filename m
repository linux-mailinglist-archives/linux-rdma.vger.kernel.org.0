Return-Path: <linux-rdma+bounces-4118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC36941FBE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0EB24401
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC611A7218;
	Tue, 30 Jul 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXbIJGJB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A221A7204;
	Tue, 30 Jul 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364481; cv=none; b=sgm4y7YTfseWgt1WCoadXQuZz5Fddj2HeG+wZucmELQuD0nQBK7Qvpi7b2czgp0FRtt7prNtKBMD6fyRS+jDJV3PjJJNL2zWwa30cR4Xb0GZPXD5VjNfe+6OLtZ8cB6Q1JksbrIaKFi5jDIgH/nojfg+MY0EgtI2HQ7EJ3gzJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364481; c=relaxed/simple;
	bh=5fDJtwutEEA5fJCM51lQrlFtqk5iBeZOuS616CxfH8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOMxTbMWVa4Ofys0FdQPGXM0MFKyVi2SE0/LGDOs+VjY/FueCPUckBeD1atLqALMmp88O/Mq6PKrFRhxAX1a5Ki4Vi1bevxFqmfjblu9Sq0jAM48msnasjxaYSzlni+1HfVx5NKMsoFD9FpnrRbbGEqG0ExYCqOUHKL3+B+HHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXbIJGJB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so3478470b3a.2;
        Tue, 30 Jul 2024 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364479; x=1722969279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=JXbIJGJBrdeCc31sIetIDFoC4yd1f838X24bwyYlB9r/BX8v5+n2uZX6kea6e7nP5W
         u+FC9wNnrETWY1J9Wdn5qCZvfr3biJZGbFfkO1rMsSBuV/j/TYp60CsA8VC01qfkodYo
         tuXxkyWiRHryBRJSZPAt0Jgw8FjaMTdJx+f2Y3oQ0zdZqbOxTYrJ+ek4ouAjlJp8/HY1
         SEqiI5OWXBb2gEBRhtuUpAqHjPCT7D56MWugpjd1NP9D8ugGzxKF22oBH82d9XmZX73L
         4uC2c4+oCHC0hh7piI77O0EdKASWvNIBesy9xhjCPCAPTF8l8fnogy49pnkBLtQFLr2w
         50dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364479; x=1722969279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEA7niYFvLj2PrS7r2T7s19npKTXpaxvDJNgOhJ1Ngk=;
        b=f4y0XefvHnwsuAds7FfKlSNnxHQXKXDUF3+a7sMnIk5lSRLYI+CtN0bl5yOTZ7X9ZO
         e8qqq/pEiDJiHC11cj2YaWY5nCnKXL3WvBdSdVs5WmMG++h/ZvNhHR3Pf5Vp9xFplyOL
         QOLDqp5nWI6BoCvvPqng5wn2oXO8Nzej9Lshyt4sPWM7boGSoE2KCs55l9oOuiAKzeC4
         4jmRQ3FwbToBqGyZIda53TaLTH3TEyorbjEEk70wC2vQxqTmsqeSuQF2Iqjqu04UWSIA
         cLt/BnyfbLDRU5M8J6v+LCtIaL9CyPbQv4efseNHVPCAjSiRiYINgBNy21NYHfTecTjw
         W9iA==
X-Forwarded-Encrypted: i=1; AJvYcCXE5l03b+TDfrAtERN2W9WPwQoZgCMdR3qYwXyiWMP1++OeCJ9cSt5uS0xdB2BezxicLMqBLiS65lJ108rKdtABUmoBilronn78om+NXnVlcHmjqsVYA8o/bJzlacRT540bPH5pfB8qFQkP8EE+cOnuMDeVl03FMtokcRakOIhYyQ==
X-Gm-Message-State: AOJu0YwI5MJVOC4loYIbJQz9O9e9JnNC42eJwqvDt93MMaslJ+XiVnVF
	J2w5SMB141Fwo/CrZgmdyI3M5AyQ+as6sqtDZszKWG2DG5QwmvZX
X-Google-Smtp-Source: AGHT+IEhQ5Y7nVWERwHGJ8+Ff0PeqVL7tnuSuJ2b9yeCbRbyWeoECh5IxoPpUVILeKEPbsdhW+rrew==
X-Received: by 2002:a05:6a00:2383:b0:70e:98e2:fdb5 with SMTP id d2e1a72fcca58-70ecedbcabamr10541966b3a.29.1722364478770;
        Tue, 30 Jul 2024 11:34:38 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:38 -0700 (PDT)
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
Subject: [net-next v3 11/15] net: ehea: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:59 -0700
Message-Id: <20240730183403.4176544-12-allen.lkml@gmail.com>
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


