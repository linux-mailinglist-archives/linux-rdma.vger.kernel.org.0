Return-Path: <linux-rdma+bounces-2030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69F8AF794
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 21:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B8B1C220D7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F2142E8B;
	Tue, 23 Apr 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CN2stkCg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0C14290F
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901783; cv=none; b=JE4kvdFym0/eCZ/sqhGVfznANUkBF1e1s9/Q9XCgSrJOOTKxEhFQEH/DpLLV1T/2Lt47GaAkyi950mt6mHxa+g419ruPZ1yp3O+LOrU2g143drhamFqmiUASHaXZ/CaJezQTgqRDgexYp0hBXvBd/Ex74Z1fiz6HNZIN++m14/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901783; c=relaxed/simple;
	bh=Ia0r0BSwe8QIUJufAJclFiQc0GFm4DiTWN09Y106Hm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9FQF1iOgjhCc4M6BMCrExcoOZD/OBD3YEg7bpwk2t/A4AQXVH04zqR+FRRvWt88ja04Plb1HiP5xwss1WiftwwCO0Na/Tboa1QEjr23bKC7Qq6OjnCwSP70+PoJ2HWZCA/wQyLkyZmPuC2nHkrU/UJN56vwwYFvPyN8DecNQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CN2stkCg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3461943a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713901781; x=1714506581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVn2/16u03FLjFZk8aJRPJceLU2TpVvTdEBl2UjSyh4=;
        b=CN2stkCgehZlulLdHqvj4QacpGOOalxpFaExf6HABiOhoqahuJ8NZIgWGYxRpWhL0E
         P2XMn1Pf11viDCxJ3SC222bNo9qeAfphBqcbqucYlwivRd/+RQLb0/R1vMVR0k4E6Bpe
         M8/UbE/xbCWBgnC8dL6OjZw+eNODMo9P/utfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901781; x=1714506581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVn2/16u03FLjFZk8aJRPJceLU2TpVvTdEBl2UjSyh4=;
        b=txtkBIbMnCYCAHVIORJDSsShTxPbXgNWS8AW+qgPhN0Zce5zhwvtSve09CQhIA3PWO
         p7WeJtH0an/2GIM8qhOrUj8jZKfnhtnyhc6DWJD1TOt9utSVXHxdz26Iz5JIu6cM4k25
         jB7c0/35wdLGyRR2LzAMApmGfFCeqSVZ+soJeBSuTYR1uLaa7Uj3W5Vpw6fEeVUGDLZF
         JAm/f0GBdiVMHkylG3AKdtOEjf3/sr2thUjLS/VaKUPcRSVZ4PfsMVQtW+b4wdiuY04s
         x4ZGe8IFUrVHRIirhrGF/T0f4t45DhHU38eiEZ9hWe+K11/taw33Bovb1W3WMg9+MOak
         VQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUuOMuANxhkiTua9dGCkn+4WKaY2kQMawbcWH/1s6HNEfn+rUk9twbhViBoB/fU4vhWQqxH2POgL0yw3bcSV48pCB92Jig585x4Vg==
X-Gm-Message-State: AOJu0YxwdW05qdOC9QJh0Zz/xUsF27mXkDXzh6NROy+OMxvIO0+7d/qo
	99KWD7FMp3c2c2VEGjnoc63H2I9ZmrWooTrXUlD+oLJdF4/m5QoH+Eog9VsYE7JN2snajwtGcJ3
	g
X-Google-Smtp-Source: AGHT+IEdHVRIc38qxCA1mIyeOG1MZrMmyYzSbB685Hg3GGC/hMJZ8mGeFWAIK08zuqTSfXkJb1ZZRw==
X-Received: by 2002:a05:6a20:974a:b0:1ad:746:b15a with SMTP id hs10-20020a056a20974a00b001ad0746b15amr349392pzc.47.1713901780830;
        Tue, 23 Apr 2024 12:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm9995672pfk.215.2024.04.23.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:49:40 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via netlink
Date: Tue, 23 Apr 2024 19:49:30 +0000
Message-Id: <20240423194931.97013-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423194931.97013-1-jdamato@fastly.com>
References: <20240423194931.97013-1-jdamato@fastly.com>
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
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 5d3fde63b273..c7f04d4820c6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3099,6 +3100,95 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
 	last_i += NUM_PHY_STATS;
 }
 
+static void mlx4_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+	const struct mlx4_en_rx_ring *ring;
+
+	stats->packets = 0xff;
+	stats->bytes = 0xff;
+	stats->alloc_fail = 0xff;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	ring = priv->rx_ring[i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+	stats->alloc_fail = READ_ONCE(ring->dropped);
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
+	stats->packets = 0xff;
+	stats->bytes = 0xff;
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
+	int i;
+
+	rx->packets = 0xff;
+	rx->bytes = 0xff;
+	rx->alloc_fail = 0xff;
+	tx->packets = 0xff;
+	tx->bytes = 0xff;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	for (i = 0; i < priv->rx_ring_num; i++) {
+		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
+
+		rx->packets += READ_ONCE(ring->packets);
+		rx->bytes += READ_ONCE(ring->bytes);
+		rx->alloc_fail += READ_ONCE(ring->dropped);
+	}
+
+	for (i = 0; i < priv->tx_ring_num[TX]; i++) {
+		const struct mlx4_en_tx_ring *ring = priv->tx_ring[TX][i];
+
+		tx->packets += READ_ONCE(ring->packets);
+		tx->bytes   += READ_ONCE(ring->bytes);
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
@@ -3262,6 +3352,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1


