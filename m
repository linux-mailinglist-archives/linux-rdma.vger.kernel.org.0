Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEA18E8FD
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2020 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCVMtP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Mar 2020 08:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgCVMtP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Mar 2020 08:49:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010AF2072E;
        Sun, 22 Mar 2020 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584881354;
        bh=E5aYA+KdW4T8uVmi3X0YlMWQ/Kipc8u8HklZv0haG/E=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLVPcA4aiShZzJ/fa3p1hJ/rJ81gHs5PYvMxQ+tU5uCKBFHIAf8ZGx5ZMySUrRsP6
         15tyUkxIliDW1nsoIWW/GieGDDlPNjBj9lhqBRp920Z84zVqMrP4bVczQMzd5CtyiD
         W56QxDbRzKK1VfErCtCX5Yt2trZ6J/JuBySXiJqU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc v1] RDMA/mlx5: Block delay drop to unprivileged users
Date:   Sun, 22 Mar 2020 14:49:06 +0200
Message-Id: <20200322124906.1173790-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Since this feature can globally block the RX port, it should
be allowed to privileged users only.

Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog:
 v1: Changed permission from CAP_NET_RAW to be CAP_SYS_RAWIO like in
    the devx code.
 v0: https://lore.kernel.org/linux-rdma/20200318100223.46436-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/qp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d3055f3eb0b6..cf44c5a21f18 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6247,6 +6247,10 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);

+	if (!capable(CAP_SYS_RAWIO) &&
+	    init_attr->create_flags & IB_WQ_FLAGS_DELAY_DROP)
+		return ERR_PTR(-EPERM);
+
 	dev = to_mdev(pd->device);
 	switch (init_attr->wq_type) {
 	case IB_WQT_RQ:
--
2.24.1

