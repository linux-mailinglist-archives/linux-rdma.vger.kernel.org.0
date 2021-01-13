Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368B92F4B27
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbhAMMRx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 07:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbhAMMRx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 07:17:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 175C423120;
        Wed, 13 Jan 2021 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540232;
        bh=CPk0hbkTi9MqVlzwxogyVXmURjTpgQ9E6E51qWy10po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ro2N26jK3as23xa1PHaIcfYdEtOb7jYA37DAYXAT3As/9iiaBrWXZ/pNqZzLFxPWN
         FrNCfQF2C4/safaAhFbmOqm8spWsWaQpGHyP0BDvsc/9oC8Lg2bl76Y/LTqXhi52sA
         ujnAeCyZ1sFdOeqMo66owGTLIOM15MnZgHs0FZjpQeAemGyqg3vHz8Rz4jsxxx8EjY
         sm/asfK/9cFpmFLr1SDUTtrJl81p93mDLRg9o9qgJtB+K7LeD16icPqDgOOm8gfQbT
         mUYsY3MV9v0i/I440IdHI0sZ+1XJlYbMEuMrvynrN0cvBkLovKt4C4zV8yLVGLLWYQ
         En7sAzj8rb6Zg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 2/5] IB/mlx5: Fix error unwinding when set_has_smi_cap fails
Date:   Wed, 13 Jan 2021 14:17:00 +0200
Message-Id: <20210113121703.559778-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
References: <20210113121703.559778-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

When set_has_smi_cap() fails, multiport master cleanup is missed.
Fix it by doing correct error unwinding.

Fixes: a989ea01cb10 ("RDMA/mlx5: Move SMI caps logic")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 36f8ae4fe619..4f21e561f73e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3978,7 +3978,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)

 	err = set_has_smi_cap(dev);
 	if (err)
-		return err;
+		goto err_mp;

 	if (!mlx5_core_mp_enabled(mdev)) {
 		for (i = 1; i <= dev->num_ports; i++) {
--
2.29.2

