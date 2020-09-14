Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E606E268A08
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINL2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgINL10 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:27:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2951621D7E;
        Mon, 14 Sep 2020 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600082834;
        bh=LLbgw0EmD3MT40P3ZbOTK/sZOjjf0bgd5dfbTb7srQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsHk1rUWXcOo7TU7AVnURqwvLpKbYA7HUN3br2tdeBl5RKETl2sGrfeUIkIuYdtEC
         sJGUVx5JwUrZhtzFMP4mxFDd8E+lwGGJ2NCM0Bw8Lmzp03yeT/JpAanpcXgsmFYglW
         ITMpICSyD5ALCE0i+ZkuFoHpSrOd9G+CYMs8F7ak=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 4/5] RDMA/mlx5: Disable IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't work
Date:   Mon, 14 Sep 2020 14:26:52 +0300
Message-Id: <20200914112653.345244-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914112653.345244-1-leon@kernel.org>
References: <20200914112653.345244-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

set_reg_wr() always fails if !umr_modify_entity_size_disabled because
mlx5_ib_can_use_umr() always fails. Withotu set_reg_wr() IB_WR_REG_MR
doesn't work and that means the device should not advertise
IB_DEVICE_MEM_MGT_EXTENSIONS.

Fixes: 841b07f99a47 ("IB/mlx5: Block MR WR if UMR is not possible")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5cf5266936de..3ae681a6ae3b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -840,7 +840,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		/* We support 'Gappy' memory registration too */
 		props->device_cap_flags |= IB_DEVICE_SG_GAPS_REG;
 	}
-	props->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
+	/* IB_WR_REG_MR always requires changing the entity size with UMR */
+	if (!MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
+		props->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
 	if (MLX5_CAP_GEN(mdev, sho)) {
 		props->device_cap_flags |= IB_DEVICE_INTEGRITY_HANDOVER;
 		/* At this stage no support for signature handover */
--
2.26.2

