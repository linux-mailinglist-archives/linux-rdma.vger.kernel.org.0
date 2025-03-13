Return-Path: <linux-rdma+bounces-8676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A2A5F862
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D33AC267
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB33A2686B0;
	Thu, 13 Mar 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGljmnIM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3A26A091
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876237; cv=none; b=RBAcOM5rZP0Zn0bArFXi+wCpYlh9xlnnDB9WJ4If0yDq6ub4IDfMDcOAy5wAcsihzcpTyx5oIP7fBd4u48kl504X3Egbsm8SnlDKGpCQMFO9MMrpUB27zQuLNGZe/e99zNVdYiGCYwpkPSCzEMyV7ynXduHdn+D9DBZh5Y9LFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876237; c=relaxed/simple;
	bh=IgViAL1463cLW4mZQ6jW+ZmXpEuXhtBUQZexRSXrM3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WugOmPDKR83uHE7xmA+VT+LDf9HU4VRfuPF7vq6AKlfNxIYHK8n/r2UX7pIaWN3ptOncK1O2Y1NqclPWh3SJ+SxmZknG5h6fbugm2jjcaTFWqIgi1uQfx1B4TJOIC5O5nQw7GA3LJiUagmRnoHmeKplhkpkB0kBYK3M3eq091RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGljmnIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C6C4CEE5;
	Thu, 13 Mar 2025 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876236;
	bh=IgViAL1463cLW4mZQ6jW+ZmXpEuXhtBUQZexRSXrM3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGljmnIMuQvdOL4o0s50vIYVFSwaq/jo9+GFbRER3Yo1V7B+3UdEjY6l6CXA2uSuY
	 wnQRpvYRM5e7QqKdTvtXbnR3swtOp2d0pSue/8+FaF9I/LSthXVassxsI8vfgyE5au
	 b2fahbBoBZ4Da3mSMM+b2x+L6oP7byvDIyqg59xYtwMKJ+wmY/bXh6crRWPXmiSO2t
	 jqq99e44w2VX8tqHyHbzkTnfvKJlYJ7lwNGgeHa5mURhs/Vv6AAACq4l7faba+o7hL
	 RJ41J/SKcxl122pp3BVvSbAtmPItebUZQU85Mbu3YZYoYDJA12JFaRkWXWMOBpm0G6
	 CZGEsco2XObeg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Align cap check of mkc page size to device specification
Date: Thu, 13 Mar 2025 16:29:52 +0200
Message-ID: <0fd33ea9d5f22c9c026285ed3e7cf7a19466738c.1741875692.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875692.git.leon@kernel.org>
References: <cover.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Align the caps checked when using the log_page_size 6th bit in the mkey
context to the PRM definition. The upper and lower bounds are set by
max/min caps and modifying of the 6th bit by UMR is allowed only when a
specific UMR cap is set.
Current implementation falsely assumes all page sizes up-to 2^63 are
supported when the UMR cap is set. In case the upper bound cap is lower
than 63, this might result a FW syndrome on mkey creation.

Previous cap enforcement is still correct for all current HW, FW and
driver combinations. However, this patch aligns the code to be spec
compliant in the general case.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ace2df3e1d9f..a6ef052c4344 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1753,10 +1753,25 @@ static __always_inline unsigned long
 mlx5_umem_mkc_find_best_pgsz(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			     u64 iova)
 {
-	int page_size_bits =
-		MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : 5;
-	unsigned long bitmap =
-		__mlx5_log_page_size_to_bitmap(page_size_bits, 0);
+	unsigned int max_log_size, max_log_size_cap, min_log_size;
+	unsigned long bitmap;
+
+	max_log_size_cap =
+		MLX5_CAP_GEN_2(dev->mdev, max_mkey_log_entity_size_mtt) ?
+			MLX5_CAP_GEN_2(dev->mdev,
+				       max_mkey_log_entity_size_mtt) :
+			31;
+
+	max_log_size = MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ?
+			       max_log_size_cap :
+			       min(max_log_size_cap, 31);
+
+	min_log_size =
+		MLX5_CAP_GEN_2(dev->mdev, log_min_mkey_entity_size) ?
+			MLX5_CAP_GEN_2(dev->mdev, log_min_mkey_entity_size) :
+			MLX5_ADAPTER_PAGE_SHIFT;
+
+	bitmap = GENMASK_ULL(max_log_size, min_log_size);
 
 	return ib_umem_find_best_pgsz(umem, bitmap, iova);
 }
-- 
2.48.1


