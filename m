Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90A1A98A2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895415AbgDOJXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895407AbgDOJXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839EC061A0F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so18071048wma.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vsqbk9yd/R1BpMJdkLDH91Om0CETzwSXfeDvcfyeZUY=;
        b=ARF1kKA5rarhNcGMUzemo8TmINevmQT9bAmzeTwOxtZYZi/ILkUtHFxM0Nij/nYGmK
         TB7IaQAd/EMg4mo3Bs1ul+Jrzxf0oZvCf1147VNTxbVd60lA9PiLfo4A5dlAfe723XT4
         5Cee7foLJrvOHnqEavb3zvKGJ7A13Idbrl/5HV7qorgkRUetONlmfVRkVFCd+cMMj95b
         DLT/ZSYw96Okr722Nhe7a3S6b6z0Ys//pIDz5GhGPdZluwNYpvsN29oK1CxOosmeyTHC
         0i1GuogCTPJaz+Yca+ow8GKB6SKtYsvWoYOLBRSuaQf7Mpxh04IJk7ANCZeqtFHUGNMe
         EUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vsqbk9yd/R1BpMJdkLDH91Om0CETzwSXfeDvcfyeZUY=;
        b=sgVwxbnYwIageGaTHPgPkQ+3cwZbGWoycGajMYSlYBEp5ZPHTGuvYILkXGpRA1x77i
         BKFNBo7rGso2Wn7XQuVt1kTwalZ6XchZwpFxYUsIxF48eFsAXgMWON28KoP1ujPf92cU
         M+7dS9/ifhF0G5JqiGq5IFGK7lOsmfk/PzlDB4dnnzcQ99gQaNa2Jh+pq8m8ZJXlfXdV
         zUvz9WN/Vq9RoJa8KUaqmQa768jxjyIWY5yomqZvsv9qUtH8x/1YbNkWu7blW1PaUpcp
         91zXga3PlX40J+/gMe+aTTj3ZetkLT0EN1y2wqugSbwI3G47Fx2s98kdkFu2p5dnQsPK
         VZnQ==
X-Gm-Message-State: AGi0PuY9fGt6zUI6aKs5AWpbESBm4SANeXJg505LNMn43FTPoHVPQqrl
        CszOfkGeY3x0OX56fY45nGOQdQnVOgEwwRo=
X-Google-Smtp-Source: APiQypKVEVqm8UCf/EmtF9FDT7krui0NoFILMq253tn05KEYtHVoGw0X1f76h1MqH/9b4QHbY/b6gQ==
X-Received: by 2002:a1c:147:: with SMTP id 68mr4394428wmb.28.1586942590936;
        Wed, 15 Apr 2020 02:23:10 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:10 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 21/25] block/rnbd: server: functionality for IO submission to block dev
Date:   Wed, 15 Apr 2020 11:20:41 +0200
Message-Id: <20200415092045.4729-22-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This provides helper functions for IO submission to block dev.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 134 ++++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv-dev.h |  92 ++++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
new file mode 100644
index 000000000000..5eddfd29ab64
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rnbd-srv-dev.h"
+#include "rnbd-log.h"
+
+struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
+			       struct bio_set *bs)
+{
+	struct rnbd_dev *dev;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->blk_open_flags = flags;
+	dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
+	ret = PTR_ERR_OR_ZERO(dev->bdev);
+	if (ret)
+		goto err;
+
+	dev->blk_open_flags = flags;
+	bdevname(dev->bdev, dev->name);
+	dev->ibd_bio_set = bs;
+
+	return dev;
+
+err:
+	kfree(dev);
+	return ERR_PTR(ret);
+}
+
+void rnbd_dev_close(struct rnbd_dev *dev)
+{
+	blkdev_put(dev->bdev, dev->blk_open_flags);
+	kfree(dev);
+}
+
+static void rnbd_dev_bi_end_io(struct bio *bio)
+{
+	struct rnbd_dev_blk_io *io = bio->bi_private;
+
+	rnbd_endio(io->priv, blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
+}
+
+/**
+ *	rnbd_bio_map_kern	-	map kernel address into bio
+ *	@data: pointer to buffer to map
+ *	@bs: bio_set to use.
+ *	@len: length in bytes
+ *	@gfp_mask: allocation flags for bio allocation
+ *
+ *	Map the kernel address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
+				     unsigned int len, gfp_t gfp_mask)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	int offset, i;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(gfp_mask, nr_pages, bs);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	offset = offset_in_page(kaddr);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (bio_add_page(bio, virt_to_page(data), bytes,
+				    offset) < bytes) {
+			/* we don't support partial mappings */
+			bio_put(bio);
+			return ERR_PTR(-EINVAL);
+		}
+
+		data += bytes;
+		len -= bytes;
+		offset = 0;
+	}
+
+	bio->bi_end_io = bio_put;
+	return bio;
+}
+
+int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
+		       size_t len, u32 bi_size, enum rnbd_io_flags flags,
+		       short prio, void *priv)
+{
+	struct rnbd_dev_blk_io *io;
+	struct bio *bio;
+
+	/* Generate bio with pages pointing to the rdma buffer */
+	bio = rnbd_bio_map_kern(data, dev->ibd_bio_set, len, GFP_KERNEL);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	io = container_of(bio, struct rnbd_dev_blk_io, bio);
+
+	io->dev	= dev;
+	io->priv = priv;
+
+	bio->bi_end_io = rnbd_dev_bi_end_io;
+	bio->bi_private	= io;
+	bio->bi_opf = rnbd_to_bio_flags(flags);
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_iter.bi_size = bi_size;
+	bio_set_prio(bio, prio);
+	bio_set_dev(bio, dev->bdev);
+
+	submit_bio(bio);
+
+	return 0;
+}
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
new file mode 100644
index 000000000000..0f65b09a270e
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_SRV_DEV_H
+#define RNBD_SRV_DEV_H
+
+#include <linux/fs.h>
+#include "rnbd-proto.h"
+
+struct rnbd_dev {
+	struct block_device	*bdev;
+	struct bio_set		*ibd_bio_set;
+	fmode_t			blk_open_flags;
+	char			name[BDEVNAME_SIZE];
+};
+
+struct rnbd_dev_blk_io {
+	struct rnbd_dev *dev;
+	void		 *priv;
+	/* have to be last member for front_pad usage of bioset_init */
+	struct bio	bio;
+};
+
+/**
+ * rnbd_dev_open() - Open a device
+ * @flags:	open flags
+ * @bs:		bio_set to use during block io,
+ */
+struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
+			       struct bio_set *bs);
+
+/**
+ * rnbd_dev_close() - Close a device
+ */
+void rnbd_dev_close(struct rnbd_dev *dev);
+
+void rnbd_endio(void *priv, int error);
+
+static inline int rnbd_dev_get_max_segs(const struct rnbd_dev *dev)
+{
+	return queue_max_segments(bdev_get_queue(dev->bdev));
+}
+
+static inline int rnbd_dev_get_max_hw_sects(const struct rnbd_dev *dev)
+{
+	return queue_max_hw_sectors(bdev_get_queue(dev->bdev));
+}
+
+static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
+{
+	return blk_queue_secure_erase(bdev_get_queue(dev->bdev));
+}
+
+static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
+{
+	if (!blk_queue_discard(bdev_get_queue(dev->bdev)))
+		return 0;
+
+	return blk_queue_get_max_sectors(bdev_get_queue(dev->bdev),
+					 REQ_OP_DISCARD);
+}
+
+static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
+{
+	return bdev_get_queue(dev->bdev)->limits.discard_granularity;
+}
+
+static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
+{
+	return bdev_get_queue(dev->bdev)->limits.discard_alignment;
+}
+
+/**
+ * rnbd_dev_submit_io() - Submit an I/O to the disk
+ * @dev:	device to that the I/O is submitted
+ * @sector:	address to read/write data to
+ * @data:	I/O data to write or buffer to read I/O date into
+ * @len:	length of @data
+ * @bi_size:	Amount of data that will be read/written
+ * @prio:       IO priority
+ * @priv:	private data passed to @io_fn
+ */
+int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
+			size_t len, u32 bi_size, enum rnbd_io_flags flags,
+			short prio, void *priv);
+
+#endif /* RNBD_SRV_DEV_H */
-- 
2.20.1

