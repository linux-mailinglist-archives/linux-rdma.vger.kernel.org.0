Return-Path: <linux-rdma+bounces-10031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A34AAADC5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505FF165469
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2653FBFA8;
	Mon,  5 May 2025 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ4RKxOZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C63BE7A6;
	Mon,  5 May 2025 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487413; cv=none; b=dqevjk7GkvbhjK3r2VhVJdkf8qb6auznKPR322qe9wKV8PuqFXVpZFcqn0m7ir+/vC5saH+oXxs6Cyr01pIulL9cJ8+pcxgKROcbJAAxBqRtcREfZrOaSLW8TscQ85BwNofMmvtJduJqhn1lvBGwV6A+ctavpOiBn2r8bucSyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487413; c=relaxed/simple;
	bh=i3x/K4kilTFOffX74faqUg69tWw7y/FP7qCjJgWEeps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+5ced4LuBbNK9cgy4kevNsCts1Qz4a/4pd6paGDxf0WpP6McBHM8nDoMAy4+FUa/a2gFjKeX1N9ogOixIM2+vQ2VYtTTT5H8WgC9jVv7FbSwf+3Pv1r2hmPO7wBkwvK9E9bANf9EN6V/DNuFvQQSpbbYEDyt5owtMnKLnzC0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ4RKxOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C5C4CEF1;
	Mon,  5 May 2025 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487412;
	bh=i3x/K4kilTFOffX74faqUg69tWw7y/FP7qCjJgWEeps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQ4RKxOZ1YGznRCs7Fn+gngDpz6iIHnUM/uBD5FaF7K19bJLEWrGMCAASEW/kgA8P
	 u9vc7r2ubQjqhYD3FCO/oL9HiLT6t3i7i1vP7+SkJsFvBzDdGXTERuHgQqINHPqKZr
	 b4nNBgNLLH986tNIsLDx/XZ2wOT/XXNZKH1Mv9qCYUQVqxfyfTo8DLYvD4qRbgeoX7
	 +WG1L4GOIgp87OxFfb+HJkx/39gc5beeXzyFWkrdqqy1fcexmNrHwu1aPPyPrg/WyF
	 gO6/W51dQ8iySNIdYDi+Gjq0D8FuUx+++kDTKa6P+BZgWsiUMQJ3hvtoZgdZloqB9s
	 Psb+QS7Vly+nQ==
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
Subject: [PATCH AUTOSEL 5.4 56/79] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 19:21:28 -0400
Message-Id: <20250505232151.2698893-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 9d7b0a4cc48a9..5e8db7a6185a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -162,9 +162,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
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


