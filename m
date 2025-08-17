Return-Path: <linux-rdma+bounces-12796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54274B29434
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 18:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E855200541
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2762FF174;
	Sun, 17 Aug 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7ishbzr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC2285075;
	Sun, 17 Aug 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448724; cv=none; b=TSacDFe2Ku90QWwwJt2ITqLTR0fmkDIqH3M19Tv73HWr7Rh0qSMilSuoQOZA32FWlwZt0IKe+A6qWrsRbl4qbr64sY6xhFXjkpFRF+cSag69yK7gUIF4QqijezJDUWTU79DZdHHSu796UuBLvZWv4kDZr6NEAusl+2eLm95bJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448724; c=relaxed/simple;
	bh=8R2fcFGpSJdmy6QSJXEPyqstFl05JrSadN5kH4ubPtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBKOpZgO17su/HXvVxVGhThXD7Op7/Q6d53dEGTw5HKLuVbx1DWCIhMTGxSyUyi1aWIQO748GUctwgxh/MWn2pMQWi4G5eobLv9UWYslcsBUsEKC4YQf2UgG23XJcpZg00nUk82BXFXDe+jV14JHaAm3D1jWJ8IGOae1gqWnuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7ishbzr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580591b0so23581385ad.1;
        Sun, 17 Aug 2025 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755448722; x=1756053522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIT6uNUMzYTnbCPCMHsRis4gVzR0ZZCKNYfvnWn+bgk=;
        b=N7ishbzrnrMt/Rfb1zN9teAA1dJTveeQ8XoFz49LBoltTwfGNir0+nChm2KOz2ZlEV
         GdFUgg6yxGDc5o8p1MdFV9kCJsO+sRB1KfXuTHKKY6KOcGPdPqtrwH8IaNzW5DRDuhwt
         gBdPo7E4Uu2YZTfaYspNBAtHNfx1m2y8gYnYze8nZTd2dRV4hKXTQnV5rmP12dLq9tOm
         M7RbQWKbblh7HLEYrDKP31knPiTMwXCg9N8FxQ+yAWjCUInxN3ym2wDBKSJ77fuSbqbX
         T//2Xl0CvbdNtfCRFnrgxO2yOZaddDib7mL20PlsmowBu9wjA2f7dN92h3c63orDf2dV
         SCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755448722; x=1756053522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIT6uNUMzYTnbCPCMHsRis4gVzR0ZZCKNYfvnWn+bgk=;
        b=WJ69+G1UAC3UurHeZVuY3AMiL/ajriZCaORR15CjzCKmnXmpVcaHOD8SHVUOkFL7Jq
         dVGOxcrakqW2bT2wYnWK6VjE0IgnhhRUTlPImR6jwjvTlFLUzP890uFKiNRPfiA+Z6RE
         vbE8R+sFtDGS5fupVFK8XpfzgwuA7C3MtNdqxS/5wVFUm/STdA9rWmWjzbJkb22FgmpI
         4knxDzRmf+I7CTeky3X4WFZdB5jfV48AEOZCY0tL/of3Oau5F6JWoRzMVmmwq6klBdjW
         5hMK82cmdR4M/66iCygShdzjNICI1XA8724tkut9HNmvBCvx3jpK/pmzaJI4NeJxshD0
         Naqw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0qTvxIJacrTrE3cQn+TnNGnc2aJsZ0cNc93o0bjKEFKS/tXasVRaqVnI5ka/W+2iCqM8ItiR@vger.kernel.org, AJvYcCXbtWWkCxdr2BlLNHMLipDW7pa0F0MsZPZcB5cxoecXQJrV+RuL/qFqDYiSzGOqlHzf7xdlnvOkrtD3Yg==@vger.kernel.org, AJvYcCXh6s9AnwzoExpsWbNV8T9iD2gT9MeUnT4SFpnJFW3f51Hv+wgLgcmhOAUU3Cg0mdXVMG2q1Hi1AzWbYMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgzcoC48LbddJ+dQQGBzywB/OLTvCAVAQbJpw/yr3i/12doFU
	RFoOAxTzh3MpDoNIQ1ho7ywitWNT30peQ/vUoQXhd5VB5oEwyHpnKV8l
X-Gm-Gg: ASbGncvIYXKNmvO3FROIYF5UZaA3o1F3XYRF9bouEJ+jDaXqDaJCHXaR2YhJOJ4YbY+
	Wq9fZdcg5xM0/U20uaSBeNtUmek9vIN/c5Rg4qXb78BPyLK6FbwKUZd/8czu6fGm/SYEvTcizIK
	Bb7exIVFWXtkBWTGtX/qgOTreyTVR/3smmOrlAJyNPyoH1DijdBAcq4ZpH+KUiR/JQlZOk2qwDw
	DoOL7fHdNC9vrJoEOLbUWGngqbfO2LmS7EtJxYfAPAOZEvtQwX2FhyRrOqiO41EB7jTuJpEAkpH
	xjxRY3qF70rGRKFkUR+E5c0EVnUd77Nn/Hds8WRNwCKCwPpx4C3txDrR466m6EV01R/jEz2ji1I
	1tPv4I3+pI5nU7Q6+Sz/0Y576IYeTFTMmLhba1XAByNf2kQ==
X-Google-Smtp-Source: AGHT+IEkSGa1drps5XlLVHbgDwqS0fGTBd+3pDBDTaNi1J6dZB00Iu5x8mb8bByRJd5ZnaAPNHfgXQ==
X-Received: by 2002:a17:902:cccb:b0:243:80d:c513 with SMTP id d9443c01a7336-2446d6e444dmr128946865ad.4.1755448722181;
        Sun, 17 Aug 2025 09:38:42 -0700 (PDT)
Received: from localhost.localdomain ([120.235.172.134])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b472d735e83sm6279040a12.33.2025.08.17.09.38.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 09:38:41 -0700 (PDT)
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
Date: Mon, 18 Aug 2025 00:38:30 +0800
Message-Id: <20250817163830.10819-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250805025057.3659898-1-linmq006@gmail.com>
References: <20250805025057.3659898-1-linmq006@gmail.com>
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
Changes in v2:
use err = PTR_ERR(ring->pp);
v1 link: https://lore.kernel.org/all/20250805025057.3659898-1-linmq006@gmail.com
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
-   if (!ring->pp)
+   if (IS_ERR(ring->pp)) {
+       err = PTR_ERR(ring->pp);
        goto err_ring;
+   }
 
    if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
        goto err_pp;
-- 
2.25.1

