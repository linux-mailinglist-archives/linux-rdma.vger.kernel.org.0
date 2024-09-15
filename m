Return-Path: <linux-rdma+bounces-4951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C0979676
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2131F21D58
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0B1C3F3B;
	Sun, 15 Sep 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJtX8d58"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511625570;
	Sun, 15 Sep 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400566; cv=none; b=pegEnFMW+996AkUXLz6VmPZhXb3I6GGhyOy9QlWABUWw3jeSFztKBgdoWQHY0gnBBIhaJoljHvaedtNCsIIc1iDz8oWfWgFiI4+kv/F6YFZHXKtJE2AQuCtnXmBZiL5HZ3BF+A01Alg7BlK5TYuZ80k07wEXS2cpJ52857rASXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400566; c=relaxed/simple;
	bh=V7BSTAtZFlkGUrqoLYcf78IeSSWOtXpI74x9W4dHEEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQFTBStHxJMrdjIz3jitqd/rsajdC7TilTZslmxNm5CUken8XeV56KHQBzObo0CMa3ebAvO4Dcj+otxfo2+OVZkwvnVoSCTwlzGz/WfkGBc60N1c2kw18S1dkwawpQBPPAnJSdz8jja4WH6DnYFStI+7h62KuzIG9FJjagvwfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJtX8d58; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so18960425e9.3;
        Sun, 15 Sep 2024 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400563; x=1727005363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lynL6C4hkouH3XP1yfEpNa/RXQ4liCR3A0iI32ucKD8=;
        b=AJtX8d58X2P5P9ruP9Tu32dDnAn/MPLbvRAxqhJk2I8USZQhBgkO4TP2SQbhxZG/zW
         ntWldP2/qV7Bkem2b+WKdQcrCMgsgKzqnIR4t2QRegt2clLIMMeF6f4MzinR5unwwo0D
         j8xiYnA0ae3+dfvFpDzNw8MFauptmvujI+9KdDjAZyXIlSkrYkmy3xzohErkFmJwJfiN
         7N9zn14/kU9Tgni4UkWUm1TwOL9NZomNIATCkr7b29rCDGM1FEZ2ygaPL2g3OlwOOKU8
         8bRogtnOaBUzLf2pp07LwZBzuKoyREvzeyn39ctbq2iqWTKBuRi0AyNFU+9yVjhEBnR/
         5NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400563; x=1727005363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lynL6C4hkouH3XP1yfEpNa/RXQ4liCR3A0iI32ucKD8=;
        b=g+/UFolut7qPg3d7XQNA8g5j8c0EwESoDUndB4VyKAJaHRdw9GSIRyTKNA6QKSNpgm
         8yH+3IMUciDGV+A6ki4WSwr+aGI8ra/A7F5DOM6bcMzSDAx0XEadGofdgVZ9yz0WIKlD
         eIlHTIBctNicef5sgpI30OsNxFwpiSOgtrhjslCnON8R2NHlaL8boSe2fcZiBz0fqMBy
         X5aqf84mcrMcQwgKHy2ahtxwj3WDtHZX9ZNaxXPaRoFcphPGvGBA3aXZY72rXvnQcYON
         4Q9Rxo87R0lzrPzhaNwAIIXXBKI0qwu+o+UEvAw+ksqDycROcXAL0aypxoW9ofHcj9PQ
         zWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUEGLkkhKWTzxrpVpVI8U3dTNS+VK4qR1J4mT92YEIe0P/GcoPHZtGX3CUXlPtPXWrhud0ZgVUcuR60hHuL@vger.kernel.org, AJvYcCVy+AVOcIAutI3Rk2sanOvep4Ob6pMEqyamodpwk8jCiLDrSaWM7CT9UQVdoqm647qIEMLw4B/Efb+pxw==@vger.kernel.org, AJvYcCXFxpAHtAP0rOYFPlw1+9gCPdeqexKiMYrXqYWd1HhqgRVq9OgU9x0TxF1Kpfp7I7grNXWtYaH9UOegN95K/2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCD3vtLi7D70TjSUlmD+UBAsICXcW568EOSS2bckk8JCDWj3g
	xmJ0QSxT3mNKrMsDtYIvL4PmjubK3WOVFxyiAqM4kfO074GBu71n
X-Google-Smtp-Source: AGHT+IFc0ijcmTZXOGVPK+Zk6DrSX+Gw9wOVUakAcGKwQpuRuUvsUpbaTUw4X0AcNIyoG255bHioTQ==
X-Received: by 2002:a05:600c:4447:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-42d9081b3d6mr53676555e9.9.1726400561903;
        Sun, 15 Sep 2024 04:42:41 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm174961325e9.1.2024.09.15.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:42:41 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] net/mlx5: Fix typos
Date: Sun, 15 Sep 2024 14:42:25 +0300
Message-Id: <20240915114225.99680-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 1477db7f5307..4336ac98d85d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -80,7 +80,7 @@ irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_de
  * isn't subset of req_mask, so we will skip it. irq1_mask is subset of req_mask,
  * we don't skip it.
  * If pool is sf_ctrl_pool, then all IRQs have the same mask, so any IRQ will
- * fit. And since mask is subset of itself, we will pass the first if bellow.
+ * fit. And since mask is subset of itself, we will pass the first if below.
  */
 static struct mlx5_irq *
 irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req_mask)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index c6e951b8ebdb..a6bf3f975d52 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1647,7 +1647,7 @@ void mlx5_unload_one(struct mlx5_core_dev *dev, bool suspend)
 	devl_unlock(devlink);
 }
 
-/* In case of light probe, we don't need a full query of hca_caps, but only the bellow caps.
+/* In case of light probe, we don't need a full query of hca_caps, but only the below caps.
  * A full query of hca_caps will be done when the device will reload.
  */
 static int mlx5_query_hca_caps_light(struct mlx5_core_dev *dev)
-- 
2.39.5


