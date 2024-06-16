Return-Path: <linux-rdma+bounces-3187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39641909E79
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4270B20D26
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0B12E47;
	Sun, 16 Jun 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGn/Eyb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E93DDAB
	for <linux-rdma@vger.kernel.org>; Sun, 16 Jun 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554657; cv=none; b=Ub3KYqjeXdsHmrymjOYx/Egt7BqDmA9qmm+zWb8L0iM8gsKo+AmK1VbU7hAWqEPBJjSuiyO/sGQEf7rJadqJOXZ0j+afzrOFLjL02eUKyRyCzCNYXKUpIM/1/xsLYRqiqR0mWKzK8SSU43JZMLGonXZ3jYoYgMP51lU1zx2h1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554657; c=relaxed/simple;
	bh=SOTNdtAy6gDIhYmgcyLnClLHAzEyEWreXDRxb5d8eNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bnUD5EPv2Ye57SbLN+yuFDDspeJXiwXGjb35Hf1VhrIqnJ5q435YhqA2nKm/U/XcubUFEMHqCnRUYBwS0CFf1GVbU3cp+fnBYZVQWJsQ44HbYQJ/hS2xWgur0UpMby9LljeUAQQM0oR7QRDU9lJ9Xb9Pi6U+yFL1Huge8kbo/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THGn/Eyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3017DC2BBFC;
	Sun, 16 Jun 2024 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554656;
	bh=SOTNdtAy6gDIhYmgcyLnClLHAzEyEWreXDRxb5d8eNM=;
	h=From:To:Cc:Subject:Date:From;
	b=THGn/EybXkrWmEGkW2iplR4GqbTphCDV5NHVEw2kmJVHt19EZkbhOx+U4qJW0F8vS
	 bEg7GKM7lGdyF2lyRnsTNHkqPjdreRqgBIrgIb6r6rBE/dEGRo/LAMM8jX+P2qGlwA
	 AWmTW1+mn2DS4qCSKxz1psJV8011tkEdAShYYDoXHA9hYD1yZ+NAYqIKxIntXJgNUj
	 nEYaXY8FhuXMBKR6PIWKuiEj7nDMoKqHijd1kb1r258Zg+z84io7v2XGDfp0ZPQEwQ
	 h7Mv1ePSyeyrT4qx+mBqicJltgAFXYS9wv29iZyxclHi90wSTheE73hn1LNQlwnPuF
	 FPWHVNUgE2ZTw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Fix truncated output warning in alias_GUID.c
Date: Sun, 16 Jun 2024 19:17:30 +0300
Message-ID: <1951c9500109ca7e36dcd523f8a5f2d0d2a608d1.1718554641.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

drivers/infiniband/hw/mlx4/alias_GUID.c: In function ‘mlx4_ib_init_alias_guid_service’:
drivers/infiniband/hw/mlx4/alias_GUID.c:878:74: error: ‘%d’ directive
output may be truncated writing between 1 and 11 bytes into a region of
size 5 [-Werror=format-truncation=]
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                                                                          ^~
drivers/infiniband/hw/mlx4/alias_GUID.c:878:63: note: directive argument in the range [-2147483641, 2147483646]
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                                                               ^~~~~~~~~~~~~~
drivers/infiniband/hw/mlx4/alias_GUID.c:878:17: note: ‘snprintf’ output
between 12 and 22 bytes into a destination of size 15
  878 |                 snprintf(alias_wq_name, sizeof alias_wq_name, "alias_guid%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixes: a0c64a17aba8 ("mlx4: Add alias_guid mechanism")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 111fa88a3be4..9a439569ffcf 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -829,7 +829,7 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 
 int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 {
-	char alias_wq_name[15];
+	char alias_wq_name[22];
 	int ret = 0;
 	int i, j;
 	union ib_gid gid;
-- 
2.45.2


