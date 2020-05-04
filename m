Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB4B1C3C35
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEDOCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEDOCq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C1C061A0F
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so8597475wmj.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABTh14ev+P/f9P0n3v/650QyNCupd96ARjVjo3ZVvN8=;
        b=R+fyAVOgNprIrRNvt4IW/81ieuje2Dq9iC67E5fz3namIg0xHTEwISy3UiM4J2c0g2
         Nplnjw3JTqmnHMoqKiZ/4Uw2ob69hsXN1SU5TXtvv9m52ANthn1Ynm/P2NtN/KaK/L1l
         s8JMU+LTXEHIlHHc0bu0ntmeZGaX/VgXFOmyd5qI0w48b5KimiiJKnBC3XtUIh32hHHg
         k4MScNz2IKGLk2Wq6+Imbd8SAvO3zugDEDAMTLsIAggd+67ljS6qqZxxwjuHjmMlOxjl
         GJvh8R/o0N/A6TOcj+MD7V8bczQEUHjCs0ff82lvXZlUOV8jTSYowKbEnBH8R0bEx3y/
         Fp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABTh14ev+P/f9P0n3v/650QyNCupd96ARjVjo3ZVvN8=;
        b=erIeRlgtvGrHgMAoZGVLc52jhvIK19PuoSf0mRMw65M5GpWCKiAjZIaaJ0sRdLRdXv
         d8p6iHfgYrmrcCtg+LaFs7rKdnwlSONTD6C7vQyF0xmSvxIVMNp0GCNRwZHracV2DDpz
         gp8eqfx7q1wWUkKPcAF/CgXwWwx+y7TcnxIvgCdrKnIRxwUblN+10Y6vpeZREd8L0QDf
         gz0saBGKKs8uXSQdrp1bslyl7fDOG9XMCIyytFKSRoDB86N1NuvdM10ArlbFYz0OqKGZ
         RDlknB2TMDAMYn4bSyYH3BTxDB9iogn3bayO4iPd8JfWbZefsYYDYglPeNL/PP17I+5t
         peoA==
X-Gm-Message-State: AGi0PubsmO3wdyLiNMLT0HQb1dCz9/89z4PXsBzX7nUGaB+xXVk/+sKc
        l7hTQi0Qev03ndKrFwiAfFSD
X-Google-Smtp-Source: APiQypJTxU76kxk3PnPcyFZ65L3K1XQVCYRzQK02HNgkzYsUS6YjgY4NqdZC+tqLrbUaIrkVJloZCQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr14138957wmc.132.1588600963968;
        Mon, 04 May 2020 07:02:43 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:43 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 21/25] block/rnbd: server: functionality for IO submitting to block dev
Date:   Mon,  4 May 2020 16:01:11 +0200
Message-Id: <20200504140115.15533-22-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This provides helper functions for IO submitting to block dev.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

