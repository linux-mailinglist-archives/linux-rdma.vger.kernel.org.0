Return-Path: <linux-rdma+bounces-12977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C102B39CFF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8A7BBC9D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D4630FF2B;
	Thu, 28 Aug 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Wem/hC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAC30F533;
	Thu, 28 Aug 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383552; cv=none; b=XhNNjCGys9l7IQKOkocEE/9lV6Cff3vYZhf0F4NTrMknMenXL9QmDKZ9hH+I/i8vpubcviykvtL5f5b9OyEiaUElLSgBRr5QwOw3QDjE4tsUADt6nOAdpuPjq3wWdrOXnEfJhnmZM7HhnR/vM00QyRw8ybKeNNnhCtuz+UVeCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383552; c=relaxed/simple;
	bh=9sw4X+qUd8JUdWsAC1P/xLMNchdiZnhRop75D3e2gDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EL97NMY+0mDouGOYYSV3QtmDjh3lMXoTW9fZpQF8fHvdALJLsvc/KgiYWND9EG+duyy4Hn2EZempm08sqvK9nN/F4GJXaiETSdgVU79BQ21hc1/i5BzrJ3Ff0bVlBshiODjkBLNUlZAP0irGhtr4vp0E+brj26+UapxMIq4gls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Wem/hC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77033293ed8so806761b3a.0;
        Thu, 28 Aug 2025 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756383551; x=1756988351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zp4VYS8itoLdeTelGLKi9B3V/A9JQoltmcgrd+WL9Y=;
        b=O4Wem/hCXhf78dpyCArKA6u++m3+3pt6jhls275EpCDQCcKkEdfKzG94byTzYaVRI5
         Obcof8kLuVA3OED5KptvEmt37YqRWj8sizatcc+qsR9DoC8KEd9Pf/IdHnB3s9edXn9C
         ypxlDk/WNw/bZExjIhSfOEMXQks/31JFgvDAWdbrpvZAnpH3x+qOgqciiMUPJlSgJIHA
         JUVlAiptWutt0aLaL23FC+XCFMOtC+tgEZbxSIfKLQez7VJDj4DWm2YrLLEQYUK/R2YW
         48Zs45KsJzM7Fr0z2L/O2XF9SsmVhEf+qTa2j8yzRBUXw2tZs6PQsgE134OEG1PaumaV
         TpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383551; x=1756988351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zp4VYS8itoLdeTelGLKi9B3V/A9JQoltmcgrd+WL9Y=;
        b=h3OjU87vZT8pNNcWUddt/X7GaXp3EjYYG2L+Hootn6NP0lt+betWkHT62KUTO2yMrF
         6eNf448xYgOsCSucpkXox4HmrbfoiiojORla9PRtlAAdm0NspP7WOtDxT21G3MA9iBVu
         6TBOHwkbFhvepIcbqn6Ubo0VU2cSoDG2u02AOJwDunFteJEFfr0eOMak5ijCT0POr/5Y
         JW49L7vw3L6s3JMCcvh4jEp7Vf5em3AwOAAZQ29jlHURccPJVYakTr8mMZJjRSa5OgBk
         ow5KMiWO14BaBDtkY9hWag0M9ADVfQPxjo1+KyFK5ZX19ngB9n258TpJK2M7XcHBdqN8
         kIOA==
X-Forwarded-Encrypted: i=1; AJvYcCUu5JwoThJKBI96TeRp41iME2XGKQwnxLLQR5zAv2eXzbhyRs/8ONCcxm9H9XxCpINnKc3VymYS@vger.kernel.org, AJvYcCVabPnATDW7ypzGnctvN/wpdysQrp3Gt22TIBgR8YpP6z0D0zZNl8L3b/MBtfQ1URK033pBkTMwPxR6CLc=@vger.kernel.org, AJvYcCXIzYm8sTNqAD+TfaW+zHxqFcI/hz3VKfAwubzj0GP/+F4kkfscFBB+ZIXYokNN7r3iqyKxA2qiPAH5Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVum55zqagSOd6qM0eAEutcqGIhDAd9ZbIh6/1teOucFhjACuD
	kLchSWJgfiCY7t0ksv3BiaLeKl+Z6/PqzBLrUKKV3eZT8SZMB2AWTUoj
X-Gm-Gg: ASbGncvO4lS9NPSAsL60iaVY68etOqGjHpkE5l4xNXjtFOqvruLWBM+96oTZUG5O8DA
	YjNCG0sToNeA9pIySjyVK4sTA5ojG2bLtOsXrmLKIt6mD8KhFtZL5gZ4yi7YftWjMIVhrdrjSpe
	bhl77rus1dazLbNZEwIxfsPp0PuBIMlE4LPBAPy7a8aLDyHbSZlDUeADLr8dsvLf154EV5/i/Vw
	C6cWn7KnQHxwLjgg0j/QUlL2vcPhhIpPWhB+d9Fd1+hDCQ8l9gOtexPbCyfss5yQuwJ3ZvL8Luh
	jy7E+vCjOF9loq1h5uxHh2ys6lKDjxZgFNHWes+q2TtOpFiKL1Rwn1CIMwh9dX7NOKBJqjYnm30
	lU4IVqRscwZH4kEpDHf1LcNoucrqpPKDdicnh4ndX0xo16k8OT0N0I4SXaz0yexbrOX+dYsB5fC
	Ke
X-Google-Smtp-Source: AGHT+IHEe4FLByihqr9w/1GzWFbbPnWny/7RgwyYCkPFEmkn/72HVrjrD5CJ72uVORV4OF0Fjru4oQ==
X-Received: by 2002:a05:6a00:84e:b0:770:5683:cc58 with SMTP id d2e1a72fcca58-7705683cd5emr20974700b3a.25.1756383550556;
        Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
Received: from localhost.localdomain ([112.97.57.188])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-770b5bed408sm12199218b3a.18.2025.08.28.05.19.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
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
Subject: [PATCH v3] eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
Date: Thu, 28 Aug 2025 20:18:58 +0800
Message-Id: <20250828121858.67639-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
----
Changes in v3:
- fix IS_ERR
Changes in v2:
- use err = PTR_ERR(ring->pp);
v1 link: https://lore.kernel.org/all/20250805025057.3659898-1-linmq006@gmail.com
v2 link: https://lore.kernel.org/all/20250828065050.21954-1-linmq006@gmail.com
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 92a16ddb7d86..13666d50b90f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -267,8 +267,10 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	pp.dma_dir = priv->dma_dir;
 
 	ring->pp = page_pool_create(&pp);
-	if (!ring->pp)
+	if (IS_ERR(ring->pp)) {
+		err = PTR_ERR(ring->pp);
 		goto err_ring;
+	}
 
 	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
 		goto err_pp;
-- 
2.39.5 (Apple Git-154)


