Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6531D0DF1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgEMJzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbgEMJzz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:55:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F284920769;
        Wed, 13 May 2020 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363754;
        bh=74Eo1OYXFY/PCrsmgylhrMjCqizfLopYS38jpYsjEMg=;
        h=From:To:Cc:Subject:Date:From;
        b=EPg6PAu0az3xtWGYpJ1K06p1y3HLzIu/tafMCdZWReZwXTWHQrJQV8NWXOndHoPwy
         N8/UdqRtmLNzFQlHp9Roi1Di+lXXvjKA92qBkcc71KIVx9w0qSmYMlV3db4YtXq7O+
         Oeh6YJirkfRqFg2cuwFONL803e3bHjAH6cA32q1U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Aharon Landau <aharonl@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Add init2init as a modify command
Date:   Wed, 13 May 2020 12:55:50 +0300
Message-Id: <20200513095550.211345-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@mellanox.com>

Missing INIT2INIT entry in the list of modify commands caused that
DEVX applications can't modify QP for this transition state. Add
the MLX5_CMD_OP_INIT2INIT_QP opcode to the list of allowed DEVX
opcodes.

Fixes: e662e14d801b ("IB/mlx5: Add DEVX support for modify and query commands")
Signed-off-by: Aharon Landau <aharonl@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index e11fa7cde254..3047e7d60a9b 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -820,6 +820,7 @@ static bool devx_is_obj_modify_cmd(const void *in)
 	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
 	case MLX5_CMD_OP_RST2INIT_QP:
 	case MLX5_CMD_OP_INIT2RTR_QP:
+	case MLX5_CMD_OP_INIT2INIT_QP:
 	case MLX5_CMD_OP_RTR2RTS_QP:
 	case MLX5_CMD_OP_RTS2RTS_QP:
 	case MLX5_CMD_OP_SQERR2RTS_QP:
-- 
2.26.2

