Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2828337556
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhCKOUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 09:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhCKOUa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 09:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98DAB64E87;
        Thu, 11 Mar 2021 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615472430;
        bh=F3Y+zsY+3inViX1OymqD8RbVm594s99tvw7999drW7s=;
        h=From:To:Cc:Subject:Date:From;
        b=b1Av7nSvSOj+iNYu0jTETsSQuUuJnbcQfW/zGWbU439aYnqH4IWqH8twGY0xCtAcL
         8A5ixg0vRS4nXG8xlpvMCuj1WaB+Sj8MZDgJ7dyposJuOaXhFMHissQCAZY9Wyusdm
         Ol1x5TusOsL0iV/NKuCLJHcRfwojuQUck4nUtrTo/YN4FFumnz8puCBlhJS0JlJO86
         3HHujz48T83GOkL5QJNIZWAO8Kho/ckh8PZGCPYeh24GJdP0jIRsry3Qzi0kmtW9PM
         NqW5anf+WE7dWZ7dJ+V3uMQfhxfRFSfry7SKI4KI2OVAJ/UF8YAFVTrETWbcvV593w
         sjmxQDlVzgnYA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, Ido Kalir <idok@mellanox.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix typo when prepare destroy_mkey inbox
Date:   Thu, 11 Mar 2021 16:20:24 +0200
Message-Id: <20210311142024.1282004-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Set mkey_index to correct place when prepare destroy_mkey inbox,
this will fix the following syndrome/

 mlx5_core 0000:08:00.0: mlx5_cmd_check:782:(pid 980716): DEALLOC_PD(0x801)
 op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x31b635)

Cc: stable@vger.kernel.org
Fixes: 1368ead04c36 ("RDMA/mlx5: Use strict get/set operations for obj_id")
Reviewed-by: Ido Kalir <idok@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index b78b5f18306d..3678b0a8710b 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1116,7 +1116,7 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 	case MLX5_CMD_OP_CREATE_MKEY:
 		MLX5_SET(destroy_mkey_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_MKEY);
-		MLX5_SET(destroy_mkey_in, in, mkey_index, *obj_id);
+		MLX5_SET(destroy_mkey_in, din, mkey_index, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_CQ:
 		MLX5_SET(destroy_cq_in, din, opcode, MLX5_CMD_OP_DESTROY_CQ);
--
2.29.2

