Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FF11C8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfLLJM3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfLLJM3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:12:29 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10D524671;
        Thu, 12 Dec 2019 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576141948;
        bh=KAOU8UALTv0liYW62+FKsszLXqpqfDTGypfeC6CD/iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uI5NQ1alcFfJpKTaz00z7CkB4GJZy6OQiWuSBIeSjxobKvSi9VEHcnB69X16EGEtb
         ZjyrtP8JuHhPOXnvFOdlntewX5y6OPd/aaTkuO066Tfiy57+TtqzrzsedtBmbUynL+
         5UbMx0LxZAY9Kyv3XMyIVa7SCrIWLczfLHmnJKBU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.co.il>, Ido Kalir <idok@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Raed Salem <raeds@mellanox.com>
Subject: [PATCH rdma-rc 3/3] IB/mlx5: Fix steering rule of drop and count
Date:   Thu, 12 Dec 2019 11:12:14 +0200
Message-Id: <20191212091214.315005-4-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212091214.315005-1-leon@kernel.org>
References: <20191212091214.315005-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

There are two flow rule destinations: QP and packet. While users are
setting DROP packet rule, the QP should not be set as a destination.

Fixes: 3b3233fbf02e ("IB/mlx5: Add flow counters binding support")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Raed Salem <raeds@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 51100350b688..2f5a159cbe1c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3544,10 +3544,6 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 	}
 
 	INIT_LIST_HEAD(&handler->list);
-	if (dst) {
-		memcpy(&dest_arr[0], dst, sizeof(*dst));
-		dest_num++;
-	}
 
 	for (spec_index = 0; spec_index < flow_attr->num_of_specs; spec_index++) {
 		err = parse_flow_attr(dev->mdev, spec,
@@ -3560,6 +3556,11 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 		ib_flow += ((union ib_flow_spec *)ib_flow)->size;
 	}
 
+	if (dst && !(flow_act.action & MLX5_FLOW_CONTEXT_ACTION_DROP)) {
+		memcpy(&dest_arr[0], dst, sizeof(*dst));
+		dest_num++;
+	}
+
 	if (!flow_is_multicast_only(flow_attr))
 		set_underlay_qp(dev, spec, underlay_qpn);
 
@@ -3600,10 +3601,8 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 	}
 
 	if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
-		if (!(flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT)) {
+		if (!dest_num)
 			rule_dst = NULL;
-			dest_num = 0;
-		}
 	} else {
 		if (is_egress)
 			flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_ALLOW;
-- 
2.20.1

