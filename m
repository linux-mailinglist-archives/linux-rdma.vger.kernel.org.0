Return-Path: <linux-rdma+bounces-7045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD18A14185
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 19:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BA3A3489
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82C22E40F;
	Thu, 16 Jan 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aln2NhOX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F9190685;
	Thu, 16 Jan 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051427; cv=none; b=eDWUegVVpz413QompJfEcgkixvwhUwRHDRbp/0Lk4MIIDlOtjhz7nJfq7WbybWTCCCfqVvp8+ICbAkeuHibqRjhZsmnXkjj/yZnFXorenhhFTK+Gtkz7VZTXd9BEy2havGqfbTTgdtyiJYexCYawdDk1PSaVTo10l18KY5o+i9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051427; c=relaxed/simple;
	bh=MeYoPD+K0np5mAk0A2X3+j2z8tt6EETtDJZqTQzBgcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvldTRmPk4Nkm0GrZaxa9jQn1sW2osbXJ0zCvzw+8K41/roqI8pZXbLY67CwS76GgxKuA140cyqX2i2Ayfyzz3PLKNxXVOwEsZ1NVCPc/BkZaWpxF6X+MyScKxIQ1rAhTULPe9+ALp07r0YVFwn8TIacMCQwDdDahz3lgXiLd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aln2NhOX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1164452f8f.1;
        Thu, 16 Jan 2025 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737051424; x=1737656224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4YWdjoeDX+MAdyj/JMomsHTE8KnFR0wYLN1dc5PSd4=;
        b=aln2NhOX0ARlwEhsGZluwQIjlkt2I36I7uULOArZLeSIoFCTpGUj71j0btsLhlYlw0
         jZc6dIGjIB9FvpjjKXW9hurnd9IBwaKKLHIXWmzl6HhTguuSV6KhFNNE6/kpD2Ju925w
         6/x/KQX3rPcwKHPbfODdRBEf2WbwH6nAo7UENlImz3k4shncuDvrRj0/iLUIbvqcWwVd
         vJhBEw5wM9aHbAtcpUOw1rrBaQtPnkSdIuTGApgDmEfaqnmgBvrk32k5J1nRPmblYkwZ
         MlkN9bUyuYIvbcd/Vwbm1xnh1c1Ibyd3a7cb4/QT1Tift6P7z2UVQ5Iw9krktxkfkEcK
         6B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051424; x=1737656224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4YWdjoeDX+MAdyj/JMomsHTE8KnFR0wYLN1dc5PSd4=;
        b=cFGSxeaM0BAB2q9HwOS+4oA6+Ceyg/63PJRijUnpDCZyW5XANpGdoVLJVPX4mOMYJn
         gVLe2bX+FCnwIYFUfU7gNy+bYtKJlIhmAY086dLAsTlFC/Y02xN0Cx1jwSFTT4simxtN
         Cq8GNILghdthxzmZWypMw81o6tXIXseDakDRnnYm/+glhZt/xJ2pZ2GLQFsaQDtZF2X8
         htK65hk2rZ8t6eBHdGWJMQaC8hM+irYaqkq16cdAWobbe5OY3/QiKvGB8VJIJlEcFIFS
         r4+tZ2DAzTkcOiOjWv9muYAohALXlm1AAmeNDA3of3UWb/3a99YltOr6W8RuGrGVF5Qt
         835A==
X-Forwarded-Encrypted: i=1; AJvYcCW5oNRclQCvugBH5iaV8OaLIXB71VqiHDksHulOAGqdsikUuUosKCqF+k7xc/7rdiZRrINFdt2Q3f2bFw==@vger.kernel.org, AJvYcCXykeHJvJSnuKvkEegabz0Xoq4d9wY+3S5LOUrBI/eR1MtRPCKRbMuoogISyAImMgLafeFNU8ltXZIpJB4=@vger.kernel.org, AJvYcCXyu16Y6v36zekaZ0dt4oiLQjo7VUR3ZjDxxeL3/nJyDPxfoaJ2vev/gSS/lOxhjBZsyi0z0jdg@vger.kernel.org
X-Gm-Message-State: AOJu0YwZg3zxWCicDuFiCL/W+S1WPu2nATAOjZf6HiDCdp660uQd1D3G
	ZzWZ3Xne1J+ZHW8eVguk6B7JUDZtdGPdu3bAR/QrncSmyIbd388C
X-Gm-Gg: ASbGncuCt/E2NKgITwGPeUUhXaz0ddLdhUwFN0xMrWL3hxhSgyWM3vLwMs2vOMAq5wk
	gGtnhjx4w7Yc2NVZLIjwBOWs7niOQO0qu750KGSKwEWHZfwbaqDpZI/hTbTXUPEnLXM9IJ13WO0
	ejj19DiOGMRDXJuJW9RGCMudEZ1bFGhi8hBUy74iWmMlF2aD7KXCkwqZvfadYCXPt5BHOEaBy5l
	aQ1nidm7x4BfziOorpMt590kt03FACnQVZ9cUAahb2cHRcKJVvjqZoLSg==
X-Google-Smtp-Source: AGHT+IF6bcPdXcf65TB9E6FxmOSPGwJ4wTAjOYV4SZ94Yg1RTECT1VqhoqSk5bGR33sBMm9dW+zOeg==
X-Received: by 2002:a5d:5f4d:0:b0:38b:ec34:2d62 with SMTP id ffacd0b85a97d-38bec342de2mr3524199f8f.24.1737051424149;
        Thu, 16 Jan 2025 10:17:04 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32754dcsm475367f8f.77.2025.01.16.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:17:03 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net/mlx5: fix unintentional sign extension on shift of dest_attr->vport.vhca_id
Date: Thu, 16 Jan 2025 18:17:00 +0000
Message-ID: <20250116181700.96437-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Shifting dest_attr->vport.vhca_id << 16 results in a promotion from an
unsigned 16 bit integer to a 32 bit signed integer, this is then sign
extended to a 64 bit unsigned long on 64 bitarchitectures. If vhca_id is
greater than 0x7fff then this leads to a sign extended result where all
the upper 32 bits of idx are set to 1. Fix this by casting vhca_id
to the same type as idx before performing the shift.

Fixes: 8e2e08a6d1e0 ("net/mlx5: fs, add support for dest vport HWS action")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 05329afeb9ea..f34bbbbba1c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -417,7 +417,7 @@ mlx5_fs_get_dest_action_vport(struct mlx5_fs_hws_context *fs_ctx,
 	vport_num = is_dest_type_uplink ? MLX5_VPORT_UPLINK : dest_attr->vport.num;
 	if (vhca_id_valid) {
 		dests_xa = &fs_ctx->hws_pool.vport_vhca_dests;
-		idx = dest_attr->vport.vhca_id << 16 | vport_num;
+		idx = (unsigned long)dest_attr->vport.vhca_id << 16 | vport_num;
 	} else {
 		dests_xa = &fs_ctx->hws_pool.vport_dests;
 		idx = vport_num;
-- 
2.47.1


