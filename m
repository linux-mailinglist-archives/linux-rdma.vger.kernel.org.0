Return-Path: <linux-rdma+bounces-11329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4CADAA77
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F95F169157
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304EA26B2CC;
	Mon, 16 Jun 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBIx3QPO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488D25D529
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061769; cv=none; b=cXaiRchP4vtRpiVQczWWovWCnwChLQn3L+Dv1WlJ0IyxO3h5Lsm9gWmf/y5Brj2U+mjT7YEkkf5KqhZTsXxuZ5upp27uEMlOIsMAxkev6m3pk7bkcysk46NM0yZ0JJmjztAim3X6VXvJmx1euXSmEbesjK1qmmv784kZSaKmZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061769; c=relaxed/simple;
	bh=aaGASF9KcbvS026l/K0FcFvzFGYKI0S+MPqVTOPCP9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CebMDr4+7Rh31be/Q49WlbMq8s7/iVlho5JuM+AzQjR58HUBlc7I/5A2Lnh9vGKHwRqtUoDAZY8l/LT/K9VuQwnZly7+sa7fBiuAt6pvhXfsuVNYv96MWBl5cI2S6RrYVkyBcswAaJvp7x+pAphnG5+y3FYHORrXOI4bLFp5PJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBIx3QPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E761C4CEEA;
	Mon, 16 Jun 2025 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750061768;
	bh=aaGASF9KcbvS026l/K0FcFvzFGYKI0S+MPqVTOPCP9g=;
	h=From:To:Cc:Subject:Date:From;
	b=OBIx3QPO0l+eKx64PMnH9TpVCy9Z9qF11I8jfFjmQZ9/b+fG9TEOf/y3iJ5hORkPm
	 NhxCm3zi4CsSkBOeZEynGJ0nJbeifZs8l5mSkll+q7NnjVBs/FqWMVXiqSKNtMELlD
	 zmnlIycyM1x1AlHUu0og+KsOkeneCEY1TUOqyDfjqo/kKG81V8VSHvL1BJFKXjEwrv
	 AT0Pe0GTnJoYWANuA2ESF6uvR46VDe1tahvaH6fWC41WDdDCyx7KOQGx/tRxj8rK6o
	 HYFAommz4VedctgKMr+Id7K+0ZC0Bah8egTRFJevEU4JAWyJb0EKmMCXk9I2kx/HSE
	 oCNr0se5v/a5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-rc] IB/core: Annotate umem_mutex acquisition under fs_reclaim for lockdep
Date: Mon, 16 Jun 2025 11:16:03 +0300
Message-ID: <9d31b9d8fe1db648a9f47cec3df6b8463319dee5.1750061698.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Following the fix in the previous commit ("IB/mlx5: Fix potential
deadlock in MR deregistration"), teach lockdep explicitly about the
locking order between fs_reclaim and umem_mutex.

The previous commit resolved a potential deadlock scenario where
kzalloc(GFP_KERNEL) was called while holding umem_mutex, which could
lead to reclaim and eventually invoke the MMU notifier
(mlx5_ib_invalidate_range()), causing a recursive acquisition of
umem_mutex.

To prevent such issues from reoccurring unnoticed in future code
changes, add a lockdep annotation in ib_init_umem_odp() that simulates
taking umem_mutex inside a reclaim context. This makes lockdep aware
of this locking dependency and ensures that future violations—such as
calling kzalloc() or any memory allocator that may enter reclaim while
holding umem_mutex—will immediately raise a lockdep warning.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index c752ae9fad6c..b1c44ec1a3f3 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -76,6 +76,17 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	end = ALIGN(end, page_size);
 	if (unlikely(end < page_size))
 		return -EOVERFLOW;
+	/*
+	 * The mmu notifier can be called within reclaim contexts and takes the
+	 * umem_mutex. This is rare to trigger in testing, teach lockdep about
+	 * it.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		fs_reclaim_acquire(GFP_KERNEL);
+		mutex_lock(&umem_odp->umem_mutex);
+		mutex_unlock(&umem_odp->umem_mutex);
+		fs_reclaim_release(GFP_KERNEL);
+	}
 
 	nr_entries = (end - start) >> PAGE_SHIFT;
 	if (!(nr_entries * PAGE_SIZE / page_size))
-- 
2.49.0


