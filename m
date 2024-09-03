Return-Path: <linux-rdma+bounces-4713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA007969B9F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73991C218D4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91F1A42AC;
	Tue,  3 Sep 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCGLevRT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14B1A42B3
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362701; cv=none; b=Ui6IbvCim43uN0GVpzWoxBaEtU03bczMsUH8OxPE/CZZ4Nx2nGMbSXSovlC84R6s8vERVqiT70d6CzkDGL0UG9mxTkFoNcjLMC5SqXFhuXyskwXMETpQ7JeorF0CREgB2ZKZJOIL8HG5L6EjINQ03ovV02xlkeVPFFGuJrRsZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362701; c=relaxed/simple;
	bh=fa3ycwiM0Bg3dtKd5t0gU3cuqlPSHGb5AplZmuP2KtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGzipTKEcSE3NdTAnbw4445016FDl95K1lHVaTAv91rudRxCZokOFPDgeSKT74ZMPYd8T0uOsMMbybbA9FMPkRutyR/6rCQCyPLLaCYVmkHyGwVcTKvmgMxuR8yxy0TV/UEXohuOahNIebo1vv2ESd1iPAqDiOEskZQeQKg0yTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCGLevRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B7BC4CEC4;
	Tue,  3 Sep 2024 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362701;
	bh=fa3ycwiM0Bg3dtKd5t0gU3cuqlPSHGb5AplZmuP2KtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCGLevRTmbmQRRqUDqKVthcq3mzcjQjCK+GyAu5hORH7oY8ld0W8RRAjL7Hlpr0hK
	 AtPDj+WS2H+7ceSP0yDhrwCd5kwJpfmtPLNyekhgIns3CHeqAtRscHntFTLzr4NEt4
	 Oog43Sz0l8Uxj9lxqj29/QGVabL8HjKZAUzlHyGUcylv08TD+3IVw5NCGX7WZPMa6t
	 fZnmkVm0IsaDCt0YHkq2HqhPY8rt44Bo1QRYgNYGOaBJbQG4NYS6AgLjqXXeGTNzCz
	 wbgJdeIPUkxIx/WDRA0VXKDYQf92i+jGZjrR5h6vsYIWxgjES7dXgrjvyS6yb11JIl
	 pG3Hsv5PApszA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 1/4] RDMA/mlx5: Drop redundant work canceling from clean_keys()
Date: Tue,  3 Sep 2024 14:24:47 +0300
Message-ID: <943d21f5a9dba7b98a3e1d531e3561ffe9745d71.1725362530.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362530.git.leon@kernel.org>
References: <cover.1725362530.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

The canceling of dealyed work in clean_keys() is a leftover from years
back and was added to prevent races in the cleanup process of MR cache.
The cleanup process was rewritten a few years ago and the canceling of
delayed work and flushing of workqueue was added before the call to
clean_keys().

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6829e3688b60..3945df08beec 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -772,7 +772,6 @@ static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 {
 	u32 mkey;
 
-	cancel_delayed_work(&ent->dwork);
 	spin_lock_irq(&ent->mkeys_queue.lock);
 	while (ent->mkeys_queue.ci) {
 		mkey = pop_mkey_locked(ent);
-- 
2.46.0


