Return-Path: <linux-rdma+bounces-15287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FFCF10AB
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4917A30388A9
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8752D97AA;
	Sun,  4 Jan 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWX5g01G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D4274B42;
	Sun,  4 Jan 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534722; cv=none; b=ck6N4a5ngPakEItb1PqKL1+qHmlcO7hcHvp5JGB3IfvYeIyiWkN+9rM6SEv3kOixKDxB6C2I+do9ib6TG2EuYF0pnhxZAtNQMOLfSNOlp9J5KLsP4YQaCYqcfZlyL1BIJe5IBtq+dMlDEz6D1CSCTcRB3wz9/jLAgNxEi5HmRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534722; c=relaxed/simple;
	bh=08SYnLgqHKSF/4Y/EkzfgqxzPfpsQUrQNyDNPrDhd9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT2U6BWqP5LDBmPp4Uci4w1n6xN/MrqWvBCPLrMdv8IWVTeKOCXCYjupYMwvCU7mJHA4j4OrfWaX8RcHgL9jCcTPVG4nlg5lyO+vJQ+2XXiijetqoiI26ENShSlEuw2MnQaEt+JTbT5JwFGtnL5LetilOHoDdmXk4/HK1sjnvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWX5g01G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E25C19423;
	Sun,  4 Jan 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534721;
	bh=08SYnLgqHKSF/4Y/EkzfgqxzPfpsQUrQNyDNPrDhd9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWX5g01GzZsZeTb4mzKUQknxgOFFfsmbOsnkfXfhiJCuG+uPsGrRvTSbcEt87TGnz
	 0Q4KESys5m8DQvWCPZXDY9gKTweR5+oY+8eUVEN7hAL1byODTTO/Vdb3DjC+ac92B8
	 9f2UAVW4aFnvYQDKH1oy6CXxfq9VglpEPwWmQYeoQydVzuGMvTFXgSPc5L75JvFooG
	 z2VKEJgcXHU3WE6jy0T9LYXza4Cr8FuOG1ctxUmAM046Xw7wiZvKfTI2i6YYnKeQTn
	 Hofxt9ObHeXWf7mH542LmEVIUhzSjFOayrB0HeS/F0ewZaOfHoyGsp7IHOJFmpCO8s
	 NvcdjjLdLp1hw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 4/6] RDMA/mlx5: Avoid direct access to DMA device pointer
Date: Sun,  4 Jan 2026 15:51:36 +0200
Message-ID: <20260104-ib-core-misc-v1-4-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The dma_device field is marked as internal and must not be accessed by
drivers or ULPs. Remove all direct mlx5 references to this field.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 325fa04cbe8a..a7b37e3df072 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1646,10 +1646,13 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 						 offset, length, fd,
 						 access_flags,
 						 &mlx5_ib_dmabuf_attach_ops);
-	else
+	else if (dma_device)
 		umem_dmabuf = ib_umem_dmabuf_get_pinned_with_dma_device(&dev->ib_dev,
 				dma_device, offset, length,
 				fd, access_flags);
+	else
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(
+			&dev->ib_dev, offset, length, fd, access_flags);
 
 	if (IS_ERR(umem_dmabuf)) {
 		mlx5_ib_dbg(dev, "umem_dmabuf get failed (%pe)\n", umem_dmabuf);
@@ -1782,10 +1785,8 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 		return reg_user_mr_dmabuf_by_data_direct(pd, offset, length, virt_addr,
 							 fd, access_flags);
 
-	return reg_user_mr_dmabuf(pd, pd->device->dma_device,
-				  offset, length, virt_addr,
-				  fd, access_flags, MLX5_MKC_ACCESS_MODE_MTT,
-				  dmah);
+	return reg_user_mr_dmabuf(pd, NULL, offset, length, virt_addr, fd,
+				  access_flags, MLX5_MKC_ACCESS_MODE_MTT, dmah);
 }
 
 /*

-- 
2.52.0


