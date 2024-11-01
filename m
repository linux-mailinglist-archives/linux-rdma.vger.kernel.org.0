Return-Path: <linux-rdma+bounces-5691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC89B8A16
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 04:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD3AB21C8E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD55145B2E;
	Fri,  1 Nov 2024 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HCs9zHau"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48F13FD83
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432934; cv=none; b=C23iWv9aq3LmOyUcD+R/YTVHd9FPU3HelUVX/FTiNMbYHMeMrxrcY5QV6uXZO9iHnzpCKTgiAtlhNUIy2rtW6cmIt30qix+WZUQKUEIz+Duc4kXKa6WGELT/a4YnS4FCf7OAWRI0QL51kod8rNf9c0qvXa8mSdY1EyWf33LQaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432934; c=relaxed/simple;
	bh=MZxHaEa7buDfvPC/4WE/aTVuUcf+xHReOo835eWZAUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnFmt5b/C7S0cBZ3PhxZB/NOpz3DBn4qdAeyZLpr2morI815Iiu5tnPzN0Fts0aULt+1wX+T30f4J8YRspfE614Da5S1YXPMRa+kNF6MWWvdSrUl1YEoUmBc5W/RZs0llbVOXGihBW/IptW+DmaWDGmzp4TNpBelc3roMU29lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HCs9zHau; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-83ab462ccb6so5622739f.1
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730432931; x=1731037731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFtIYGNmdHvtGkRyGJ94EvP76ryCIg69gweJeFB48t0=;
        b=HCs9zHauggqjpYWcYjPW0xyxkRycf0hDSS39kyc0zHdFnydwppplgrE1wdeQ5NzVRe
         2UL+kZaSW0UlRFBaozlQ9QGRevlzr+YOgQ51qygXXOakv7lC1ga+Bqga7JWwRXQY+643
         AQq9+dpD8d0AyGWAWxH93XJYCQ8VQgEc3BTgmy3bKmdJKGgjOS8UGbC3L6nVO1B7dySE
         XHBr7ShVirOqWTMv8bzzHIXE7quxivyMA9NAmTszaZz4wKBGu+rkxI2atTOwnAbjh4yO
         TV1L0//awQova1WwEsJc0z6ZoIMswU1k1vHzkcfGP/PmP2lTcxWg+fiXfwoed5RjwdNY
         lR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730432931; x=1731037731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFtIYGNmdHvtGkRyGJ94EvP76ryCIg69gweJeFB48t0=;
        b=xPZuPFrH4XTBO7aBASTj2bTAz1PcUQHQpz6EtsGUIBfL51I7Q7OURctx3Dv3RghI22
         Mv5SkWALLOf65tBj7AHaDRAAc0631YFYxy4yav/6+cS2hSMtDCBkitEX1i3b4OQOQTCN
         SJa3dSymCieZxtIKsNu2FwPK37xqRUQlSvfzRPfgHLsF/sjAQhas4hM6Z4laHxswsUNx
         NKWnpyE7ywF6PYJrxa7n06MX9W8lui8Dzo9HFElMyNXgxka3JnyX6brantzLGC2mHqOi
         lEWGoP+L6tAb/SLCRpl0ASto1I8WRRHW2cyU59cSSTjCdgFdkJ2djiDHxz59HXLxEbce
         tyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK2ew8NMm5OhqJ4N3rXCxc+jlzXRyHFluZq1z0xKNWm++Hkp0NYM8R/HRAkcsq+pHerqXATVhcj0q1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9I68mQ/hvPrnBSD7b6M8rU61NjBs+kayXo5K6+dYhiWGSZ3CJ
	Dx4zB14saBUQcoRujSK8j0rY5JoybBO1g6pyFRe3sT7CJeQqRkOTFEiUVaNH99LQER2AqUu3ljB
	5sZOl2rb7cZee8YFsDCIVKTAS6KP7M1J2paB2prR3KBZHc0lG
X-Google-Smtp-Source: AGHT+IGeAIngWc5LMAF4LFYsaT5zMsZvEQP0mtRiGlcTjVrfrCa0VFOydr5yNiWCR5zgfn9ud1jX8qtLZ/w6
X-Received: by 2002:a6b:d90c:0:b0:82a:a4f0:c95e with SMTP id ca18e2360f4ac-83b1c60c9e0mr536930939f.5.1730432931086;
        Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-83b67cde42esm10054639f.35.2024.10.31.20.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D22243406A8;
	Thu, 31 Oct 2024 21:48:49 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BD92DE41EB6; Thu, 31 Oct 2024 21:48:19 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] mlx5/core: avoid memory barrier in eq_update_ci()
Date: Thu, 31 Oct 2024 21:46:39 -0600
Message-ID: <20241101034647.51590-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier in eq_update_ci() after the doorbell write is a
significant hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see
3% of CPU time spent on the mfence. As explained in [1], this barrier is
only needed to preserve the ordering of writes to the doorbell register.

Use writel() instead of __raw_writel() for the doorbell write to provide
this ordering without the need for a full memory barrier.
memory-barriers.txt guarantees MMIO writes using writel() appear to the
device in the same order they were made. On strongly-ordered
architectures like x86, writel() adds no overhead to __raw_writel();
both translate into a single store instruction. Removing the mb() avoids
the costly mfence instruction.

[1]: https://lore.kernel.org/netdev/CALzJLG8af0SMfA1C8U8r_Fddb_ZQhvEZd6=2a97dOoBcgLA0xg@mail.gmail.com/

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 4b7f7131c560..f03736711343 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -68,13 +68,12 @@ static inline struct mlx5_eqe *next_eqe_sw(struct mlx5_eq *eq)
 static inline void eq_update_ci(struct mlx5_eq *eq, int arm)
 {
 	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
 	u32 val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
 
-	__raw_writel((__force u32)cpu_to_be32(val), addr);
-	/* We still want ordering, just not swabbing, so add a barrier */
-	mb();
+	/* Ensure ordering of consecutive doorbell writes */
+	writel((__force u32)cpu_to_be32(val), addr);
 }
 
 int mlx5_eq_table_init(struct mlx5_core_dev *dev);
 void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);
 int mlx5_eq_table_create(struct mlx5_core_dev *dev);
-- 
2.45.2


