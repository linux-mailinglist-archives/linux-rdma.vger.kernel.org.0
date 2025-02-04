Return-Path: <linux-rdma+bounces-7384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E50CA26A60
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 03:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A167A3074
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220F14B094;
	Tue,  4 Feb 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIAInkUL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5F25A634;
	Tue,  4 Feb 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637870; cv=none; b=sHgulA2r+FIinQpgdULOKAL73XIbphZ2jfUfLeMksvvWRvwUATlGN53/Ty5SUTParhuvjnt0vuzwlan7xZSdhu79iySV/SWUpJDFJ2ohTb3PSZi1rHQlxB2xLqbZUfps2sb6XGyEj8YflQ5t767p7ETY+eEQTNlIURAhEYVJnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637870; c=relaxed/simple;
	bh=CszYs/LJUcQ5jw0qlgHashLCbJKeipVq4nzLbBwNyjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NgJhY1tr5dM159JojGI+xSBnk4Q7EUhjPIkVxFK/75hvqCmmwBh3vD/YsIgtxtbgdExbsUuEmvDBZHB7d6ghlyuW9xoUpTr8mdRqgYorfdi0g2d7nlqzukatz/8uTTEPimP80IdaAuotzXvXf/uazu1kXfnswbH6L7pk0Es6pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIAInkUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02FC4CEE0;
	Tue,  4 Feb 2025 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637869;
	bh=CszYs/LJUcQ5jw0qlgHashLCbJKeipVq4nzLbBwNyjI=;
	h=Date:From:To:Cc:Subject:From;
	b=uIAInkULcB4ZqT8id7Ve+pfC1Pl5mWRvTOFpU49bVYCyvw92i2y0379QVAUT0Sm8W
	 mqi5FMzB+qCUC3cI1ETkFuXT+wlTxPqXFrv0t8+JphZBkAoQkkNQ7QZ9yBqauo00Ee
	 cFXzvjl1YfcOH/NQxIeR9TBuvvu2WgJpVwRlFzaleJfJEnQzoI3WEWecNQTjVH2/+7
	 7AfmCxBQxA81E9e+0+QXdbmmZ3Y0rSw6ij45vxOGn4yFUyrUjJ6v3PhwSxCqWQj3wq
	 p7myqBrCs8t8xYNA1mwCrccLMkGhk2XIh3YdwiAwl3Iwsm326k4lDpvNGxgnSVwH13
	 c9uqJkQNKTtnA==
Date: Tue, 4 Feb 2025 13:27:41 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6GCJY8G9EzASrwQ@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `struct_group_tagged()` helper
to create a new tagged `struct mlx5e_umr_wqe_hdr`. This structure
groups together all the members of the flexible `struct mlx5e_umr_wqe`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct mlx5e_umr_wqe` to `struct mlx5e_umr_wqe_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct mlx5e_umr_wqe_hdr` as
a completely separate structure, thus preventing having to maintain two
independent but basically identical structures, closing the door to
potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

So, with these changes, fix 124 of the following warnings:

drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 13 +++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..c30c64eb346f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -233,15 +233,20 @@ struct mlx5e_rx_wqe_cyc {
 };
 
 struct mlx5e_umr_wqe {
-	struct mlx5_wqe_ctrl_seg       ctrl;
-	struct mlx5_wqe_umr_ctrl_seg   uctrl;
-	struct mlx5_mkey_seg           mkc;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(mlx5e_umr_wqe_hdr, hdr,
+		struct mlx5_wqe_ctrl_seg       ctrl;
+		struct mlx5_wqe_umr_ctrl_seg   uctrl;
+		struct mlx5_mkey_seg           mkc;
+	);
 	union {
 		DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
 		DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
 		DECLARE_FLEX_ARRAY(struct mlx5_ksm, inline_ksms);
 	};
 };
+static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 enum mlx5e_priv_flag {
 	MLX5E_PFLAG_RX_CQE_BASED_MODER,
@@ -660,7 +665,7 @@ struct mlx5e_rq {
 		} wqe;
 		struct {
 			struct mlx5_wq_ll      wq;
-			struct mlx5e_umr_wqe   umr_wqe;
+			struct mlx5e_umr_wqe_hdr umr_wqe;
 			struct mlx5e_mpw_info *info;
 			mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
 			__be32                 umr_mkey_be;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bd41b75d246e..4ff4ff2342cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -373,6 +373,8 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 {
+	struct mlx5e_umr_wqe *umr_wqe =
+		container_of(&rq->mpwqe.umr_wqe, struct mlx5e_umr_wqe, hdr);
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
 	size_t alloc_size;
 
@@ -393,7 +395,7 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 		bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 	}
 
-	mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
+	mlx5e_build_umr_wqe(rq, rq->icosq, umr_wqe);
 
 	return 0;
 }
-- 
2.43.0


