Return-Path: <linux-rdma+bounces-5229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01934990D3C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7442281105
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0202207202;
	Fri,  4 Oct 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug2liVRr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E022071F9;
	Fri,  4 Oct 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066362; cv=none; b=ZMbMOPWLxzzrfKXC/PEcim+yxwPRUNsqJTLFCnpx/zIaxVLWcVuffMAb7hlB7Pylu2dcQnt+THNcu9v7M5DrNE23bDjPGLB509b6R0OevVG6mvOF5E+4Uy3CsvDnkta8aqMEKDwz5Q+/M4nPh8T6TdAZTJIq+2DZLq4EPkAyt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066362; c=relaxed/simple;
	bh=wWAM6pbEa+F6NoXD2vTaZhKqg/mJC29kUtzDx1IdrFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWZil15nrY2P1LforR4uIuuvNo/WSnNEXMYNiB/k8tWPARNxcsYaw/rtduM9qc8UBzeOACENiQ6eHhMwGDCC6syJS2dyAPy/lHOuCgetTqBnVl4dX3+pIevAqKH65YzJQhOpQ1VmAW5OeLQEjGSoROtWe4qYPOu5gMWNdArxDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug2liVRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488BFC4CEC6;
	Fri,  4 Oct 2024 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066362;
	bh=wWAM6pbEa+F6NoXD2vTaZhKqg/mJC29kUtzDx1IdrFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ug2liVRrpfW18dJj8P8MdcpQmwXS39lS59BKNCG89tCrEicSjJFR1jYYdluk7kwa3
	 5tcrDvzrefQ1W4yzCQREHLYUur8V9mgOnQSm4/RcVLcphz28Y6jv77g6FqnFiSLd3k
	 uFU0A4Ke87LQcFNarD6tVT8op7hdO8aYhLPrDcwjwqLtDmJgcVEWXFmkJjCOV1edko
	 zFoY10Dx90FGGypXi2TyiOCOxgOObvnNJcYgihok0C6jNsy+Lt8ZAcq2H6mQ2eU9ru
	 36MA7pEJd6/mqS78QJY79xUkzs7Cx25M3QCigCTZ4QktJQvXOGo03mMdm2n8a2Q5Ob
	 BsQoJ+gWpxKtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/58] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
Date: Fri,  4 Oct 2024 14:24:06 -0400
Message-ID: <20241004182503.3672477-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

[ Upstream commit 8c6d097d830f779fc1725fbaa1314f20a7a07b4b ]

The new memory scheme page faults are requesting the driver to fetch
additinal pages to the faulted memory access.
This is done in order to prefetch pages before and after the area that
got the page fault, assuming this will reduce the total amount of page
faults.

The driver should ensure it handles only the pages that are within the
umem range.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://patch.msgid.link/20240909100504.29797-5-michaelgur@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index a524181f34df9..3a4605fda6d57 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -733,24 +733,31 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
  *  >0: Number of pages mapped
  */
 static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
-			u32 *bytes_mapped, u32 flags)
+			u32 *bytes_mapped, u32 flags, bool permissive_fault)
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
 
-	if (unlikely(io_virt < mr->ibmr.iova))
+	if (unlikely(io_virt < mr->ibmr.iova) && !permissive_fault)
 		return -EFAULT;
 
 	if (mr->umem->is_dmabuf)
 		return pagefault_dmabuf_mr(mr, bcnt, bytes_mapped, flags);
 
 	if (!odp->is_implicit_odp) {
+		u64 offset = io_virt < mr->ibmr.iova ? 0 : io_virt - mr->ibmr.iova;
 		u64 user_va;
 
-		if (check_add_overflow(io_virt - mr->ibmr.iova,
-				       (u64)odp->umem.address, &user_va))
+		if (check_add_overflow(offset, (u64)odp->umem.address,
+				       &user_va))
 			return -EFAULT;
-		if (unlikely(user_va >= ib_umem_end(odp) ||
-			     ib_umem_end(odp) - user_va < bcnt))
+
+		if (permissive_fault) {
+			if (user_va < ib_umem_start(odp))
+				user_va = ib_umem_start(odp);
+			if ((user_va + bcnt) > ib_umem_end(odp))
+				bcnt = ib_umem_end(odp) - user_va;
+		} else if (unlikely(user_va >= ib_umem_end(odp) ||
+				    ib_umem_end(odp) - user_va < bcnt))
 			return -EFAULT;
 		return pagefault_real_mr(mr, odp, user_va, bcnt, bytes_mapped,
 					 flags);
@@ -857,7 +864,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0);
+		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0, false);
 		if (ret < 0)
 			goto end;
 
@@ -1710,7 +1717,7 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 	for (i = 0; i < work->num_sge; ++i) {
 		ret = pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
 				   work->frags[i].length, &bytes_mapped,
-				   work->pf_flags);
+				   work->pf_flags, false);
 		if (ret <= 0)
 			continue;
 		mlx5_update_odp_stats(work->frags[i].mr, prefetch, ret);
@@ -1761,7 +1768,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 		if (IS_ERR(mr))
 			return PTR_ERR(mr);
 		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
-				   &bytes_mapped, pf_flags);
+				   &bytes_mapped, pf_flags, false);
 		if (ret < 0) {
 			mlx5r_deref_odp_mkey(&mr->mmkey);
 			return ret;
-- 
2.43.0


