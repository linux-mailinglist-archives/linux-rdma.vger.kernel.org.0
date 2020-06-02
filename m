Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32D21EBC25
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFBMz7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 08:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgFBMz6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 08:55:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC154206A4;
        Tue,  2 Jun 2020 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591102558;
        bh=pMI6eRLslYCASoIsWsxp6VlaySudpGXDUM673vBl8gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSb1kyaaQmlz+6GDbyIQeerhIxnmHkaw8ZWjOdjxj1eqM4FdJP5Wi+O1I6NOgkyhu
         Jgy1sX42ZoAxQjk9qDw4F2D0GPEotl8QydeVuBPsdR2ZxvjnyagLLyt/qe37RBPrds
         FnN1OBZ+PTYa7jYyxu+IAC2CAVsu1lnfXJk5dv04=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 1/3] RDMA/mlx5: Return an error if copy_to_user fails
Date:   Tue,  2 Jun 2020 15:55:46 +0300
Message-Id: <20200602125548.172654-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602125548.172654-1-leon@kernel.org>
References: <20200602125548.172654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

In theoretical event, the ib_copy_to_udata() can fail, so
return -EFAULT error to the user, so he will destroy the QP.

Fixes: 50aec2c3135e ("RDMA/mlx5: Return ECE data after modify QP")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index bc776542efd3..e8427231cf15 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4305,12 +4305,8 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	/* resp.response_length is set in ECE supported flows only */
 	if (!err && resp.response_length &&
 	    udata->outlen >= resp.response_length)
-		/*
-		 * We don't check return value of the function below
-		 * on purpose, because it is unclear how to unwind the
-		 * error flow after QP was modified to the new state.
-		 */
-		ib_copy_to_udata(udata, &resp, resp.response_length);
+		/* Return -EFAULT to the user and expect him to destroy QP. */
+		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 
 out:
 	mutex_unlock(&qp->mutex);
-- 
2.26.2

