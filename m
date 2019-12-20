Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B56127FF6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLTPvi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36554 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPvg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so9894909wru.3;
        Fri, 20 Dec 2019 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkP4w98AtoDHX5keZyBHATpNs1UFV8kOi9qzkCSeNHM=;
        b=UIPsPGvQLgkR/YcD+WX+kB2e9bYEqblGvKdhb38YcOc7OYLgrvvYANQW0KjWSme5Mi
         GeK+8z0dCQ+s89vcqwa4gQAPQJXDSK8FDqyEIzGlSV18+VyPeIE1f5J4AMEkgr3VMN6o
         63B/zD/pJ6CozsCBzB5IG8ShUvHdts1efdXMoRwez9oWMYV5U5qBWJuzgXd9bJt4ZqZg
         t1iqz+Hf+wi+2F3L6+qH7p+z0rWMBMRBbA7O8v73mUBG28a8sbbAvtVSqWjY+NFGsA/X
         9b/aBVZQZsLBMd0IXhNYSzG9yXc5eiSolfHOL6NNt3Vejks90UnYAwt8GJZuBPXzgqDN
         ajCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkP4w98AtoDHX5keZyBHATpNs1UFV8kOi9qzkCSeNHM=;
        b=t0gJST8v30eXu5fNPql23NzF1ksQllNhzoMUcZMDl6ZI7IA7fMKeRLDws2SNqT+//g
         iDcAQVQ0nUuaV3NRnazibaJHOM7FwKe3X5BpeWuHMpwIkwQOUDKtld/4+MSh0O+J/VSh
         lhCT5ll7nE13vgtgSbIrztg3AnATpFXTsqPCYNa8Y6fIGU/WLmsWsDyZqZtbwxtG37+f
         TgN/2V+0EinLWG4LmJXVgGwgUohdCf3Kq+Bdr+rEwDra4kHjl3MT4nfHEXyw6G+T68cf
         uIXWY56JzrJhD0uxsLBKjkMG7HA/op7gXulAosbw8DfKeQpEFTjB7lXc9cD7Z//LCjL0
         XA3Q==
X-Gm-Message-State: APjAAAWYdIEbeyhP0dlEbGXhktrcePw0Zgepowt7LWo0aCfC2JHRDHGd
        Calg6+JhlcqHlXmlYpm2oDHvJJLhASY=
X-Google-Smtp-Source: APXvYqwLm70qIc1uRVe05LXWWhDS6eiSOoWs51WhvXIcTuVtTJ/xwD03dTb9a8z7LUoldWXqi1n8ZA==
X-Received: by 2002:adf:814c:: with SMTP id 70mr15373226wrm.157.1576857094227;
        Fri, 20 Dec 2019 07:51:34 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:32 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 16/25] rnbd: client: private header with client structs and functions
Date:   Fri, 20 Dec 2019 16:51:00 +0100
Message-Id: <20191220155109.8959-17-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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
 drivers/block/rnbd/rnbd-clt.h | 169 ++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt.h

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
new file mode 100644
index 000000000000..b8b51a41af8e
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -0,0 +1,169 @@
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
+ *          Swapnil Ingle <swapnil.ingle@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
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

