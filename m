Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA66A1A681B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgDMOYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbgDMOXx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:23:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E052078A;
        Mon, 13 Apr 2020 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787832;
        bh=sq71uW2CkHp8EG7eRA81OUsBnQrue0wiZ0MUxxXM7oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rePDZo1M081gFAsn0znsFGqz/PeLdflRwPcQQ8cBkpsSGHBeOZMlRra0GgUGbffT6
         +XqUHBoKD8Xqog1QywgcE01m9DIoBORBF3hiW70zrRKYnKDvp+P5l7c9sI7yP3/sfg
         9Facgt92/a8oMBpPNVfu4EFGrG5arI3AHP9+7TFk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 12/13] RDMA/mlx5: Alphabetically sort build artifacts
Date:   Mon, 13 Apr 2020 17:23:07 +0300
Message-Id: <20200413142308.936946-13-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413142308.936946-1-leon@kernel.org>
References: <20200413142308.936946-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Sort .o objects in makefile to make addition of new object
less cumbersome.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/Makefile | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 2a334800f109..375b341be8a1 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -1,11 +1,24 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_MLX5_INFINIBAND)	+= mlx5_ib.o
+obj-$(CONFIG_MLX5_INFINIBAND) += mlx5_ib.o
+
+mlx5_ib-y := ah.o \
+	     cmd.o \
+	     cong.o \
+	     cq.o \
+	     doorbell.o \
+	     gsi.o \
+	     ib_virt.o \
+	     mad.o \
+	     main.o \
+	     mem.o \
+	     mr.o \
+	     qp.o \
+	     restrack.o \
+	     srq.o \
+	     srq_cmd.o
 
-mlx5_ib-y :=	main.o cq.o doorbell.o qp.o mem.o srq_cmd.o \
-		srq.o mr.o ah.o mad.o gsi.o ib_virt.o cmd.o \
-		cong.o restrack.o
 mlx5_ib-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += odp.o
 mlx5_ib-$(CONFIG_MLX5_ESWITCH) += ib_rep.o
-mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o
-mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += flow.o
-mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += qos.o
+mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o \
+					    flow.o \
+					    qos.o
-- 
2.25.2

