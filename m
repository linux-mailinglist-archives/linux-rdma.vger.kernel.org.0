Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791A91C69E4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEFHQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFHQT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:16:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE5D20663;
        Wed,  6 May 2020 07:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588749379;
        bh=cln4EIe2p9HSFyTA4G2rYtcCEy8eqf34l1Jb5gzaJX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBf/SVdXrqy+N1a80KSPINPm/fS8g5USjQLkKLGASQVznfNDcWdR2WFkHLwlt2TlD
         FH8mUAeJvETDIQFW0PuXXog1NIDbaLXEoElPSyAHcqS7hjydgey2nA9GISBxf27Uwx
         t2PWWJu99KC76mrmNSfuk83G+Tjrroxo1VgXuOWo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabled
Date:   Wed,  6 May 2020 10:16:02 +0300
Message-Id: <20200506071602.7177-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506071602.7177-1-leon@kernel.org>
References: <20200506071602.7177-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <markb@mellanox.com>

When operating in switchdev mode or using devlink to disable RoCE
only raw Ethernet QPs are allowed to be created.

When in switchdev mode this can lead to passing an invalid port number
as part of the modify qp firmware cmd and will lead to a syndrome
reported back to the user, such as:

 * mlx5_cmd_check:803:(pid 50148): RST2INIT_QP(0x502) op_mod(0x0) failed,
   status bad parameter(0x3), syndrome (0x177405).

Internal UD QP might be used to test for write combining support (even if
externally we report RoCE as disabled) check for that specific flag and
allow is specifically.

Fixes: b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
Signed-off-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index fb2ea3bf9be4..40150595fdbb 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2436,15 +2436,17 @@ static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
 		if (!MLX5_CAP_GEN(dev->mdev, xrc))
 			goto out;
 		fallthrough;
-	case IB_QPT_RAW_PACKET:
 	case IB_QPT_RC:
 	case IB_QPT_UC:
-	case IB_QPT_UD:
 	case IB_QPT_SMI:
 	case MLX5_IB_QPT_HW_GSI:
-	case MLX5_IB_QPT_REG_UMR:
 	case IB_QPT_DRIVER:
 	case IB_QPT_GSI:
+		if (dev->profile == &raw_eth_profile)
+			goto out;
+	case IB_QPT_RAW_PACKET:
+	case IB_QPT_UD:
+	case MLX5_IB_QPT_REG_UMR:
 		break;
 	default:
 		goto out;
@@ -2641,6 +2643,10 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	int create_flags = attr->create_flags;
 	bool cond;

+	if (qp->type == IB_QPT_UD && dev->profile == &raw_eth_profile)
+		if (create_flags & ~MLX5_IB_QP_CREATE_WC_TEST)
+			return -EINVAL;
+
 	if (qp_type == MLX5_IB_QPT_DCT)
 		return (create_flags) ? -EINVAL : 0;

--
2.26.2

