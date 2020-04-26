Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697721B8DBA
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDZH70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 03:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZH70 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 03:59:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF41206D4;
        Sun, 26 Apr 2020 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587887965;
        bh=PhY7UALwu0nmvMDGM3Z6XFxPGK70ZhEvYwgSOFhFC7g=;
        h=From:To:Cc:Subject:Date:From;
        b=dwPkaRzC0gp2OUdMJDFpAYz0LknnXjjkHGn37RMzkcbABzJMgQkP/mEaDwBedueNG
         kJFKtkokZmIg3x9xdtPqIJoCH3VmJ0rKQWLdNndUYXL4vQHC0fln7KtqKRH7BziTKo
         aBsEkkrNyMCEAZOfjUoNGSaLKn+bozDlZSefq9zg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] IB/mlx4: Test return value of calls to ib_get_cached_pkey
Date:   Sun, 26 Apr 2020 10:59:21 +0300
Message-Id: <20200426075921.130074-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

In the mlx4_ib_post_send() flow, some functions call ib_get_cached_pkey()
without checking its return value. If ib_get_cached_pkey() returns
an error code, these functions should return failure.

Fixes: 1ffeb2eb8be9 ("IB/mlx4: SR-IOV IB context objects and proxy/tunnel SQP support")
Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
Fixes: e622f2f4ad21 ("IB: split struct ib_send_wr")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 2f9f78912267..cf51e3cbd969 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -2891,6 +2891,7 @@ static int build_sriov_qp0_header(struct mlx4_ib_sqp *sqp,
 	int send_size;
 	int header_size;
 	int spc;
+	int err;
 	int i;

 	if (wr->wr.opcode != IB_WR_SEND)
@@ -2925,7 +2926,9 @@ static int build_sriov_qp0_header(struct mlx4_ib_sqp *sqp,

 	sqp->ud_header.lrh.virtual_lane    = 0;
 	sqp->ud_header.bth.solicited_event = !!(wr->wr.send_flags & IB_SEND_SOLICITED);
-	ib_get_cached_pkey(ib_dev, sqp->qp.port, 0, &pkey);
+	err = ib_get_cached_pkey(ib_dev, sqp->qp.port, 0, &pkey);
+	if (err)
+		return err;
 	sqp->ud_header.bth.pkey = cpu_to_be16(pkey);
 	if (sqp->qp.mlx4_ib_qp_type == MLX4_IB_QPT_TUN_SMI_OWNER)
 		sqp->ud_header.bth.destination_qpn = cpu_to_be32(wr->remote_qpn);
@@ -3212,9 +3215,14 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 	}
 	sqp->ud_header.bth.solicited_event = !!(wr->wr.send_flags & IB_SEND_SOLICITED);
 	if (!sqp->qp.ibqp.qp_num)
-		ib_get_cached_pkey(ib_dev, sqp->qp.port, sqp->pkey_index, &pkey);
+		err = ib_get_cached_pkey(ib_dev, sqp->qp.port, sqp->pkey_index,
+					 &pkey);
 	else
-		ib_get_cached_pkey(ib_dev, sqp->qp.port, wr->pkey_index, &pkey);
+		err = ib_get_cached_pkey(ib_dev, sqp->qp.port, wr->pkey_index,
+					 &pkey);
+	if (err)
+		return err;
+
 	sqp->ud_header.bth.pkey = cpu_to_be16(pkey);
 	sqp->ud_header.bth.destination_qpn = cpu_to_be32(wr->remote_qpn);
 	sqp->ud_header.bth.psn = cpu_to_be32((sqp->send_psn++) & ((1 << 24) - 1));
--
2.25.3

