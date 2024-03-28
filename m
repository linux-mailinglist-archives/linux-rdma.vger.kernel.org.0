Return-Path: <linux-rdma+bounces-1635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28068901DF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736B91F26944
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5617BAF4;
	Thu, 28 Mar 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwlsvkhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B712BEA0;
	Thu, 28 Mar 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636336; cv=none; b=r6jlSDlIp2kjm3+3yyYrk5/Kfj30PKkooy1wya/QS20+16jt8vfjedyH7VWaJpfQoVv3g7COtmnvmTfDX0qMYUakvL5LbiZUdaykOdPWrNdWxOwlM6C89qrBwTAXSixSWTbCXZM9Pe35DsBeItRa91KyIz6l8ZSuar3xvCfKVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636336; c=relaxed/simple;
	bh=oOMLQx+gPaXHH5Tk6o+DNZIrvqEEtpFNuWMdgsGdvoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2V28Mqe7RAhA0iJzGNNSU4GZEsZRo0w7C0YVELohycv94O7Scvj5KAXj9p0VoatgeNpat9PDsJdAEQABWRonMJUTgl0j6KGbsO3iazTruqC1wwTXAI8Jtv0nV6ZQTUd7/uvWQ8sfGAvTaYTuNoIcJa1kAcs7XFy6Kps1Cy/MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwlsvkhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBF9C433C7;
	Thu, 28 Mar 2024 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636336;
	bh=oOMLQx+gPaXHH5Tk6o+DNZIrvqEEtpFNuWMdgsGdvoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwlsvkhHCsWSQWHVw/27w1M7pS1Z3C3fvOkjQZto5XbtiZvBzheadtKt4qSt9CO53
	 BRkZ1E9up6qBgTfor+rcxdIc0tpi08tqJfhHIhvDMK2F9Uzd/A44Xm5N1CZ4AtzNOw
	 M31LEk8eYkBTzX6NzeKe8UsHOGHu8oSP48s0psUqL7RdUe32N+QrfOvA+wzOxn/z6x
	 bGGtaUBNb3NdDlOlch3dTNKM8l8KiK4VVMjjnnVnLeXTYPetOdxgDP5WwxSLNecWsh
	 TLngdvzP4KMTHREfE0HPuRvpbwwU8jiF0Jk67qcQrAliZbIH+7w3RMZduND8EqkBUz
	 V3dj+E+ST0j6w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 8/9] mlx5: stop warning for 64KB pages
Date: Thu, 28 Mar 2024 15:30:46 +0100
Message-Id: <20240328143051.1069575-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with 64KB pages, clang points out that xsk->chunk_size
can never be PAGE_SIZE:

drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:19:22: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (xsk->chunk_size > PAGE_SIZE ||
            ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~

In older versions of this code, using PAGE_SIZE was the only
possibility, so this would have never worked on 64KB page kernels,
but the patch apparently did not address this case completely.

As Maxim Mikityanskiy suggested, 64KB chunks are really not all that
useful, so just shut up the warning by adding a cast.

Fixes: 282c0c798f8e ("net/mlx5e: Allow XSK frames smaller than a page")
Link: https://lore.kernel.org/netdev/20211013150232.2942146-1-arnd@kernel.org/
Link: https://lore.kernel.org/lkml/a7b27541-0ebb-4f2d-bd06-270a4d404613@app.fastmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 06592b9f0424..9240cfe25d10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -28,8 +28,10 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5e_xsk_param *xsk,
 			      struct mlx5_core_dev *mdev)
 {
-	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+	/* AF_XDP doesn't support frames larger than PAGE_SIZE,
+	 * and xsk->chunk_size is limited to 65535 bytes.
+	 */
+	if ((size_t)xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
 		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
 			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
-- 
2.39.2


