Return-Path: <linux-rdma+bounces-1754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6C8969E2
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E60B2299C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F26EB51;
	Wed,  3 Apr 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOVmPh9I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22856471
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135033; cv=none; b=XWJLgEQZaz+QL5sKqRwIQC/OB9NRHEwnfVZdVwdZ4gU9A34dQVpNHsTbdDw/MtKdcGLr07M0GN0X1RphQc27jaG156KKoM0hUbsOhSx9E/FtF05B6d4RkM9oYGArZUhLCKn7t00u2kMnW6EqdPuX8k+7BzSVV3AyYeWI1EiwdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135033; c=relaxed/simple;
	bh=i0u5bC6Vc59Xg059z2gFdTdez3pj9wHsX/gxdM08/7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kafKY1L8D+09bczsv0QlgirX+2Vvc9PSw9mZnmDjPBea/qdKJ16IFQjfPt6HI0DEj2n4j6dRcycuDvlWaiDpyub991KgGzs5+VSLEKCtftKWpcwykY+u+6YBBb9Bx444Nibcib/UrvmUVlyA4HtecuvcilGrtP/Owfa8TBg1XfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOVmPh9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD547C433F1;
	Wed,  3 Apr 2024 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712135033;
	bh=i0u5bC6Vc59Xg059z2gFdTdez3pj9wHsX/gxdM08/7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=vOVmPh9INjfRS8z2AtyPiLky8OmRufZ10rv7QVcl+MXDgbA8o4RGpLvdNrTHHASOE
	 /ptPv11f3TSFvIXC2/uyW/csMh6//IypgnfnMU/f66J8l9d0dmPWnJ3Sr0OsLf+G8b
	 um2R6Iakj3CQDADkSyIRSKDL/bUXgJvrKFw/y58qjag3L4+saitl4NzFV7gsKlGBFI
	 QoD39Zb04MX3G9JyDjv/UdIO3KfaL/ivOi0ph5ASUa+wYLkgNHZI2ytWE4voRjCY+L
	 3+kLdnKaT/RBgx+H1GiDSrgQf7PrpbTn4wIQriIoaL2OziwCKLkakee23mCHOO7KEL
	 Ad7h8P+RHks0Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix port number for counter query in multi-port configuration
Date: Wed,  3 Apr 2024 12:03:46 +0300
Message-ID: <9bfcc8ade958b760a51408c3ad654a01b11f7d76.1712134988.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Set the correct port when querying PPCNT in multi-port configuration.
Distinguish between cases where switchdev mode was enabled to multi-port
configuration and don't overwrite the queried port to 1 in multi-port
case.

Fixes: 74b30b3ad5ce ("RDMA/mlx5: Set local port to one when accessing counters")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 0c3c4e64812c..3e43687a7f6f 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -188,7 +188,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 		mdev = dev->mdev;
 		mdev_port_num = 1;
 	}
-	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1) {
+	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1 &&
+	    !mlx5_core_mp_enabled(mdev)) {
 		/* set local port to one for Function-Per-Port HCA. */
 		mdev = dev->mdev;
 		mdev_port_num = 1;
-- 
2.44.0


