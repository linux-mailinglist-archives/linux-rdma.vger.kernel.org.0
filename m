Return-Path: <linux-rdma+bounces-8470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DBA567F8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FD018997CE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA862192FD;
	Fri,  7 Mar 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nou0fraV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357A14A4F9;
	Fri,  7 Mar 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351179; cv=none; b=ayxVasQz0WdaT7upizRXtWSPmB+p7MmBLre8QqWZ4m/52Wq3X+b7oqzYthaXOi3Pd+jZSnewO/2L44MzlUYxgsqRyxWmtbPRNblsgyGOghFNf7U+jEquaaPaG7LEgqdCiIrQwTqbHVA6Ycj+mt1a2oDZ2xK7v3TZnOEUmM6lTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351179; c=relaxed/simple;
	bh=s7hiwi95qFo8m2jua01lQD0x3S0kGOR2e9V0JFfUNlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kj3j20r7cUegRMYRES71ArVX1FRDOt/dharcV+elRo2Unnl3KjUH8GWUJS9jDgDTQQVmwNs7XZxK5EjedT9A6sMJMC43H8/t0SajJ5Ggim9VvulMq19vRmTwvnxzWS7tZYD2jCN+JCGpd7KIrJpKTh+JLxW61j0jRZOQD3/iP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nou0fraV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA1BC4CED1;
	Fri,  7 Mar 2025 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741351179;
	bh=s7hiwi95qFo8m2jua01lQD0x3S0kGOR2e9V0JFfUNlo=;
	h=From:Date:Subject:To:Cc:From;
	b=Nou0fraVToEv1T92e++EC7LlXcHeIoJ1j4BCPoLX9/dBRYfQupMAkHL8OFJV0w5J6
	 WbCDMz6fCD49yMOHnRIFbv8W7Dbzz8zSmxsUwogjAkTnCBO/VUeeUuMVO0YxEl6Vk7
	 m1GfjetHnPHoecCjRgI3k78zukOk6BKIjdiud9HDrhxms1FKj2mVbV59FxP+ZIYBbd
	 aE70Y2Zeh0mMOKJ7AC3RsV1fyRJETStiGnjjiksc+V21Wri4g1LQyHUum8AgL4b9R2
	 z/NWbjLGoM/58NmivxDVIm3Ov6ed4D82uAdGvvO9I9NsMKaysprXJAZnkkY12sksYa
	 sk1esOPz+FBmA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 07 Mar 2025 12:39:33 +0000
Subject: [PATCH net-next] net/mlx5: Avoid unnecessary use of comma operator
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAATpymcC/x3MSwqAMAwA0atI1gbij6pXERdaowZslVakULy7x
 eVbzETw7IQ99FkEx494OW1CkWeg98lujLIkQ0llQxUpNEdoUJ/GTEiLbmdV1ExdBSm4HK8S/tk
 Alm+0HG4Y3/cDldp7XGYAAAA=
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-19 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
index c862dd28c466..e8cc91a9bd82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
@@ -700,7 +700,7 @@ mlx5_chains_create_global_table(struct mlx5_fs_chains *chains)
 		goto err_ignore;
 	}
 
-	chain = mlx5_chains_get_chain_range(chains),
+	chain = mlx5_chains_get_chain_range(chains);
 	prio = mlx5_chains_get_prio_range(chains);
 	level = mlx5_chains_get_level_range(chains);
 


