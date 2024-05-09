Return-Path: <linux-rdma+bounces-2378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED98C17F2
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 22:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08C51F21CAA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15E126F05;
	Thu,  9 May 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jXh2kqeU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129885623
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287872; cv=none; b=PmnBPD/gyqQ/DYqKYayU1ak/DPPQ19KBcnfjBFVS3eaYFt210BJEqUFlWlXqf/b6uRiMkSoHFGnvXIUPRX+C/kOI/R6L6JkxjFZR4Qbh14R6R/QtyVTX6CVuYSlIjzyHizo2QNreHpwJ2f9WaRYM8TwHQ/ehh5DJkCHDf1HPyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287872; c=relaxed/simple;
	bh=jh0q0ulQ5LcPy3XQUg0Ue3n4pGfewvXGaX+N3ICGH+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGtuacFhml3eDzfPB2fnObc+lbbRZ9hlaBwz0wSwSDc1F5nPTtOJgZF7LO2I3ZvwGGCgZwvdNky7VXHfeqzRxL8rPqh1PHBWP9sAoK2eyFQIHYem2hNp6+L5XRvpRMBLjMPbrwWBP05gQX7234IzLXTeheT25kMauR+iT1gR+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jXh2kqeU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee5235f5c9so11277245ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287869; x=1715892669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No8/jmvB2lIMy6tK61c0Wm+y+Z2VaVEhQDXdDb8ENDg=;
        b=jXh2kqeUaVQ0nhfXGHTIL23aws5KMCR8Yscd7r1sehBwfSwQRHDjCnXqcnG0IRr0oH
         3a+hKH2nHUvzXiXJA9/y/H35CGqSW2LAh6Wx5h13meATPrwl3nalSImdxrrhXHWILNuv
         4JPlAyjSq+MMJEmRPYcZXa80RgNMRcWQWZ1i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287869; x=1715892669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No8/jmvB2lIMy6tK61c0Wm+y+Z2VaVEhQDXdDb8ENDg=;
        b=fTJ8uGKxaiabGfRs/hazA+KCFPs4vZMRyjysoQmau3anlrvTf2YE4TXLi0yzCvkMC4
         ccbjpfYGeGNa7W/2mbfu9nfhzQQSgBNUe3QKAJlucZPoDElcLlBiiAtTdcENcAJ/3mB/
         0p4T0Widfub3WFQtwWwor5Myjmp+JFdp7w2A8j5ri9wrt0b+etDDhVfyybphR2uTY5jN
         +duMvLDNZol1Tikd6p+wgkYSjCCnSspBUN3pVXZa6hlgv/Mo8gyQwBJcwvj5FKazX5ES
         lEvIOIfXufCGn7JBgy9bsDXHYGGQ0UnkSp3QhTSSF2f1Uv9wLgbxZ3M+q7VNtN7Wlvql
         61MA==
X-Forwarded-Encrypted: i=1; AJvYcCVMlSiEbNSsH2fn9/29SrrtGljA7MpV+TKxjXGDRlsGI9kJgVPWOMg+UT+I1asS5aAlQii448Cje/S68hZ9eh0NkkDSCPSCi2pY8g==
X-Gm-Message-State: AOJu0Yz0ibiwRAJedRfgQ3ATleH7K5UwRXFwUUTrH1eRuJj6xD1Tutm/
	DlNzRwNAIDAAhknzPbaBmYQky3bpoGGcVaqovFvsnA4QaiuvxJ0h/fw1J8/K9Hs=
X-Google-Smtp-Source: AGHT+IFdJzoOlK3+2PZn0yWAVQ5SUDkUUcQQGgjCs9iyqPeiJ5XXgMJqnpVya2oFF/6RdwbW0XGY1w==
X-Received: by 2002:a17:902:f812:b0:1eb:1474:5ef5 with SMTP id d9443c01a7336-1ef43d2ea72mr6154495ad.33.1715287868873;
        Thu, 09 May 2024 13:51:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:08 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v4 3/3] net/mlx4: support per-queue statistics via netlink
Date: Thu,  9 May 2024 20:50:56 +0000
Message-Id: <20240509205057.246191-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509205057.246191-1-jdamato@fastly.com>
References: <20240509205057.246191-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx4 compatible with the newly added netlink queue stats API.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 4c089cfa027a..fd79e957b5d8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3099,6 +3100,77 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
 	last_i += NUM_PHY_STATS;
 }
 
+static void mlx4_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+	const struct mlx4_en_rx_ring *ring;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	ring = priv->rx_ring[i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+	stats->alloc_fail = READ_ONCE(ring->alloc_fail);
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static void mlx4_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+	const struct mlx4_en_tx_ring *ring;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	ring = priv->tx_ring[TX][i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static void mlx4_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	if (priv->rx_ring_num) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+	}
+
+	if (priv->tx_ring_num[TX]) {
+		tx->packets = 0;
+		tx->bytes = 0;
+	}
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static const struct netdev_stat_ops mlx4_stat_ops = {
+	.get_queue_stats_rx     = mlx4_get_queue_stats_rx,
+	.get_queue_stats_tx     = mlx4_get_queue_stats_tx,
+	.get_base_stats         = mlx4_get_base_stats,
+};
+
 int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 			struct mlx4_en_port_profile *prof)
 {
@@ -3262,6 +3334,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1


