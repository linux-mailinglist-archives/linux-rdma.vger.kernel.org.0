Return-Path: <linux-rdma+bounces-3383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99609911A09
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D87B2387E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5B16C444;
	Fri, 21 Jun 2024 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMeaS5rK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FB16B3A0;
	Fri, 21 Jun 2024 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946352; cv=none; b=gmGr594oSXB60ylqGNd7p5i7jyRC4Udmt3S80ZvAg6qp0c+Naf8qMBsUmzAy5f/wRYta2lmAE3NW7+HoumKJ7TlfTIOLjDM0999/YBRDpWnnvAVQd3AK9G5eftWMK2HMN5rgPKW7jWDQ+/XvCqYBdjmvZ/oVlntlzgaPF1N0rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946352; c=relaxed/simple;
	bh=i5I8aG+aYcWEncWeF56dW54t1OzqXvJqCOlfAieN1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyIzkLBtHjEsnNMdN412IafigIWJcwFGj8kBG1J7/FhYKtsYuBsAjKgF9hf/vZLPKPk5ZTHEPlr0h7N0dni8SGLXsOW1nTNvuYNpBy+h2sFBOu2he9I680WSkq6qNzLlfLQhDjQws173gl3gdqqxKwLJKUOvbIdvowPuI9iQDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMeaS5rK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c81ce83715so224219a91.3;
        Thu, 20 Jun 2024 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946351; x=1719551151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=FMeaS5rKcYJky99tWSaBxOp8kr7ywHh/jSNZ2/FBQb+Vx0G9yF7sZ6FKj6HBkhx3sA
         dJU0Xbzrduzgja7FYggFbPOcq4yiEyn5tFa2Qi4MHJWmv0ftnl56pM6eOC+xqmBNMjZE
         2WxM5uYwKQHCJ7OapZSW4vUMAawnN0ypj0fi8Qe0wvUV1ht4bthocC6Au5lIu39ZczMB
         0OuJ5e5GCH2Ebts3x9LoqaAUaNyQwMrUeD+oY6OBlbm+noi6PS/XvXzqYjsZIXdQsD4c
         GXOP+BZqBxIUFVP4n/0Hmr3nCxmk7oqJP6Ey/0xsrY+z8f2IryJsUUsr4WwAaxlD6ZZe
         y4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946351; x=1719551151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSOLAIhMr7ucmgYUhEqNv7YbAkTdXAs1lqXyxcdm0Hs=;
        b=G6UGT8jPb4OYsIZjmFKnP6d34H8PQLHUdvSCjtlDX7wiHATVOabWazU7LPyg1luABD
         wLgMhjpOCVUoCR76RFnlTulbTSrdA7WT/5douudU/pkF5iJbMRCaIAsB8Zprwq9Lq0Bk
         /xbqn3V6XPkLNyBOVNxKoMAT9ztZgyhUJCL709iLoW/fl4lKMHtUzdNh7nA2tyvQJNN8
         cqRMDVwoAcTNm8QKuaxzeqLucy3Ih9Lb4mmd1/pPHEuxzIhD1mVJLc/cCx6KNMcF/pmL
         haudWda8b8N/PtbCXfPqKESIT+L1Bydfcg2uZP8KBBNcLIvwaTANGZHGIM1Vh6ij2KBj
         EqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9GPFfnnxXQ6X0a/ckalLD7KKZM1S18EcbgfUEl35URn16xT+RjTBn5lwUstQWDH38UHUvqcvjIc9LIBaKN4cjS8qbW0fR93ZQedmO27LPpo6byG9vtQj5E+D69Gqhziwfm2IomsfdfMwqE+FnsvwfXC06u5TOhEsrJG983elzaQ==
X-Gm-Message-State: AOJu0YxzePXBrAMfEjGeILf86wa2i33Q5rpwBsfZ6fGQcXlGys6bO1jy
	1FxNP0R8RoPnUHTLzNXcDem8+UWjceB5IwK2Hnn32OxJY4JHSvzm
X-Google-Smtp-Source: AGHT+IEyuwYNpw8Gzr/dG2J+s7Nt7f5YGBzB8AF6/hrpl+K05+/Kt7O4aTIQGkGtG1XbQE+PkcSe7w==
X-Received: by 2002:a17:90a:3908:b0:2c7:2fdf:57b7 with SMTP id 98e67ed59e1d1-2c7b5dcd506mr6764966a91.46.1718946350554;
        Thu, 20 Jun 2024 22:05:50 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:50 -0700 (PDT)
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
Subject: [PATCH 06/15] net: octeon: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:16 -0700
Message-Id: <20240621050525.3720069-7-allen.lkml@gmail.com>
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


