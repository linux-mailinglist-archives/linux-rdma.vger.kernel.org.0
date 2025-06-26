Return-Path: <linux-rdma+bounces-11690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7DAEA5F6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E971720AC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724162EF649;
	Thu, 26 Jun 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQMWaPea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310752EF298
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964321; cv=none; b=DpEwrhifjQ9seTn1FLHu7wApFFajup9zYBPpVBebiTndlqm4BYN/TsP+xe/DYjrN/GbwZRFIXaNmGAOb8OKau2BWC1cW+4smG5xV5BUJU0KpmHY3QPSVuiG6jd5Hnk/5yM49Fuv5ekcM7PZxW8JdWWb88ZJLsRN/l6O5Siaz2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964321; c=relaxed/simple;
	bh=GPDKejWJdhQVqsjWyNOfAkqLNpQ+OUIIT/EeqIjjwQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q76AYUhPvG7JL836qh7HXrSH35PuS2bcWK+FdwLLogAcKE2l7X3YU5A8P/AYvrLZuK0BkzNw3PlaKVPttqwN9r4essbh5Pz7yGvcAwe/XBUDH0ef84IwM+DZWVfI1rpmnUMbKjnDpJzj6QVYnZ/om31FWvBmTAlKGRr8zQ5+zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQMWaPea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A4C4CEEB;
	Thu, 26 Jun 2025 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964320;
	bh=GPDKejWJdhQVqsjWyNOfAkqLNpQ+OUIIT/EeqIjjwQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQMWaPealMIukwD1h8D+sjPimhy76KR1TrEQkmb1yWq1Fl3EGTX0DYg7WwC3byiLW
	 qSDsB+yHuPc7iSQRxofYCD6K/7wFrjnMiqf2Faozgamzb67IgehlC5pQc9UvSbhrUt
	 yAoKM0nFEF8+K/cljIEcg4sHdjpE/062vjESM7nkD/dDk+4Oi2OiA2w0Hc+c/oe3nI
	 RHR9ICmhvkaTB8zjWvsIWs60Zb+pX/pGDQsuN+AACt+AkpC5wSdZPru7kgla02BBqz
	 mY42CAoBbZa+mOeIh8gmcB65WyJAbJx/9E47I/2MfQ/MUhMGgnQEBxkeBEW+GY9Mg1
	 5zTpMKhLq63kA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 3/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
Date: Thu, 26 Jun 2025 21:58:06 +0300
Message-ID: <c2376ca75e7658e2cbd1f619cf28fbe98c906419.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using Podman, it fails to create
the anchor.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 0c6ab0ca9a66 ("RDMA/mlx5: Expose steering anchor to userspace")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 58e058c067d3..bab2f58240c9 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2990,7 +2990,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 	u32 ft_id;
 	int err;
 
-	if (!capable(CAP_NET_RAW))
+	if (!rdma_dev_has_raw_cap(&dev->ib_dev))
 		return -EPERM;
 
 	err = uverbs_get_const(&ib_uapi_ft_type, attrs,
-- 
2.49.0


