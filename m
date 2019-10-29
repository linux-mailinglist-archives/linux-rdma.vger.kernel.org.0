Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE08E7FF9
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 06:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJ2F52 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 01:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfJ2F52 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 01:57:28 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB6E2053B;
        Tue, 29 Oct 2019 05:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572328648;
        bh=fMQxvmT9rkf2KoAAY3aRiYT4G1la/kj4vKrfyou7f4s=;
        h=From:To:Cc:Subject:Date:From;
        b=EshY2Yyr0pB6lYEz/WMLZa8Wq/ud84gl2gcxUDDnUEcoTfz+o6quVOC8w/MDvt293
         kiJr3J2J/2GoIbH9s6z7AymlMedgycg4cArJrDrb4bo5BPfuuv8ZvS4teXld5P68uE
         RaiTfu949zT1KwZHuBXrIh3GXBvreXfP04/N5+r4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Return proper error value
Date:   Tue, 29 Oct 2019 07:57:21 +0200
Message-Id: <20191029055721.7192-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Returned value from mlx5_mr_cache_alloc() is checked to be error
or real pointer. Return proper error code instead of NULL which
is not checked later.

Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 7019c12005f4..99d563dba91b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -428,7 +428,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry)
 
 	if (entry < 0 || entry >= MAX_MR_CACHE_ENTRIES) {
 		mlx5_ib_err(dev, "cache entry %d is out of range\n", entry);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	ent = &cache->ent[entry];
-- 
2.20.1

