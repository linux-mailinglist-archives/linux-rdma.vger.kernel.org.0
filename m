Return-Path: <linux-rdma+bounces-2633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D48D1BBA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D919BB2597E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3916DEB0;
	Tue, 28 May 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxZwnYVk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4F16D9AA
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900813; cv=none; b=FKzVx191lr8DFiX7AZSu4PCwCaCoBQSillSMA1N2sjqwmJ/ARqgO8nY35gKbfi2CuBOnAvNfBE8uJ17BvLHm9JZhMBGwLE7975fK5mv3udKO/wW+PEJXvPZuqXJR/Apw6xpnQ+fzZmTcqyhCQnod4lBwTBTMwbfCpB6nxjlwNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900813; c=relaxed/simple;
	bh=j2OYHNjPbW6hoVk6/0XlL3jE4lhTroPogrU5k0LNsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7NqXHTHx3Sb5qE868eKJOIm3lVowbkNqqGp6meRmfqAM4ohQGH95NIoijIS6V+C2UdUIoBYn2mQk2GE8HMqHY9lcFTiZRE2mOC9DNcM3Nwa0+7zfY/H/08jvr3HlyjVGUfw59IaibYXxon7Bo4ty7c3pZloWR7fUAghQEwBHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxZwnYVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48966C3277B;
	Tue, 28 May 2024 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716900812;
	bh=j2OYHNjPbW6hoVk6/0XlL3jE4lhTroPogrU5k0LNsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxZwnYVkAt16lE4BQ7v7Knl/EB90y4uPCxRp32d6GBp5LFEsIAjxtzx1HoKCODDu1
	 q4t+WkIKH1AcGr7dwyPAqbzUz2y979tyx1TJCI4CUT7zB5mi2aYNGZF0auVedbZVyF
	 S9qpWYeVpW9s3tp//PDlzu7e5kQU3Tsk2wIgUBMoEp4IeG7+CZ0PwhdTXCL0DddmCO
	 nSIOu/PnPBbFUGoFVKQYZX6jDzE8hEJIXsctRZnexmH9ad4byc4csdSvG2Wk50393W
	 Y/h7cpyFOcRtZqtXHzttAkaarUPUrYPdvPC9w2aJfhsAZTJ53/Wvn/rFnwt0KyuOo0
	 iF5kaee1vqr5w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc 6/6] RDMA/mlx5: Add check for srq max_sge attribute
Date: Tue, 28 May 2024 15:52:56 +0300
Message-ID: <277ccc29e8d57bfd53ddeb2ac633f2760cf8cdd0.1716900410.git.leon@kernel.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

max_sge attribute is passed by the user, and is inserted and used
unchecked, so verify that the value doesn't exceed maximum allowed value
before using it.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index a056ea835da5..84be0c3d5699 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -199,17 +199,20 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	int err;
 	struct mlx5_srq_attr in = {};
 	__u32 max_srq_wqes = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
+	__u32 max_sge_sz =  MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
+			    sizeof(struct mlx5_wqe_data_seg);
 
 	if (init_attr->srq_type != IB_SRQT_BASIC &&
 	    init_attr->srq_type != IB_SRQT_XRC &&
 	    init_attr->srq_type != IB_SRQT_TM)
 		return -EOPNOTSUPP;
 
-	/* Sanity check SRQ size before proceeding */
-	if (init_attr->attr.max_wr >= max_srq_wqes) {
-		mlx5_ib_dbg(dev, "max_wr %d, cap %d\n",
-			    init_attr->attr.max_wr,
-			    max_srq_wqes);
+	/* Sanity check SRQ and sge size before proceeding */
+	if (init_attr->attr.max_wr >= max_srq_wqes ||
+	    init_attr->attr.max_sge > max_sge_sz) {
+		mlx5_ib_dbg(dev, "max_wr %d,wr_cap %d,max_sge %d, sge_cap:%d\n",
+			    init_attr->attr.max_wr, max_srq_wqes,
+			    init_attr->attr.max_sge, max_sge_sz);
 		return -EINVAL;
 	}
 
-- 
2.45.1


