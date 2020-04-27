Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF911BA855
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD0Pq6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgD0Pq5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:46:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA9E2064C;
        Mon, 27 Apr 2020 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002417;
        bh=AwpTALlKEnGgtrKeCvNdxTSDHrxKc0VAlT+rd6LrFHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcnJP+bblBIY/NB7pSc5c+JuuNlFCRu4lZ9MYEEgx+SaXtTQRRc3pZ4B18mq1TUqh
         vm3o903yjfUpsg3iENp7xwZ9PwTLXF+S6GJhSpPxcfAPkaCvjCLiwJPMAyi3q+UWeQ
         qzcFZelVY52iJ4DNpv+j5QA1oXe7OG3jQ3uS/Ak0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 02/36] RDMA/mlx5: Delete impossible GSI port check
Date:   Mon, 27 Apr 2020 18:46:02 +0300
Message-Id: <20200427154636.381474-3-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

GSI QP is created in the kernel with very strict parameters,
there is no possible way that port number will be wrong in
such flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/gsi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 1ae6fd95acaa..1afbf03d1a98 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -123,15 +123,6 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 	const int num_qps = mlx5_ib_deth_sqpn_cap(dev) ? num_pkeys : 0;
 	int ret;
 
-	mlx5_ib_dbg(dev, "creating GSI QP\n");
-
-	if (port_num > ARRAY_SIZE(dev->devr.ports) || port_num < 1) {
-		mlx5_ib_warn(dev,
-			     "invalid port number %d during GSI QP creation\n",
-			     port_num);
-		return ERR_PTR(-EINVAL);
-	}
-
 	gsi = kzalloc(sizeof(*gsi), GFP_KERNEL);
 	if (!gsi)
 		return ERR_PTR(-ENOMEM);
-- 
2.25.3

