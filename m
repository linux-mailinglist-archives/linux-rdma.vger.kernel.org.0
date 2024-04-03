Return-Path: <linux-rdma+bounces-1756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA6896CAB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429771F2CB5F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBE137C2F;
	Wed,  3 Apr 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef6wwbix"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B1433AD
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140574; cv=none; b=dLs2YaY982cENb9lFQwL5tOnR4sAd8hfDzPdrTI4WdhNa7HPd7xL/+YSSGs2zBBqk2+uAPSNdHgbzn4UWoKe+qFdP6mwlUrQ7hpQZ58EwEtbZXmeyipzPz+vmVnuAggeZOk0vTyNUqxApwHxybVYmHV6R/3GfQGRGfrLRqtMX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140574; c=relaxed/simple;
	bh=oUJRha4fMxW+pvW8Uz39rjHv6c2cWJRFI++Ii6JasxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRLHjLz9+Fy3Aij3NRtJ1Odox84ZM/e3Q5ZFQBrO7uUk4SrPKMH4macwfXgF7PiPP7IRxf7h52ioMnVeBiDCjjH0Qp30HUowh+C3/WkXrJR/8onWQ3iJIe3np50Pw3Y7FVe1RkqWE14Zrdw3b/tiwL4APz8HVMdGdGaY+DE6VVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef6wwbix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C3C433C7;
	Wed,  3 Apr 2024 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712140573;
	bh=oUJRha4fMxW+pvW8Uz39rjHv6c2cWJRFI++Ii6JasxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ef6wwbix2X1/kHRDFJfOsQ9+FSzNxCgjAeP5cq+6dO+aUPl4haLCbh1FCXWgXp+ol
	 yTzAKn/niCJLEHRrFuYkp5hnly/NbWIvD6rgSnwNxZ3NheuVOw8HPleYj+sNYbzLrG
	 XritGJ2tUfowHOWFp08+qydtvWbuTT5yLqbm0ANzGLKrifXs9qKg+7Tqsuv/VVUvAI
	 mt7G4ZJ4xTfGTR1y4UqKtPE8Mwg7ka9QCqBqt2GJZalFMgtRxM5a7pO3Gz+i0Kintg
	 Bgx9/vUGZ/nbzV8ZTTei7BjaGheclkAPy2if5s02dvNS1VLAyK7htnQe9RWoL+Mke0
	 Onv/WJI8EdbfA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 1/3] RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
Date: Wed,  3 Apr 2024 13:35:59 +0300
Message-ID: <f2742dd934ed73b2d32c66afb8e91b823063880c.1712140377.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712140377.git.leon@kernel.org>
References: <cover.1712140377.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

As some mkeys can't be modified with UMR due to some UMR limitations,
like the size of translation that can be updated, not all user mkeys can
be cached.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a8de35c07c9e..e74f04865062 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -643,7 +643,7 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
-	/* User Mkey must hold either a rb_key or a cache_ent. */
+	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
 	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
-- 
2.44.0


