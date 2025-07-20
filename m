Return-Path: <linux-rdma+bounces-12322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97DFB0B494
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9A188958D
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4261E47B3;
	Sun, 20 Jul 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuI50goQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC270808
	for <linux-rdma@vger.kernel.org>; Sun, 20 Jul 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003546; cv=none; b=o4sdugLw0Rn+RYyVVk+vDVsKpqt7GgXdwsajp5j8QL7Huo95pqHMKLBnlWvtB9atc1WzwF5FKjnFrQ2gbGdNAgD2EPD5PZ6MKFnXQ809QRIULzE6lUJ87D8g1+R7WeNlzQh8FFwYaE0pqIv0XzjyJ97THxCpOhg0Bf5qIWPY28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003546; c=relaxed/simple;
	bh=x9+Um59ZZZ8feAqLh+ZPvldygODcZxh5xHI8HnIus4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+p9kJslt07bSow7715xONVaAFkzgmq0exAZvQu+cO/CXu4ps4hmchORx3PRwomWitDIkJiyhiX7N4y8ByNYwq/ddjKSWd5YMg6IE6Lja19StbhVEwWMLhSrWlud4iPgvjkwYVA5ZO9iTKnGm0jR0tmIzjnbVJeovABnYnw7LvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuI50goQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F2C4CEE7;
	Sun, 20 Jul 2025 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753003546;
	bh=x9+Um59ZZZ8feAqLh+ZPvldygODcZxh5xHI8HnIus4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuI50goQ524aM+b2MD0E5nGAKt79B/HTMNNd7LC73fXxg9Py7UI6mY9jREZVKEkxv
	 mXk3irAd6p5yyPrDPqUg7ZyOe77bWe5nyLZ1JMnOn+YjBf+2RmI3gj1YCkC+vjNcG/
	 Mz7FrdQjRknfKvSdNM/AWl8k834MKU7XHDAtv9eUfQxixAoiJDmqG4ULT54xl1BSN0
	 FsFrrC7m+0MxI6wgGtDH5/wjOluq1VO8FGdv3QPYBLyJZOtPgDU0TuANh7M039ixHP
	 lUqWKZglU6QQFUGIM+sjdNBQQvlcym6p8aJhpzHePuIkPx+7w6TX5x0aei92O1hP5m
	 sYUmYmXYQqF8g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Fix incorrect MKEY masking
Date: Sun, 20 Jul 2025 12:25:35 +0300
Message-ID: <e354d70b98dfa5ecf4c236a36cd36b64add9d9de.1753003467.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
References: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

mkey_mask is __be64 type, while MLX5_MKEY_MASK_PAGE_SIZE is declared as
unsigned long long. This causes to the static checkers errors:

drivers/infiniband/hw/mlx5/umr.c:663:49: warning: invalid assignment: &=
drivers/infiniband/hw/mlx5/umr.c:663:49:    left side has type restricted __be64
drivers/infiniband/hw/mlx5/umr.c:663:49:    right side has type int

Fixes: e73242aa14d2 ("RDMA/mlx5: Optimize DMABUF mkey page size")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 054f6dae24151..7ef35cddce81c 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -660,7 +660,8 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 		if (!mr->ibmr.length)
 			MLX5_SET(mkc, &wqe->mkey_seg, length64, 1);
 		if (flags & MLX5_IB_UPD_XLT_KEEP_PGSZ)
-			wqe->ctrl_seg.mkey_mask &= ~MLX5_MKEY_MASK_PAGE_SIZE;
+			wqe->ctrl_seg.mkey_mask &=
+				cpu_to_be64(~MLX5_MKEY_MASK_PAGE_SIZE);
 	}
 
 	wqe->ctrl_seg.xlt_octowords =
-- 
2.50.1


