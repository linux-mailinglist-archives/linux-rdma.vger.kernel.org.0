Return-Path: <linux-rdma+bounces-9823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F346FA9D82B
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 08:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250669A4017
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 06:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167B1A9B24;
	Sat, 26 Apr 2025 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWo+vyQe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B617A2F0;
	Sat, 26 Apr 2025 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647933; cv=none; b=jiaTV7wVfPOYYVKiYRpf1xoLML8A6Bq6tF/ta8OGpqpCyTMEXZkbBMH1w3qXZcXBXmjzkQBC2HAyUeszu5pFybdYRSCCz0xpAwYUh2DBs951itwHa9YWwEyIex+AqyUKD2EOMqMz//cyh5WrQ8EKSyHUg620re3N5TZ/kX3vsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647933; c=relaxed/simple;
	bh=ZEpUVBmF4lQQYKMYQqtRo2azK3Xo9Ud+kmgvw9U8dzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTzs/aoHU0OvRkibzFXXqi7bkLkl/QLGgyCJoVoZ0z1zro6UAHvdrsZS9/H4ryBfQQP7H2+CkKBZTCxv2wIhjJmkXnIZqyF8r6b76ppG63azC6YsH3PBvuflx8X0IDY/1rKXBkg7xLmTXSWKWinNK/gsy3Q+Tv4AhkjS+myc2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWo+vyQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE0C4CEE2;
	Sat, 26 Apr 2025 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647933;
	bh=ZEpUVBmF4lQQYKMYQqtRo2azK3Xo9Ud+kmgvw9U8dzY=;
	h=From:To:Cc:Subject:Date:From;
	b=oWo+vyQeC6OxprhiBfGH9JOnjClAHWX+YGKWsu/2XXmzYFf8ROAbrYq5W3jTmdUpm
	 UxFR1F1eehg3fWCjCFkdDnOxNjh5cYU+m2QfFjAbRPYpm71ZGPrRkZ78yX/IF+sJk+
	 I01VcAR9oP8pASZJGi7RjU7TM40kJOJs33bmX9SKkhWSzekdolaSbt3kk5dwzp5RGp
	 SfCA/6rWEwt4Nt31NpNLKdbPnyobIM/mqrNUtw0uuZMZqKJl5Sm5ZSQN9AzidQdWkh
	 CgyZINN+cwB54nfEUxBjmOg+SprFjk/sRZHP8zhFfSUV3oxLi/PfWN4webxyl7vzTC
	 CsbHpp2qMp+mA==
From: Kees Cook <kees@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] IB/mthca: Adjust buddy->bits allocation type
Date: Fri, 25 Apr 2025 23:12:09 -0700
Message-Id: <20250426061208.work.000-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=kees@kernel.org; h=from:subject:message-id; bh=ZEpUVBmF4lQQYKMYQqtRo2azK3Xo9Ud+kmgvw9U8dzY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8lRbmc/1Wp6Uev/jBc2eptkTs28BTYdlLnqnzaEjZb fxilvayo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKzDBkZ1lefn1r9y/Iah4Lc 0nSGMkMldpE1SkKiXnVnnNlUoriyGBnO64lO+jeH68P+9I0liVtMDxwUqVP83dr+InaBWKyMkA8 TAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "unsigned long **", but the returned type will be
"long **". These are the same allocation size (pointer size), but the
types do not match. Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: <linux-rdma@vger.kernel.org>
---
 drivers/infiniband/hw/mthca/mthca_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index 192f83fd7c8a..dacb8ceeebe0 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -144,7 +144,7 @@ static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 	buddy->max_order = max_order;
 	spin_lock_init(&buddy->lock);
 
-	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(long *),
+	buddy->bits = kcalloc(buddy->max_order + 1, sizeof(*buddy->bits),
 			      GFP_KERNEL);
 	buddy->num_free = kcalloc((buddy->max_order + 1), sizeof *buddy->num_free,
 				  GFP_KERNEL);
-- 
2.34.1


