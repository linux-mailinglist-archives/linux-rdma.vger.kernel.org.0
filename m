Return-Path: <linux-rdma+bounces-10019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FBAAACE5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67783A6A3C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D43A7BD8;
	Mon,  5 May 2025 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDOpt8zo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD828A70F;
	Mon,  5 May 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487021; cv=none; b=mFvvj+OThNo3/epUWtcfpPHkDv9reGUh5slOpTJMmHKZ4+y3KIeGo2nY7L8AtKKpiFMHLv7Hd8TIxVeopSOYzQb10rEkNNlj8UxAgbp4F6/Nj4PPxBZBeRcHC2xPnRs/7jp1EP9FPdNGszQsy28YOpi4Fbf1JqT71qbLDf/gQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487021; c=relaxed/simple;
	bh=ib1Vrhx+ahc+Vj+0Ro997g+1+fNzOjfu6r3NEqs8MS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozm2NAbmzz51SvCYXxMEj8kZSXGPD7XL7Nv55M+Gtxyd6wVSu80pCtVeyeGYf912kO2JZ2hXXzwmk6WjgiIP0LpmlDdibbOFjUohzkcL7tSA1gI964JZCVaeyIzhRsuAXDUcdXpHu5TD3qeM/THL7+wcDFi6FRERmXL7b+l6mYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDOpt8zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2269BC4CEEF;
	Mon,  5 May 2025 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487019;
	bh=ib1Vrhx+ahc+Vj+0Ro997g+1+fNzOjfu6r3NEqs8MS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDOpt8zoJA7nYIpA1Bu17Pr41oxLD+KDp9X7yVEELPd+h9aiBB/odBHZdjx9tkLPY
	 fgyXcUGO7wQVptLG4t5WitZE3yqfOy5e/6E8mflM008nuFfEd9FBME2AhTKjPK7Sp1
	 56Ve0bcyY+WtcIiQuKpKQsU1caL00EwvXNPfk5moeuGis6rSy0DyDvAH4feFixVpL6
	 LEfDQUnwG4nk7pf0cpteIopcX5q/CXYhNcWwKSomIT44LKpS982CNntX7TrN6JSxhm
	 /W9Lpv7OeBunuwnlTSRh4bEfct7Incwvu6YkOdTeztiqyyCIOGcn3uS1eR1gVwR2tV
	 1q8OsmTzFqwgA==
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
Subject: [PATCH AUTOSEL 5.15 111/153] net/mlx5: Apply rate-limiting to high temperature warning
Date: Mon,  5 May 2025 19:12:38 -0400
Message-Id: <20250505231320.2695319-111-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 080aee3e3f9bb..15d90d68b1ffd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -166,9 +166,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
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


