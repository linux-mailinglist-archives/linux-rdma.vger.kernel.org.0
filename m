Return-Path: <linux-rdma+bounces-5185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88398E3F2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C7A1F2830C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A162216A26;
	Wed,  2 Oct 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScOrOzi9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47423216A1D;
	Wed,  2 Oct 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899734; cv=none; b=qQCrlPnLAxqsLp4LXR4rqGaz+H7e9J2EeLAOXDDtkbKiLD0MkgMBg6kLm2tp+ukRVFCNZwUlIx0MFTp7G/ssVdswbaV8kd5kQxi+CdyPxb+dy1HMfQF3jXaU/rX+x7Bht6JqOp6YmqaVjvV4kkK+MgRZq5KMgDHqanXfU6UdiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899734; c=relaxed/simple;
	bh=vz46hAmWpG5YlUYcSCarIwa9teQKaxayVj5G8KNqlRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKHZfT9vplG3IYlkWGZnefjbzXaAEIPbUahSfBSkMW3Tk2xB2aRqZ0uNFWPXvZsWxKXvFH7Q2X2/MOwUjwpc0SzshKe2BCJnJElFzQJhl5GRB6Ka7tJi0iOH+Dtsdb1kuKgZlb9FEQ60+jh2iD5JN651XdYEWKp8O3pF8Kv+jNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScOrOzi9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so1106805e9.1;
        Wed, 02 Oct 2024 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727899731; x=1728504531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxnZLWasoXEFToT3v/SC94iiLBjMSWRh3PeDY/tsPKQ=;
        b=ScOrOzi9Mm71ArVJ5/754JFL2TDPN2eyY9tMoqyybRfDEHqhx1n/D41p7Zu2FDG4kZ
         T2Q9s6PXQlcgTWHXbJDMvJy5VwJABo+fXLhyWYDFJ1nB8iShWqggIaTQl6jGVP/f+pJr
         GzB49D378Jh8elkZC0W7ymQkh7ienJm6/0d09uZVOxwSFmgTyLaAKTkBffRyPZgWLOkw
         sLiJPpZM0rhW2ecrtt4TK9IvvZiuhsdjIVT/0Q4dwo2Ukrm7J5aKbXRpCylKodTGbQKf
         Ck2C2bBsFIssE4wCt9hV66FxyZZYbZNp3S66Vyk2GN2whuQI1rK3+etdQV5qOB7hUi+k
         +9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899731; x=1728504531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxnZLWasoXEFToT3v/SC94iiLBjMSWRh3PeDY/tsPKQ=;
        b=GbdePVZcVyJbu5NTGXj6uGB36RjJROCn+jKyUtkviwkdw5hXtwdDQjGBDgCHb49/KV
         qEzvFg/XxI3qcWDJTslH4cvKHEKv6cJLSjD30tN4cq5xuqLFuBfl97TMuyU6oYGgrNIk
         chRF9YCm0/N+fmzb9+3N0vnCdA6ku6nMGYUs9QmwqviQpZAa0f+QRtXkrNMH2xRrG2+z
         YmdNB8S1APtEDvBvyfOoJbb43btYtEofvFPs9DdqlPa9k9SrZwPOlTj286P+aIqq6Du5
         rsXw5H4M6mCXo07/sI0foqLCBrbcQMGXdcYBeDz20Uq7wWX9nTyRHQocN7VbcdznJKuI
         6uoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIvuNsX1/coxv4vA1rv9GikQpJlWc668DqpfwpHHnHpJNhODum7qhbqeyRzPjmK12aQZj0N6gdNmj89A==@vger.kernel.org, AJvYcCV31FC0ElLlJmQjX4d2BtvdybyX/hPVMpN6G8QEDHVaeO018Ft5f1Ge1yzUgNljBVGCTj4uJwpxL9mFPbNC@vger.kernel.org, AJvYcCVHu6jOq7gIFbynP3p5KZeQyt/V8foidrViemI5phXsNEMUSBpjtpPXOmGZ8hbR3YRlH2KIhz8CycHnnSY+SN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEVdDzSDtsIseiSpLtTddRJdUlBikb9421K3ls47/gcvRML0x
	lZ8tPOOY29DYrKI3kS/wSrwy7DnB64j1EnJHXB3xvk7L8Yi5NKOI
X-Google-Smtp-Source: AGHT+IFgZsIkiwvcQcdxhWGuOwo3EX/o3oFREL30NYWJAmnmWI4NukS+lsvENJabe0gnVRXhfdDW1A==
X-Received: by 2002:a05:600c:4686:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-42f777b0c38mr30491615e9.5.1727899731212;
        Wed, 02 Oct 2024 13:08:51 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02f174sm27934655e9.44.2024.10.02.13.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:08:50 -0700 (PDT)
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
Subject: [PATCH net-next v2] net/mlx5: Fix typos
Date: Wed,  2 Oct 2024 23:08:38 +0300
Message-Id: <20241002200838.7316-1-algonell@gmail.com>
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
v2:
  - A repost, there is no range-diff.
v1: https://lore.kernel.org/netdev/20240915114225.99680-1-algonell@gmail.com/

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
index 220a9ac75c8b..82911ea10ff8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1664,7 +1664,7 @@ void mlx5_unload_one(struct mlx5_core_dev *dev, bool suspend)
 	devl_unlock(devlink);
 }
 
-/* In case of light probe, we don't need a full query of hca_caps, but only the bellow caps.
+/* In case of light probe, we don't need a full query of hca_caps, but only the below caps.
  * A full query of hca_caps will be done when the device will reload.
  */
 static int mlx5_query_hca_caps_light(struct mlx5_core_dev *dev)
-- 
2.39.5


