Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9844512CED9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfL3KaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35306 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfL3KaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so32223874edv.2;
        Mon, 30 Dec 2019 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WG0Nm7cwKU1z8Z+q+Tare/lWV89eCxjxQc86gtuqHfw=;
        b=K/Td+FmH2s0DlxJHp/9cOGONruCehZ4PAa/K2GJ1qjcknOdJ9p8XJlE/Vdj0TLl2kb
         OCckqGKF5G2vOC4504sQsFbmPgoJlOI4zWjH0H9clepp1o7HE51rUns9z/gbzMsKX/6u
         ZjhEMt6HpJk1P5oLjN66+54EoP76MkKipGsEulp0PHECvXydcUaSh1IK/Adk5g+5HRCh
         RtYdSZ6rvwf9rVcobVf5hW5KaJEGPi4uMUhOuYLGwPG35K2PX4l9xfEGt6fSi/5svWXF
         37gU39chUuBXRgM9CLxqOBPTjFtbUzuCSTlbnQaV69cwplHpWsp51MsWmct16iWuihut
         2vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WG0Nm7cwKU1z8Z+q+Tare/lWV89eCxjxQc86gtuqHfw=;
        b=I6PDNuXiTaR1Sxh6hkq+Y0DVmeZ1GySX7gxhCsi5B3ekrm4z6Xh+SqhDtExcmMvhd9
         p1FIthupmOORObLRG1WSVfg2g8JZkEmdlc1jDvFWeSvOO8iAzAq6+Fsd0q9GkAQdcT2e
         Et6kjutFt7TEmQIuHCIxptUFsGnXkD/rZ5bfEtRLKbcpVXoaVgkqwTJxblZxk0w3HRk9
         fppHvEZpG+7V77YP9y6epBVdpBio5qWwBHHNmsd7zG/83xOaylJf7bjJyLAJWnN/TTRh
         j5Mub2QhKr18mfbU/tHAwWP8dUF/AQG8e3530UjSJN0b9G+gNC9ZRNn1dQpZnpj9BFp+
         OYjw==
X-Gm-Message-State: APjAAAW+AIqKRoO+nYPrlT0OBxYXZ4waSDHdvfGjsutJOB+VUkkhASs3
        N6MkNw1MMAYBaRDlD4cBF1+FIuuS
X-Google-Smtp-Source: APXvYqwHOMovnWQMWYxd7uxvFLBUmQOqMGaAObrnxCvT/6RnaEeOzHmT0Q7wl88iahZBTJVVdeXePQ==
X-Received: by 2002:a17:906:2e47:: with SMTP id r7mr69414379eji.215.1577701802092;
        Mon, 30 Dec 2019 02:30:02 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:01 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 16/25] rnbd: client: private header with client structs and functions
Date:   Mon, 30 Dec 2019 11:29:33 +0100
Message-Id: <20191230102942.18395-17-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rnbd-client
module, mainly for managing RNBD sessions and mapped block devices,
creating and destroying sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.h | 151 ++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt.h

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
new file mode 100644
index 000000000000..a9ff25e36fdf
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -0,0 +1,151 @@
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
+
+#ifndef RNBD_CLT_H
+#define RNBD_CLT_H
+
+#include <linux/wait.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/blk-mq.h>
+#include <linux/refcount.h>
+
+#include "rtrs.h"
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+#define BMAX_SEGMENTS 29
+#define RECONNECT_DELAY 30
+#define MAX_RECONNECTS -1
+
+enum rnbd_clt_dev_state {
+	DEV_STATE_INIT,
+	DEV_STATE_MAPPED,
+	DEV_STATE_MAPPED_DISCONNECTED,
+	DEV_STATE_UNMAPPED,
+};
+
+struct rnbd_iu_comp {
+	wait_queue_head_t wait;
+	int errno;
+};
+
+struct rnbd_iu {
+	union {
+		struct request *rq; /* for block io */
+		void *buf; /* for user messages */
+	};
+	struct rtrs_permit	*permit;
+	union {
+		/* use to send msg associated with a dev */
+		struct rnbd_clt_dev *dev;
+		/* use to send msg associated with a sess */
+		struct rnbd_clt_session *sess;
+	};
+	blk_status_t		status;
+	struct scatterlist	sglist[BMAX_SEGMENTS];
+	struct work_struct	work;
+	int			errno;
+	struct rnbd_iu_comp	comp;
+	atomic_t		refcount;
+};
+
+struct rnbd_cpu_qlist {
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	unsigned int		cpu;
+};
+
+struct rnbd_clt_session {
+	struct list_head        list;
+	struct rtrs_clt        *rtrs;
+	wait_queue_head_t       rtrs_waitq;
+	bool                    rtrs_ready;
+	struct rnbd_cpu_qlist	__percpu
+				*cpu_queues;
+	DECLARE_BITMAP(cpu_queues_bm, NR_CPUS);
+	int	__percpu	*cpu_rr; /* per-cpu var for CPU round-robin */
+	atomic_t		busy;
+	int			queue_depth;
+	u32			max_io_size;
+	struct blk_mq_tag_set	tag_set;
+	struct mutex		lock; /* protects state and devs_list */
+	struct list_head        devs_list; /* list of struct rnbd_clt_dev */
+	refcount_t		refcount;
+	char			sessname[NAME_MAX];
+	u8			ver; /* protocol version */
+};
+
+/**
+ * Submission queues.
+ */
+struct rnbd_queue {
+	struct list_head	requeue_list;
+	unsigned long		in_list;
+	struct rnbd_clt_dev	*dev;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+struct rnbd_clt_dev {
+	struct rnbd_clt_session	*sess;
+	struct request_queue	*queue;
+	struct rnbd_queue	*hw_queues;
+	u32			device_id;
+	/* local Idr index - used to track minor number allocations. */
+	u32			clt_device_id;
+	struct mutex		lock;
+	enum rnbd_clt_dev_state	dev_state;
+	char			pathname[NAME_MAX];
+	enum rnbd_access_mode	access_mode;
+	bool			read_only;
+	bool			rotational;
+	u32			max_hw_sectors;
+	u32			max_write_same_sectors;
+	u32			max_discard_sectors;
+	u32			discard_granularity;
+	u32			discard_alignment;
+	u16			secure_discard;
+	u16			physical_block_size;
+	u16			logical_block_size;
+	u16			max_segments;
+	size_t			nsectors;
+	u64			size;		/* device size in bytes */
+	struct list_head        list;
+	struct gendisk		*gd;
+	struct kobject		kobj;
+	char			blk_symlink_name[NAME_MAX];
+	refcount_t		refcount;
+	struct work_struct	unmap_on_rmmod_work;
+};
+
+/* rnbd-clt.c */
+
+struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
+					   struct rtrs_addr *paths,
+					   size_t path_cnt,
+					   const char *pathname,
+					   enum rnbd_access_mode access_mode);
+int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
+			   const struct attribute *sysfs_self);
+
+int rnbd_clt_remap_device(struct rnbd_clt_dev *dev);
+int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
+
+/* rnbd-clt-sysfs.c */
+
+int rnbd_clt_create_sysfs_files(void);
+
+void rnbd_clt_destroy_sysfs_files(void);
+void rnbd_clt_destroy_default_group(void);
+
+void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
+
+#endif /* RNBD_CLT_H */
-- 
2.17.1

