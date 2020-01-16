Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCE13DAEE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAPM7s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39827 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgAPM7r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so18826750eds.6;
        Thu, 16 Jan 2020 04:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3aZKdNY9KMW790/AeeT27O3RqO+c2hQ/W0pgClm0aR4=;
        b=ouGE8N/bvw2SdtMpC7FdY9oN6Bdft3uNKnk8Zk6GzpDC68L94EiAMAXq3kGUj5EiMV
         0ZuMYhmWQDpWLO8mUppuXcMGkpcnywONuh+TDjSWDRbMFAnfoViCpJ4y4i0gqVUdH8JL
         Icyrwh2U04R68Lcf1H9whPJktPSBqfcoiglvcDtlv4qqCMPD/gOrJeeXOPU391Kqq35r
         HGThQhdGuj68alddh/ykyAu63wcfuAzX1z0PFkSundU7fV9GEvJ3x95dj8y9/qlH5uqm
         N7CdRvbozbTkpflBGCMRZ5rReJAQ0zpdhw3/rDavwer1JLcRvBDKSbVzavyMYlJLBrGD
         VJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3aZKdNY9KMW790/AeeT27O3RqO+c2hQ/W0pgClm0aR4=;
        b=Y07VVjjpmdKP5JgykWqkqX9S8djCA1NQMXe2nmgLsh+Sy2VW1Y4ofwEXYWWkekc+Fl
         ydWTIaRj387pvDOoDC3nTLL5AJFPHMC8BMkGUdMePAvWRpTsRIsUgIdoq5KlwIg+1MGF
         eaXnfJ83FAExtS1M92d00ay3SqvxCTvAMcxIVSaryDv7QU2wvWx2zL/XZ0l7eSyAKe0e
         U0kd3MblNVo6ZKGfz8YJs5IOotI7+0cl3zZAsbBvAB/pCMXdmVXPRVfd93jmNj0+5yyD
         Zgxx16ijN6+HDHEPqI3qEYPRKaH+gYox4Co3PPmV9x8Yyt2+WF6g/VFQHfL2GYxNI2Ko
         ABXg==
X-Gm-Message-State: APjAAAXXaXmt37DHVg+zTmUQGbmRe4i3hn7ebbfutAHKMInroJR4wPUN
        yBfM+hPb1kkJ0UAWeuUk1HhaV3N+
X-Google-Smtp-Source: APXvYqws1+QH+yuygs0gqaf9APkkchVMca1XocPDzF7mQnhdX7Hsh7u3iHyLA/PknSGqJ0gPFp1SRg==
X-Received: by 2002:a17:906:e249:: with SMTP id gq9mr2748190ejb.219.1579179585471;
        Thu, 16 Jan 2020 04:59:45 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:44 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 21/25] block/rnbd: server: functionality for IO submission to file or block dev
Date:   Thu, 16 Jan 2020 13:59:11 +0100
Message-Id: <20200116125915.14815-22-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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
index 000000000000..2a9090229ee6
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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
index 000000000000..bdb140e1081f
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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

