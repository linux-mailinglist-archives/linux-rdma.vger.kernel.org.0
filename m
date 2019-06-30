Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC65B07B
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfF3Psk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 11:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfF3Psk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 11:48:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D8420673;
        Sun, 30 Jun 2019 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561909719;
        bh=BSHGkWftBv8LIaYpaZ5QSlU6A7nS5mkpR0VD8cYNw24=;
        h=From:To:Cc:Subject:Date:From;
        b=A4l4RlRnNdVnfaBiddpmwB8Ai7M5Qvyt2cOTvLDVUlk8Vfxp2iZJMjrC01zTdaZLg
         0In/xNBCimcK7DrGpzb/jtErVMs2rbKlAetf+1BwWMZ/iCR3FcNJ1DmmBdoEB0Dztf
         ntSr9GJ9HYJhyCR/r5VqV9A7Hu4AewT0UwUdcJmU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/mlx5: Use proper allocation API to get zeroed memory
Date:   Sun, 30 Jun 2019 18:48:32 +0300
Message-Id: <20190630154832.21388-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need in custom memory zeroing, because it can be done
by using kzalloc from the beginning.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index aa5af73acfc7..6686f8f876f0 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4682,7 +4682,7 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 	int err = -ENOMEM;
 	struct ib_udata uhw = {.inlen = 0, .outlen = 0};
 
-	pprops = kmalloc(sizeof(*pprops), GFP_KERNEL);
+	pprops = kzalloc(sizeof(*pprops), GFP_KERNEL);
 	if (!pprops)
 		goto out;
 
@@ -4696,7 +4696,6 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 		goto out;
 	}
 
-	memset(pprops, 0, sizeof(*pprops));
 	err = mlx5_ib_query_port(&dev->ib_dev, port, pprops);
 	if (err) {
 		mlx5_ib_warn(dev, "query_port %d failed %d\n",
-- 
2.20.1

