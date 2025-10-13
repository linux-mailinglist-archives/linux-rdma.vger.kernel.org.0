Return-Path: <linux-rdma+bounces-13830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B1BD4042
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5971A500359
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD83126C6;
	Mon, 13 Oct 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbVzEuG9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845F311C07
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367230; cv=none; b=KVaay10a2E/vMOqURk/TT7upnB76Ey9SeiOjR0L0mp15NkKt4VYUG1gkrTdBlXIp0349BlvcZXpn+5W9VSAiiuGC/rxfB+BCSfgGFbDKoy/2Wh3JyeDqc2CmvuCRXYgyVXprD7eClHPRoXckbSIlC4LODY2GSAhE5xWlJdltylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367230; c=relaxed/simple;
	bh=ohf51NQmqI5eH29ikGFIJZZTwuakm4SgvzB8g1tVGig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njZm8OvSXnkvAfz8toENZFdaIJffI3mNfNsYd5jIl1rZBKFYtWMp1AxwYV0CBYNziw/KIFbq5Ws/K/fAk65s96b9iatmM0wxjrBLZbFzKto5i8W42KyYKWo4FD8RoWSdZ61bwH5/FC0OendufkSw6177rFB5hwDR12dgcm3PMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbVzEuG9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso2590781f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367226; x=1760972026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QA5Dn0k/m/ZYqLaKjYYKC36p5eoeH9cvfqouoo8+4U=;
        b=JbVzEuG9DZiYOQNPetls9vOvGeUig5GUF7nbxaOV0yDyJpKHO5BxiX89j8ESSdTUc/
         FeHj7aS3VKF2UhlFlLYRXIFmBkoBEcUuGJGbF9L+8QdAHYlQhn4AUIu7s85W4hVW/1/s
         UsnJwj4+P0J/4mFA/HTVLYmOMEyEjtrDz083LTXAtL8YYrC5kiAKtFripSkUl6jQ3cOA
         Vgusv8TufH82u3zDKjkAQryFhuVbBejFZ1Va0UIqV8ObGDoikoROkI4bWNKZM8tZsUdr
         9cHRztzFjgPc1RzYm7NxWRQgtBKkqBMlyCKZgwlMSjroTIyWG3nw/PrhXjpsocDDivZV
         YJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367226; x=1760972026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QA5Dn0k/m/ZYqLaKjYYKC36p5eoeH9cvfqouoo8+4U=;
        b=eaXFIJporUfkNMBzcSrpCcFDAuJz1HROmff667jSzbDVCO2MQPpUOKt42e+hwqqxQ4
         4gCTCyOd3ZGuckF6lfzOLNUqxLoZwZ7B9w5hEK5YvlfAY5AeQL0ZQFtOB+Xsku2o0Fv+
         YrrC1ePUkCbX+ubBCbO8Whp5K/t29jeaCQCOgH3fbkOTYFFHpw5SYjcuvzIyd+iEUtlY
         KWWmh0VPPhqTuYIbJuWJuujrAtHgE3XDnVC7qHSJwMLX32zdEGPoPybLUT/H4JqcgEhs
         T/YgtdmKWbxcOjnsPd2WwKjp1mzvHYlEno4yFKqSsp6iapWLSYAd1BAe0zPk7HNmaBSu
         nGhw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZWRapGjANBPdrB1hCh971TfnVUIv21qklF5y/GRtiZG3KbwtmVk1d+45BxXmOg2aZLohkXQXtAg4@vger.kernel.org
X-Gm-Message-State: AOJu0YwhM5QjL0Ah1/SMISKJl8/DP3L2DdVMNkQ+P3dZVzw+Eib0Rk2B
	rPY0S30XMnJGJNnZe9HjzAZe8ZNPoQvICLd+iO5shT/uDBZ8G9fJjdyq
X-Gm-Gg: ASbGncuJ1h08aO9FpaqURjCiYCNoB7Sv1QeGgjdHn2hgz3mAf6sn2ao30jUeXUCmiZB
	+SXbI1VJBhR46I2hWjG260GYShNn6wW+ddn4gtEuzQeV2YOkf9bl82D1pXylElgHkpLY9tfUx2H
	rnRRz7Vmw+NvK2+9/HGZqZ1FW/qKOPI/qtk9kAfq612rMs/vnAjTpQjD/2bUjVj9yhyx1oCcMhx
	Crb2FH6/5FkTkIW9UufHi3OAJU0JEdyvaFoq3zFnzAU23JZuYKQkd6WD/mMOaxZcbr9SSXvjA7W
	P8IVsNpyTkQBmh8yaK4fF7+UwqECDT7k5CcV/0HglDiVwg6qqoaUbg6N4/DqT0Rrsot0//UgypA
	aOJRpOerNX5hFHuVB/fBooeuWipRRbyR0LuiHj9p2P+xQ6A==
X-Google-Smtp-Source: AGHT+IFeJ4IOoAxLgq+L5wlOOmHh/QBv7jI6C0T8Xf09WrG0JjgDMOfYa69q1eQ3ZU8BVd7FiZ1O0w==
X-Received: by 2002:a05:6000:4283:b0:3e8:b4cb:c3dc with SMTP id ffacd0b85a97d-4266e7ce955mr14632061f8f.3.1760367225907;
        Mon, 13 Oct 2025 07:53:45 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 13/24] net: allocate per-queue config structs and pass them thru the queue API
Date: Mon, 13 Oct 2025 15:54:15 +0100
Message-ID: <4de6f631d23a5f3019bc39922755d72c4cf50833.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Create an array of config structs to store per-queue config.
Pass these structs in the queue API. Drivers can also retrieve
the config for a single queue calling netdev_queue_config()
directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: patch up mlx callbacks with unused qcfg]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++-
 drivers/net/ethernet/google/gve/gve_main.c    |  9 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  8 ++-
 drivers/net/netdevsim/netdev.c                |  6 +-
 include/net/netdev_queues.h                   | 19 ++++++
 net/core/dev.h                                |  3 +
 net/core/netdev_config.c                      | 58 +++++++++++++++++++
 net/core/netdev_rx_queue.c                    | 11 +++-
 9 files changed, 116 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5c57b2a5c51c..7d7a9d5bc566 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15882,7 +15882,9 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_mem_alloc(struct net_device *dev,
+				struct netdev_queue_config *qcfg,
+				void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
@@ -16048,7 +16050,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	dst->rx_agg_bmap = src->rx_agg_bmap;
 }
 
-static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_start(struct net_device *dev,
+			    struct netdev_queue_config *qcfg,
+			    void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1be1b1ef31ee..a49c28f3667b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2580,8 +2580,9 @@ static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
 		gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
 }
 
-static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
-				  int idx)
+static int gve_rx_queue_mem_alloc(struct net_device *dev,
+				  struct netdev_queue_config *qcfg,
+				  void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_alloc_rings_cfg cfg = {0};
@@ -2602,7 +2603,9 @@ static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
 	return err;
 }
 
-static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, int idx)
+static int gve_rx_queue_start(struct net_device *dev,
+			      struct netdev_queue_config *qcfg,
+			      void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_ring *gve_per_q_mem;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a56825921c23..75757abeb3dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5562,8 +5562,9 @@ struct mlx5_qmgmt_data {
 	struct mlx5e_channel_param cparam;
 };
 
-static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
-				 int queue_index)
+static int mlx5e_queue_mem_alloc(struct net_device *dev,
+				 struct netdev_queue_config *qcfg,
+				 void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
@@ -5624,8 +5625,9 @@ static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
 	return 0;
 }
 
-static int mlx5e_queue_start(struct net_device *dev, void *newq,
-			     int queue_index)
+static int mlx5e_queue_start(struct net_device *dev,
+			     struct netdev_queue_config *qcfg,
+			     void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b1e8ce89870f..8854c496f1dd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2789,7 +2789,9 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
 	fbnic_wrfl(fbd);
 }
 
-static int fbnic_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int fbnic_queue_mem_alloc(struct net_device *dev,
+				 struct netdev_queue_config *qcfg,
+				 void *qmem, int idx)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
 	const struct fbnic_q_triad *real;
@@ -2841,7 +2843,9 @@ static void __fbnic_nv_restart(struct fbnic_net *fbn,
 		netif_wake_subqueue(fbn->netdev, nv->qt[i].sub0.q_idx);
 }
 
-static int fbnic_queue_start(struct net_device *dev, void *qmem, int idx)
+static int fbnic_queue_start(struct net_device *dev,
+			     struct netdev_queue_config *qcfg,
+			     void *qmem, int idx)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_napi_vector *nv;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index ebc3833e95b4..032ef17dcf61 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -750,7 +750,8 @@ struct nsim_queue_mem {
 };
 
 static int
-nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_mem_alloc(struct net_device *dev, struct netdev_queue_config *qcfg,
+		     void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
@@ -799,7 +800,8 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 }
 
 static int
-nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
+		 void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index b7c9895cd4b2..a7b325307029 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -32,6 +32,13 @@ struct netdev_config {
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
+
+	/** @qcfg: per-queue configuration */
+	struct netdev_queue_config *qcfg;
+};
+
+/* Same semantics as fields in struct netdev_config */
+struct netdev_queue_config {
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -136,6 +143,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *
  * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
  *
+ * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
+ *			defaults. Queue config structs are passed to this
+ *			helper before the user-requested settings are applied.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -156,12 +167,17 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  */
 struct netdev_queue_mgmt_ops {
 	size_t	ndo_queue_mem_size;
+	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
 				       int idx);
 	void	(*ndo_queue_mem_free)(struct net_device *dev,
 				      void *per_queue_mem);
 	int	(*ndo_queue_start)(struct net_device *dev,
+				   struct netdev_queue_config *qcfg,
 				   void *per_queue_mem,
 				   int idx);
 	int	(*ndo_queue_stop)(struct net_device *dev,
@@ -173,6 +189,9 @@ struct netdev_queue_mgmt_ops {
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
 
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg);
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
diff --git a/net/core/dev.h b/net/core/dev.h
index 1ec0b836c652..a2d6a181b9b0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -9,6 +9,7 @@
 #include <net/netdev_lock.h>
 
 struct net;
+struct netdev_queue_config;
 struct netlink_ext_ack;
 struct cpumask;
 
@@ -96,6 +97,8 @@ int netdev_alloc_config(struct net_device *dev);
 void __netdev_free_config(struct netdev_config *cfg);
 void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 270b7f10a192..bad2d53522f0 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -8,18 +8,29 @@
 int netdev_alloc_config(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg = cfg;
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
 }
 
 void __netdev_free_config(struct netdev_config *cfg)
 {
+	kfree(cfg->qcfg);
 	kfree(cfg);
 }
 
@@ -32,12 +43,59 @@ void netdev_free_config(struct net_device *dev)
 int netdev_reconfig_start(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	WARN_ON(dev->cfg != dev->cfg_pending);
 	cfg = kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kmemdup_array(dev->cfg->qcfg, maxqs, sizeof(*cfg->qcfg),
+				  GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
+}
+
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending)
+{
+	memset(qcfg, 0, sizeof(*qcfg));
+
+	/* Get defaults from the driver, in case user config not set */
+	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
+		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+}
+
+/**
+ * netdev_queue_config() - get configuration for a given queue
+ * @dev:  net_device instance
+ * @rxq:  index of the queue of interest
+ * @qcfg: queue configuration struct (output)
+ *
+ * Render the configuration for a given queue. This helper should be used
+ * by drivers which support queue configuration to retrieve config for
+ * a particular queue.
+ *
+ * @qcfg is an output parameter and is always fully initialized by this
+ * function. Some values may not be set by the user, drivers may either
+ * deal with the "unset" values in @qcfg, or provide the callback
+ * to populate defaults in queue_management_ops.
+ *
+ * Note that this helper returns pending config, as it is expected that
+ * "old" queues are retained until config is successful so they can
+ * be restored directly without asking for the config.
+ */
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg)
+{
+	__netdev_queue_config(dev, rxq, qcfg, true);
 }
+EXPORT_SYMBOL(netdev_queue_config);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..f6a07fccebd1 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -7,6 +7,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
 
+#include "dev.h"
 #include "page_pool_priv.h"
 
 /* See also page_pool_is_unreadable() */
@@ -22,6 +23,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
 	void *new_mem, *old_mem;
 	int err;
 
@@ -41,7 +43,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	netdev_queue_config(dev, rxq_idx, &qcfg);
+
+	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -54,7 +58,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		if (err)
 			goto err_free_new_queue_mem;
 
-		err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
+		err = qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
 	} else {
@@ -69,6 +73,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	return 0;
 
 err_start_queue:
+	__netdev_queue_config(dev, rxq_idx, &qcfg, false);
 	/* Restarting the queue with old_mem should be successful as we haven't
 	 * changed any of the queue configuration, and there is not much we can
 	 * do to recover from a failure here.
@@ -76,7 +81,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, &qcfg, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
-- 
2.49.0


