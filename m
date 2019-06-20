Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999484D178
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfFTPEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38971 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTPEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so5181748edv.6;
        Thu, 20 Jun 2019 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1AbZ9GXPjaD1sgBA+8WOzTIQzRxU2DSfKTYNm/EVrY=;
        b=GB4P0UxzRTyu6TaSEzA4iFcKt9r7VdiVVv5RPqsQ/HblPs2J8VQYJPZ6Cm6KgTiCd9
         z+w00Ywzxmhcvf9BcpJYoDLOFmH6cCrNHLJM/dBvG/HSWIgHGe8lS6eLzJiw9mRjBjmE
         h6JhfAzCXpz96Z3kygB1s6k/r4jwr9aey/3/Gbjq7w0Gz3JKc0xhzUeOE7hV2AIrUxsY
         zxTzaWwjhgQz5ZCMfIckUl1h60qjp33cLyEAf/v4T5oc2yoDbo0U7Rqp1rNlQpy34rDV
         WplQJROi0Dy2FF3rnbQrzhAfVEb/AyceYvsd1TcGGbKAIq+ORCJ0DDzwO9BaUOl2C12a
         sOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1AbZ9GXPjaD1sgBA+8WOzTIQzRxU2DSfKTYNm/EVrY=;
        b=FSy8QRp/VPsxLQ8Btl8zDivogRRqZZx15LjLN6xe2bfuF3mimTapR6+7O7MiJzoUSo
         E1Z0xE5bkmnEv4rVcJZ9s25bvYu081tEwN0B4AzRiWxOVzML1xTfBK6atGEO+wU+2EoW
         O5SHeSjqhu+JWGZUPAmCO7ba7kF3mRaVl/T3vSzHCV6wcCwKpWcwZIzsRNqZfBlM2Bxh
         8HlvVuI1SbU8w9XZljXVPs5s++r3D+c1UgrUidRNm/8MNSjkTGK8Xvo69ptKX37PltHO
         XcYyCv2IYScZ2efLuOFiT5A3e3n1jk1rmZ88GAE23Xo+Vmc8Ggol1GyPQX/ke9A3GObG
         xLlA==
X-Gm-Message-State: APjAAAWq4Ks55w6AOxdEO2f23qeZvqkDwPqaTGdEZPu4jCiuUcTexUYK
        njbxIrUjCP6jw2WNSd5yv/yFQyr8/f4=
X-Google-Smtp-Source: APXvYqyOLIPLqsdS189c/VFcxPyXDS9y/4U0ns1cK8kdnnvqcs3pitlTgfhFibJOvSFhhsM7HkCD0w==
X-Received: by 2002:a17:906:3385:: with SMTP id v5mr110574990eja.301.1561043045962;
        Thu, 20 Jun 2019 08:04:05 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:05 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 21/25] ibnbd: server: functionality for IO submission to file or block dev
Date:   Thu, 20 Jun 2019 17:03:33 +0200
Message-Id: <20190620150337.7847-22-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This provides helper functions for IO submission to file or block dev.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/ibnbd/ibnbd-srv-dev.c | 408 ++++++++++++++++++++++++++++
 drivers/block/ibnbd/ibnbd-srv-dev.h | 143 ++++++++++
 2 files changed, 551 insertions(+)
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.c
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-dev.h

diff --git a/drivers/block/ibnbd/ibnbd-srv-dev.c b/drivers/block/ibnbd/ibnbd-srv-dev.c
new file mode 100644
index 000000000000..5c1a518638b2
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-srv-dev.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "ibnbd-srv-dev.h"
+#include "ibnbd-log.h"
+
+#define IBNBD_DEV_MAX_FILEIO_ACTIVE_WORKERS 0
+
+struct ibnbd_dev_file_io_work {
+	struct ibnbd_dev	*dev;
+	void			*priv;
+
+	sector_t		sector;
+	void			*data;
+	size_t			len;
+	size_t			bi_size;
+	enum ibnbd_io_flags	flags;
+
+	struct work_struct	work;
+};
+
+struct ibnbd_dev_blk_io {
+	struct ibnbd_dev *dev;
+	void		 *priv;
+};
+
+static struct workqueue_struct *fileio_wq;
+
+int ibnbd_dev_init(void)
+{
+	fileio_wq = alloc_workqueue("%s", WQ_UNBOUND,
+				    IBNBD_DEV_MAX_FILEIO_ACTIVE_WORKERS,
+				    "ibnbd_server_fileio_wq");
+	if (!fileio_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ibnbd_dev_destroy(void)
+{
+	destroy_workqueue(fileio_wq);
+}
+
+static inline struct block_device *ibnbd_dev_open_bdev(const char *path,
+						       fmode_t flags)
+{
+	return blkdev_get_by_path(path, flags, THIS_MODULE);
+}
+
+static int ibnbd_dev_blk_open(struct ibnbd_dev *dev, const char *path,
+			      fmode_t flags)
+{
+	dev->bdev = ibnbd_dev_open_bdev(path, flags);
+	return PTR_ERR_OR_ZERO(dev->bdev);
+}
+
+static int ibnbd_dev_vfs_open(struct ibnbd_dev *dev, const char *path,
+			      fmode_t flags)
+{
+	int oflags = O_DSYNC; /* enable write-through */
+
+	if (flags & FMODE_WRITE)
+		oflags |= O_RDWR;
+	else if (flags & FMODE_READ)
+		oflags |= O_RDONLY;
+	else
+		return -EINVAL;
+
+	dev->file = filp_open(path, oflags, 0);
+	return PTR_ERR_OR_ZERO(dev->file);
+}
+
+struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
+				 enum ibnbd_io_mode mode, struct bio_set *bs,
+				 ibnbd_dev_io_fn io_cb)
+{
+	struct ibnbd_dev *dev;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	if (mode == IBNBD_BLOCKIO) {
+		dev->blk_open_flags = flags;
+		ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
+		if (ret)
+			goto err;
+	} else if (mode == IBNBD_FILEIO) {
+		dev->blk_open_flags = FMODE_READ;
+		ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
+		if (ret)
+			goto err;
+
+		ret = ibnbd_dev_vfs_open(dev, path, flags);
+		if (ret)
+			goto blk_put;
+	} else {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	dev->blk_open_flags	= flags;
+	dev->mode		= mode;
+	dev->io_cb		= io_cb;
+	bdevname(dev->bdev, dev->name);
+	dev->ibd_bio_set	= bs;
+
+	return dev;
+
+blk_put:
+	blkdev_put(dev->bdev, dev->blk_open_flags);
+err:
+	kfree(dev);
+	return ERR_PTR(ret);
+}
+
+void ibnbd_dev_close(struct ibnbd_dev *dev)
+{
+	flush_workqueue(fileio_wq);
+	blkdev_put(dev->bdev, dev->blk_open_flags);
+	if (dev->mode == IBNBD_FILEIO)
+		filp_close(dev->file, dev->file);
+	kfree(dev);
+}
+
+static void ibnbd_dev_bi_end_io(struct bio *bio)
+{
+	struct ibnbd_dev_blk_io *io = bio->bi_private;
+
+	io->dev->io_cb(io->priv, blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
+	kfree(io);
+}
+
+static void bio_map_kern_endio(struct bio *bio)
+{
+	bio_put(bio);
+}
+
+/**
+ *	ibnbd_bio_map_kern	-	map kernel address into bio
+ *	@q: the struct request_queue for the bio
+ *	@data: pointer to buffer to map
+ *	@bs: bio_set to use.
+ *	@len: length in bytes
+ *	@gfp_mask: allocation flags for bio allocation
+ *
+ *	Map the kernel address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *ibnbd_bio_map_kern(struct request_queue *q, void *data,
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
+	bio->bi_end_io = bio_map_kern_endio;
+	return bio;
+}
+
+static int ibnbd_dev_blk_submit_io(struct ibnbd_dev *dev, sector_t sector,
+				   void *data, size_t len, u32 bi_size,
+				   enum ibnbd_io_flags flags, short prio,
+				   void *priv)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+	struct ibnbd_dev_blk_io *io;
+	struct bio *bio;
+
+	/* check if the buffer is suitable for bdev */
+	if (unlikely(WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len))))
+		return -EINVAL;
+
+	/* Generate bio with pages pointing to the rdma buffer */
+	bio = ibnbd_bio_map_kern(q, data, dev->ibd_bio_set, len, GFP_KERNEL);
+	if (unlikely(IS_ERR(bio)))
+		return PTR_ERR(bio);
+
+	io = kmalloc(sizeof(*io), GFP_KERNEL);
+	if (unlikely(!io)) {
+		bio_put(bio);
+		return -ENOMEM;
+	}
+
+	io->dev		= dev;
+	io->priv	= priv;
+
+	bio->bi_end_io		= ibnbd_dev_bi_end_io;
+	bio->bi_private		= io;
+	bio->bi_opf		= ibnbd_to_bio_flags(flags);
+	bio->bi_iter.bi_sector	= sector;
+	bio->bi_iter.bi_size	= bi_size;
+	bio_set_prio(bio, prio);
+	bio_set_dev(bio, dev->bdev);
+
+	submit_bio(bio);
+
+	return 0;
+}
+
+static int ibnbd_dev_file_handle_flush(struct ibnbd_dev_file_io_work *w,
+				       loff_t start)
+{
+	int ret;
+	loff_t end;
+	int len = w->bi_size;
+
+	if (len)
+		end = start + len - 1;
+	else
+		end = LLONG_MAX;
+
+	ret = vfs_fsync_range(w->dev->file, start, end, 1);
+	if (unlikely(ret))
+		pr_info_ratelimited("I/O FLUSH failed on %s, vfs_sync err: %d\n",
+				    w->dev->name, ret);
+	return ret;
+}
+
+static int ibnbd_dev_file_handle_fua(struct ibnbd_dev_file_io_work *w,
+				     loff_t start)
+{
+	int ret;
+	loff_t end;
+	int len = w->bi_size;
+
+	if (len)
+		end = start + len - 1;
+	else
+		end = LLONG_MAX;
+
+	ret = vfs_fsync_range(w->dev->file, start, end, 1);
+	if (unlikely(ret))
+		pr_info_ratelimited("I/O FUA failed on %s, vfs_sync err: %d\n",
+				    w->dev->name, ret);
+	return ret;
+}
+
+static int ibnbd_dev_file_handle_write_same(struct ibnbd_dev_file_io_work *w)
+{
+	int i;
+
+	if (unlikely(WARN_ON(w->bi_size % w->len)))
+		return -EINVAL;
+
+	for (i = 1; i < w->bi_size / w->len; i++)
+		memcpy(w->data + i * w->len, w->data, w->len);
+
+	return 0;
+}
+
+static void ibnbd_dev_file_submit_io_worker(struct work_struct *w)
+{
+	struct ibnbd_dev_file_io_work *dev_work;
+	struct file *f;
+	int ret, len;
+	loff_t off;
+
+	dev_work = container_of(w, struct ibnbd_dev_file_io_work, work);
+	off = dev_work->sector * ibnbd_dev_get_logical_bsize(dev_work->dev);
+	f = dev_work->dev->file;
+	len = dev_work->bi_size;
+
+	if (ibnbd_op(dev_work->flags) == IBNBD_OP_FLUSH) {
+		ret = ibnbd_dev_file_handle_flush(dev_work, off);
+		if (unlikely(ret))
+			goto out;
+	}
+
+	if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE_SAME) {
+		ret = ibnbd_dev_file_handle_write_same(dev_work);
+		if (unlikely(ret))
+			goto out;
+	}
+
+	/* TODO Implement support for DIRECT */
+	if (dev_work->bi_size) {
+		loff_t off_tmp = off;
+
+		if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE)
+			ret = kernel_write(f, dev_work->data, dev_work->bi_size,
+					   &off_tmp);
+		else
+			ret = kernel_read(f, dev_work->data, dev_work->bi_size,
+					  &off_tmp);
+
+		if (unlikely(ret < 0)) {
+			goto out;
+		} else if (unlikely(ret != dev_work->bi_size)) {
+			/* TODO implement support for partial completions */
+			ret = -EIO;
+			goto out;
+		} else {
+			ret = 0;
+		}
+	}
+
+	if (dev_work->flags & IBNBD_F_FUA)
+		ret = ibnbd_dev_file_handle_fua(dev_work, off);
+out:
+	dev_work->dev->io_cb(dev_work->priv, ret);
+	kfree(dev_work);
+}
+
+static int ibnbd_dev_file_submit_io(struct ibnbd_dev *dev, sector_t sector,
+				    void *data, size_t len, size_t bi_size,
+				    enum ibnbd_io_flags flags, void *priv)
+{
+	struct ibnbd_dev_file_io_work *w;
+
+	if (!ibnbd_flags_supported(flags)) {
+		pr_info_ratelimited("Unsupported I/O flags: 0x%x on device "
+				    "%s\n", flags, dev->name);
+		return -ENOTSUPP;
+	}
+
+	w = kmalloc(sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	w->dev		= dev;
+	w->priv		= priv;
+	w->sector	= sector;
+	w->data		= data;
+	w->len		= len;
+	w->bi_size	= bi_size;
+	w->flags	= flags;
+	INIT_WORK(&w->work, ibnbd_dev_file_submit_io_worker);
+
+	if (unlikely(!queue_work(fileio_wq, &w->work))) {
+		kfree(w);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+int ibnbd_dev_submit_io(struct ibnbd_dev *dev, sector_t sector, void *data,
+			size_t len, u32 bi_size, enum ibnbd_io_flags flags,
+			short prio, void *priv)
+{
+	if (dev->mode == IBNBD_FILEIO)
+		return ibnbd_dev_file_submit_io(dev, sector, data, len, bi_size,
+						flags, priv);
+	else if (dev->mode == IBNBD_BLOCKIO)
+		return ibnbd_dev_blk_submit_io(dev, sector, data, len, bi_size,
+					       flags, prio, priv);
+
+	pr_warn("Submitting I/O to %s failed, dev->mode contains invalid "
+		"value: '%d', memory corrupted?", dev->name, dev->mode);
+
+	return -EINVAL;
+}
diff --git a/drivers/block/ibnbd/ibnbd-srv-dev.h b/drivers/block/ibnbd/ibnbd-srv-dev.h
new file mode 100644
index 000000000000..131746e38a9d
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-srv-dev.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#ifndef IBNBD_SRV_DEV_H
+#define IBNBD_SRV_DEV_H
+
+#include <linux/fs.h>
+#include "ibnbd-proto.h"
+
+typedef void ibnbd_dev_io_fn(void *priv, int error);
+
+struct ibnbd_dev {
+	struct block_device	*bdev;
+	struct bio_set		*ibd_bio_set;
+	struct file		*file;
+	fmode_t			blk_open_flags;
+	enum ibnbd_io_mode	mode;
+	char			name[BDEVNAME_SIZE];
+	ibnbd_dev_io_fn		*io_cb;
+};
+
+/** ibnbd_dev_init() - Initialize ibnbd_dev
+ *
+ * This functions initialized the ibnbd-dev component.
+ * It has to be called 1x time before ibnbd_dev_open() is used
+ */
+int ibnbd_dev_init(void);
+
+/** ibnbd_dev_destroy() - Destroy ibnbd_dev
+ *
+ * This functions destroys the ibnbd-dev component.
+ * It has to be called after the last device was closed.
+ */
+void ibnbd_dev_destroy(void);
+
+/**
+ * ibnbd_dev_open() - Open a device
+ * @flags:	open flags
+ * @mode:	open via VFS or block layer
+ * @bs:		bio_set to use during block io,
+ * @io_cb:	is called when I/O finished
+ */
+struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
+				 enum ibnbd_io_mode mode, struct bio_set *bs,
+				 ibnbd_dev_io_fn io_cb);
+
+/**
+ * ibnbd_dev_close() - Close a device
+ */
+void ibnbd_dev_close(struct ibnbd_dev *dev);
+
+static inline int ibnbd_dev_get_logical_bsize(const struct ibnbd_dev *dev)
+{
+	return bdev_logical_block_size(dev->bdev);
+}
+
+static inline int ibnbd_dev_get_phys_bsize(const struct ibnbd_dev *dev)
+{
+	return bdev_physical_block_size(dev->bdev);
+}
+
+static inline int ibnbd_dev_get_max_segs(const struct ibnbd_dev *dev)
+{
+	return queue_max_segments(bdev_get_queue(dev->bdev));
+}
+
+static inline int ibnbd_dev_get_max_hw_sects(const struct ibnbd_dev *dev)
+{
+	return queue_max_hw_sectors(bdev_get_queue(dev->bdev));
+}
+
+static inline int
+ibnbd_dev_get_max_write_same_sects(const struct ibnbd_dev *dev)
+{
+	return bdev_write_same(dev->bdev);
+}
+
+static inline int ibnbd_dev_get_secure_discard(const struct ibnbd_dev *dev)
+{
+	if (dev->mode == IBNBD_BLOCKIO)
+		return blk_queue_secure_erase(bdev_get_queue(dev->bdev));
+	return 0;
+}
+
+static inline int ibnbd_dev_get_max_discard_sects(const struct ibnbd_dev *dev)
+{
+	if (!blk_queue_discard(bdev_get_queue(dev->bdev)))
+		return 0;
+
+	if (dev->mode == IBNBD_BLOCKIO)
+		return blk_queue_get_max_sectors(bdev_get_queue(dev->bdev),
+						 REQ_OP_DISCARD);
+	return 0;
+}
+
+static inline int ibnbd_dev_get_discard_granularity(const struct ibnbd_dev *dev)
+{
+	if (dev->mode == IBNBD_BLOCKIO)
+		return bdev_get_queue(dev->bdev)->limits.discard_granularity;
+	return 0;
+}
+
+static inline int ibnbd_dev_get_discard_alignment(const struct ibnbd_dev *dev)
+{
+	if (dev->mode == IBNBD_BLOCKIO)
+		return bdev_get_queue(dev->bdev)->limits.discard_alignment;
+	return 0;
+}
+
+/**
+ * ibnbd_dev_submit_io() - Submit an I/O to the disk
+ * @dev:	device to that the I/O is submitted
+ * @sector:	address to read/write data to
+ * @data:	I/O data to write or buffer to read I/O date into
+ * @len:	length of @data
+ * @bi_size:	Amount of data that will be read/written
+ * @prio:       IO priority
+ * @priv:	private data passed to @io_fn
+ */
+int ibnbd_dev_submit_io(struct ibnbd_dev *dev, sector_t sector, void *data,
+			size_t len, u32 bi_size, enum ibnbd_io_flags flags,
+			short prio, void *priv);
+
+#endif /* IBNBD_SRV_DEV_H */
-- 
2.17.1

