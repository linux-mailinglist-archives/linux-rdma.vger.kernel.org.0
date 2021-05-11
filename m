Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4B379F4E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEKFtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFts (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DA0A61924;
        Tue, 11 May 2021 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712122;
        bh=DfWuBY142BHuiR18p/NOMe+FXmKKxNQeaNXRYsxmYCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDqJkEGEAh7WJlu7RbNfxcnm2UjH8WB0+FIT2XMA7F/yAO5Cfu9mWz/OT1Q3hZVyM
         LKy2tagTRXX8O5whJqsm18xdryKAeqelCPbJrCKbOQY3kbzC03SEj8XaK+TcoUQuyl
         EEoNi2owyMxSFG6zZghyLVHT0G3N2U0UTfnTtqbjTFygpOJG4lgZDnUYirDdFW2aVc
         zEOSJTx2ejchSNL8wgq8OP9owVN6FZq/eEONNQU+vVJhm51r5JOduGq/Erc143gyPG
         HpB1nZAnILiZ1Qusr2/0EcoKatrEeKRb0EATA9UPUuP4bJ4odaAgPevgrIh6QQM2fX
         gibfYXaxeLQBg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 3/5] RDMA/mlx5: Recover from fatal event in dual port mode
Date:   Tue, 11 May 2021 08:48:29 +0300
Message-Id: <8906754455bb23019ef223c725d2c0d38acfb80b.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

When there is fatal event on the slave port, the device is marked
as not active. We need to mark it as active again when the slave
is recovered.

Fixes: d69a24e03659 ("IB/mlx5: Move IB event processing onto a workqueue")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6d1dd09a4388..644d5d0ac544 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4419,6 +4419,7 @@ static int mlx5r_mp_probe(struct auxiliary_device *adev,
 
 		if (bound) {
 			rdma_roce_rescan_device(&dev->ib_dev);
+			mpi->ibdev->ib_active = true;
 			break;
 		}
 	}
-- 
2.31.1

