Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2811B642C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgDWTDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDWTDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:03:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E9C20767;
        Thu, 23 Apr 2020 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668615;
        bh=8JwVP5YP+s3akMNSohsWrxSEQR1hzVD4YhmlqRjnsHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4YVK9VFRmpQs6yZecwS4VpBsaqHGMqMFgRhw+xlIEI9W+UJ91GkdUUwQMAcUroR3
         JDJ4i1hReMQ+NEJP0xa0lkebk44qDGI80WU6we4uvc6zQc0+mo5tzWthNiAIXy+idC
         hbDj3mHrmMX2C81YxA3jAxpykVIL7hWhruya/Gj8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 07/18] RDMA/mlx5: Delete impossible inlen check
Date:   Thu, 23 Apr 2020 22:02:52 +0300
Message-Id: <20200423190303.12856-8-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423190303.12856-1-leon@kernel.org>
References: <20200423190303.12856-1-leon@kernel.org>
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
index 007163753f6f..9c9c9e3c793f 100644
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

