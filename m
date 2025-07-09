Return-Path: <linux-rdma+bounces-11993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D567AFE048
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B012C58755B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A8275B15;
	Wed,  9 Jul 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiIr8oiw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AB275AE7;
	Wed,  9 Jul 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043348; cv=none; b=QUkebVmD1febGFwc9echWvHW4KnJFqIUA9OAEuchYxJyZ+2gTLglO74a0NWtLTE7lytFDQuxpLnbiGPVQMWhBUykF7aA1WQw7MathZvcHoieFISjCoMkzD2IBwPsCf6tWLerWWTRtlW4bNdMp/hUbmKO2qV2YvVIV9YPxhoDt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043348; c=relaxed/simple;
	bh=aqKwt2R4domWj2Qf+nj3tEgmAE88WlyqP0DCKD+z32c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9rP9ClMHyc0HpjSxUuYhLlLsG+Q0uUzoKC7s8yobCQXE/7Qoxul6/t6r2inBqvM8NdR6pY8fpz1P/rGPVKIH+mMAFzQjH+Qcyj5L2DRB/dmLNAwStm58lyoXdkAFj3WAiDjErK3Z6ShF9rAnfrg1NPeAuPYgDPKEfnANFPbW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiIr8oiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC2C4CEF5;
	Wed,  9 Jul 2025 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043347;
	bh=aqKwt2R4domWj2Qf+nj3tEgmAE88WlyqP0DCKD+z32c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiIr8oiwEYShNkxmPcYEZfC2MGvVCf8N+QgCZYbdYEypIVBPPWKK0YZGdyLA7jkUj
	 9W+rEozTYsj6d59daoPU4lyC1Vi/ZdSNGSuiG75oarIjWCr5UEs6MVKtflG7F5MMhH
	 BRNNE460vggihWjSCJQJzmv0gCoaTKYUl+qtNy6OWPUPArgFmVH8tlMdd0di3kCyb8
	 u07l5GiPjeglny1oMPQEncTlCj4MTtTflwhXLflDBXqcQf/GznGWFaHWqZqUilxO3k
	 8fFEKrMZL/UWkFK8Rg8ufTO2RYiZ11MRgxivF+XIjF5oIQKokt3d05NnHxovfArs1S
	 h4Ns2B1RH4/dg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 2/4] RDMA/mlx5: Fix UMR modifying of mkey page size
Date: Wed,  9 Jul 2025 09:42:09 +0300
Message-ID: <9f43a9c73bf2db6085a99dc836f7137e76579f09.1751979184.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751979184.git.leon@kernel.org>
References: <cover.1751979184.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Srouji <edwards@nvidia.com>

When changing the page size on an mkey, the driver needs to set the
appropriate bits in the mkey mask to indicate which fields are being
modified.
The 6th bit of a page size in mlx5 driver is considered an extension,
and this bit has a dedicated capability and mask bits.

Previously, the driver was not setting this mask in the mkey mask when
performing page size changes, regardless of its hardware support,
potentially leading to an incorrect page size updates.

This fixes the issue by setting the relevant bit in the mkey mask when
performing page size changes on an mkey and the 6th bit of this field is
supported by the hardware.

Fixes: cef7dde8836a ("net/mlx5: Expand mkey page size to support 6 bits")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 6 ++++--
 include/linux/mlx5/device.h      | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 5be4426a2884..25601dea9e30 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -32,13 +32,15 @@ static __be64 get_umr_disable_mr_mask(void)
 	return cpu_to_be64(result);
 }
 
-static __be64 get_umr_update_translation_mask(void)
+static __be64 get_umr_update_translation_mask(struct mlx5_ib_dev *dev)
 {
 	u64 result;
 
 	result = MLX5_MKEY_MASK_LEN |
 		 MLX5_MKEY_MASK_PAGE_SIZE |
 		 MLX5_MKEY_MASK_START_ADDR;
+	if (MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5))
+		result |= MLX5_MKEY_MASK_PAGE_SIZE_5;
 
 	return cpu_to_be64(result);
 }
@@ -654,7 +656,7 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 		flags & MLX5_IB_UPD_XLT_ENABLE || flags & MLX5_IB_UPD_XLT_ADDR;
 
 	if (update_translation) {
-		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask();
+		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask(dev);
 		if (!mr->ibmr.length)
 			MLX5_SET(mkc, &wqe->mkey_seg, length64, 1);
 	}
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 6822cfa5f4ad..9d2467f982ad 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -280,6 +280,7 @@ enum {
 	MLX5_MKEY_MASK_SMALL_FENCE	= 1ull << 23,
 	MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE	= 1ull << 25,
 	MLX5_MKEY_MASK_FREE			= 1ull << 29,
+	MLX5_MKEY_MASK_PAGE_SIZE_5		= 1ull << 42,
 	MLX5_MKEY_MASK_RELAXED_ORDERING_READ	= 1ull << 47,
 };
 
-- 
2.50.0


