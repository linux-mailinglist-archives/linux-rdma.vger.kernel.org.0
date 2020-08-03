Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5D239F5B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHCF6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 01:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgHCF6z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Aug 2020 01:58:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755A220678;
        Mon,  3 Aug 2020 05:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596434334;
        bh=62DyfZVI/tE2AV8v/cnpysnfgi7K425vJAZCp31eFII=;
        h=From:To:Cc:Subject:Date:From;
        b=sHlaPWfYDF604Tz4b/5IwQaEaglz4rURQXpVndg653UAPAbuRasY5Laeg8AR+txmG
         xPmGYap2whNjwUzZRTskXJ0wvvLM+eWtThjB+5165nVDeLCZk2Y4TnH0AxjNZ1CpVl
         ug3CEtADHOHYg3N5eu+/O8ertG6RlAzZQbUKKYgQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix flow destination setting for RDMA TX flow table
Date:   Mon,  3 Aug 2020 08:58:49 +0300
Message-Id: <20200803055849.14947-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

For RDMA TX flow table, set destination type to be 'port' and prevent
creation of flows with TIR destination.

As RDMA TX is an egress flow table the rules on this flow table should
not forward traffic back to the NIC and should set the destination to be
the port.

Without the setting of this destination type flow rules on the RDMA TX
flow tables are not created as FW invokes a syndrome for undefined
destination for the rule.

Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index fbbb1adac273..d75f461eba50 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1866,12 +1866,14 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 		else
 			*dest_id = mqp->raw_packet_qp.rq.tirn;
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS) {
+	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
+		   fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) {
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 	}

 	if (*dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
-	    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS)
+	    (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
+	     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX))
 		return -EINVAL;

 	return 0;
--
2.26.2

