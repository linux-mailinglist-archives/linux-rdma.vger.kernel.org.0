Return-Path: <linux-rdma+bounces-13832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6CABD3E7C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638B71882229
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F553128B2;
	Mon, 13 Oct 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8zixbqV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6133126D8
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367234; cv=none; b=XB9GGtr/lOuKXzodlFJckHmbTn6C3MlgodxnFmUTPvX66wZTxYIlCtrEQywm8sky1BFsodU/lU/GarsWz20QPvdR8nQ/o7yFyfdytLMIGbXjeM+IkONK4bcIq9jgb7SmwLhtJqyMSJ9K6U2A5tLK/dWYhcDAepqUFzzWGJUwTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367234; c=relaxed/simple;
	bh=GjwSFSwqU8rkn5De5P7jUBJg+PMBSZmYg+Q+t755HF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phWir7gp0px35VsaFWUsxbuBYq865/tbjeqm8U3HsL65LBcyIoREy2cPrf9jt6QY/BMXhoLhL2rS0mHjGuts69gHWSROr7C4BeMgOJid9Am3qsZAUAUkWKeQis/dhqNr37uAxq+5eyqh50uT4JIhp6Om2HyXA1+RAf+ik0cXVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8zixbqV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3713703f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367230; x=1760972030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmgyMrfNSf1QbkW2cWjL4/Xd2W/yNMiKsE6jAo6f6fY=;
        b=b8zixbqV5pRk9k5FD4jROeZ+DDkFbbMYer7qFxsyRrZl29LYC2d2knJnJt9oNxGVKQ
         j5k51/sLopVHp45KcchsKvbT0eOfOW9uEoRPgNo2wVFQUFVlUCW3HgJ1ytNipQp1QfdX
         kxj0htVsOwTfSvMcxXNVXlny6k1t+xpE+v5vXpUKU+pVXtzDCDGLP2arAi5yeT93Y8Dj
         NRcd7LSkwbUxC0XD9E5kXkmNCw2CXQ4qtvmUqdIGiHQxt24fRQ06YTSIKhTReaecuvTM
         o1PRGXCNJ53XMb4Cwh1KtA3NavFLYlzxm4OOZre9AEC9J24nf9lUzjCUAXlF+9TKc09F
         dgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367230; x=1760972030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmgyMrfNSf1QbkW2cWjL4/Xd2W/yNMiKsE6jAo6f6fY=;
        b=oPh48AsMkGakIHiQrKXu68c7fQVKsOTSohhAshtWV+rUqVpbedcbNWpPQavIiYkLEw
         pFYmEg6cbOUTY+1HsKAiQpfxf7GwZlaCdFrZQjoE0BCuoCRCokA2GvYIHfMeYgikw+U3
         K0AHgbnZQ/KVmyAIsp6Pko4Tr++zguBUx0U3Jkt7O36C6fMxHp4+ffLWAgOhrm34p2+Z
         xhTmgYZJBPclumS2th7dhHEinF1RwTcI0l1214nddVztfepe47VOOyqAVsWJRnYilmDM
         YgTJRu3cw7YuQupqU4/bpZGxgsCxE3mmC8g+JS9Z0m5indL0mt2wDncDXnm29HkKfYnT
         0Sfg==
X-Forwarded-Encrypted: i=1; AJvYcCUNsjls/FKcMpGAswCkZfb7b50r/XnUj5UQsLO0sY7/btuiNvXlDXcrKGGaAEzyEsSMl51btgupbCGD@vger.kernel.org
X-Gm-Message-State: AOJu0YxwX6gbxIVi9hNG7TVaRZVQ28IBx90+WhMwK2H9SzWeM10RcM2m
	gTFF9UgzNIZTg3npGmcWdXYwOCMeN4dX8zB+SiSALCb61MzbxgduZjou
X-Gm-Gg: ASbGncvgJXyAvOInxPfNIo92+PA7xsfaA9lb02aZIFKGWm254aWi2miFqDSTcL/Nev8
	2v7AVFTb/E/8gG8tvXkMnAX6XY7GEnOrVy5cN9XEEh4hklQepxLvScLM1uLRudChJ0D3bRyWIah
	hTA3ydT6UcDwR3U9Par6Li3WjyNbDqpgGYCUGyEux16FzZ4lEykXac5TilvxDD2lmoEY1Qj6GWa
	vlRkAa1DxnHxtgU5QM/oIBJVqjSN23zAds+eJhX+DtPIgPlWEdIj4ejdciaUO+g6HofyBYUYOpo
	q1GU3BGuS7RMmO6fLqjdfXAFas7H45DCwcFB4OCf09KBGEkLDyqAfyR+I52sxdPVHI8JazIWbQc
	qj0uXPFnSrDvZ1GaUqJRM4r3WXbeCOsG/9lE=
X-Google-Smtp-Source: AGHT+IF4BqUEqPY/lEHVdfhtdHZQUBn4lD2yFKhAE2G5bjuGJP3/uoHRJB95i7fwZ4AdUzgso19ltg==
X-Received: by 2002:a05:6000:260a:b0:426:d53d:a405 with SMTP id ffacd0b85a97d-426d53da458mr5999140f8f.20.1760367229805;
        Mon, 13 Oct 2025 07:53:49 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:49 -0700 (PDT)
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
Subject: [PATCH net-next v4 15/24] net: add queue config validation callback
Date: Mon, 13 Oct 2025 15:54:17 +0100
Message-ID: <4daa213af8779cbb8dfebb7ff559814f80611cfc.1760364551.git.asml.silence@gmail.com>
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

I imagine (tm) that as the number of per-queue configuration
options grows some of them may conflict for certain drivers.
While the drivers can obviously do all the validation locally
doing so is fairly inconvenient as the config is fed to drivers
piecemeal via different ops (for different params and NIC-wide
vs per-queue).

Add a centralized callback for validating the queue config
in queue ops. The callback gets invoked before each queue restart
and when ring params are modified.

For NIC-wide changes the callback gets invoked for each active
(or active to-be) queue, and additionally with a negative queue
index for NIC-wide defaults. The NIC-wide check is needed in
case all queues have an override active when NIC-wide setting
is changed to an unsupported one. Alternatively we could check
the settings when new queues are enabled (in the channel API),
but accepting invalid config is a bad idea. Users may expect
that resetting a queue override will always work.

The "trick" of passing a negative index is a bit ugly, we may
want to revisit if it causes confusion and bugs. Existing drivers
don't care about the index so it "just works".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 12 ++++++++++++
 net/core/dev.h              |  2 ++
 net/core/netdev_config.c    | 20 ++++++++++++++++++++
 net/core/netdev_rx_queue.c  |  6 ++++++
 net/ethtool/rings.c         |  5 +++++
 5 files changed, 45 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index a7b325307029..532f60ee1a66 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -147,6 +147,14 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *			defaults. Queue config structs are passed to this
  *			helper before the user-requested settings are applied.
  *
+ * @ndo_queue_cfg_validate: (Optional) Check if queue config is supported.
+ *			Called when configuration affecting a queue may be
+ *			changing, either due to NIC-wide config, or config
+ *			scoped to the queue at a specified index.
+ *			When NIC-wide config is changed the callback will
+ *			be invoked for all queues, and in addition to that
+ *			with a negative queue index for the base settings.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -170,6 +178,10 @@ struct netdev_queue_mgmt_ops {
 	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
 					  int idx,
 					  struct netdev_queue_config *qcfg);
+	int	(*ndo_queue_cfg_validate)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg,
+					  struct netlink_ext_ack *extack);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
 				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
diff --git a/net/core/dev.h b/net/core/dev.h
index a2d6a181b9b0..a203b63198e7 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -99,6 +99,8 @@ void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index bad2d53522f0..fc700b77e4eb 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int rxq,
 	__netdev_queue_config(dev, rxq, qcfg, true);
 }
 EXPORT_SYMBOL(netdev_queue_config);
+
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
+	int i, err;
+
+	if (!qops || !qops->ndo_queue_cfg_validate)
+		return 0;
+
+	for (i = -1; i < (int)dev->real_num_rx_queues; i++) {
+		netdev_queue_config(dev, i, &qcfg);
+		err = qops->ndo_queue_cfg_validate(dev, i, &qcfg, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 16db850aafd7..5ae375a072a1 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -46,6 +46,12 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg);
 
+	if (qops->ndo_queue_cfg_validate) {
+		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, &qcfg, extack);
+		if (err)
+			goto err_free_old_mem;
+	}
+
 	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 6a74e7e4064e..7884d10c090f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -4,6 +4,7 @@
 
 #include "netlink.h"
 #include "common.h"
+#include "../core/dev.h"
 
 struct rings_req_info {
 	struct ethnl_req_info		base;
@@ -307,6 +308,10 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
+	ret = netdev_queue_config_revalidate(dev, info->extack);
+	if (ret)
+		return ret;
+
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	return ret < 0 ? ret : 1;
-- 
2.49.0


