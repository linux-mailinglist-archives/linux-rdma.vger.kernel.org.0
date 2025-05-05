Return-Path: <linux-rdma+bounces-10048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BEAAB358
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ACE3B433B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B535022B59A;
	Tue,  6 May 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+P5yBYI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373A2E3383;
	Mon,  5 May 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486221; cv=none; b=b4Hvjc4BEL+1wcRSbE7lsfwyx6HsAgGpSMa2xpIQ7V6BHWrRAzWOo9xMhaoQ5KIRYkPXwHjWGBnSg4bATkJkim1/cjZKyBPBF84T68yHksqNnCu0AMI3UxlvCK/x/9BMA/MmzpXZRmHa2Po8ceDsBqla3xd7vwcyCC9sRxq5Eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486221; c=relaxed/simple;
	bh=/poekQtgswXL0n9PrpAg6A9ekTrrgUkF7TlsYeW/k5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fd+tYcD8VLGmxoBwQ/rvRXVA/wG38F8uTjMXb8R5lBof/gl9PL807g3a+WG7v6avy/z98ZdkasrFLLNlGe0znDBYJy/Q+4hBXoxxGoUgOxGPkwqXOcGiKu9wlMXy0xCIVjN+oo6hkGFgnr4imhcOJBV0XU0uSLByGelc74SM8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+P5yBYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19DC4CEF2;
	Mon,  5 May 2025 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486220;
	bh=/poekQtgswXL0n9PrpAg6A9ekTrrgUkF7TlsYeW/k5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+P5yBYICznq+2q7rPMP/4ie1YpNvIxfTNzkHpQMnSJXCqpFmeAV7K4efswH0RVl3
	 WnxuZw46l7aM/60QRn4eWm2FTymcI3wuRAXL2UqcKCTWBdneimO7ifm9mlzW/GfvOY
	 Z5pc0uxS3KCIUA7q3fFj17kdEXyEBXNcF4UsdFUqTVyFFXloboGAZii2RIcEWKUg6j
	 7M6K52HaIRuJis6gK55YUXQpf1IWqdU71GVcWRVjAth4zuvNjsnK3PoOqPoRs8l1Du
	 qj3GbzUGZI/RvZWu0VCXulFN+YcVeYnUTBrEbiwAbsqen8Suh6IgtsRIvelNb6ov9B
	 3Gz4MXGKZaB0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	yishaih@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 214/294] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
Date: Mon,  5 May 2025 18:55:14 -0400
Message-Id: <20250505225634.2688578-214-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 4a6f18f28627e121bd1f74b5fcc9f945d6dbeb1e ]

GCC can see that the value range for "order" is capped, but this leads
it to consider that it might be negative, leading to a false positive
warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):

../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
  691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
      |                                    ~~~~~~~~~~~^~~
  'mlx4_alloc_db_from_pgdir': events 1-2
  691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                     |                         |                                                   |                     |                         (2) out of array bounds here
      |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
                 from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
  664 |         unsigned long          *bits[2];
      |                                 ^~~~

Switch the argument to unsigned int, which removes the compiler needing
to consider negative values.

Signed-off-by: Kees Cook <kees@kernel.org>
Link: https://patch.msgid.link/20250210174504.work.075-kees@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
 include/linux/mlx4/device.h                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d67..f2bded847e61d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
 }
 
 static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
-				    struct mlx4_db *db, int order)
+				    struct mlx4_db *db, unsigned int order)
 {
-	int o;
+	unsigned int o;
 	int i;
 
 	for (o = order; o <= 1; ++o) {
@@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
 	return 0;
 }
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_db_pgdir *pgdir;
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c891..86f0f2a25a3d6 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 		       struct mlx4_buf *buf);
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
-- 
2.39.5


