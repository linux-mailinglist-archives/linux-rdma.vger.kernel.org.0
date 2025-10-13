Return-Path: <linux-rdma+bounces-13831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A255DBD42C8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18143E2898
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4530C37D;
	Mon, 13 Oct 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwgEaukU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDC30C379
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367233; cv=none; b=CsBG2uJrrJqdAyzC0on4XcxGErwNolKAh+0VZ78aL+SusD5A3djcnKX+OTa61GO1aEBwI+SMWgfwNnzO/NYaKAfd6D+hOOfDs1WJmwgPTO/hJOCB4zoto9YqAXR/F2afv/2nzSBthvk7omU0itmiDTqmexv2L/JQHrN9t1vTXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367233; c=relaxed/simple;
	bh=D68sIcGcW8AD97DUUABnw+4SAHYdP99w8kG7MJxPpuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1k3Sbh+L0gOuM8FxUIeJ8ZKC3/ZsgUbibwgX+8rgx1N5kspQY4xcnGEqzwRQKeay346Qg8eRmDyKxXoK/CYll3n+tq6QuH/U31hyS6LpkH8IOzG05KT6hzWIfOgZhBHdCf9XxGY7w4HkN+YNJKlhnluHCQ9Ny4mNhEOQrjEvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwgEaukU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bca51so2852243f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367228; x=1760972028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=fwgEaukUjhYVnmQ8AVW6BNlVQE0cMo3BWtp7IVfC1O9B0iLe1lhk8FxlPVq1fTRKyb
         pBz4705SNJ6SLjEATAjDzJVeK4rsXJcyRUwRkyQ9F0h2mV/D8f+uBF/vNIMLlOu9LK3A
         alb0iAvwxGsR43s6gCBb6VGXijw46omDMwcUd7DzijeTnXsWuAnI2Rc6KsPEmxvhjgV4
         xK40mJjVCKZEXies9kmVueGSl0BcuIArtqE429PstvO2mFo7/HdoYdNJEZFi4aDJC3wC
         0yXeBoiQxfhgRE8I3sroNOFrYTfjIa6k/VY/L8xbiCb6hEUgapWQc7FQDuj3CJP2XO+e
         3Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367228; x=1760972028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApFnEwRpSxW12wS5COVxMxaB14LXZ+AG99lB5fOtbBM=;
        b=Yuy9i6KPcHh9A5XzGsyaTm2IQAtMPpBoD1Vatm/ufwgAFIwBx4rtEqcLI6dWy1sQIt
         7SLeIc58F4tERtoC0rk3D6vekNcCShvRA9PYes4j7ejpBGfSThFYW3WIUbVYZCFIAhG9
         QfUFMX6z0XT1kFQ+h5WnGccVsn7h27Iht4rbtOGhrB+YeNzgqGI9eM1rwD6MsVrkPiOV
         Y/hpQ1VLVSF/uCPovSv8Az3QNTA606YDF8L/V3BvGILjdWC4PgagKaJi32z4PmKZSWOp
         TXHEe0WpqdTNPelILv/8k8qN758lHrDv5N5KA2yZo6qqur5wHt+9MN6j8DjQLJNnH+5E
         xB8g==
X-Forwarded-Encrypted: i=1; AJvYcCWcHVHE34qefIl2buy2L5Nmln4HcqRDbiYeKitLKq+dDFvcs/+LAVoEguUJc+bf7DVNhRvfdOAekeOz@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg9DjKszyQWRryR2Za+mlgWPnwlkSXzmw2hwdEBXVzeEaaKl/
	EtFhwrttaLXXafgLHeIz++tPPVO8Wx9TsTuAneFphRTTAQlExCelR8BG
X-Gm-Gg: ASbGncsfbtjkC9glJVtkBsqBvZpD2L9AtBnLjO7QBywmvzYWjAGu7olHFEbfyYUlHI2
	m7n4SGmzDsRtwXBXqTugnOLBXH6lpQrD2Iv7t8wVKEzf68GiCcc0Vh5Kkk400GwIWtrTZBRmyYd
	AKwjiUOTDPRPT2YRIIo/gD54gqKaYrdruO/35kCuXvaeO2u0wE4JoX3RXO2TUQp6xiHsszYG5/4
	/eltK2qaOivPwxUwTg/wBWP8zeGGy0uUp7SCgZBirPz8pP81pHoz1hNyQKG6SQTlhYnjG1EzX0h
	FDJ7eNHOOBTGbJQByLSK4Z7TwTRG2tGq1Gu4sDACYlZGmt1Tt2dzPUFYNxleAxxMkZSKNU9Pi3M
	RpChfDt6GUSdqc/l5YFF/+L+H
X-Google-Smtp-Source: AGHT+IGhdCNMbexhcA+WKt1V3KL/FuPKgFmigZrXjQ1ZszoP38SE47hCNbYpQqpsjRmxatSSV4+luQ==
X-Received: by 2002:a05:6000:4b1a:b0:426:d818:e46a with SMTP id ffacd0b85a97d-426d818e49fmr5836115f8f.60.1760367228006;
        Mon, 13 Oct 2025 07:53:48 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:47 -0700 (PDT)
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
Subject: [PATCH net-next v4 14/24] net: pass extack to netdev_rx_queue_restart()
Date: Mon, 13 Oct 2025 15:54:16 +0100
Message-ID: <c7bc7d4cb8e3dd6b13f044495ed9efef8aab294b.1760364551.git.asml.silence@gmail.com>
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

Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/netdevsim/netdev.c            | 2 +-
 include/net/netdev_rx_queue.h             | 3 ++-
 net/core/netdev_rx_queue.c                | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d7a9d5bc566..61e5c866d946 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11570,7 +11570,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr, NULL);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 032ef17dcf61..649822af352e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -886,7 +886,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	}
 
 	ns->rq_reset_mode = mode;
-	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ret = netdev_rx_queue_restart(ns->netdev, queue, NULL);
 	ns->rq_reset_mode = 0;
 	if (ret)
 		goto exit_unlock;
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..a7def1f94823 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -56,6 +56,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index f6a07fccebd1..16db850aafd7 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -19,7 +19,8 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
+			    struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
@@ -143,7 +144,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 #endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx, extack);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -186,7 +187,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, ifq_idx, NULL);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.49.0


