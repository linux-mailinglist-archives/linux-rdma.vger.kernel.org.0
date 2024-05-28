Return-Path: <linux-rdma+bounces-2628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9F8D1BB0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B271C21B72
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664716D9CA;
	Tue, 28 May 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlW9j5pU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539E16D9BD
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900791; cv=none; b=uCNoSNQyp2YoeMsBscXmYfMHUM9h8qiuVKOrMbkAv9QUNB+pFrhHXB20Jh6Ymo0nqfGRBxJg1OhcMcG4lkDcrQQprfFWyHSZBb19eqpV5r8H51KK4luSn+UNbPIO5wDwxJiVB7KfoA4IGu3VgaZekYupKbaXPxGGW0fNSYbOOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900791; c=relaxed/simple;
	bh=jb55TNR3k3CgqDAMPDfcN/zdxlqKbDs6fmeZQ+ZCYhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvoP6xhYhnYpbsdBIKa3fyIP15HYrUGt1IK3NmLkoFPG/GPuHPikMd9u+6O5nr69FKU3zR16qzu0LQYxVFKp5rlToGA1p0w79m1VdKOG0/eUNbY5YPxruyof8WEsvlIokMNSs9T85UBbrA5OTqfopmFJ5GNyE3XsTL21xEC9TCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlW9j5pU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30040C3277B;
	Tue, 28 May 2024 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900790;
	bh=jb55TNR3k3CgqDAMPDfcN/zdxlqKbDs6fmeZQ+ZCYhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VlW9j5pUSe9AZArHKbds17J85gzO2bb+J2gA09jiwR0fZqvnqW+uZZ5LM3YV89+e/
	 seDp5em+Znriten9qiNmjkTqqeTiFiUpxHasmg+IJJABJXVKV/WP59/v6c14yUTdUL
	 ljW3HgLmGulmE9C2CYnYtxOn7qBCmnDxUqAqEL35RzFj1j3haP5npg89PxrAWdhS6J
	 TaaLp2xIH7GKWfFON+3As6texZxBodc6cCMVZHTaP8RPwoCiRuHu94W5zv82e9hRMj
	 WYLwRgl4Xf1c3NibNsSbas/LcHWYPbq5W4vnEQ7QwmtTQT77Pcb2R8frutY4OnVw6Q
	 CjShHkoxnhBuA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 2/6] RDMA/mlx5: Remove extra unlock on error path
Date: Tue, 28 May 2024 15:52:52 +0300
Message-ID: <78090c210c750f47219b95248f9f782f34548bb1.1716900410.git.leon@kernel.org>
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

The below commit lifted the locking out of this function but left this
error path unlock behind resulting in unbalanced locking. Remove the
missed unlock too.

Cc: stable@vger.kernel.org
Fixes: 627122280c87 ("RDMA/mlx5: Add work to remove temporary entries from the cache")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ecc111ed5d86..38d2c743db87 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -641,10 +641,8 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 			new = &((*new)->rb_left);
 		if (cmp < 0)
 			new = &((*new)->rb_right);
-		if (cmp == 0) {
-			mutex_unlock(&cache->rb_lock);
+		if (cmp == 0)
 			return -EEXIST;
-		}
 	}
 
 	/* Add new node and rebalance tree. */
-- 
2.45.1


