Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB31D0F56
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgEMKIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 06:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbgEMKIP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 06:08:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DC820575;
        Wed, 13 May 2020 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364494;
        bh=SPmbzUyKAa+DVV2H6PlQ1HB/zXHA7NDdXmg2nypawOE=;
        h=From:To:Cc:Subject:Date:From;
        b=It/h3eO2zOVod5Bjcj7CvWf+Vm637Np1VV323u6WPgyMJLT82TJ5uFk6GAlV8rof4
         VtS3yJAX79JzHd/Mz0ciMIPyubZoS3oZbLHCSViEinSuXaDro+O+esSl+qacX5NbG2
         LIZvfD7T+stWVfDFzWP3AC+AJKFE2Z6T0B+8lvA4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Fix query_srq_cmd() function
Date:   Wed, 13 May 2020 13:08:09 +0300
Message-Id: <20200513100809.246315-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The output buffer used in mlx5_cmd_exec_inout() was wrongly changed
from pre-allocated srq_out pointer to an input "out" point. That
leads to unpredictable results in the get_srqc() call later.

Fixes: 31578defe4eb ("RDMA/mlx5: Update mlx5_ib to use new cmd interface")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index bc50a712bf2e..6f5eadc4d183 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -169,16 +169,16 @@ static int query_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 	MLX5_SET(query_srq_in, in, opcode, MLX5_CMD_OP_QUERY_SRQ);
 	MLX5_SET(query_srq_in, in, srqn, srq->srqn);
-	err = mlx5_cmd_exec_inout(dev->mdev, query_srq, in, out);
+	err = mlx5_cmd_exec_inout(dev->mdev, query_srq, in, srq_out);
 	if (err)
 		goto out;
 
-	srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
+	srqc = MLX5_ADDR_OF(query_srq_out, srq_out, srq_context_entry);
 	get_srqc(srqc, out);
 	if (MLX5_GET(srqc, srqc, state) != MLX5_SRQC_STATE_GOOD)
 		out->flags |= MLX5_SRQ_FLAG_ERR;
 out:
-	kvfree(out);
+	kvfree(srq_out);
 	return err;
 }
 
-- 
2.26.2

