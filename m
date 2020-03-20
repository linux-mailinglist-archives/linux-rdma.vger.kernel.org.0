Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4218CDC0
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgCTMRh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52035 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCTMRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so6254614wme.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Febvpk8H0CfldfHZhzVT2mSC65UCbc+4UoAb79NFUIs=;
        b=DYM12+MG+GFCOvX3jdiiZzY74cWteFJ+wDmBCw80LvfzF03bJOBkQ7rER6HgUqNlNq
         bP4lCiyB/HAMYWBLEFG1goSK7jgiSOmudBOofFVQwNFC9R1FZyZjqS3p9d3rJF95f9Pw
         5LWCLgmSE25HQefUuoS7CSCpUH+bhwoVme1T4/DyV+wdivHnHiyn5QqOCSCrFu1y/0D7
         3rbySidEIkl7JBKeBNxw0F0a9ybU9eXBzF5L55jugOHp3zk9PI5Cc7iiz+7zpynWEc2q
         gLoaZuVPpmFhIBoWZI2YLw0rJ60VT18GwJN55i1ZxpOvut1vQWrmFjB2Un9S2ZRx4kzd
         3ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Febvpk8H0CfldfHZhzVT2mSC65UCbc+4UoAb79NFUIs=;
        b=Ac2TvIjn9Bt5jCYWbmJFVWhXe8HSvi4ET1xtrKpIKNkk89+pW57EGLWUsOQb8B01fN
         zuk/lUp1WhNG/s95RLVmxrbdivoZo0xE3Ca4+8ozVBwFiF5P/edz65oJokPTKoJZsE9D
         wLvfRZCDUsDT6+/mX/TLDxlaOXDKOKjn0f2B04bGHLpCFOiVwReF0M24k9LF3EJ63apW
         RUO/eJYewl3r6kPgFy8ssrRxYLOAbeYtO69V9RCWhxsp9YbyzIPsR2SgiG0GXcFDiQ7S
         44OaDmN4Q8vX2miS5MJrAQjHd7amLfMKHfuyb0YgnAL0iW1J+5HwXeIioM/Hp7ALeULR
         jgkQ==
X-Gm-Message-State: ANhLgQ0wCnFQtXrUEbDDaotOzlw+N2aFZyeiDMQYDMURlC0JvAj4MerX
        I33EmPTXFSlU3EcNpzjYYXmqGg==
X-Google-Smtp-Source: ADFU+vucYIo5+7/3dTwBABjEc5SXhXO6QWGFEgAsEY7Y49p21H8RAIyli6BD2KonXoOz+/Jvj7R/4A==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr9769540wmm.43.1584706655072;
        Fri, 20 Mar 2020 05:17:35 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 22/26] block/rnbd: server: functionality for IO submission to file or block dev
Date:   Fri, 20 Mar 2020 13:16:53 +0100
Message-Id: <20200320121657.1165-23-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This provides helper functions for IO submission to file or block dev.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 94 +++++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv-dev.h | 88 +++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
new file mode 100644
index 000000000000..370f4a43e10c
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -0,0 +1,94 @@
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
+			       void (*io_cb)(void *priv, int error))
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
+	kfree(io);
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
+	bio = bio_map_kern(q, data, len, GFP_KERNEL);
+	if (IS_ERR(bio))
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
index 000000000000..6d07b9323f84
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -0,0 +1,88 @@
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
+	fmode_t			blk_open_flags;
+	char			name[BDEVNAME_SIZE];
+	void			(*io_cb)(void *priv, int error);
+};
+
+struct rnbd_dev_blk_io {
+	struct rnbd_dev *dev;
+	void		 *priv;
+};
+
+/**
+ * rnbd_dev_open() - Open a device
+ * @flags:	open flags
+ * @io_cb:	is called when I/O finished
+ */
+struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
+			       void (*io_cb)(void *priv, int error));
+
+/**
+ * rnbd_dev_close() - Close a device
+ */
+void rnbd_dev_close(struct rnbd_dev *dev);
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
2.17.1

