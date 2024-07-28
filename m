Return-Path: <linux-rdma+bounces-4035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CB93E2FE
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 03:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CACFB20F06
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5D19EEB8;
	Sun, 28 Jul 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX90WKYY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0711422D6;
	Sun, 28 Jul 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128129; cv=none; b=KACXc1BOwh7qBUX2x7rM80Rr3vOd8h3PlU6W7hpzVNQ0SItfUu20yCfohp+PujoL53STwlFjW2FNc/VbsK+GflN8WFnOFULRPQ7tM16qvy0YSchyPbrKaKDx/WFrrICAmCdhjyTb/eLdtWilsfzDbY0qHtjm/uvWMbHU/Po7TiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128129; c=relaxed/simple;
	bh=AfHzpo7cGgU90dejs6XYcCvp3rR7UvPMbsQq9N/ptV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbJDRsd5uchZFImXYoMGEWnlYiSfTOpAH7QvNqPJVKqh0tP4ERDB2o0TauXtJlNpNLw5x2ohTXkKZfOcDirAbfFlkX5gl6Pxp2BiDx0+V6zR2L5YNqB7ldC9Io1W8paMZgH2Hf4zveulsG4f3Z5oy7TgLsfmE/bCt0Ftpg5fKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX90WKYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B60C32781;
	Sun, 28 Jul 2024 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128129;
	bh=AfHzpo7cGgU90dejs6XYcCvp3rR7UvPMbsQq9N/ptV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX90WKYYcXdN/hylAYkesqJwUtWxWHX8rIjhT4MgBCLAut6v5rnUBjhVil8oql6/L
	 ceoc9PyCbwBORltqB+/y6cME2hhDP2TuWx6eBH315qmB7CTeC6Iz1TP2ctzaSQoU5h
	 wNkQbnV+/CTbEbISqaLmqnMLYywJlBSmsLecitvrD5p6vOGm7dVCn+m5LidsUXvC9x
	 qcJM0Zm0An1bphTATr7WPHHoYrZaXaL+cEMJvhAO/Hf9oQOBxYh3GGO+sKjVWeSl6q
	 VFLHvi4YiuUFWCbcD7TqxjsJI85JuEypvRlX17w0/n3Lhd99hIP3tx0piWV40wmiDY
	 RgvRIjwkJqlbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/11] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
Date: Sat, 27 Jul 2024 20:55:08 -0400
Message-ID: <20240728005522.1731999-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit fba8334721e266f92079632598e46e5f89082f30 ]

When all the strides in a WQE have been consumed, the WQE is unlinked
from the WQ linked list (mlx5_wq_ll_pop()). For SHAMPO, it is possible
to receive CQEs with 0 consumed strides for the same WQE even after the
WQE is fully consumed and unlinked. This triggers an additional unlink
for the same wqe which corrupts the linked list.

Fix this scenario by accepting 0 sized consumed strides without
unlinking the WQE again.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240603212219.1037656-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 56d1bd22c7c66..97d1cfec4ec03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2146,6 +2146,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
 
+	if (unlikely(!cstrides))
+		return;
+
 	wq  = &rq->mpwqe.wq;
 	wqe = mlx5_wq_ll_get_wqe(wq, wqe_id);
 	mlx5e_free_rx_mpwqe(rq, wi, true);
-- 
2.43.0


