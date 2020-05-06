Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36CB1C69E3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEFHQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFHQQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:16:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BFC20714;
        Wed,  6 May 2020 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588749375;
        bh=GSrGj8vWUTx13WSMMSAYUFscOAUPDKsnuNOydjIPpiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUlL/0Mp6shoQngCOilX91pnJHHdau4zg0RbR6HuyqgoaaVCDRsf3igIUAfVBg3gF
         z8Z8aMdpLOYTkUicbFruLo+DnlftyNR5vW4bEh/8oPZgzsQC8Q/5bC0kEzlaXstMRI
         7ZvOwhM9W2Yo7fiCe4Mef6lMt4d/SFQqEcF1zGtU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Assign profile before calling stages
Date:   Wed,  6 May 2020 10:16:01 +0300
Message-Id: <20200506071602.7177-2-leon@kernel.org>
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

Assign the profile to the IB device before executing stages. This will
allow to check which profile is being used from within a stage.

Signed-off-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.h | 2 +-
 drivers/infiniband/hw/mlx5/main.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.h b/drivers/infiniband/hw/mlx5/ib_rep.h
index 3b6750cba796..5b30d3fa8f8d 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.h
+++ b/drivers/infiniband/hw/mlx5/ib_rep.h
@@ -9,9 +9,9 @@
 #include <linux/mlx5/eswitch.h>
 #include "mlx5_ib.h"
 
-#ifdef CONFIG_MLX5_ESWITCH
 extern const struct mlx5_ib_profile raw_eth_profile;
 
+#ifdef CONFIG_MLX5_ESWITCH
 u8 mlx5_ib_eswitch_mode(struct mlx5_eswitch *esw);
 struct mlx5_ib_dev *mlx5_ib_get_rep_ibdev(struct mlx5_eswitch *esw,
 					  u16 vport_num);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c5f5aeea82b0..65790e2b442c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -7131,6 +7131,8 @@ void *__mlx5_ib_add(struct mlx5_ib_dev *dev,
 	int err;
 	int i;
 
+	dev->profile = profile;
+
 	for (i = 0; i < MLX5_IB_STAGE_MAX; i++) {
 		if (profile->stage[i].init) {
 			err = profile->stage[i].init(dev);
@@ -7139,7 +7141,6 @@ void *__mlx5_ib_add(struct mlx5_ib_dev *dev,
 		}
 	}
 
-	dev->profile = profile;
 	dev->ib_active = true;
 
 	return dev;
-- 
2.26.2

