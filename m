Return-Path: <linux-rdma+bounces-12582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F97B1AC80
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 04:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515813BBA1A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C01D9A70;
	Tue,  5 Aug 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs0nX/Nl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3A1F948;
	Tue,  5 Aug 2025 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754362271; cv=none; b=CW84Jhj2dokb9BV0q8V0Mk9VeXoKneH9B4xyWqmMjXrkgQSzCea0O2aa4bNQa5AMPiTazHqmfw1znl1GfkpjWRQBEUulCGxpQVJj/z4+sqB8gJpXe6Ebo9NEB8V2yDjc2tKd4SzPxeC/w0tttjcATGXGaNvoZg2MJzXNf4wSAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754362271; c=relaxed/simple;
	bh=uM2eVyipiju3kW/MbQVtysbJWhwxTWJEIHrHstjdqZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2slHsI6WjJaVLYhpFtVPJBnnbe13HqCYzXQuGeVuPA8bzyDm6sP2XS+8UckHW0U7ZDG+GeWgAHFhMsWsRxhSFceWAlwqAYNjXcT0861lyEThDUFJKDcxc2d7fKR2QkrzUoo/vD0EGg8t0o8KhJdbgLuhpjq3AHxAaKmXWLULgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs0nX/Nl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b423036a317so2718228a12.3;
        Mon, 04 Aug 2025 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754362269; x=1754967069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqeaa8uY9Za+zVsiXl9Xc9xX5x9azHIxirf0ihgztdg=;
        b=Qs0nX/NlPDJxdkPdVP/IfDAawOzfG6UWzolAptu6vQ4XO30Vu0G1t5B4vJ0ZuI6k5w
         zZetzIWjOrZKnJrNLxVEfr1r20tvhZaQYF3eJv+Tn3Q39MG+DbUd/wVn/C7LKNQpB7YY
         dcxXEZJonb/boRy9n9p7aV7WC/yuGkKVKxLV0JnFMreRpI2A0VEZ4rsKM9H0OBDmL8bQ
         81r5X9cfFMc8THxuRyHta8Mrr6/dqSxfrI5CGsIk1AqQ1jxDkAPexjLl6Kuue3MGF6Ka
         SnWUr0nryWaqAVtlR/guQtmHOa3OAjpNu0URpi+C69L/2eVVl4DqqgFgGpVmd6IWAb1J
         lV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754362269; x=1754967069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqeaa8uY9Za+zVsiXl9Xc9xX5x9azHIxirf0ihgztdg=;
        b=aWPlvLd24x6HiqIGLVaRzGKX5Lnd9RTQeHQoSHvmlB4teoA/BChvLlQuId5j9f8Oom
         IVVlQU+bGmx0+SGO8xcnxeOmv6HVtTe+8h7n4Wdny4PF45NXmo6/XFbgW6T+m35N89xi
         Ml5eKc+C1EzC/OyJ5HfiaTWQfi1QFlww13OGEDjyNDdfa+k0S/b7BHdsPY/FKQotxSvK
         SHWyhuT3eQ3g6uA/py4Eartrp/n03djGuF/lrW2V4cRj6oANga8L1FLKYBaEb9tf+9s4
         DkTxVEH6ZeAsN7i7VVxeD24imlKABn41gfgOOJo6yTycgWJRh3pZcIeJEQgyM7ExoyLr
         5dzw==
X-Forwarded-Encrypted: i=1; AJvYcCVn6/f0f47mE7yjFfcykDG96wjuG52Y2R/3znM2oIy867BHfufOJfak7uz9njXqVVjzWoo22IVUJE7Ttg==@vger.kernel.org, AJvYcCW9YbU8sE6o8hUiN+e9N+8GvvrTWUFLzqfcNwICleuh18tQWMKocRgeNdOlwuB7+5pi27O73Hyu6miGXlo=@vger.kernel.org, AJvYcCWWXNiQ0tgVo71g4Cx79Qk1JY8XW1qP4KbSFehJ7GGnpUmBuKgV+hwN0EahlRyfX2FgYVRj90Rb@vger.kernel.org
X-Gm-Message-State: AOJu0YyKB1x1/c1QOnfxm3vzk/Au5vF0yPgh8lreLoVJ9m2nOeYRMQS4
	R+LP++5tET9eGfL7ITxDJYb+ZLMUN3d4qPEiHDMAmUzb913RaWhq/k7w
X-Gm-Gg: ASbGncuSqTUkllmIaFH+x3KjUvjKxBme8dh2pPkjT00spOEdEt9oxYUxPxYvaqliRYQ
	AhMqiBkAlfA7HDBrx9JP5KxORJeprHhzE1EHhJ9WfztsG+YZiKPduVMCZfGNXV5NfmU/qThN8NP
	nsZHBIkIOS/7Vg018apBRsVVqPSkAV8swCH2ZNc2kqIRd6yQxBHlpEqrRckI3AlhErJIHPEGxe/
	0HDwpESxSvQoDbrSBq8zTp56jS1h4m7dPAbpmhnUtrMWJBUDQEUci+sHeXALnaG+dF9MtXpXL1R
	/92FIRquLY27glgXHN8uuX3EFS93brePli4sPWZiUP/ZIqWMiinY7TGocmPgcglPalIN2rM2NU4
	lzq0q+P8Ggz62AMyoD0s0RPeD
X-Google-Smtp-Source: AGHT+IEd/SBEMENFpG10Loncgc4YWgnJMjb2xdueteZUnYjU3CqX1v6XdICnKEMweKWdnQJXQ41P8w==
X-Received: by 2002:a17:903:1247:b0:234:f4da:7eed with SMTP id d9443c01a7336-24247014978mr159776595ad.44.1754362269204;
        Mon, 04 Aug 2025 19:51:09 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241d1f21b69sm122354335ad.71.2025.08.04.19.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:51:08 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
Date: Tue,  5 Aug 2025 06:50:57 +0400
Message-Id: <20250805025057.3659898-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace NULL check with IS_ERR() check after calling page_pool_create()
since this function returns error pointers (ERR_PTR).
Using NULL check could lead to invalid pointer dereference.

Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 92a16ddb7d86..b60f3d5fbd16 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -267,7 +267,7 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	pp.dma_dir = priv->dma_dir;
 
 	ring->pp = page_pool_create(&pp);
-	if (!ring->pp)
+	if (IS_ERR(ring->pp))
 		goto err_ring;
 
 	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
-- 
2.25.1


