Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB46412CEE9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfL3KaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35321 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfL3KaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so32224124edv.2;
        Mon, 30 Dec 2019 02:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yDWFlVbJBqOqd8Pp/3GtZ6NbzCt8jYBsZRQXb3iyKJ0=;
        b=CSC7ULKJC3/GeC9Z9pfNTrRypZUSi5ojprhibIdBcFD4HRbL2raKJbExR7eURMlvOM
         UiJqWi5McGRifE3U2evs+JebRSwOAtVp+8UhtLMT53WtMAtEAz4jP1KozImBxPEzkNX+
         9LfYsKemhmhX249NdHsKdD1PS3uNlmyN34lbSduWdZq4Q17yhkwEJIRmpkefRo/TSlxl
         sMJBuEjdCxxfWgZR7kHk4CZEI709eGUW/AB3cTChFmFOSVSjgESrn6c3EfRXFkG5rDVD
         JND845A39YT+455HViuMGjIeqqhS3nfO4j/b6R/0xJftP1QA6XppJj2VxHujoIwdfmHr
         A2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yDWFlVbJBqOqd8Pp/3GtZ6NbzCt8jYBsZRQXb3iyKJ0=;
        b=ZySuIiKRx4cv2Bc3GGA3NRfpqfRQcgmycGDttSJqgfOgGFI3Np0rS4T+r7zdLBtHxS
         dxT4hTp8DgrYDuolpVYuZBbozxXR+dnK+P8ergGyPMQpDASUXzPtUkHoHfnHQlDlXOkU
         sEOV3DPv3Du834mH4lfID8ktp+EMzXssvfWRT8tRFOOzEoGo6vrysAV+JrC+q3vP3GvF
         JE5NQhHOL13IVnTzQVeET23CHMODbMUKaQ0Mypf+hnqoxpPNPp9k17qF8GCBpwFt58Hy
         2XR6C/npxydav9YQNQ+H+ObsJRlj+IHsf4j69ZklRlmnXXu4eYJVjo+MxJjUPIZWeaOq
         nztQ==
X-Gm-Message-State: APjAAAUh9wc8Lf6mLrVpH+RaQYbnT6C2IF9zs7so8M466+kkC9uHAaO9
        /Tb6CHpFG2F/iY2yNS3ExeR6uTBZ
X-Google-Smtp-Source: APXvYqwOiqmEQPYfIBeC5j24s2NSDt3hLrpXmXDs8VbnccnLiumwSgzM/VMzFVKhrfPGIU6GEafr+g==
X-Received: by 2002:a05:6402:1558:: with SMTP id p24mr70400247edx.120.1577701807771;
        Mon, 30 Dec 2019 02:30:07 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:07 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 21/25] rnbd: server: functionality for IO submission to file or block dev
Date:   Mon, 30 Dec 2019 11:29:38 +0100
Message-Id: <20191230102942.18395-22-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This provides helper functions for IO submission to file or block dev.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 144 ++++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv-dev.h | 112 +++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
new file mode 100644
index 000000000000..49305e0b2d40
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rnbd-srv-dev.h"
+#include "rnbd-log.h"
+
+struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
+				 struct bio_set *bs, rnbd_dev_io_fn io_cb)
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
+	dev->blk_open_flags	= flags;
+	dev->io_cb		= io_cb;
+	bdevname(dev->bdev, dev->name);
+	dev->ibd_bio_set	= bs;
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
+	io->dev->io_cb(io->priv, blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
+}
+
+/**
+ *	rnbd_bio_map_kern	-	map kernel address into bio
+ *	@q: the struct request_queue for the bio
+ *	@data: pointer to buffer to map
+ *	@bs: bio_set to use.
+ *	@len: length in bytes
+ *	@gfp_mask: allocation flags for bio allocation
+ *
+ *	Map the kernel address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *rnbd_bio_map_kern(struct request_queue *q, void *data,
+				      struct bio_set *bs,
+				      unsigned int len, gfp_t gfp_mask)
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
+		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
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
+			size_t len, u32 bi_size, enum rnbd_io_flags flags,
+			short prio, void *priv)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+	struct rnbd_dev_blk_io *io;
+	struct bio *bio;
+
+	/* check if the buffer is suitable for bdev */
+	if (WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len)))
+		return -EINVAL;
+
+	/* Generate bio with pages pointing to the rdma buffer */
+	bio = rnbd_bio_map_kern(q, data, dev->ibd_bio_set, len, GFP_KERNEL);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	io = container_of(bio, struct rnbd_dev_blk_io, bio);
+
+	io->dev		= dev;
+	io->priv	= priv;
+
+	bio->bi_end_io		= rnbd_dev_bi_end_io;
+	bio->bi_private		= io;
+	bio->bi_opf		= rnbd_to_bio_flags(flags);
+	bio->bi_iter.bi_sector	= sector;
+	bio->bi_iter.bi_size	= bi_size;
+	bio_set_prio(bio, prio);
+	bio_set_dev(bio, dev->bdev);
+
+	submit_bio(bio);
+
+	return 0;
+}
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
new file mode 100644
index 000000000000..f2b5f8d56383
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_SRV_DEV_H
+#define RNBD_SRV_DEV_H
+
+#include <linux/fs.h>
+#include "rnbd-proto.h"
+
+typedef void rnbd_dev_io_fn(void *priv, int error);
+
+struct rnbd_dev {
+	struct block_device	*bdev;
+	struct bio_set		*ibd_bio_set;
+	fmode_t			blk_open_flags;
+	char			name[BDEVNAME_SIZE];
+	rnbd_dev_io_fn		*io_cb;
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
+ * @io_cb:	is called when I/O finished
+ */
+struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
+				 struct bio_set *bs, rnbd_dev_io_fn io_cb);
+
+/**
+ * rnbd_dev_close() - Close a device
+ */
+void rnbd_dev_close(struct rnbd_dev *dev);
+
+static inline int rnbd_dev_get_logical_bsize(const struct rnbd_dev *dev)
+{
+	return bdev_logical_block_size(dev->bdev);
+}
+
+static inline int rnbd_dev_get_phys_bsize(const struct rnbd_dev *dev)
+{
+	return bdev_physical_block_size(dev->bdev);
+}
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
+static inline int
+rnbd_dev_get_max_write_same_sects(const struct rnbd_dev *dev)
+{
+	return bdev_write_same(dev->bdev);
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
2.17.1

