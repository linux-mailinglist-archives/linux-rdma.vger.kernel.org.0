Return-Path: <linux-rdma+bounces-5223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02A990B6F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE161F22A26
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D2A1DD52A;
	Fri,  4 Oct 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyuCry2R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B71DD520;
	Fri,  4 Oct 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065982; cv=none; b=ui/gHOoSomlwHRjhjmsIqLfmW8by4XAiryNXuOd/v4QnZONrk9sxXRmki4tRK44c/45j7g86EzZ3VFh7Qs0eFf4fYxiEIgiB0H8RBjKZ0nF9u2EQdqX5LG+5ERZj9ZeWFOq2MqwidUxNGIrm2LPwOBrY/qlcYBFv4P4vFdetimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065982; c=relaxed/simple;
	bh=wWAM6pbEa+F6NoXD2vTaZhKqg/mJC29kUtzDx1IdrFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOtldq906xvsOb7Zpq4GPYqspQ56eubQY40WYYcNRYxEOEPdouP/feM7dM6N5TtaTssNBRgiMXmtm27FnPgZeOJYuJu5bXmPxRJ/Q8+UV0e3Yev1BWL6nfnCTi1DHp5v3yDigddrlXxMbupzJ1N6UmxJqxwqjQFUfX0uXZy1bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyuCry2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A2C4CEC6;
	Fri,  4 Oct 2024 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065982;
	bh=wWAM6pbEa+F6NoXD2vTaZhKqg/mJC29kUtzDx1IdrFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyuCry2R3Zthpsdn6iWAA+NvR81X/Zd+rpZEfsrMgz5yoGR4+QEPWuvBzreN2joW2
	 lXpAGxXjFojsgRcXZqyvnh/wl7TgxzSSZOkH7FyL0T54+1AGe6yOVC1jxvTBdhFYnh
	 DDKqKbdOFDyqD33GXhKksWML+eaxHoBw5d/1X0A2WmIIVrIG4l0nces+5xJliXQsXB
	 e9cyFCmnnJFCsARaivGwVmIFXZJsBPmX06HbnKfJV2wX4PlA3DmyIrY7J2MWgTSwms
	 skkXl/JT6jfcA8Vq1ItR9qshnrFWh/ttzf7+v98kOrSQkMf/GwQrpz2DssI4aIRQ02
	 Es5hEGlwL7/9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 39/76] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
Date: Fri,  4 Oct 2024 14:16:56 -0400
Message-ID: <20241004181828.3669209-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


