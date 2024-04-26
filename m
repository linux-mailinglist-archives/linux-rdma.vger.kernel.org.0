Return-Path: <linux-rdma+bounces-2117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF878B3F62
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EB81F24CE7
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787D14A96;
	Fri, 26 Apr 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PS19TAq3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8098749C
	for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156453; cv=none; b=XLewiFblIaJCEboUEHCbSi1qde0nsjiAjBdUzEQbAp6JFpcu4n2coQtyuIzaiEnDvN4Eu6cvAAl32otLNVpB2DFIYRc6w0pqA7NeUZSV8gYS559eF+XYsKjwc4FlGpzXPoiU2/iSs2y8guPQu+R+lRMHe6GTlxgJ31f2LFKyIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156453; c=relaxed/simple;
	bh=MLuvGJ/zA1iclcyHt/GxmXZCz5tS19mI8X3ZFBvh8do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXM5O8R7+oRwIxhrUMkxVpCW5L35EDXN2UDKEEpMngvMI/w+H+oAF9ypocSQu7uvgfol4hTIVwNkFJAbjtrdUjUa8Q4Hlo6lKWwAnTbbLJb2J2MBODvurR2lklR0NjtLuSkqd9cB10UOTtCBbagPb2oeDjFfTePOgF9Tn7NcoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PS19TAq3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso18961455ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714156451; x=1714761251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvWkUDJTV88ioDILsOGCqcHdicMQ5/7lOhgwRuMptVU=;
        b=PS19TAq3fZDuOmElwvm4aY25ENEM+vR9XOJEbtlR79rMVLfExkKE6Uvdbv8KmpW09j
         a5ztdq/SlHm4DXkzwTnKWl3y3YmCri8fBi2T7vvAqqDM4TdiSTFKA8I83JMXcW4LBF3V
         tP9zfEduvPwtYPXBp1Ys7sj6odRVHm3eW4Qv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156451; x=1714761251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvWkUDJTV88ioDILsOGCqcHdicMQ5/7lOhgwRuMptVU=;
        b=j6iWZVwFyMSSJSYGhZDSLEqGhLvOLpz3uPes4vnSI9MboM3LUCt/Mq/PgBGcEXcx9k
         FR7QEzURYIn6yw7yNPftiBf/7tg+ifIwYrar/QA6NDBC4upYDCF4UMsWR6dt4VQ7nyxL
         ry63x5/WzObSFfXst0Lpul34cwZwvtb2X2Ci8J+D+CUiORdt13C5cldjgu3ErcnNhSMT
         0DWKQoxiGBD5Hg7R6zq6jdh1JT9pNTRUAqF6JzK/zM6/qKdOzGIRVFgnqHKsaFymDmCH
         mVwUTWjbX1Fc/s61mcXyo+Y1PJ5ClhflfsoamAW9HQilBtsacQadNCOEbNEgq0NC47O+
         Ek0g==
X-Forwarded-Encrypted: i=1; AJvYcCX/FMp3jVcVKKooaPKGBkKhg/adYHxPY1OzB9xhFGDSZHILH2OQJM9bn0FwGFeuQXffBBs5bALCNDMw8e1WzPxx3MNRnWDFz+4K3Q==
X-Gm-Message-State: AOJu0YyUPPEhUeMp5k8UIi5nNlA7JCGCl4f5yaWc/IqEvGwpN/RWu2V9
	VHHHWJzVLknR5U9Mz8yzpAJCF/PBAxvUZa6+fotmeoEmUWIkjPBVAQtaIxtW7Q8=
X-Google-Smtp-Source: AGHT+IEL2BH46uz5mSu+XJ6KKa6VNvwHhbLsO2C+ij6hWATE+1ghZzydX50iems5S/LvEF8wTN3Zjw==
X-Received: by 2002:a17:902:c40f:b0:1e9:cf94:5bea with SMTP id k15-20020a170902c40f00b001e9cf945beamr4414909plk.35.1714156451222;
        Fri, 26 Apr 2024 11:34:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm15713152pll.100.2024.04.26.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:34:10 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/3] net/mlx4: support per-queue statistics via netlink
Date: Fri, 26 Apr 2024 18:33:55 +0000
Message-Id: <20240426183355.500364-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426183355.500364-1-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
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
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 5d3fde63b273..6875f8c5103a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3099,6 +3100,83 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
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
+	if (i < 0 || i >= priv->rx_ring_num)
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
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	if (i < 0 || i >= priv->tx_ring_num[TX])
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
@@ -3262,6 +3340,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1


