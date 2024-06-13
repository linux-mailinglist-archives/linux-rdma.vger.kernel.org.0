Return-Path: <linux-rdma+bounces-3131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43753907A8C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B6B1F24AD4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA577149E1A;
	Thu, 13 Jun 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX3JUCQR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2FC12CD8F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301710; cv=none; b=j94w58H7bNA3IGbhWopq/n0idZU6Z19pgVE+rqpVrmN6jIJUA9aGrPMGC2Uz9gN1ogLdzGOo4OEp/e4HWIEgQ/zdffTSet1VO/wCdwzMEmEi0uU6/FLs6K/3T08B1FaUM+ipHRR4ls+p+iU2hovuG0R1cN8DdYpq8bDXhuJWTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301710; c=relaxed/simple;
	bh=tkELYc1YnU+l62BgNK7l5hZmQ3rfGQcB74qQxb5G2Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6bVj5P0U6TMBOmRKUwk1Ljnl7WWIktJE8+zfJmcE/2FNZ+mIoKw9cRQ8Dipd4ToRnMSSWUP6rUjrrAIMcpBLqxjunEOJ4NM5G5S/0mS0V9TCio7E6zyxq6znnuRLcXLm8eG1sbgl+mZ2/HqvFfpgCmiM9Ym4+cRAnswvotmVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX3JUCQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96635C2BBFC;
	Thu, 13 Jun 2024 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301710;
	bh=tkELYc1YnU+l62BgNK7l5hZmQ3rfGQcB74qQxb5G2Gg=;
	h=From:To:Cc:Subject:Date:From;
	b=NX3JUCQRHUDrVaI2rSsO9dAgTccItLQhCsinhPyDFj24wHjm9MJ1ISCVUwDBF8Q+L
	 OtS9rlmhdoix47gYjP2P8KyOSLl9rwGLDGWm/KK+MCoXB8r6grnRZvyUl8ua7TnxNm
	 UpZI6wjKN0R3AlJxQYRH8UTpozG7Xc+oxsAojc8sflBglEjKW4OsHjYeQORcC0G2cC
	 nX4F2cMYPQwV08tTcgaOxIYuvS7rO5LVSRnpjo1B0xeiQ/BVvsnqVYxnicjNxfUxuR
	 xisSQhsz1QY8ZqPyNfMmMrhzqm/8kGwKYk9UUll3GyiRXdQJuDnBgIA0G4R2gqgHk6
	 7yDXU43V3OnrQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jianxin Xiong <jianxin.xiong@intel.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE
Date: Thu, 13 Jun 2024 21:01:42 +0300
Message-ID: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Set the mkey for dmabuf at PAGE_SIZE to support any SGL
after a move operation.

ib_umem_find_best_pgsz returns 0 on error, so it is
incorrect to check the returned page_size against PAGE_SIZE

Fixes: 90da7dc8206a ("RDMA/mlx5: Support dma-buf based userspace memory region")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 13 +++++++++++++
 drivers/infiniband/hw/mlx5/odp.c     |  6 ++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index cbcb14d9a42a..bf25ddb17bce 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -115,6 +115,19 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 		__mlx5_bit_sz(typ, page_offset_fld), 0, scale,                 \
 		page_offset_quantized)
 
+static inline unsigned long
+mlx5_umem_dmabuf_find_best_pgsz(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	/*
+	 * mkeys used for dmabuf are fixed at PAGE_SIZE because we must be able
+	 * to hold any sgl after a move operation. Ideally the mkc page size
+	 * could be changed at runtime to be optimal, but right now the driver
+	 * cannot do that.
+	 */
+	return ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
+				      umem_dmabuf->umem.iova);
+}
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4a04cbc5b78a..a524181f34df 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -705,10 +705,8 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		return err;
 	}
 
-	page_size = mlx5_umem_find_best_pgsz(&umem_dmabuf->umem, mkc,
-					     log_page_size, 0,
-					     umem_dmabuf->umem.iova);
-	if (unlikely(page_size < PAGE_SIZE)) {
+	page_size = mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf);
+	if (!page_size) {
 		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 		err = -EINVAL;
 	} else {
-- 
2.45.2


