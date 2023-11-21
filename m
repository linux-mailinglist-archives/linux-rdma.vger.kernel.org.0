Return-Path: <linux-rdma+bounces-13-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F97F2DDF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DD7B21865
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E2487B6;
	Tue, 21 Nov 2023 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NktQzhjm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF27D54
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4094301d505so23010705e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700571800; x=1701176600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N5diH3NzTwu+Z+b9bfOmp1JRsDBa4qDlybGDABjlCw=;
        b=NktQzhjmNFmpRRvpA3BeROE2x3D8GXWqIEa03zji2RcHw0hUDb1CYL7aq1JH3k0T1P
         ZFYMh5nfH7lFCpihWHcd3jCHFFywEQxrkCCCr8yOTcSCsmfv3GNR4rFfV9u7rizfrT3a
         VK9eShHxS/fRhJeyH/pFVWeG5Q6H10Fvq/WME97+kmRETUd15Oy32TmEaSNbiH5ntzxk
         vQn9gkWwpLtfbeWhNgLxfka+WZ2zTMHqn2RtZtt9jMM1RW9I3lxPN6HRcJ9We6qPykN7
         V70HYjMX0Lcqo8xTTicXuumFE5QXBFFDbHZCWy2bACaSbbHLgg/agNdKZfnPickHvEG+
         b59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571800; x=1701176600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N5diH3NzTwu+Z+b9bfOmp1JRsDBa4qDlybGDABjlCw=;
        b=USibW53/gt5mdYRpgdcZcIetq1+rIatOsmQY4/l6sl8sPPfP7yS9nidBGcXN01H6MD
         eVBzJiYPisnBiszJphHtYhAI7xWiMZGmOduwNDpsOoFO6d0JLlLVbxRKlJkZixjzOa5z
         4pO2nN5d8FqK80DrE2P5XWLGnGrjrB2HwH9KW3cfVkRjR+yOjwiNV5SGcAiSFuR8KAEQ
         URZk70xIfkX1Vkp85yYKPZQOBJ9ljjt7/iudomW46Ec31Z8W7gRn46+rV7gjb3qvAQa0
         Rz6Wi+ebixwK1ehjK3OKSx+KVFFeU9U2DFmabTeMvdvdYCa4dw1PnlpPz9ZfOu4Dn+Yq
         dH5A==
X-Gm-Message-State: AOJu0YzzWX64IXLcWysRZrl4YQCSq+1tIp27/bGZL90fsLiKQrclfadu
	OVBbTiqCXv2edY92+dFlAJX4jBgQAnmVwE9Ute0=
X-Google-Smtp-Source: AGHT+IGu2vDTm36Nm0viBuIUY9zVnO3L2VRIjLimrK6U+1vO/sdOoGLFoSjE5VrXPBTKwHh/B5el/A==
X-Received: by 2002:a05:600c:5106:b0:409:7b62:f694 with SMTP id o6-20020a05600c510600b004097b62f694mr8539938wms.11.1700571800030;
        Tue, 21 Nov 2023 05:03:20 -0800 (PST)
Received: from lb02065.fritz.box ([2001:9e8:1427:de00:2523:9f30:fa95:ba54])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b004077219aed5sm21949606wmb.6.2023.11.21.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:03:18 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca
Subject: [PATCHv2 2/2] ipoib: Add tx timeout work to recover queue stop situation
Date: Tue, 21 Nov 2023 14:03:16 +0100
Message-Id: <20231121130316.126364-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121130316.126364-1-jinpu.wang@ionos.com>
References: <20231121130316.126364-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we sometime run into tx timeout from ipoib, queue seems stopped
and can't recover. Diff with mellanox OFED show
mellanox driver has timeout work to recover in such case.

Add tx timeout work/napi work to recover such case.

Also increase the watchdog_timeo to 10 seconds, so more tolerant to
error.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h      |  4 +++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   | 26 +++++++++++++++++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 33 +++++++++++++++++++++--
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 35e9c8a330e2..963e936da5e3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -351,10 +351,12 @@ struct ipoib_dev_priv {
 	struct workqueue_struct *wq;
 	struct delayed_work mcast_task;
 	struct work_struct carrier_on_task;
+	struct work_struct reschedule_napi_work;
 	struct work_struct flush_light;
 	struct work_struct flush_normal;
 	struct work_struct flush_heavy;
 	struct work_struct restart_task;
+	struct work_struct tx_timeout_work;
 	struct delayed_work ah_reap_task;
 	struct delayed_work neigh_reap_task;
 	struct ib_device *ca;
@@ -499,6 +501,7 @@ int ipoib_send(struct net_device *dev, struct sk_buff *skb,
 	       struct ib_ah *address, u32 dqpn);
 void ipoib_reap_ah(struct work_struct *work);
 
+void ipoib_napi_schedule_work(struct work_struct *work);
 struct ipoib_path *__path_find(struct net_device *dev, void *gid);
 void ipoib_mark_paths_invalid(struct net_device *dev);
 void ipoib_flush_paths(struct net_device *dev);
@@ -510,6 +513,7 @@ void ipoib_ib_tx_timer_func(struct timer_list *t);
 void ipoib_ib_dev_flush_light(struct work_struct *work);
 void ipoib_ib_dev_flush_normal(struct work_struct *work);
 void ipoib_ib_dev_flush_heavy(struct work_struct *work);
+void ipoib_ib_tx_timeout_work(struct work_struct *work);
 void ipoib_pkey_event(struct work_struct *work);
 void ipoib_ib_dev_cleanup(struct net_device *dev);
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 7f84d9866cef..5cde275daa94 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -531,11 +531,35 @@ void ipoib_ib_rx_completion(struct ib_cq *cq, void *ctx_ptr)
 	napi_schedule(&priv->recv_napi);
 }
 
+/* The function will force napi_schedule */
+void ipoib_napi_schedule_work(struct work_struct *work)
+{
+	struct ipoib_dev_priv *priv =
+		container_of(work, struct ipoib_dev_priv, reschedule_napi_work);
+	bool ret;
+
+	do {
+		ret = napi_schedule(&priv->send_napi);
+		if (!ret)
+			msleep(3);
+	} while (!ret && netif_queue_stopped(priv->dev) &&
+		 test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags));
+}
+
 void ipoib_ib_tx_completion(struct ib_cq *cq, void *ctx_ptr)
 {
 	struct ipoib_dev_priv *priv = ctx_ptr;
+	bool ret;
 
-	napi_schedule(&priv->send_napi);
+	ret = napi_schedule(&priv->send_napi);
+	/*
+	 * if the queue is closed the driver must be able to schedule napi,
+	 * otherwise we can end with closed queue forever, because no new
+	 * packets to send and napi callback might not get new event after
+	 * its re-arm of the napi.
+	 */
+	if (!ret && netif_queue_stopped(priv->dev))
+		schedule_work(&priv->reschedule_napi_work);
 }
 
 static inline int post_send(struct ipoib_dev_priv *priv,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 967004ccad98..7a5be705d718 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1200,7 +1200,34 @@ static void ipoib_timeout(struct net_device *dev, unsigned int txqueue)
 		   netif_queue_stopped(dev), priv->tx_head, priv->tx_tail,
 		   priv->global_tx_head, priv->global_tx_tail);
 
-	/* XXX reset QP, etc. */
+
+	schedule_work(&priv->tx_timeout_work);
+}
+
+void ipoib_ib_tx_timeout_work(struct work_struct *work)
+{
+	struct ipoib_dev_priv *priv = container_of(work,
+						   struct ipoib_dev_priv,
+						   tx_timeout_work);
+	int err;
+
+	rtnl_lock();
+
+	if (!test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+		goto unlock;
+
+	ipoib_stop(priv->dev);
+	err = ipoib_open(priv->dev);
+	if (err) {
+		ipoib_warn(priv, "ipoib_open failed recovering from a tx_timeout, err(%d).\n",
+				err);
+		goto unlock;
+	}
+
+	netif_tx_wake_all_queues(priv->dev);
+unlock:
+	rtnl_unlock();
+
 }
 
 static int ipoib_hard_header(struct sk_buff *skb,
@@ -2112,7 +2139,7 @@ void ipoib_setup_common(struct net_device *dev)
 
 	ipoib_set_ethtool_ops(dev);
 
-	dev->watchdog_timeo	 = HZ;
+	dev->watchdog_timeo	 = 10 * HZ;
 
 	dev->flags		|= IFF_BROADCAST | IFF_MULTICAST;
 
@@ -2150,10 +2177,12 @@ static void ipoib_build_priv(struct net_device *dev)
 
 	INIT_DELAYED_WORK(&priv->mcast_task,   ipoib_mcast_join_task);
 	INIT_WORK(&priv->carrier_on_task, ipoib_mcast_carrier_on_task);
+	INIT_WORK(&priv->reschedule_napi_work, ipoib_napi_schedule_work);
 	INIT_WORK(&priv->flush_light,   ipoib_ib_dev_flush_light);
 	INIT_WORK(&priv->flush_normal,   ipoib_ib_dev_flush_normal);
 	INIT_WORK(&priv->flush_heavy,   ipoib_ib_dev_flush_heavy);
 	INIT_WORK(&priv->restart_task, ipoib_mcast_restart_task);
+	INIT_WORK(&priv->tx_timeout_work, ipoib_ib_tx_timeout_work);
 	INIT_DELAYED_WORK(&priv->ah_reap_task, ipoib_reap_ah);
 	INIT_DELAYED_WORK(&priv->neigh_reap_task, ipoib_reap_neigh);
 }
-- 
2.34.1


