Return-Path: <linux-rdma+bounces-6195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539D9E1F20
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 15:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F3EB356B1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630E1F4284;
	Tue,  3 Dec 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVA8BANR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99591EB9EB
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233471; cv=none; b=PwrOVhVuPGleRgLhQXCxbJoIZCatgEMH6kF9HSll9hPetBsLxplCE7M2sjEZRrmomF03l/52AYDiqeH4SCuPFc8+bbyRMj4QN/g5sIJafWM2IX2zVT4LdXBj+CReQJUF7Hg7HV8CHCbQbfRpYQhbOSW/1mz7aI1h/WCOYfuIpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233471; c=relaxed/simple;
	bh=oCXka45g+q7Piw+p0YIR2ySYIn0clp1/oFpp74vgTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr0ejxm+8UZc4acWTmO6KA4oGALXfUXZsdMAMiK+LenxiVx4EAcZm3yRSsDg9pUsF2sivlalmHKzNjvy0XMG5L+UjncbbHQCPqfoJy/vjrUE2v+Fk3ur66Mr4ljb5Lp0pHycf+HMKtKOvYFYZWIR0M69YACP6eaa5DBDCTryNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVA8BANR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B42FC4CED6;
	Tue,  3 Dec 2024 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233470;
	bh=oCXka45g+q7Piw+p0YIR2ySYIn0clp1/oFpp74vgTEM=;
	h=From:To:Cc:Subject:Date:From;
	b=fVA8BANRePsW7MLjdLto2s+u0gjTE7ZOk/LvqCy32voJd1HiItCQg/58PT3MsitDD
	 A5QwnwnjvdPA8nSfHPoQxMHuANi+Wo15JGLEIFX9/zCOw3LsVR1LULcfDAt71RJGx4
	 TJE2cCId4/atsgu+sBYlti7VGZoMjKysxhxjK5dqtdjcGDeq5nuXFjr6zw4zbm4Q66
	 4+zn/iIu1EPLYb/jYdSA8Cb4ek0ZYAs2MAAVgME02LQVeeB512x4NBB/aG7zBqA/UK
	 OPIpsj8EzdMRU4nLVElUrHmzNgp/XrSkokF+BmDp+U6JTrnQ/u5//tuImK6GebvYPX
	 alCfEpblFklNg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Avoid false error about access to uninitialized gids array
Date: Tue,  3 Dec 2024 15:44:25 +0200
Message-ID: <6a3a1577463da16962463fcf62883a87506e9b62.1733233426.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Smatch generates the following false error report:
drivers/infiniband/hw/mlx4/main.c:393 mlx4_ib_del_gid() error: uninitialized symbol 'gids'.

Traditionally, we are not changing kernel code and asking people to fix
the tools. However in this case, the fix can be done by simply rearranging
the code to be more clear.

Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c..b1bbdcff631d 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -351,7 +351,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct mlx4_port_gid_table   *port_gid_table;
 	int ret = 0;
 	int hw_update = 0;
-	struct gid_entry *gids;
+	struct gid_entry *gids = NULL;
 
 	if (!rdma_cap_roce_gid_table(attr->device, attr->port_num))
 		return -EINVAL;
@@ -389,10 +389,10 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 	spin_unlock_bh(&iboe->lock);
 
-	if (!ret && hw_update) {
+	if (gids)
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
-		kfree(gids);
-	}
+
+	kfree(gids);
 	return ret;
 }
 
-- 
2.47.0


