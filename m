Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51D27C0B1
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgI2JO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 05:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgI2JOO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 05:14:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2749207F7;
        Tue, 29 Sep 2020 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601370853;
        bh=c31YQhSpeUNEH1BOqMoLj2kg6Yzsbp16GK3iXhaWezI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1gqP1Vza2HrhKjA2wxhggz/O9ENbPqOUhObsxrg9VUQfiOBjUFnuPI9tKc4ECBO2
         X6kFRdh6ExIOYPB2GVMkOYrPjUyfKpEwvFYnx+RdECRTFzu2rx8FOPJIYQiXjKsum+
         JAEBakk8ANvkpqKE0l+s9U0302+qazI1OT8JWeDI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
Date:   Tue, 29 Sep 2020 12:13:57 +0300
Message-Id: <20200929091358.421086-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929091358.421086-1-leon@kernel.org>
References: <20200929091358.421086-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The RDMA vector affinity code is not backed up by any driver and always
returns NULL to every ib_get_vector_affinity() call.

This means that blk_mq_rdma_map_queues() always takes fallback path.

Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/Kconfig               |  5 -----
 block/Makefile              |  1 -
 block/blk-mq-rdma.c         | 44 -------------------------------------
 drivers/nvme/host/rdma.c    |  7 ++----
 include/linux/blk-mq-rdma.h | 11 ----------
 5 files changed, 2 insertions(+), 66 deletions(-)
 delete mode 100644 block/blk-mq-rdma.c
 delete mode 100644 include/linux/blk-mq-rdma.h

diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..8ede308a1343 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -227,11 +227,6 @@ config BLK_MQ_VIRTIO
 	depends on BLOCK && VIRTIO
 	default y

-config BLK_MQ_RDMA
-	bool
-	depends on BLOCK && INFINIBAND
-	default y
-
 config BLK_PM
 	def_bool BLOCK && PM

diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..bbdc3e82308a 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY_T10)	+= t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
-obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
deleted file mode 100644
index 14f968e58b8f..000000000000
--- a/block/blk-mq-rdma.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2017 Sagi Grimberg.
- */
-#include <linux/blk-mq.h>
-#include <linux/blk-mq-rdma.h>
-#include <rdma/ib_verbs.h>
-
-/**
- * blk_mq_rdma_map_queues - provide a default queue mapping for rdma device
- * @map:	CPU to hardware queue map.
- * @dev:	rdma device to provide a mapping for.
- * @first_vec:	first interrupt vectors to use for queues (usually 0)
- *
- * This function assumes the rdma device @dev has at least as many available
- * interrupt vetors as @set has queues.  It will then query it's affinity mask
- * and built queue mapping that maps a queue to the CPUs that have irq affinity
- * for the corresponding vector.
- *
- * In case either the driver passed a @dev with less vectors than
- * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
- * vector, we fallback to the naive mapping.
- */
-int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
-		struct ib_device *dev, int first_vec)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	for (queue = 0; queue < map->nr_queues; queue++) {
-		mask = ib_get_vector_affinity(dev, first_vec + queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			map->mq_map[cpu] = map->queue_offset + queue;
-	}
-
-	return 0;
-
-fallback:
-	return blk_mq_map_queues(map);
-}
-EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..5989d4e35ef3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -12,7 +12,6 @@
 #include <linux/string.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-rdma.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -2171,10 +2170,8 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-			ctrl->device->dev, 0);
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
-			ctrl->device->dev, 0);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);

 	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
 		/* map dedicated poll queues only if we have queues left */
diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
deleted file mode 100644
index 5cc5f0f36218..000000000000
--- a/include/linux/blk-mq-rdma.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BLK_MQ_RDMA_H
-#define _LINUX_BLK_MQ_RDMA_H
-
-struct blk_mq_tag_set;
-struct ib_device;
-
-int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
-		struct ib_device *dev, int first_vec);
-
-#endif /* _LINUX_BLK_MQ_RDMA_H */
--
2.26.2

