Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0A27C0AB
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgI2JOO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 05:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgI2JOK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 05:14:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F592076B;
        Tue, 29 Sep 2020 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601370849;
        bh=5E3slNjRuvNNMcxv/TURB1ODurtLk+FxpM6WF84I9eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eD0XGSr3+0Agd6IUm1AK+1BjhSo7o0PQKkrFwt17Xi02vAO34ojq6cXvCocqySYjD
         583ZL3/PRW5KZMCJTXag9M6FFW0boQcOm0a9YzWq1j+KYkgvELur+nM9gCbkaoaO1F
         ibMAgZmc/jakTD35Jh/eDJht3SykRDQvYIpn7IeY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blk-next 2/2] RDMA/core: Delete not-implemented get_vector_affinity
Date:   Tue, 29 Sep 2020 12:13:58 +0300
Message-Id: <20200929091358.421086-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929091358.421086-1-leon@kernel.org>
References: <20200929091358.421086-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There are no drivers that support .get_vector_affinity(), so delete it.

Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c |  1 -
 include/rdma/ib_verbs.h          | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 417d93bbdaca..e00ce044555d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2619,7 +2619,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_link_layer);
 	SET_DEVICE_OP(dev_ops, get_netdev);
 	SET_DEVICE_OP(dev_ops, get_port_immutable);
-	SET_DEVICE_OP(dev_ops, get_vector_affinity);
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_guid);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7fb09a36b654..b1b279d888f0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2319,8 +2319,6 @@ struct ib_device_ops {
 	int (*modify_device)(struct ib_device *device, int device_modify_mask,
 			     struct ib_device_modify *device_modify);
 	void (*get_dev_fw_str)(struct ib_device *device, char *str);
-	const struct cpumask *(*get_vector_affinity)(struct ib_device *ibdev,
-						     int comp_vector);
 	int (*query_port)(struct ib_device *device, u8 port_num,
 			  struct ib_port_attr *port_attr);
 	int (*modify_port)(struct ib_device *device, u8 port_num,
@@ -4545,27 +4543,6 @@ static inline __be16 ib_lid_be16(u32 lid)
 	return cpu_to_be16((u16)lid);
 }

-/**
- * ib_get_vector_affinity - Get the affinity mappings of a given completion
- *   vector
- * @device:         the rdma device
- * @comp_vector:    index of completion vector
- *
- * Returns NULL on failure, otherwise a corresponding cpu map of the
- * completion vector (returns all-cpus map if the device driver doesn't
- * implement get_vector_affinity).
- */
-static inline const struct cpumask *
-ib_get_vector_affinity(struct ib_device *device, int comp_vector)
-{
-	if (comp_vector < 0 || comp_vector >= device->num_comp_vectors ||
-	    !device->ops.get_vector_affinity)
-		return NULL;
-
-	return device->ops.get_vector_affinity(device, comp_vector);
-
-}
-
 /**
  * rdma_roce_rescan_device - Rescan all of the network devices in the system
  * and add their gids, as needed, to the relevant RoCE devices.
--
2.26.2

