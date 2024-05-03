Return-Path: <linux-rdma+bounces-2227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3468BA552
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 04:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE91F2341D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 02:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402718B1A;
	Fri,  3 May 2024 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O6bTUkNn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D3171C4
	for <linux-rdma@vger.kernel.org>; Fri,  3 May 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703168; cv=none; b=oF2uBVm2PCvLR5XqLhFOdsc85COzjON46ULuDMb5PzQKq63YlwgFr7Y/ZAvZD0UCz2CKlNyETRCLzYRj4L0OKbmJAvtJjRPzHXtuWkZKbWvG/J9ShrgNpay782Y3h3idpyzP8Ryb/JjWepUuAJINxMlW+B36/9iqnsn1lTraMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703168; c=relaxed/simple;
	bh=0W+4qulNpxim3pXBIMO7dTvyebotdt1Nj2l6T7+AL9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvhvzvGldB7SWNsJGm2A6kJsMGYAETMKok/MnpdPKAzLGLbMUvb5kv40rsMPxwdl/0lBNqMFOQVvJ+6pGU4JfRjhqeG7uYe/BQWoONEaBNdf4vMQgCRx5R4QGMyagqJcmTG7MZAgGigkshf+kLB0v9+NUUfnnXD+L37mFQDF38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O6bTUkNn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e50a04c317so48712175ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2024 19:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714703166; x=1715307966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx7i6Sbb+BTCT9xqynGVbjpRu8jFxCp8g3RRsDiRFNM=;
        b=O6bTUkNnrzf39McHHyZO2hKN3Yo8+NDysNNo6GqlyGhixmYvsy+HP2YVXOO37Al1Fg
         Irk7fbeRRy0fouWQ6lbOKApwCKGizVT9O3GkGGxJpKum52CP1YQpzq++BRX//tPPGMc7
         PXUY0/iNkypoPzdhmwYwp8TodmVhsb7GDD6Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714703166; x=1715307966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx7i6Sbb+BTCT9xqynGVbjpRu8jFxCp8g3RRsDiRFNM=;
        b=XUMstxJk8MLKHND0Z0yk9+XgYJT1G+8N8DrP/yVfZnjNXwKS4TxMZyqgd7TywPBBkN
         vTpMBTmGyxZPNeKbtfdzOwq/OHfNAf1Pmgz0KvuS/MOQ7yxrEQi8ms6RKbyMamMc9vlV
         +5drxbudwOyvbyM4AZU5F4QLDR8STCE/BJG2gfl1PTL/KX7CpzCyw+c60JqlYpMyYVYl
         WRFSTUBIsvtwtTgRuvd1bWFM+GxxGEqqaSe30hqUkhNPXVv1ShRD3SeFdsMasJXklOLF
         eNMMqH4RqJxKRG8mH6x0T9+66mqDQwK/I0Xd086U2L8Rjbbcap5XQEpZAby06fDybGHE
         k0cA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtWqiY8GEjn0VwVgBDnbUaOyMbICia676x9/wvJjbBIDLszYWSsETA+YK0Jcuz8W/Ja31wjlf2n0MkJhAPTqiHazGPTnYik9tmQ==
X-Gm-Message-State: AOJu0YwVrZCZghUm3oFLvd4Cud8reR4hh7cvwnhdWHf5MD6e28oQjEIl
	IuwC4qc8Po50zJx460u6IOtAwjfnLSi8+IEGihyzzToZbsh/aj1PiaMRshGZag0=
X-Google-Smtp-Source: AGHT+IEgm+26S4LekeWDVaH4vKR/HJV9YvSW8X4gNvzBZVrgk8o3weUAJGW9TI8NVXx75xr5WTh4Ew==
X-Received: by 2002:a17:902:e786:b0:1eb:6477:f2e3 with SMTP id cp6-20020a170902e78600b001eb6477f2e3mr1282262plb.49.1714703166352;
        Thu, 02 May 2024 19:26:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170903054300b001e904b1d164sm2070450plb.177.2024.05.02.19.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:26:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next 1/1] net/mlx5e: Add per queue netdev-genl stats
Date: Fri,  3 May 2024 02:25:49 +0000
Message-Id: <20240503022549.49852-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503022549.49852-1-jdamato@fastly.com>
References: <20240503022549.49852-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to support the netdev-genl per queue stats API.

./cli.py --spec netlink/specs/netdev.yaml \
--dump qstats-get --json '{"scope": "queue"}'

...snip

 {'ifindex': 7,
  'queue-id': 62,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 105965251,
  'rx-packets': 179790},
 {'ifindex': 7,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 9402665,
  'tx-packets': 17551},

...snip

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3bd0695845c7..3bd85d5a3686 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -39,6 +39,7 @@
 #include <linux/debugfs.h>
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -5282,6 +5283,72 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
 	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
 }
 
+static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	if (i < priv->stats_nch) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+		struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
+		struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
+
+		stats->packets = rq_stats->packets + xskrq_stats->packets;
+		stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
+		stats->alloc_fail = rq_stats->buff_alloc_err +
+				    xskrq_stats->buff_alloc_err;
+	}
+}
+
+static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_tx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	int j;
+
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	if (i < priv->stats_nch)  {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+
+		stats->packets = 0;
+		stats->bytes = 0;
+
+		for (j = 0; j < priv->max_opened_tc; j++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
+
+			stats->packets += sq_stats->packets;
+			stats->bytes += sq_stats->bytes;
+		}
+	}
+}
+
+static void mlx5e_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	if (!mlx5e_is_uplink_rep(priv)) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+	}
+
+	tx->packets = 0;
+	tx->bytes = 0;
+}
+
+static const struct netdev_stat_ops mlx5e_stat_ops = {
+	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
+	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
+	.get_base_stats         = mlx5e_get_base_stats,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5299,6 +5366,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->watchdog_timeo    = 15 * HZ;
 
+	netdev->stat_ops          = &mlx5e_stat_ops;
 	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
 
 	netdev->vlan_features    |= NETIF_F_SG;
-- 
2.25.1


