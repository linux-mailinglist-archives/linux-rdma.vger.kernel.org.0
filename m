Return-Path: <linux-rdma+bounces-2461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859078C4605
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A7A1C20DE7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314722E647;
	Mon, 13 May 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eLNUbDU3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B723768
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621361; cv=none; b=dBhQ8xxIjddW0xRU1Wg4miG2Lud0NpK7NbXoIL7//y+vvD3j3mp5mfgPNXTA8p/CyNkYzBNHHK5cibAraY7thY9KC1c/r/JRmAEWEPRWAc8ae3oZXzNcq0o/m6c7Aw8Zq0rDI+Q6VORY7UEswFlZFWLxfmxZpZcoSG1QkW6uR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621361; c=relaxed/simple;
	bh=gCbabcQaR8Ix1K97TkMliO2FSC7RBAC3W9/BPXaCzC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMNiRaN/RYMle3xYSG1qlTO7u9iFT41MzzX55YDX9sQHHagIz7A6DVIcLRZ/kC1rsgDcsmZKi3me97UxF3u+aaHghPBqSk6i4wGOWui3LWGqBZQEKdy1gs7cdksT8snIgYlosLyYcbB/htp3dyJvY42K0Usxr11FObNMNqTqDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eLNUbDU3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee0132a6f3so33149355ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621359; x=1716226159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=eLNUbDU3Yot1/LExXUhEBigzYXXARnPWhj0JeNXOZVU9YSKkPwZuBKjukVp5IZ2ZFv
         ORwVo6dEWws21LAOv6ntTJ1Ap16deVyK99tSzEOMalIHX5bjzBfq1Jom4bhT2E+hf0K9
         nCbRe9Ca5d+wAxfZTLSlG96+kDXzxhgTvnIbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621359; x=1716226159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=H/90MnFZsRoIlk0vgkR/Vet8c0/mI6XkCSe/KMHrPyVIuySkfzzG/sgxWx3XDUwVLW
         KssYo8c2ucXHS1OWeXnbdu6FiBsHWZCJpCzH7yN1jJqLe1skM2iSV/CTXayHlDA5XIIW
         vM98JDNV3zOREfKzD+9hmB70ywiwrNEJIa+FZBJett5d9xd2zgx/MgEj4QYQAjnXRMei
         aSYMU/yFucFnlP/nAENCC+pWyWc/Yz950VOxLPVRc6971Trw8yZ9dawxTH6F9cbgE4Jq
         9YGbP+1Q6u1XjH2dyfjVVXgbM8uOhDqomzZQrMTVpG6oL60nkw38cn2/CgwrvV0qyB4R
         SYfw==
X-Forwarded-Encrypted: i=1; AJvYcCUmHA1s0FSgK68rjLUqjhZcscNO8tsHcsyyZLcVmoao8m4ykoVbatHuV16njQYZTsTpGOwyNlTX7w/Z+mPAUOTztAxjRxizJtAYLg==
X-Gm-Message-State: AOJu0Ywg5l+3gPtwuhYtsTmBIwgPGTe1frvmIjiIEJ7II9MMdU/FU0Mv
	IlJnsDLIxLCrqiy/T3hOycpiRwgtOL1maN1VKXhpYfqe5C1Qb5Xc9MDoTRv9wC0=
X-Google-Smtp-Source: AGHT+IE2rxb2pPIKH8S7FxU35hdeFvoMaGhTcH1N3h9juaMagb8UpgyIIgNSFKB0+A0A1wmImOTmlw==
X-Received: by 2002:a17:902:cf0b:b0:1e4:6253:75db with SMTP id d9443c01a7336-1ef43d1707emr120273805ad.17.1715621358954;
        Mon, 13 May 2024 10:29:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1663sm81948995ad.6.2024.05.13.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:29:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v5 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Mon, 13 May 2024 17:29:07 +0000
Message-Id: <20240513172909.473066-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513172909.473066-1-jdamato@fastly.com>
References: <20240513172909.473066-1-jdamato@fastly.com>
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..461cc2c79c71 100644
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
@@ -189,6 +195,14 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
 	if (cq->type != TX_XDP) {
+		enum netdev_queue_type qtype;
+
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index cd70df22724b..28b70dcc652e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -380,6 +380,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1


