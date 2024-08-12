Return-Path: <linux-rdma+bounces-4341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BE94F0FC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D48B24487
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F1153BF6;
	Mon, 12 Aug 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sINuLwcJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84020187860
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474639; cv=none; b=mD45j6Yy6VtaKt8Coge35eMp/Aeqca/Qlug8+CJ80huG/cTFW9/k54UD85Mcs9afqu6RPCIiahWwNRiscyZAJOSvlVcSOCfoMceQrYFHKM2Vom6eohf5juGHce69w8JH+6TLDTMt+KietXDNKLvBxPTWfEDrST0fmvk92p/JLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474639; c=relaxed/simple;
	bh=PeMx/Nmrr+6PvU9tabl/ApT3ymGjWp++nP1TeXixLcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAf5hHm0V32zg0qE9nZKiNvVX5/BrbR9QTv4ICMczjADKDOZJkH/y3nR3a3ZrX9hjSa4qUE8XMUu2Rwqxhqu51BrTX8qwyohfx19Ox2RKuHNeETN1zmrq4FIVcq8I/wqi74Ri+4ze+aeNCcp3kYwx8St7DnxXX+oW3iqK6NhnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sINuLwcJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd70ba6a15so32199125ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474637; x=1724079437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItAoJGLSfkfsRS38y1iOZ6bIC8SZzEF77FLkXtuBPRA=;
        b=sINuLwcJeSQGnGBwzWl718E6dw9yDkDHrpFVideUBn1utxXetRMMhsP+K0iuRR7Zp9
         AKMH2C4BUqnEjpa/9JGheD74KZ/4PYXF9jxu3ENpTXKM+Pafgvf+jveAiKWY/CVcU0/o
         AaKaH7DVxEDztASzbI/zBNmLxJzs2LUuvH1BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474637; x=1724079437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItAoJGLSfkfsRS38y1iOZ6bIC8SZzEF77FLkXtuBPRA=;
        b=aI76WNpZQ9hWMP9zdjTuUQnC9LS5A5zAvoNnxrmqACcn8xhqrPC42m8kKeBKn0emdz
         ErN1Mt93F4hSTKFNJcsTb7Aav/EfZCSPEoQvWKCJrxgu6FAxJbkncYbXZSFliGCyG0B0
         6QsvbX4IfvWHQHAwGDUPnHi6qZkZCC8ccqN6wiyhjYvdhQCjSkpM6//SmAkQdSiDCQpa
         OOVWhVwGbD1IZd+55KmMlMxnPPPLf6jGLVIzH5IU3JFw5ESaREWuiOlPcSHynMbA5l2a
         QnR5EcmvSfEa/fif9l+tF9GkkS28FQWhTmHc7uq8QHJ0MJbzlVX6i5vUolOSv0kgo8NF
         3CXg==
X-Forwarded-Encrypted: i=1; AJvYcCWe5IitWm8nb0vMq1g45UpsQhqJgEVQt8rhj0zZuqn4R/M9xMiHhTap+W2MGRxFiqAbE2rUCo0BDwRTgV/n1Guk1jAKgUqCfHdwhQ==
X-Gm-Message-State: AOJu0Yz6xJyaP2x+vDtW6toL8BV9bZetIyQkoChKe5HDWS/TmsrpSXti
	hhFMDPJFvSu+4G6qH8shpCY6eGOeCR5w8YVQovKxlpcq7IQIgPrA610wxhbEwqY=
X-Google-Smtp-Source: AGHT+IF6+BtyPaJDNmgeJnbxo3+hA+k0daqI0HbQdgRptG4H/1cOc+4ZuJzFbF2axrgf7+g7HivGWg==
X-Received: by 2002:a17:903:1447:b0:1f9:f906:9088 with SMTP id d9443c01a7336-201ca13c3f4mr7492035ad.22.1723474636902;
        Mon, 12 Aug 2024 07:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:16 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 6/6] mlx4: Use napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:27 +0000
Message-Id: <20240812145633.52911-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_affinity_no_change instead of mlx4's internal implementation,
simplifying and centralizing the logic.

To support this, some type changes were made, which might have been bugs:
  - mlx4_eq_get_irq should return unsigned int (since the field it
    returns is u16)
  - fix the type of irq (from int to unsigned int) in mlx4_en_activate_cq

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 6 ++++--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 6 +-----
 drivers/net/ethernet/mellanox/mlx4/eq.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
 include/linux/mlx4/device.h                  | 2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 461cc2c79c71..9c3e1c810412 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -90,9 +90,10 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 			int cq_idx)
 {
 	struct mlx4_en_dev *mdev = priv->mdev;
-	int irq, err = 0;
-	int timestamp_en = 0;
 	bool assigned_eq = false;
+	int timestamp_en = 0;
+	unsigned int irq;
+	int err = 0;
 
 	cq->dev = mdev->pndev[priv->port];
 	cq->mcq.set_ci_db  = cq->wqres.db.db;
@@ -144,6 +145,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		goto free_eq;
 
 	cq->cq_idx = cq_idx;
+	cq->irq = irq;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 15c57e9517e9..4c296327b75b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -1022,14 +1022,10 @@ int mlx4_en_poll_rx_cq(struct napi_struct *napi, int budget)
 
 	/* If we used up all the quota - we're probably not done yet... */
 	if (done == budget || !clean_complete) {
-		int cpu_curr;
-
 		/* in case we got here because of !clean_complete */
 		done = budget;
 
-		cpu_curr = smp_processor_id();
-
-		if (likely(cpumask_test_cpu(cpu_curr, cq->aff_mask)))
+		if (likely(napi_affinity_no_change(cq->irq)))
 			return budget;
 
 		/* Current cpu is not according to smp_irq_affinity -
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 9572a45f6143..feca4ea30750 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -1539,7 +1539,7 @@ int mlx4_assign_eq(struct mlx4_dev *dev, u8 port, int *vector)
 }
 EXPORT_SYMBOL(mlx4_assign_eq);
 
-int mlx4_eq_get_irq(struct mlx4_dev *dev, int cq_vec)
+unsigned int mlx4_eq_get_irq(struct mlx4_dev *dev, int cq_vec)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 28b70dcc652e..1f9830b23c9c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -381,6 +381,7 @@ struct mlx4_en_cq {
 
 	const struct cpumask *aff_mask;
 	int cq_idx;
+	unsigned int irq;
 };
 
 struct mlx4_en_port_profile {
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c89..1f2e9e954768 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1433,7 +1433,7 @@ int mlx4_assign_eq(struct mlx4_dev *dev, u8 port, int *vector);
 void mlx4_release_eq(struct mlx4_dev *dev, int vec);
 
 int mlx4_is_eq_shared(struct mlx4_dev *dev, int vector);
-int mlx4_eq_get_irq(struct mlx4_dev *dev, int vec);
+unsigned int mlx4_eq_get_irq(struct mlx4_dev *dev, int vec);
 
 int mlx4_get_phys_port_id(struct mlx4_dev *dev);
 int mlx4_wol_read(struct mlx4_dev *dev, u64 *config, int port);
-- 
2.25.1


