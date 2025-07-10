Return-Path: <linux-rdma+bounces-12020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBFAFFBCF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 10:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121EF1627C6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577AC28B7E5;
	Thu, 10 Jul 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2RDgZdz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4422D9E3;
	Thu, 10 Jul 2025 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135008; cv=none; b=I1Kg8uKvXnPimF7Yos1VYT0qTbE7KWXjgYKcnqSQFWkYKCY4dklLCfZhUkOjCssPUs/tABN3E/3Tf3AyBidu6E1C/4MvLTAmzTbjByMIbS0sNiM7SGYWFhR8fMAWizg4cPuJTa4b/Ozale8O5q2zlet/idR49QY4hHatfwGDT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135008; c=relaxed/simple;
	bh=l6o0QvUlgEpaATSaxinq/vq2+N9a6aWAXKed88dkYeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ib27eedIaVLrOpk7IYpzTCu25PQ8z/2F7rGCPkj3kR2dT4ORDVvo8WU2qfVv9911UzfiVQNB/MyMsdoB38tJ0ZPL+PPpGj/Vu6sRnXtUCAO432hnRhG/shfG19GQeDlx7yfJtkePLSOeDpFEwNXDgMUCmznfYk83CduTL7di1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2RDgZdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E68BC4CEE3;
	Thu, 10 Jul 2025 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135007;
	bh=l6o0QvUlgEpaATSaxinq/vq2+N9a6aWAXKed88dkYeY=;
	h=From:To:Cc:Subject:Date:From;
	b=B2RDgZdz6y5eo785kiiLdGQ7ZfXpmkkqNLWvXXTTbZfwt+p1+BYPdFJS7jwvuGGTP
	 R/wdGSALGpkotkbCD50pc7fBUVd3hwsDfChr60r0tPqutUVNLg98QjKNcoSIPZ5UDq
	 /K4dXe/7sc2GpqgNTppv2tnKLxxphPkNKYKrnBj7E5rxBwhEibbiqlZAUhU6MKlq4V
	 T2od39wWnVU35ltYHnUo+STRYll6wv2ngmq7rAlU8WxEb09aypipf1JeM1SP15phiD
	 cEiMIhXVAecYD2QqMDPGxKEvSN9+R2U/D23KBwh85icWr9UO7vkgyKtOqqA4FNoEs/
	 sEtfzco15416A==
From: Arnd Bergmann <arnd@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Parav Pandit <parav@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mark Bloch <mbloch@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: fix linking with CONFIG_INFINIBAND_USER_ACCESS=n
Date: Thu, 10 Jul 2025 10:09:50 +0200
Message-Id: <20250710080955.2517331-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The check for rdma_uattrs_has_raw_cap() is not possible if user
access is disabled:

ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Limit the check to configurations that have the option enabled
and instead assume the capability is not there otherwise.

From what I can tell, the UVERBS code in fs.c is not actually called
when INFINIBAND_USER_ACCESS is turned off, so this haz no effect
other than fixing the link error. A better change might be to not
build the code at all in that configuration, but I did not see
an obvious way to do that.

Fixes: 95a89ec304c3 ("RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If there is a better way of addressing the link failure, please just
treat this as a bug report
---
 drivers/infiniband/hw/mlx5/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index bab2f58240c9..c1ec9aa1dfd3 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2459,7 +2459,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	struct mlx5_ib_dev *dev;
 	u32 flags;
 
-	if (!rdma_uattrs_has_raw_cap(attrs))
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS) ||
+	    !rdma_uattrs_has_raw_cap(attrs))
 		return -EPERM;
 
 	fs_matcher = uverbs_attr_get_obj(attrs,
-- 
2.39.5


