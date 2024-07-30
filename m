Return-Path: <linux-rdma+bounces-4113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFE941FAF
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044C028604F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053F18C900;
	Tue, 30 Jul 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhDyFEmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0C1A0714;
	Tue, 30 Jul 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364466; cv=none; b=saQJJXR7hLqLMJbIZjyrE5Zm0tp3VprW6G1L+SaEmviuwCmx0Wv7V1eHBk6tOmsm+LIgKEdvaCx59fl78TgPWqI+LDi5YeRneMKyr77xFJYZkjS+rvUGJ32ko+wCu7gFRYD+hLR75RmKeUPrdcR+eIFjXJ+FoynGfm7nYMlaMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364466; c=relaxed/simple;
	bh=i5I8aG+aYcWEncWeF56dW54t1OzqXvJqCOlfAieN1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuuTu5rA04/CHCogevN9oYrIlPOVg/m37W0OlUx7xOKH51nPFusYzc03nrJ1ufDkucTsdwFyZZFwLu1yZP3ictT/JSffc4vuN66qtKSQgmqaZBljQ0Hq99ZMNyYVXWhoVuxBuzBPk6M6LHy4Nnq7QP/zhFE2HLhGjAY1FoZbYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhDyFEmt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d333d5890so4566392b3a.0;
        Tue, 30 Jul 2024 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364464; x=1722969264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=YhDyFEmtC6UPVJKTBxn7j0Hdn8TNbaKQ2bOuJg34uX6/ZDfMp/VZnpCutfOLMaDCn1
         cDHVQNnt1VaYDfdMlsJBE8R3IaIzFmuXBhHDHBwpBj8A8Bk9H6i0OejPFe+1YBE5Ighc
         O0CsxfQAM1MysLfwWWqCTLCpKg9Tx5RS0I/7kT3/AHQNLWCjjZntdyKVV0W0+107zt3b
         1a2Om83GapCecRup4un3ofXc/bjdrPMuIfv5xqYDF1CLjRO5X7NVs699sABx5gSulgmD
         hgrX5wqdteo6m2o4utTrVeoWuaiPQGz7Es3H2pNDiWo5HYgIAdLDYwLd3iz6qsfq2Iq5
         aj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364464; x=1722969264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=l9IWWEdInDaYMXHOnJQ0oZmd8uS+nD/gFHwVUabQVrtqxgTw5n2B7tcmKEfelSzWCH
         cPcVlXbl6/jGlyqdK5cXJkWXh7EcMrmGCDnbPuQRFTzFnfPdX9N5adQJ20G5mf9EwIBY
         23UtbeI2lsTk+kq6MgIbg4rKuo87Sm+Q+R0rKivFHnydkKG+XdrJyhIPSjXWkaT5RW6w
         qAoYOHCQy4I3LWXkrOmXZI/nmJvV+O9RKdohiL/C3ljGOCIpgqMrmLo/6vq9gHv/gXqR
         qhYV4Ij5rl9dG/Llw2tGfndkEwSuLmLUigpC2BVZyucNoIHkBmJN2MfWcvNH3sXg/UQd
         we9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4SJO/PzO7Xaqg12+5m/sLpQQzc0LiPmfxyL3OAg1uSppx91TyRyzfo6IGWXAD8GH83vDZASaqxzH0BNL9RAl2v6uLFtM6MRRxnKL61JoK8zX1+d4EQ3PCiiF3gZV36IeqHSNBa0qJAJ/Zo4mCvB4moIE8TTmUffPiJlKw25dgNQ==
X-Gm-Message-State: AOJu0Yz7jm9DTAs4sB/d52weK/+osMf8ILlLIqxbuTNfM1a7Vel7Hv2y
	G9ing9BIemT0uzsrCKbkrT3AjPl57zXKty8sIcLW0ikEVRZgOEJ8
X-Google-Smtp-Source: AGHT+IGaW6btoR/A4Kaalo+y8iM7yRCvjX+nYGRNH0nXvrBuoT4A8PyVvkGhd6m9uRSpDxD0OfRKlg==
X-Received: by 2002:a05:6a00:39a0:b0:70d:2b95:d9c0 with SMTP id d2e1a72fcca58-70ecea327demr16457353b3a.14.1722364464403;
        Tue, 30 Jul 2024 11:34:24 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:23 -0700 (PDT)
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
Subject: [net-next v3 06/15] net: octeon: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:54 -0700
Message-Id: <20240730183403.4176544-7-allen.lkml@gmail.com>
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
APIs throughout the cavium/octeon driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 744f2434f7fa..0db993c1cc36 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -13,6 +13,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/if_vlan.h>
 #include <linux/of_mdio.h>
@@ -144,7 +145,7 @@ struct octeon_mgmt {
 	unsigned int last_speed;
 	struct device *dev;
 	struct napi_struct napi;
-	struct tasklet_struct tx_clean_tasklet;
+	struct work_struct tx_clean_bh_work;
 	struct device_node *phy_np;
 	resource_size_t mix_phys;
 	resource_size_t mix_size;
@@ -315,9 +316,9 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
 		netif_wake_queue(p->netdev);
 }
 
-static void octeon_mgmt_clean_tx_tasklet(struct tasklet_struct *t)
+static void octeon_mgmt_clean_tx_bh_work(struct work_struct *work)
 {
-	struct octeon_mgmt *p = from_tasklet(p, t, tx_clean_tasklet);
+	struct octeon_mgmt *p = from_work(p, work, tx_clean_bh_work);
 	octeon_mgmt_clean_tx_buffers(p);
 	octeon_mgmt_enable_tx_irq(p);
 }
@@ -684,7 +685,7 @@ static irqreturn_t octeon_mgmt_interrupt(int cpl, void *dev_id)
 	}
 	if (mixx_isr.s.orthresh) {
 		octeon_mgmt_disable_tx_irq(p);
-		tasklet_schedule(&p->tx_clean_tasklet);
+		queue_work(system_bh_wq, &p->tx_clean_bh_work);
 	}
 
 	return IRQ_HANDLED;
@@ -1487,8 +1488,8 @@ static int octeon_mgmt_probe(struct platform_device *pdev)
 
 	skb_queue_head_init(&p->tx_list);
 	skb_queue_head_init(&p->rx_list);
-	tasklet_setup(&p->tx_clean_tasklet,
-		      octeon_mgmt_clean_tx_tasklet);
+	INIT_WORK(&p->tx_clean_bh_work,
+		  octeon_mgmt_clean_tx_bh_work);
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-- 
2.34.1


