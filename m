Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01734239F64
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHCGCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgHCGCV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Aug 2020 02:02:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C64220678;
        Mon,  3 Aug 2020 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596434541;
        bh=6BXkjP6+mcQZKKuLlATdY3kfL5UYRkZ2sTDXif65aSk=;
        h=From:To:Cc:Subject:Date:From;
        b=O7LpT7GxiR1bThYd2NhLkCYltkXcqw4c6qDyMTX0iFArOVOwprw5XD1ZeAdgGVLjW
         z5kFQzlX7MbPB9aOIJ0bsDY2p72ITZBbdwk9BJHS00QUvrRvA72IqYxYYmXr0lHRni
         LDCrtTb0x5kP6XiBt/b/EbGieBoeBnNueYGzR9LU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Enable sniffer when device is in switchdev mode
Date:   Mon,  3 Aug 2020 09:02:14 +0300
Message-Id: <20200803060214.15328-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

In order to allow sniffer when the RDMA device is in switchdev mode,
we don't need to set the source port when creating the sniffer rule.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Sorry for being late and sending this in merge window, this patch is
small enough to be taken anyway. It was in my queue for a weeks already,
simply missed it.

Thanks
---
 drivers/infiniband/hw/mlx5/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 1a7e6226f11a..fbbb1adac273 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -954,7 +954,7 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 	if (!flow_is_multicast_only(flow_attr))
 		set_underlay_qp(dev, spec, underlay_qpn);

-	if (dev->is_rep) {
+	if (dev->is_rep && flow_attr->type != IB_FLOW_ATTR_SNIFFER) {
 		struct mlx5_eswitch_rep *rep;

 		rep = dev->port[flow_attr->port - 1].rep;
@@ -1116,6 +1116,7 @@ static struct mlx5_ib_flow_handler *create_sniffer_rule(struct mlx5_ib_dev *dev,
 	int err;
 	static const struct ib_flow_attr flow_attr  = {
 		.num_of_specs = 0,
+		.type = IB_FLOW_ATTR_SNIFFER,
 		.size = sizeof(flow_attr)
 	};

--
2.26.2

