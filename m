Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D163FB41A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhH3Ktt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 06:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236474AbhH3Kts (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Aug 2021 06:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0781610FA;
        Mon, 30 Aug 2021 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630320534;
        bh=OdHDJhqcf8FGllCXWYax9/FnXGIoWcjcc6A2skNg+aw=;
        h=From:To:Cc:Subject:Date:From;
        b=FbFTnFasbUs/gE0nJ2tYQnPAHwRCAbl1Lw2gb8P0cjEDqLNRb4zZsX8lA+ANlWBwo
         vCY60HvYNbZr03N4TFAotGLBTWBBDeW+XinZyXkwWzpYm/sF5YmwuT6YMKBlmDio14
         mgNTSx0fLvrtbXdSo6Kx4wdX2VAc0mlXYvLwL4/T16B8widEQxo0IqfVZJ79mHOq1w
         U7opOUmfmIzJ0P5A3GZ+VlVaBH+EN/5ccVdbn6w4Bo0luq3KxRwvv1FRAwzzMo9Fds
         ZlRG/w/5PRKh3QwP5jT+gqh7XpSpeZTB/v8GDQLYOzxc/PZ9hJzlPlth/aKYIPzBaY
         3GasMovIDDrQw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lior Nahmanson <liorna@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Meir Lichtinger <meirl@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Relax DCS QP creation checks
Date:   Mon, 30 Aug 2021 13:48:49 +0300
Message-Id: <3e7b3363fd73686176cc584295e86832a7cf99b2.1630320354.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lior Nahmanson <liorna@nvidia.com>

In order to create DCS QPs, we don't need to rely on both
log_max_dci_stream_channels and log_max_dci_errored_streams capabilities.

Fixes: 11656f593a86 ("RDMA/mlx5: Add DCS offload support")
Signed-off-by: Lior Nahmanson <liorna@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Jason,

Please add this patch in the upcoming PR for the feature that was
accepted in this cycle.

Thanks
---
 drivers/infiniband/hw/mlx5/qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 81e3170a1ae6..4e2d0f8f267f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2813,8 +2813,7 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCI, true, qp);
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_TYPE_DCT, true, qp);
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_DCI_STREAM,
-			    MLX5_CAP_GEN(mdev, log_max_dci_stream_channels) &&
-			    MLX5_CAP_GEN(mdev, log_max_dci_errored_streams),
+			    MLX5_CAP_GEN(mdev, log_max_dci_stream_channels),
 			    qp);
 
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SIGNATURE, true, qp);
-- 
2.31.1

