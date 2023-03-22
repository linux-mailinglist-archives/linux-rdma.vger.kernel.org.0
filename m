Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B56C4AC9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 13:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCVMhP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCVMhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 08:37:14 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1E45AB68;
        Wed, 22 Mar 2023 05:37:07 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so6169130wmq.4;
        Wed, 22 Mar 2023 05:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679488625; x=1682080625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRwZsANB3r2C91lXFiZnI3O1RAzjRFSQIWS7Bmxs4kw=;
        b=kEVyKmxHCDtHquzkXbz3/iIgF5Yq7f9kaDX+E58sD64JWj98XaQQ52H1emgtGXbteZ
         8spBx50fxTnTYsWdroIIj5jviLqKrkGf1d4ewbKm/Up3lF90yM87akrE0Ed9GcjtTStz
         HEtuRAYDMF/Ct1uXJp+UzPXhDWagFRtti1B7D/Lzrj7yM/dU0LTE91TW6vHDoF3QsGID
         c0TrNXf1I9cmlvs4AnjXlTAU2yrZwE60NNVcEOOWPa5R5bEjUUFzEx5ni2chkcovX9vT
         LgUscpMeKg8LPHDKyeITQ09J5N0tvz/P4hTISJa57g54DU88Bu9gpJg1RT7wGUtteI+S
         O2MA==
X-Gm-Message-State: AO0yUKVIUPkSdN+32k3tSYEqzKP8UBJW5P+1fOD6ahTet4Vvmd62WHJg
        563geg8giipOzrI/iulkR82g0eRhO1E=
X-Google-Smtp-Source: AK7set+DFNuOfo4tAskyhOm3T819ZfypjR/C+2jy8A+mbjjVnZsIAC+xiBgMVqvhh7gVF1jqcDGADQ==
X-Received: by 2002:a05:600c:4504:b0:3ed:d119:df27 with SMTP id t4-20020a05600c450400b003edd119df27mr6060190wmo.3.1679488625440;
        Wed, 22 Mar 2023 05:37:05 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13939285wrr.8.2023.03.22.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:37:04 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Date:   Wed, 22 Mar 2023 14:37:03 +0200
Message-Id: <20230322123703.485544-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No rdma device exposes its irq vectors affinity today. So the only
mapping that we have left, is the default blk_mq_map_queues, which
we fallback to anyways. Also fixup the only consumer of this helper
(nvme-rdma).

Remove this now dead code.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
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
index 5d9d9c84d516..0b7c13f9a089 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -215,11 +215,6 @@ config BLK_MQ_VIRTIO
 	depends on VIRTIO
 	default y
 
-config BLK_MQ_RDMA
-	bool
-	depends on INFINIBAND
-	default y
-
 config BLK_PM
 	def_bool PM
 
diff --git a/block/Makefile b/block/Makefile
index 4e01bb71ad6e..b31b05390749 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY_T10)	+= t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
-obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
deleted file mode 100644
index 29c1f4d6eb04..000000000000
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
-void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
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
-	return;
-
-fallback:
-	blk_mq_map_queues(map);
-}
-EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..3a62867b6cab 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -12,7 +12,6 @@
 #include <linux/string.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-rdma.h>
 #include <linux/blk-integrity.h>
 #include <linux/types.h>
 #include <linux/list.h>
@@ -2163,10 +2162,8 @@ static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
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
index 53b58c610e76..000000000000
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
-void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
-		struct ib_device *dev, int first_vec);
-
-#endif /* _LINUX_BLK_MQ_RDMA_H */
-- 
2.34.1

