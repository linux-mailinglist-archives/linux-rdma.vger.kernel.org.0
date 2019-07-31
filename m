Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579437C03A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfGaLkY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfGaLkY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 07:40:24 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0470C2089E;
        Wed, 31 Jul 2019 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564573223;
        bh=C/Gz4t24d4mCTjpzKyETFE6k2PDAfdF6m7qnsGffUZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cchqIuV2hehAlWU2SYyLztiDYsYxvQYnNjHTXwjBAJZ6kd1F6XzABmYdvAvfVlNPt
         zmEttUd/wEN1WiVdJhWV5NC2zn4H1ikeNCvuHyDb9YMWm5vQxI7vVUlIxJwt2RpYxG
         pIytidv+JFR+9BPBXOcLpLdODdkrPWV6Oj+t1Xqo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Aviv Heller <avivh@mellanox.com>
Subject: [PATCH rdma-next 2/2] IB/mlx5: Support MLX5_CMD_OP_QUERY_LAG as a DEVX general command
Date:   Wed, 31 Jul 2019 14:40:14 +0300
Message-Id: <20190731114014.4786-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731114014.4786-1-leon@kernel.org>
References: <20190731114014.4786-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

The "MLX5_CMD_OP_QUERY_LAG" is one of the DEVX general commands, add it.

Fixes: 8aa8c95ce4cc ("IB/mlx5: Add support for DEVX general command")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index a527cf7f01ac..fd577ffd7864 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -930,6 +930,7 @@ static bool devx_is_general_cmd(void *in, struct mlx5_ib_dev *dev)
 	case MLX5_CMD_OP_QUERY_CONG_STATUS:
 	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
 	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
+	case MLX5_CMD_OP_QUERY_LAG:
 		return true;
 	default:
 		return false;
-- 
2.20.1

