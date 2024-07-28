Return-Path: <linux-rdma+bounces-4034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748493E2CC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 03:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2ECCB2134E
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 01:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DE194C9E;
	Sun, 28 Jul 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqMOX9KW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55593194ADE;
	Sun, 28 Jul 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128091; cv=none; b=En3o1ZmV4kneb3uxuEcSySRZmKnCXhvzFurcbD2/ajlmmX4ATQCiSK3o0EotpS8phct/P1vTFTa86nR7Dn5L7qYCfzvgUbXhN7DNBrDAmlYi4sycKXe3VTk9GH5yrOcL8bo60kuUWwJPW8iowf+tyEslAB22f4w2RNUh9bMAJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128091; c=relaxed/simple;
	bh=Gd923LaDh7TxUFQuQq3G5OAX4Im5g0smbajmP5Z4ykk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u926lVdvrSr1YHFeosB9zjk0UC34Pe0N6BHPB93V8aqTFvfBkCaaob2oTWBL6VYkKYogNJR75XOkipdtIR1byTeT1XARuq7Wf2p01rWIZGRbeomSAw7MEvE11THxPog8TPYQ8rbxGxQ9snNFjRWwyZBjQyp1XQFDQ3TEInXMrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqMOX9KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7B7C4AF09;
	Sun, 28 Jul 2024 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128091;
	bh=Gd923LaDh7TxUFQuQq3G5OAX4Im5g0smbajmP5Z4ykk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqMOX9KW4rCimrGBjpNqIZOGSW0cYqfoKA1SB9dkQ9K8xTLF3rDkKzpqcR0ixVKe6
	 TYQY8AIRVo/6ifmmq4TkuiSOjLvneT35h1YguBjkUSvqSVEIHWlmFxPOV4NNh/+cld
	 MoPtM3qPi0oOFQSmeXO1ieYzhQF91vTAHUfL8GBIh6I0HAHbjAy30I08vtZ7CxprTH
	 8bUuaAkcSbTO0YTZ4PG4HcKCM9q5P6CoMSFIElnDIoR3OaM1mZTnKnM0iEcORg/kg3
	 OxqmvJbfzBxW8ABfRXbqrmPuO9hp4SCIOIMKX9ngsg4FxjvUTaY1+qrmXrEIvFjMP1
	 /3oDkU8gkjNUg==
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
Subject: [PATCH AUTOSEL 6.6 04/15] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
Date: Sat, 27 Jul 2024 20:54:25 -0400
Message-ID: <20240728005442.1729384-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 8d9743a5e42c7..79ec6fcc9e259 100644
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


