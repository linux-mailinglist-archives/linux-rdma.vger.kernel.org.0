Return-Path: <linux-rdma+bounces-10056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939AAAB478
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C081BA2992
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60034316C;
	Tue,  6 May 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/y+q4xF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F82F0B91;
	Mon,  5 May 2025 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486693; cv=none; b=WSaHu3Li+QN+G7yd/oFNrxBgIU4uEmuOP/SnNH3b2ZCv+yQ79ubfO/+WlCf9TNA/DRzTEdoOyrD5zeeuBgHMe1zyH19ofbn6VC1S4fS8PawN6dYkpj6WuG33LrmlRsDHn9ZZP6Fg3rDI8CR6056GHfscZ/JgJnXUyEvluUMl+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486693; c=relaxed/simple;
	bh=AzMzZj0tsTeC+UxRZX/JQTSxu27YYYsKHcsDBERFInM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+o+akU+3GsbsRegZay4+rO27Pl4jFMfyL7a/qAxL898uPk/0z2y3OpUVN6fDUPOnvF4R40fl6dQhqOTjr7oA05Wbo+gnBblQlxJ0jcvAAHEqfsswAZxNpT7Gfo9qd8+fNpzSHjLObooboph7hWvHb7MmeeCeNE/2QI28iUuTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/y+q4xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50795C4CEEF;
	Mon,  5 May 2025 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486692;
	bh=AzMzZj0tsTeC+UxRZX/JQTSxu27YYYsKHcsDBERFInM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/y+q4xFvuzE5LrJ4GfmoxvKoYMgD7P3o6h6b1ih2oSvgHoQqTgK+O8l0RDfIhgLU
	 YyOT4lj9O1ObQfYax81XNT8WeeVAbKSAKlXVN85KYRahMY1gs38/P4nSI+L4UQLKfm
	 1mDbb6Vwd24/hv7UbOi15bRnxZRIirWzllbyFbskCNt36z+zOBg1dnxsDxTa4BVtnC
	 CWcoEadk8VOsR27aHV27w9r/9O7PWPQyiU1h2QwCEGMtRPAfVtlKYFfhYC+pQX0SF9
	 MNVHYsxMaQ+v6jZucqRGZhGsLDAklJIgU5njJuuza+7Tnn2kEWxZ1R1s3C6kh0MJAF
	 Sa7Jk0uKCFZpA==
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
Subject: [PATCH AUTOSEL 6.1 154/212] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 19:05:26 -0400
Message-Id: <20250505230624.2692522-154-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 68b92927c74e9..6aa96d33c210b 100644
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


