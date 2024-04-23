Return-Path: <linux-rdma+bounces-2029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778178AF78F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4A81F23EB0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688F1428F2;
	Tue, 23 Apr 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="la4dsS6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAC1422D5
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901781; cv=none; b=JHP1eU+PZBrxLosGWZm0FucY296EWwnHd4AQvZpeS5g8jOp3+DkwHJZPrMFwutYtLGjgwkfyBSY5CcVBfCOLxKucHLVN6AQEajrB8tUbSqhMwkRL9iSrfUvf1gtT8VKzlkH+i4hWqpjnsdZw8vaXmLv+7jTIS38vSZM+KUApZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901781; c=relaxed/simple;
	bh=74FTgsNpDoGFaJwtMp1SRuD1D9Y0+Vbu/uFyRIKGcj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTVLMIX5c9yJfRpao6s0st9dFqfRMVKuOOGfNekp9I8Pxwlmtovs3kQEAZzX2cWN8R4ZbW1AEzvm8Qeioj44yoIDNx/lQk5drMzvufRfnTuyZy8nWbFvxaNilrb7zPYhnj8FjG0LwMIqCdLiGZHqYASIxmIqsyWiTfGc7xubaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=la4dsS6g; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso4109369b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713901779; x=1714506579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3hn5TsRaFYOkcNTzS8vHf8VfDIP6F4sJqKqR0K4LTA=;
        b=la4dsS6gqn5SLEuThfDMJKmc7s1xtZMSnV8Ry3BKJ4KFvaGAqpd++96pseiKvwB9PO
         Nw5Zx8uEjp8I7ehigEplq+DAhc24MPHcg0XezJySlfiA+ZD6guZAgAoaoIIjKVq1Es5S
         ZzHpQzHxCIXvsrnj4dujLx0OefZme43bHod+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901779; x=1714506579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3hn5TsRaFYOkcNTzS8vHf8VfDIP6F4sJqKqR0K4LTA=;
        b=Z6+ErkwkwoGMJ179TVubYuyILsN10TLQXlaNxDhNoFnx1anG31LL+mmMim6+Fx8IEG
         epbe16Gv6+BD7wbtARQ4dKsDHC12oaz72ovXkzROr8yGfXZvnILVjEGkrBOPo/ywnqiW
         E3cYMSoU2cmNWdAyruIvuiiWEXs+3drw5+uWgQjCYNKng5wEJwOBjyVhpeuREA7h5g1e
         x1FiMvWfbK9wLKhg8qgpZjJiTSXp6i3TNJWm2O6w8TWZWlp7wRpQ/NtbZ/xZkIEo7ipf
         aHA7xlqI3gZTyZHXJ5cDRlbFUkE2LHpBO+hbegj4tgh3V0H1ELd1Q0wAUWu683VZEhBZ
         iv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH4I0YvFWE7Tl+BzsZwyafktaFb9AFyiqFU25PXS1HFr//lNW2r9bWkS+4f0paWl8wAVqGBeUxp/bhqvJO1OnfJY+MRm8TvQsy4Q==
X-Gm-Message-State: AOJu0Yxe/PJFdjfyUT+5sTzCCffWMmOICgNzTSaWVRAhp+T7MgZpLXKS
	Dls5gyH9l/RIbc9bj+EqV+rmIX6BJGzdOJhDsK5+tHyYW6yb/pOajXVKh1Zx6Jg=
X-Google-Smtp-Source: AGHT+IHRM/pFIOlUTo0+zFZNp0G8QYV3sN9KVCAYc9wfXWxCwKDFXcp+V6Y3SzqZ5aixKJt4Z5OtRg==
X-Received: by 2002:a05:6a21:348b:b0:1a7:aecd:9785 with SMTP id yo11-20020a056a21348b00b001a7aecd9785mr386439pzb.25.1713901779138;
        Tue, 23 Apr 2024 12:49:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm9995672pfk.215.2024.04.23.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:49:38 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Tue, 23 Apr 2024 19:49:29 +0000
Message-Id: <20240423194931.97013-3-jdamato@fastly.com>
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

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..d212ed9bfd60 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -126,6 +126,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq_idx = cq_idx % priv->rx_ring_num;
 		rx_cq = priv->rx_cq[cq_idx];
 		cq->vector = rx_cq->vector;
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
 	}
 
 	if (cq->type == RX)
@@ -142,18 +143,23 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	if (err)
 		goto free_eq;
 
+	cq->cq_idx = cq_idx;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
 	case TX_XDP:
 		/* nothing regarding napi, it's shared with rx ring */
@@ -188,7 +194,15 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
+	enum netdev_queue_type qtype;
+
 	if (cq->type != TX_XDP) {
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else if (cq->type == TX)
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..896f985549a4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -379,6 +379,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1


