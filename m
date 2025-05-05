Return-Path: <linux-rdma+bounces-10010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D3AAAF08
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894BF16CC36
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541832F6620;
	Mon,  5 May 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eku9V9da"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079E281359;
	Mon,  5 May 2025 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486195; cv=none; b=CD2ACHdsGpbX87qeXFo8eykXsXeJ9254nFKCyoaEZzy263fNDjJ2oJNIzAivpRASxP03/v2GwwJa+FVkQeB1low0yGkjjfEGj/tLiGiChJqYLxMRbnBSJGyAjZJj6Izon07JVQH7nGn6SO8SXHGB3VZEAjL3K7+rLFrdu63v1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486195; c=relaxed/simple;
	bh=cG9+6Z7Bog13sT6niqG2mYbzsvFckweOUilz1ChfGsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4U1+5dQ1Yj87a6V1ounBhh9MYU3EG3XtMQh1O0eLhYqtSSFEyP/+MrikGJse+6NjnHY1i1AMhwbVZqX5n32wA9Gnb97hm1uwF9DbJoNjWXavKAuo0UFituualsLhot8QGr5KVTKTOi33bx0tin5Gu3mTch6lK0dtGUAmMjGJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eku9V9da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F1AC4CEED;
	Mon,  5 May 2025 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486194;
	bh=cG9+6Z7Bog13sT6niqG2mYbzsvFckweOUilz1ChfGsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eku9V9dao6NMG5zyzaZGM7qBaIBi4MiGSQV2KzrJwbq6SF17AtLdZbuf+ksPXLDve
	 zj2a3xu+kFFLNWVIhN6lia40qHM/Odxrg2EhwrWyitjlCcNeSadBasMToTUkXS3/Kn
	 PVvOVQRrdMdHXfWoKrTrV5EW8cZ3urhDG5GqUZrkmUcsOvIszYTkA7sXaXrjLXeZpq
	 d+/IAM1eWaVjMIKTGSpX09i/U0zUJXlZTQ8meMLLDmJWnO74hYNkO2VBV8CjTOixWl
	 qcVtAIOp2rvAaqw5EfwIV/ssDyJ6C59ae+iImsCIA1rBm4tx8xxjurB53ZRjSkofBZ
	 RLBmrL8JRr28w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 197/294] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 18:54:57 -0400
Message-Id: <20250505225634.2688578-197-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Shahar Shitrit <shshitrit@nvidia.com>

[ Upstream commit 9dd3d5d258aceb37bdf09c8b91fa448f58ea81f0 ]

Wrap the high temperature warning in a temperature event with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated warning messages when temperature exceeds the
threshold multiple times within a short duration.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Link: https://patch.msgid.link/20250213094641.226501-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 0f4763dab5d25..e7143d32b2211 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -169,9 +169,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
-- 
2.39.5


