Return-Path: <linux-rdma+bounces-7645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA1A2F5A9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D421D1694F3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941E255E4B;
	Mon, 10 Feb 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8PBU0H4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE8F2500BA;
	Mon, 10 Feb 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209508; cv=none; b=AOvBUbxZAlOE8ab7uy1MtRBDeraHjtiTNRi6hsOTydV+AzuK7tFSBWD6t6HkDWAqyfm/etkB2OSKzXB9AXJxcReQ3Dpowd1G9JZibumrnzl0HgZR6SdgbtlOLuPftqhyXFEKXfwpg+ZxGkMOnbGBgBd1Hhb+74sGCm7eSqGOHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209508; c=relaxed/simple;
	bh=EkPg0iVWp2FJbeErYnYBxnLlulonUWK0FxLvxy3RRK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eb4GB9yKwOvz3JR7C4qAgfgk9qLQ/kjtDHmwEfe0R8N+cV+0C0/I3F2CRyaG5vQN90TzooTdtQCKaEcTA1pyKuw/2H+/RqrxITi8lPKVSzTo3M40JRTOQs405cNq2ZK1CAlu4y3AKQMZ/V3p87pjmDBtKw1jCPolfeSWp+l7E00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8PBU0H4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567D9C4CEE5;
	Mon, 10 Feb 2025 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739209507;
	bh=EkPg0iVWp2FJbeErYnYBxnLlulonUWK0FxLvxy3RRK4=;
	h=From:To:Cc:Subject:Date:From;
	b=A8PBU0H4UdGp7EEii9SVKDYE3xCTXFxnvsSm8n6vjdQKVpgfLVGBqMvwYcxapcqpG
	 /e9WhuyHheagw0ggp5DGCOWc0AnApALJ0iW4WveKnDahwmH/3SJlhgo1lV/7jv8OUM
	 9GU+cJNUit24AYXhDaBEmgBns7TT5XjQR3jrX52kpazd8M8GoYAfD8Up8/CBz6OHio
	 evRcWwznTb4ubpjoL+hvA6H/uZIB7GRBQwh3/B28BQvPkoR7l1xCZJ/E2l5MKHCZlz
	 vhHUHKstenVnlUZ9HBkO70ibzWQbihBg72d9QfAhGNuXuTc2MI/jcCN433DEyLGhd7
	 oSogFORbTUGWQ==
From: Kees Cook <kees@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
Date: Mon, 10 Feb 2025 09:45:05 -0800
Message-Id: <20250210174504.work.075-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3608; i=kees@kernel.org; h=from:subject:message-id; bh=EkPg0iVWp2FJbeErYnYBxnLlulonUWK0FxLvxy3RRK4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrrBU+V3w5JxDieixNs3bKsg1HJS8/6yu7FMJesI1tm pLqtFOhHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABP51MzI0MoVuTjI7V/Imin7 fz7hVjPYxvHm6E3Otf6rcjqulj8oZWFkWPLgkVkHT6j8q3Pf+ATFrK/NPaLA8+9Z9M87ipV2kz4 f4AQA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

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
---
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
 include/linux/mlx4/device.h                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d6..f2bded847e61 100644
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
index 27f42f713c89..86f0f2a25a3d 100644
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
2.34.1


