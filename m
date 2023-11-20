Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2137F1E0B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjKTUfL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKTUfK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 15:35:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F64C7
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso17480265e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700512504; x=1701117304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikrB5p+uIVXseszn3Sj0eFXmNvbq512IL9fPz+/7K5o=;
        b=KBPn1mmo3vAYK0PLnRNutLKrAZ1Oy+KABM2Ay0C1Y9ifT+Wvi3yRVbKTVjzOqyWObf
         A2PIlYfa2P6pAqNg1qw/ia9l5ml8shhRZWIX6yWvgyvFSvW8mmaBAwes87ZHPFH9VfIZ
         nmI5IAWjmhSzJcLhCogIUMqRTkx9iQ4Sx2wXSKqYaxuWH5dEbI0Z5JaWtvvnFsX6g6aH
         15xq2MyrD01RJ4CJSFBh4jAQIYmCFkkkrS05OOAspP48PHGxJrc9WZLtYO3rJyxpt5+d
         1dtTkQeck6y9GvUxvR8G08UKqAtSR396F+ZRoG46yb1FhiqWGu6ZB81L3Eqn//0ELVxW
         n57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512504; x=1701117304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikrB5p+uIVXseszn3Sj0eFXmNvbq512IL9fPz+/7K5o=;
        b=SAoqzfWhdWoRF+Ao0mIopCunpjYEOrMywXP459AHQBA57cz0d1/5hCgEdr/ccD6vgL
         yAf9WUtz+2aK2LzM7QXpEnojcEwbWsblJBlIE0Wzi6vOoRDZ95e6B4M8BeWCsqf3jOND
         7JrdkNoDjlwFI0+6F1x42XlKaRTZrzmIGFYGhxM1E3A7F+FTAJk4VUC6g1bpaF5Pj2Cj
         jNsvOor5BI9FVvSZDxgrxlz/Xfysn1dE6vzvGZ8Mni8u38x7Ei+BPHFMsXQywuKVZprw
         uJPLd5gFzcolSJCrkv/9DfzzG26L+KLAeZwt2imfNoapmUWZuUuHzyfJzSR1avwHPia6
         VouA==
X-Gm-Message-State: AOJu0Yyb3K6jS4Xi6PaFPiQTYUu8uc4HGUYnVDnf0H7TvtiLBXyFkXun
        kN96H6kMwTJxgltFJfNsvNmArt0/DoEdsmxo7+4=
X-Google-Smtp-Source: AGHT+IFRf6cuKyFpGm4ezT5uV0P2tiG+oyhd3jy39lhrV6m4WnePU2obbPA2OaBKdjizwULh5YPQUg==
X-Received: by 2002:a05:600c:3c8f:b0:40a:3e13:22aa with SMTP id bg15-20020a05600c3c8f00b0040a3e1322aamr7296853wmb.7.1700512504431;
        Mon, 20 Nov 2023 12:35:04 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:140b:5d00:621d:e8e7:5d04:1c60])
        by smtp.gmail.com with ESMTPSA id x11-20020adfffcb000000b003316b8607cesm11258241wrs.1.2023.11.20.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:35:03 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca
Subject: [PATCH 2/2] ipoib: Add tx timeout work to recover queue stop situation
Date:   Mon, 20 Nov 2023 21:35:01 +0100
Message-Id: <20231120203501.321587-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120203501.321587-1-jinpu.wang@ionos.com>
References: <20231120203501.321587-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
index 7f84d9866cef..29ba2e443738 100644
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
+		ret = napi_reschedule(&priv->send_napi);
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
+	ret = napi_reschedule(&priv->send_napi);
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

