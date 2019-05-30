Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADC2FC3F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE3NZm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:42 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34940 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726418AbfE3NZl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:41 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZZ007883;
        Thu, 30 May 2019 16:25:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 07/20] RDMA/mlx5: Add attr for max number page list length for PI operation
Date:   Thu, 30 May 2019 16:25:18 +0300
Message-Id: <1559222731-16715-8-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PI offload (protection information) is a feature that each RDMA provider
can implement differently. Thus, introduce new device attribute to define
the maximal length of the page list for PI fast registration operation. For
example, mlx5 driver uses a single internal MR to map both data and
protection SGL's, so it's equal to max_fast_reg_page_list_len / 2.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 include/rdma/ib_verbs.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b6588cdef1cf..7b48aeafef9e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1008,6 +1008,8 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	props->max_srq_sge	   = max_rq_sg - 1;
 	props->max_fast_reg_page_list_len =
 		1 << MLX5_CAP_GEN(mdev, log_max_klm_list_size);
+	props->max_pi_fast_reg_page_list_len =
+		props->max_fast_reg_page_list_len / 2;
 	get_atomic_caps_qp(dev, props);
 	props->masked_atomic_cap   = IB_ATOMIC_NONE;
 	props->max_mcast_grp	   = 1 << MLX5_CAP_GEN(mdev, log_max_mcg);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a1713b86398..6e30ca4f1ef5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -401,6 +401,7 @@ struct ib_device_attr {
 	int			max_srq_wr;
 	int			max_srq_sge;
 	unsigned int		max_fast_reg_page_list_len;
+	unsigned int		max_pi_fast_reg_page_list_len;
 	u16			max_pkeys;
 	u8			local_ca_ack_delay;
 	int			sig_prot_cap;
-- 
2.16.3

