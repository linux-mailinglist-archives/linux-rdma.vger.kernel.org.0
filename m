Return-Path: <linux-rdma+bounces-15285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58746CF1096
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45AC330010C3
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4830E847;
	Sun,  4 Jan 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyQdDSyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68930E831;
	Sun,  4 Jan 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534714; cv=none; b=kC0q0w1pY2D4+cW118iVfDtIpdxB8AGLSFmWtmEOxbOWcvKErA45HP3L4zmvcNULNT7DnaDiNPqxZnkIKPpItKcPQ3NDzB6RTBgCeQ+1KpwwqZT7HeraW5/vZH3dx2TIpbpagAo3VQ/PcGrqT565OFWsQ5X2DK4ZQDHWLB8gQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534714; c=relaxed/simple;
	bh=EeZQUbk7mszSUq49dnmxH/p0FndUizzKMzIynzr0iz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRN9a4Ul5U/m9u5PSqA/hx0eV6pcRkOv65l48SM2LDblUpT6ekvys8GqXuX1EEQG53Do9mXvvjBisLtnPCiziyfoOkDBprLYrS+hNNOzr7MPO4hYQXbk4arxjAW2Ef6c7ctKxGdhSpV2+lhLk6MxETysY9VKsjHmlBcdF73BUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyQdDSyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D8AC19422;
	Sun,  4 Jan 2026 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534713;
	bh=EeZQUbk7mszSUq49dnmxH/p0FndUizzKMzIynzr0iz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyQdDSyuC1YAO481SXcqr5pC/JPW/Cw1nrI/C3LjcRoHz03+y7DIXPhkBhB5c2VIz
	 74an+Et9bXf3miz1DiCL/YiTgLWXG++tAZV7C9stH/qdOLXeFdpPFTy0zGZJ8zKSgJ
	 HJwqNliVR/P1ltwrHhQ7UADD4/xVN04IaW07eL4DCrTQ/bGQzrUieS+wsp2TQWPvjL
	 UzzH/j2BLxd+YNlRvn+4KmrVdhlLhoaI82f1C53YzJCzRcPbpNuYzxQP4OtxpnwDcA
	 2xHxjWivrcyVmEqFhmSsfd1l2KVqi4cO/b3AE4gyeR/jNRis4KhXrjOpf/V++bB48W
	 D29zNnHeeHpUA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/6] RDMA/umem: Remove redundant DMABUF ops check
Date: Sun,  4 Jan 2026 15:51:33 +0200
Message-ID: <20260104-ib-core-misc-v1-1-00367f77f3a8@nvidia.com>
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

ib_umem_dmabuf_get_with_dma_device() is an in-kernel function and does
not require a defensive check for the .move_notify callback. All current
callers guarantee that this callback is always present.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 0ec2e4120cc9..939da49b0dcc 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -129,9 +129,6 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
 	if (check_add_overflow(offset, (unsigned long)size, &end))
 		return ret;
 
-	if (unlikely(!ops || !ops->move_notify))
-		return ret;
-
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);

-- 
2.52.0


