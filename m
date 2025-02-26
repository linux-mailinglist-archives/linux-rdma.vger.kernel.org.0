Return-Path: <linux-rdma+bounces-8102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49EA453AE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 04:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09DB173364
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0AF21D58E;
	Wed, 26 Feb 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMWAAffn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74321CFF0;
	Wed, 26 Feb 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539160; cv=none; b=QZJhiUyjIMUfV9uDdWi0EmEgOPTN8Si9Qmfg6Rc+jQk8/f0cdx44ImoeOvOXlYemAPtkOFH95XMxSJoN1I9WNplsshx+/9uMxS7tps5VxpqpcgTIVxvAMMpaeB0vqCse3czmFNUpwkw/F3UaYNh0HE1+EpDnWgKi0VwIlK8KQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539160; c=relaxed/simple;
	bh=sAnrnDiqmmu+twpkvTp+YjYokbJnVI5dUkatxEoUo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hU+bnihDzYDmhP9kVzHvQv+VAbbV+pg7/0qOF+Cu6eoD+0VNCfRAg5I1H1iqScUahGwrDZZnkT3gYbaEhCkRNbgq6KYZu+tUb1RVmzeezEv8q77gNpUiik8byh7aKm1CF+P99R+z/lq0SzIrbagYfc6p1ikXIRZTv3geP2Qirl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMWAAffn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E367C4CEDD;
	Wed, 26 Feb 2025 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539159;
	bh=sAnrnDiqmmu+twpkvTp+YjYokbJnVI5dUkatxEoUo9M=;
	h=Date:From:To:Cc:Subject:From;
	b=XMWAAffn44d+2aX37Gv1Mu6kkrLyK40ELF84IaSsXnprQ46w1YXInkYDQ90Mnh7kC
	 pbuRGMHyV1OvqymVByHl/Hu2WkxdbNYjx8t08I0LYjg6BlI+2Ki+nXer/XSEe4R4KQ
	 amUK5CJREoXEURGUDUbJf9ch/u1KU9oztPaioavpaH+Y/URzAP0DRHDRNxKEk6Pa7n
	 9w9tUGN745RCOPHkfIz0i96kAyZ7IVnfsWMmOoGdqcJoRFgcYlxditBdpe8jZCpSWU
	 QizghxL7zUWoVbNz4UGDUcF5MDUUFvk80epiqyihAh4MrEFq7O4UGCWvfspN5SWHf+
	 YqgMzuDiVgwBQ==
Date: Wed, 26 Feb 2025 13:35:55 +1030
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
Subject: [PATCH v2][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z76FE8oZO2Ssuj9T@kspp>
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

So, in this particular case, we create a new `struct mlx5e_umr_wqe_hdr`
to enclose the header part of flexible structure `struct mlx5e_umr_wqe`.
This is, all the members except the flexible arrays `inline_mtts`,
`inline_klms` and `inline_ksms` in the anonymous union. We then replace
the header part with `struct mlx5e_umr_wqe_hdr hdr;` in `struct
mlx5e_umr_wqe`, and change the type of the object currently causing
trouble `umr_wqe` from `struct mlx5e_umr_wqe` to `struct
mlx5e_umr_wqe_hdr` --this last bit gets rid of the flex-array-in-the-middle
part and avoid the warnings.

Also, no new members should be added to `struct mlx5e_umr_wqe`, instead
any new members must be included in the header structure `struct
mlx5e_umr_wqe_hdr`. To enforce this, we use `static_assert()`, ensuring
that the memory layout of both the flexible structure and the newly
created header struct remain consistent.

The next step is to refactor the rest of the related code accordingly,
which means adding a bunch of `hdr.` wherever needed.

Lastly, we use `container_of()` whenever we need to retrieve a pointer
to the flexible structure `struct mlx5e_umr_wqe`.

So, with these changes, fix 125 of the following warnings:

drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Split the header members of `struct mlx5e_umr_wqe` into a
   separate `struct mlx5e_umr_wqe_hdr`, and refactor the code
   accordingly. (Jakub)
 - Update the changelog text.
 - Also, this part is intentionally left as-is (to keep the assertion
   as close as possible to the flex struct):

| CHECK: Please use a blank line after function/struct/union/enum declarations
| #63: FILE: drivers/net/ethernet/mellanox/mlx5/core/en.h:249:
| };
| +static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z6GCJY8G9EzASrwQ@kspp/

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 10 +++++++--
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  6 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 22 +++++++++----------
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..0e8f4ace8b87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -232,16 +232,22 @@ struct mlx5e_rx_wqe_cyc {
 	DECLARE_FLEX_ARRAY(struct mlx5_wqe_data_seg, data);
 };
 
-struct mlx5e_umr_wqe {
+struct mlx5e_umr_wqe_hdr {
 	struct mlx5_wqe_ctrl_seg       ctrl;
 	struct mlx5_wqe_umr_ctrl_seg   uctrl;
 	struct mlx5_mkey_seg           mkc;
+};
+
+struct mlx5e_umr_wqe {
+	struct mlx5e_umr_wqe_hdr hdr;
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
@@ -660,7 +666,7 @@ struct mlx5e_rq {
 		} wqe;
 		struct {
 			struct mlx5_wq_ll      wq;
-			struct mlx5e_umr_wqe   umr_wqe;
+			struct mlx5e_umr_wqe_hdr umr_wqe;
 			struct mlx5e_mpw_info *info;
 			mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
 			__be32                 umr_mkey_be;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 1b7132fa70de..2b05536d564a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -123,7 +123,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 	wi->consumed_strides = 0;
 
-	umr_wqe->ctrl.opmod_idx_opcode =
+	umr_wqe->hdr.ctrl.opmod_idx_opcode =
 		cpu_to_be32((icosq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) | MLX5_OPCODE_UMR);
 
 	/* Optimized for speed: keep in sync with mlx5e_mpwrq_umr_entry_size. */
@@ -134,7 +134,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		offset = offset * sizeof(struct mlx5_klm) * 2 / MLX5_OCTWORD;
 	else if (unlikely(rq->mpwqe.umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE))
 		offset = offset * sizeof(struct mlx5_ksm) * 4 / MLX5_OCTWORD;
-	umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
+	umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
 
 	icosq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
 		.wqe_type = MLX5E_ICOSQ_WQE_UMR_RX,
@@ -144,7 +144,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 
 	icosq->pc += rq->mpwqe.umr_wqebbs;
 
-	icosq->doorbell_cseg = &umr_wqe->ctrl;
+	icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2fdc86432ac0..9abc6ce13ac9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -311,8 +311,8 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 				       struct mlx5e_icosq *sq,
 				       struct mlx5e_umr_wqe *wqe)
 {
-	struct mlx5_wqe_ctrl_seg      *cseg = &wqe->ctrl;
-	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg      *cseg = &wqe->hdr.ctrl;
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->hdr.uctrl;
 	u16 octowords;
 	u8 ds_cnt;
 
@@ -393,7 +393,9 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 		bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 	}
 
-	mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
+	mlx5e_build_umr_wqe(rq, rq->icosq,
+			    container_of(&rq->mpwqe.umr_wqe,
+					 struct mlx5e_umr_wqe, hdr));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1963bc5adb18..5fd70b4d55be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -631,16 +631,16 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
 			  __be32 key, u16 offset, u16 ksm_len)
 {
 	memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_ksms));
-	umr_wqe->ctrl.opmod_idx_opcode =
+	umr_wqe->hdr.ctrl.opmod_idx_opcode =
 		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
 			     MLX5_OPCODE_UMR);
-	umr_wqe->ctrl.umr_mkey = key;
-	umr_wqe->ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
+	umr_wqe->hdr.ctrl.umr_mkey = key;
+	umr_wqe->hdr.ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
 					    | MLX5E_KSM_UMR_DS_CNT(ksm_len));
-	umr_wqe->uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
-	umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
-	umr_wqe->uctrl.xlt_octowords = cpu_to_be16(ksm_len);
-	umr_wqe->uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+	umr_wqe->hdr.uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
+	umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
+	umr_wqe->hdr.uctrl.xlt_octowords = cpu_to_be16(ksm_len);
+	umr_wqe->hdr.uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
 static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq, int header_index)
@@ -704,7 +704,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 
 	shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
 	sq->pc += wqe_bbs;
-	sq->doorbell_cseg = &umr_wqe->ctrl;
+	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
 	return 0;
 
@@ -814,12 +814,12 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 	wi->consumed_strides = 0;
 
-	umr_wqe->ctrl.opmod_idx_opcode =
+	umr_wqe->hdr.ctrl.opmod_idx_opcode =
 		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
 			    MLX5_OPCODE_UMR);
 
 	offset = (ix * rq->mpwqe.mtts_per_wqe) * sizeof(struct mlx5_mtt) / MLX5_OCTWORD;
-	umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
+	umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
 
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
 		.wqe_type   = MLX5E_ICOSQ_WQE_UMR_RX,
@@ -829,7 +829,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 
 	sq->pc += rq->mpwqe.umr_wqebbs;
 
-	sq->doorbell_cseg = &umr_wqe->ctrl;
+	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
 	return 0;
 
-- 
2.43.0


