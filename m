Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7C11CC3C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfLLLag (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLag (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:30:36 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A97922B48;
        Thu, 12 Dec 2019 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150235;
        bh=EX+XyhjzWlebOUCAHVTMLho4zfuHxEA8jdsO/HgN+NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+z7kSJVXxe8kX5JzyxhQiyZ/qPcD8RPu05Fvdg0dcY1Bfop309SYANN4rV85oI5h
         RTwze10n7Za75dA55ni8zRnS8c5z49gTHiIAwn0fXlfMBiz9OC+hzSNvMWUUW7HnPa
         a6l3x2cg2gr3ZeBlp1eW5diXbqCZw1K04XjUSmWA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 1/4] IB/mlx5: Do reverse sequence during device removal
Date:   Thu, 12 Dec 2019 13:30:21 +0200
Message-Id: <20191212113024.336702-2-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212113024.336702-1-leon@kernel.org>
References: <20191212113024.336702-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When IB device profile initialization completes, device is marked as
active.
However, IB device is not marked inactive, during device removal flow.
It should be the mirror of the add flow.

Hence, mark it inactive during remove sequence.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 52bc86ab9490..a9090065a997 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6921,6 +6921,8 @@ void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
 		      int stage)
 {
+	dev->ib_active = false;
+
 	/* Number of stages to cleanup */
 	while (stage) {
 		stage--;
--
2.20.1

