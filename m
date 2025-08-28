Return-Path: <linux-rdma+bounces-12972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C1B3943B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC263A4095
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E427B354;
	Thu, 28 Aug 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8BwCKXl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056032797B7;
	Thu, 28 Aug 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363869; cv=none; b=QpYz/E8h4Hrc7uF3pJEbVGm/daEbhN8DVY8MrWSx+d1QLJ+3bN0MPadqedrD+fjivnOXnHnZLTsq3R+XAT2i+QEY5wySWF1MB1p17JGA1oU2gr728OKtHX8BLql6kmLz7ev5nZT9iBtkAURQgo1EuUX+rjI9sqGDg0gkrKkwGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363869; c=relaxed/simple;
	bh=UAo3JV7GcRkxO2b2K9+QuSbEAtC0O3QgoXSeSZ5al4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEGs1c6IpGHyUflvRWW7gk+yaWFKkvk8q0YrHgjLRBqTdbuHx2nqm6PNlGaL6NxB8CsG/tlIoWGc1BO5Bo4D0n0oESK5yUE3Xp+4eeZqkKNDVtqNPiSbx5RY4TJJEV6MXVlV72lhxirGtCM9I1wotMF4xCiS015+sH6vBfrdLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8BwCKXl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso494583a91.1;
        Wed, 27 Aug 2025 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756363867; x=1756968667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIMdp+BGDSNuOjdemBoiNkjyZntQ+XVi4yTlgnNJQek=;
        b=O8BwCKXlTMOyV2DjnvC1WTRQn7emkMjL8MamXT91L6yntUEl9hL7lYaDLKyLAKlAzo
         vWZCI5x2/KePafAKGz1MYfqOVbrRSxA7haZDAMhKor6eknsv2iSsz+FxjdEx2XVJjowI
         WeqJZkva+twaErv+MPUsWtrc/0eWuhKOoXzatz/7iO16CHRq9IyOxwoOCjTI7Z8ocO6y
         +9z/W7jnrELPp+tiLfugsiWvpMqZG5ixxT6DUXK4l/2JaqXKAcrA4TiwANd11P/+JdBc
         T2Ip8fxDmCZwucrxblluSQ1ps4h/lBfTqlF7Re7PKoocCZZjc95wqVEBw5O/bGedU2Io
         Rhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363867; x=1756968667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIMdp+BGDSNuOjdemBoiNkjyZntQ+XVi4yTlgnNJQek=;
        b=deGhWjJ88aq8971ZOYwCmU7+G6x/NKGPF9+I5wmRX22JM2Zctd8Pa5o7HSVJPCh5l+
         DXmLC0bkReAPhNzRSYwrTP1TVDJiE/ZGMy3hmif2VT40uthPDOflQVrAY2z+3MXUZ4xH
         h7N0nWEbsu9h7H59xtE42jweSPpb9hhr5KWfDhU948bMw/3xSwPdMHtld4M7RkfshP6D
         nhnWvBZp0bucLH+zLMyMnprJuitZIC3+BQSCUy2z4sx/vAa/PICKRe/SSrtpeXETnXmG
         48o6vJefBAV720/BhCFCaAyvtR9nXTqbEGfhdbd8TMHx3hC6LeREgScsOydQO2HH/F4+
         tnew==
X-Forwarded-Encrypted: i=1; AJvYcCUbXYiuY+5k4BQrOZFugpNzh2s7D6LAjub0n3e1kSy+yMIgTrCDi1TfMVKS7mLTKzmzYVRjxJrVam4I+Q==@vger.kernel.org, AJvYcCVlJiYAwtMjyAmCAFeYm+QjDGi1GhEByH3gFSEm7F8xNes9v31QxUHmXYKZlp2682E6PxaAnOqXwoYXQe8=@vger.kernel.org, AJvYcCVrFvRNedX2nU0eG5OEyIClVEGT5liG1dAcoeIGVisgSqACf/fIRvOsognPCy/a8cTuAwdj0b08@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9glAFVrF3gWa4WQLP80+uPAFn7nmvyhdCuS5H9hVTnI9fySfy
	kfpVTc1GLFhPU0ut9cFv2FEZJh8fAxdR2dLBYIyKsrAV89oaoJh3gxQx
X-Gm-Gg: ASbGnctl9PPWzRDPBfUVeDho5EICogspeGW8vgDOPyk2Y2++ZBeUIvgV7cvkrZRGTAS
	B+greG9BkKD/VoGxgdDiAyo4wH9eAiGwxJPsZymuPwtnz/Bu8+KgzGrToiG466CNeMMEo+7M5Xi
	Qrhc1SBJmT442Te8ZV213oyIX67a4GSMaSeV7dxmz9U6xNhitBcRvfSmPkJLsjFmtRmKQ6j2vqq
	Rq4I7bQ6I7pWo37Bo0V/dRcUe76WSDRVThueyKtUtw9Jxfae0+Fe/y5kaVKSY3hXCBrb7LclDYl
	m9h+7xXAHY72JVmqGt4JRej1NzdgpXucrZq5pG48q2RCnRZcMBbXSX1kN4dLiIchh+Yua1XKeXH
	1wxuaugVaJ/wz31UxxT3uRgMZrKjRZ6qlIsRgGxTHKK9Aq4HqLol0RtQuFYU2rzfe836B1gRlwG
	HUDYyXk462ooKJ/BStmb0qbQ==
X-Google-Smtp-Source: AGHT+IGfOtD167eT2rfVxdwTsipYluXjtiJ+7zWRk+PvDr4kGjQIu1tk2hHrrYSKDlWpn9+KTJC/JQ==
X-Received: by 2002:a17:90b:2f87:b0:31f:8723:d128 with SMTP id 98e67ed59e1d1-32517b2db8fmr28547178a91.34.1756363867201;
        Wed, 27 Aug 2025 23:51:07 -0700 (PDT)
Received: from localhost.localdomain ([112.97.57.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32753e58618sm2642250a91.2.2025.08.27.23.50.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 23:51:06 -0700 (PDT)
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
Subject: [PATCH v2] eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
Date: Thu, 28 Aug 2025 14:50:50 +0800
Message-Id: <20250828065050.21954-1-linmq006@gmail.com>
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
Changes in v2:
use err = PTR_ERR(ring->pp);
v1 link: https://lore.kernel.org/all/20250805025057.3659898-1-linmq006@gmail.com
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 92a16ddb7d86..4728960c2c4e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -267,8 +267,10 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	pp.dma_dir = priv->dma_dir;
 
 	ring->pp = page_pool_create(&pp);
-	if (!ring->pp)
+	if (!ring->pp) {
+		err = PTR_ERR(ring->pp);
 		goto err_ring;
+	}
 
 	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
 		goto err_pp;
-- 
2.39.5 (Apple Git-154)


