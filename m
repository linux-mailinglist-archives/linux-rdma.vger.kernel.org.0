Return-Path: <linux-rdma+bounces-2629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C0B8D1BB1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CD41C21E81
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746C16D9D9;
	Tue, 28 May 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5ekjcuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DE16D31F
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900795; cv=none; b=dS/kzOHosy+9kYg/7iveo3I3uZ1CESqwfKLhagXcohdrjkt7ACZXdsvbBHjBCgpAgBmwkOJCrGuJM7k+Qxia6syJcLMHoNAt0iifwaVC7eaEnf8Tm5u34ewMy+4q/u8cWgvHbxvzxduGm7shlICi+Fzq24/+pjAkfRAq+G5Nt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900795; c=relaxed/simple;
	bh=j/VaX961WtOx0tOpWiKQjxZSDBDT5m+pLYMsvbM6Ji8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d11WgeyZpMquD8WlITcZa1eeTEEK3xEJ3q9vjex7QplSJ/PdbGWeAgWS0fL4yaZZ8/vKFDExMw9ouKCqccFb8lSVPU9wr0pY+iT/MQberWu78zL/HObBhnXSs7fnLezO8bvmrcSh9c0tU2Y7fwCklkNrB5JKNXhh5X10YYs3q9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5ekjcuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626A0C32782;
	Tue, 28 May 2024 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900794;
	bh=j/VaX961WtOx0tOpWiKQjxZSDBDT5m+pLYMsvbM6Ji8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5ekjcuJE+f49i4GjOc70Gafn1Gp32I+u4aTmcO+GmXqoyaFPoBAsosTtdlGvcJk7
	 BpKxOXNx3IJ78vxv5mrHJrqpKHUuiFI/8tnz9/jcc9zYu8DFsLp+VRvlfGxr/vK6ZI
	 2U+6F2AQeajByCIhApHxzdWoJWRtIbX7IJqd00FUsFA1XRAccQhGIN6aEq2L85bxcO
	 M7IfP4cfmwXHWp0bOzPDAYEATPjkeHZuDG/4sci9QI7afDyOMd1mpkTP7ahC4N6PUe
	 o5QJBRx7vZmJkefa5pY5wqihccAUkKkfXT0TVZpoN6vl2qChdN/uwuRhQRrwfdMV8w
	 6TJQsly/PHdvw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 3/6] RDMA/mlx5: Follow rb_key.ats when creating new mkeys
Date: Tue, 28 May 2024 15:52:53 +0300
Message-ID: <7c5613458ecb89fbe5606b7aa4c8d990bdea5b9a.1716900410.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716900410.git.leon@kernel.org>
References: <cover.1716900410.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

When a cache ent already exists but doesn't have any mkeys in it the cache
will automatically create a new one based on the specification in the
ent->rb_key.

ent->ats was missed when creating the new key and so ma_translation_mode
was not being set even though the ent requires it.

Cc: stable@vger.kernel.org
Fixes: 73d09b2fe833 ("RDMA/mlx5: Introduce mlx5r_cache_rb_key")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 38d2c743db87..35dcb9d9e12a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -246,6 +246,7 @@ static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 	MLX5_SET(mkc, mkc, access_mode_1_0, ent->rb_key.access_mode & 0x3);
 	MLX5_SET(mkc, mkc, access_mode_4_2,
 		(ent->rb_key.access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, ma_translation_mode, !!ent->rb_key.ats);
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
 		 get_mkc_octo_size(ent->rb_key.access_mode,
-- 
2.45.1


