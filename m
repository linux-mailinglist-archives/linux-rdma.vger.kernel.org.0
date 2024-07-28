Return-Path: <linux-rdma+bounces-4033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C693E276
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 03:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3269280E85
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 01:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C974E09;
	Sun, 28 Jul 2024 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fviJlMum"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88E7406F;
	Sun, 28 Jul 2024 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128021; cv=none; b=iNGQrZoLCX+s8uOY23JVAVGolB7wdqWPvZq2pKZL6wJQ4oyn01LgyvxY+2rMBXgZQxED89EW6RxAM4bY6xyl/kvYHUPCkbFQL5yBM2uK39qYIoR8uGQ1I3yuvH4d4+9ZjcfdXhgxziMFbSflp9NbsLlu9JWpY75nMH6fONci+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128021; c=relaxed/simple;
	bh=gCUdydaAj5yyKiGTZ3hoMjlwP9QJfPPtJ+FOFS9yk68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr0SB2weWArJHLJdD7c8njEfhLlSIu2A8URw9bdB+DlWzLXO3d2HMsTcydAnwUtM3MPi83otOmdlvqMk6YXKa9uQXmZq+Wk3GivX46PYazwa0NO0WeA1MB4zckM7jEUPnrZ86+T+pfIwANAf4Ik2+bbVgE39KlGthMeeYjDQfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fviJlMum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAACC32781;
	Sun, 28 Jul 2024 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128021;
	bh=gCUdydaAj5yyKiGTZ3hoMjlwP9QJfPPtJ+FOFS9yk68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fviJlMum1ISDBCUVpX0ed5gqMwDnSwiwxXI5Gyi5tlnbeeyzQWDAng8EIWGTVkR2B
	 YgqSTzlXjBZ7XxnsP4EhPLP1b2aoR5blzlf3etFmiCaIyl326HqDcRJGAIkbIxpG0p
	 NkYX45xKf8Qj3FaFm0VT7UaTYDBZLidiELVwZ+kxzpWRzAjteB1eGqhiQRMWjPFtG3
	 EvmUt8Ze3MdcYd/9nm0spr/8vgDhzcOMXIYTg32bpMG/ek/gwNkkF0sF7wHJs8DJ/4
	 ok7IO0Ql0E7ALtafZ82wMC5RMfkIMpXTQhiegKsESTehD5PDeYxYcdOWSU17FgLu7/
	 xHpNf/u6+wbyg==
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
Subject: [PATCH AUTOSEL 6.10 06/27] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
Date: Sat, 27 Jul 2024 20:52:49 -0400
Message-ID: <20240728005329.1723272-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index b5333da20e8a7..cdc84a27a04ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2374,6 +2374,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
 
+	if (unlikely(!cstrides))
+		return;
+
 	wq  = &rq->mpwqe.wq;
 	wqe = mlx5_wq_ll_get_wqe(wq, wqe_id);
 	mlx5_wq_ll_pop(wq, cqe->wqe_id, &wqe->next.next_wqe_index);
-- 
2.43.0


