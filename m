Return-Path: <linux-rdma+bounces-1758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F882896CAD
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816211C26249
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D122137C33;
	Wed,  3 Apr 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDvYS7kH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA3134CCA
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140582; cv=none; b=DeWW+Y1F/aV7RD5RppeEFLIZPdWZDUxavgi+mSVWWAkTGCs14j+BmRs5uULo7secV9/+mL5RKCNYTySMjCosgwjou7uRPSibHor/7GBI51FlKDMZCuB2C/eP1BEt49VCDK4pnsn3XsdH410bH3PWBL7GeCFa1CWcZxvtdzqINMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140582; c=relaxed/simple;
	bh=hfGZW4mkZ5Kxage6JgCUtZjIlIoeRXr7pULrTdQgC2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj65fQyGVuDnCdXiQy8a/MuPOklzZ3lA3+nm7X2PjEB1N3Sxc7YrJqT+3di9cxkHZdpDJ+phaW4CcaiJnNr0wFTrkp30PAjNMjPjonOU9S77KAmIzeOzbPwcZw4u0jl1Utmq+5KSeBtYfTPS+oAdK5+AaaBusuCdPdxZCsdyx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDvYS7kH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02618C433C7;
	Wed,  3 Apr 2024 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712140581;
	bh=hfGZW4mkZ5Kxage6JgCUtZjIlIoeRXr7pULrTdQgC2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDvYS7kHPzP+2cWNK1XdyDfuxhTKb5dUrXSPUt86PnWAP72Db05UQqa0RbHpAwern
	 hkOiJRPF88FU3zXWCWKqoa4oZ/pQWpCuIK1Lj8VU0+6LDawKffQdeia5EP8pZqBxdw
	 jcVidrCeur+tr4CXHY2/deRMd9/OHwo/mIxVqf3ffTnqW3nMEAq9PZhI8P6btiJyp6
	 V4DX9uPTsdOkhOXS2/8EQoOpuc9A4PNDVC4nzVRZL05h9Q7sbnjr5Bv7BhNaOFnTqS
	 JtbY66zHZCgRf31x93xi4XFhGARAJK+xaJlXhjfOZVrlqoiHo4+E8rdCJsFiPTRTml
	 0wD23vr+DTWsA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 3/3] RDMA/mlx5: Adding remote atomic access flag to updatable flags
Date: Wed,  3 Apr 2024 13:36:01 +0300
Message-ID: <24dac73e2fa48cb806f33a932d97f3e402a5ea2c.1712140377.git.leon@kernel.org>
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

Currently IB_ACCESS_REMOTE_ATOMIC is blocked from being updated via UMR
although in some cases it should be possible. These cases are checked in
mlx5r_umr_can_reconfig function.

Fixes: ef3642c4f54d ("RDMA/mlx5: Fix error unwinds for rereg_mr")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 7f7b1f59b5f0..ecc111ed5d86 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1572,7 +1572,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING |
+		      IB_ACCESS_REMOTE_ATOMIC))
 		return false;
 	return mlx5r_umr_can_reconfig(dev, current_access_flags,
 				      target_access_flags);
-- 
2.44.0


