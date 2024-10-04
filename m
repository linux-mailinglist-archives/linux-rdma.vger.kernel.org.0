Return-Path: <linux-rdma+bounces-5232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE238990E36
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF6B2AC1C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D421265E;
	Fri,  4 Oct 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb4oFKOD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CD212653;
	Fri,  4 Oct 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066481; cv=none; b=rfMazOLMdA1sjZdsUAbYXb5SsU0Q5tPf7nQHq9oiGESUG4fJ7m3hpkrBWWYJnhhk2Deva5LHuZfwCmK7KPEuPvn3h1ePD92S9IPrEjW/ToBIpmmTwBh/93t4PstHqbnxUoHFx5ppPk85nl0Or1kxUV36Tk4ytMac8szVUsKb9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066481; c=relaxed/simple;
	bh=lSceGbSZok+ff+XHPgvVYT2+P10Qduot0oQscGawOgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRntq/DUXVBqCGrBjJo/lNteDgUYpIW4xsKMkwYaGOU6XYaZ0WSxnHIf17Io89pcOz0dnVtquwBkXO2py1+xZaFa71YUx80yBX7/bi6pEevFsJOn5NVG6e8ysbRRoGpqVabZHUW6OU40/XmEEriiSTp/T5IEzqbF1czFuSHyJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb4oFKOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EC6C4CECD;
	Fri,  4 Oct 2024 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066481;
	bh=lSceGbSZok+ff+XHPgvVYT2+P10Qduot0oQscGawOgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eb4oFKODE+eu8tknmGFVw9SP+tD5eODx/XJJCTnNIvvDkiRHUjYQWROl41J2AbCXg
	 d8mEreNPo0x5SKjBd65xHqW3GLmIRaPPgZG2mvOVuKSH/0yPEFA8IJBMQq9ES7u36Q
	 zuvsuyI/4LimAVwZTVMFcStkDCeatypsgTVOL2krGDHFuyRimUn9svIrY6v4/tjFC8
	 Rfvv10RDKx3c28pyiERBnaBDbDvPq7EYo5APaIWW4kcu4McF3I6HT7QlU2OOFb7wzF
	 PC8PNSfvITSvtCLMcAIio0bCIZZu09TTubhezDVyM0BlEhXhmMcLX586P/CQ0JpGfQ
	 ZwZQ5iUZG8hHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/42] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
Date: Fri,  4 Oct 2024 14:26:35 -0400
Message-ID: <20241004182718.3673735-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index af73c5ebe6ac5..d3cada2ae5a5b 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -734,24 +734,31 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
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
@@ -858,7 +865,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0);
+		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0, false);
 		if (ret < 0)
 			goto end;
 
@@ -1724,7 +1731,7 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 	for (i = 0; i < work->num_sge; ++i) {
 		ret = pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
 				   work->frags[i].length, &bytes_mapped,
-				   work->pf_flags);
+				   work->pf_flags, false);
 		if (ret <= 0)
 			continue;
 		mlx5_update_odp_stats(work->frags[i].mr, prefetch, ret);
@@ -1775,7 +1782,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
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


