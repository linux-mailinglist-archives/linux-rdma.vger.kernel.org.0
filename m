Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38D1B0F68
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDTPL3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgDTPL3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9235A2074F;
        Mon, 20 Apr 2020 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395489;
        bh=RXNvQ/cT/QXAv1L+OKmfuU3SIQOPNVZkqtALMcYuwlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2smS0g43TYqTnx15JG3CPj4oMnLK73YOdPJxNOmyLSr7JlB1lYZT0E3gpXVgU/Uq/
         TPIN+eiajGu1YU+h6ju7XTXvyFpZzZCwIOvYmBCl6QzOjZdzd9uYvZkhRogIG6uHrW
         eO3fMIq9nF95P48pXe02UFG7pLjOQ5ERFSfzDd4k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 05/18] RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
Date:   Mon, 20 Apr 2020 18:10:52 +0300
Message-Id: <20200420151105.282848-6-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420151105.282848-1-leon@kernel.org>
References: <20200420151105.282848-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to set NULL in recv_cq and send_cq, they are already
set to NULL by the IB/core logic.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6a025153cb93..2039f5391e20 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2771,14 +2771,8 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		}
 	}
 
-	if (init_attr->qp_type == IB_QPT_XRC_TGT) {
-		init_attr->recv_cq = NULL;
+	if (init_attr->qp_type == IB_QPT_XRC_TGT)
 		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
-		init_attr->send_cq = NULL;
-	}
-
-	if (init_attr->qp_type == IB_QPT_XRC_INI)
-		init_attr->recv_cq = NULL;
 
 	err = create_qp_common(dev, pd, init_attr, udata, qp);
 	if (err) {
-- 
2.25.2

