Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945681BA8C9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgD0PsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgD0PsN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D78A20661;
        Mon, 27 Apr 2020 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002493;
        bh=xENY5ur1nU/tNXzq4DYvLG+ws8fSZcBIMJuWaw+CMmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnhZRlcSWJ+UdcS1X7kHCOWTTnVsr12CkJyPmek8gO5eyhKmG9Rp3Z9OpbS2FKYJE
         78dYUT0hPmmexslQWOsV7AVbfCMYDJm4whmgvUK3wWaPIvreLt5Zr7GFZ8pkAQrFtV
         fW5KQhaHvR5RH+3AK8AtZBSbmKwGuw9CqfSOxgoo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 25/36] RDMA/mlx5: Delete impossible inlen check
Date:   Mon, 27 Apr 2020 18:46:25 +0300
Message-Id: <20200427154636.381474-26-leon@kernel.org>
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

The inlen is set to be above zero in all flows before
and can't be negative at this stage.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 74f09cdb4a33..5a43128d651b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2107,11 +2107,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->flags &= ~IB_QP_CREATE_PCI_WRITE_END_PADDING;
 	}
 
-	if (inlen < 0) {
-		err = -EINVAL;
-		goto err;
-	}
-
 	if (init_attr->qp_type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
@@ -2156,8 +2151,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		destroy_qp_user(dev, pd, qp, base, udata);
 	else
 		destroy_qp_kernel(dev, qp);
-
-err:
 	kvfree(in);
 	return err;
 }
-- 
2.25.3

