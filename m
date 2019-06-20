Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4D4D16F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfFTPEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41094 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbfFTPEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so5157491eds.8;
        Thu, 20 Jun 2019 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sftFB0HlG/dnR9eDM3aN0JqJCicby8jJdUZ99x2NOuo=;
        b=s7wZGXXoaAk1VOZremO0/jjbJCZJVbYs4eu9MbKIsAvZKvXgzcFmlxMnEuaJ24SdFF
         iS7EwVm/7JVHis7a/nCnElUGK72aaQoq7PuLSGVR82MkffENLxB1xb1/83zSMq/NQHa9
         nbc8MxR3jXzisaBhHU3eFMzcCkNReAsq+fbNZ99kIAIyVug3PZxx6IiVfKWfWNIrEOG3
         CK8dyPO8bGzIz3hDzual5XPuaiweWra2INhLVrXb+5Zqkq6AWJLYoDSjBRGCYllFP+TX
         rieKFlFgY8/zgAJHrxAkUsX0SwupfBbI2OxU1HX0bdaGEGJIuGoh2aMHNGcfkBk4YZ7B
         +z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sftFB0HlG/dnR9eDM3aN0JqJCicby8jJdUZ99x2NOuo=;
        b=SgEFUc25ap0HfDyqpt/kjTW2FZKUK97B6Ooq1ANfNA87n2vuHE4EDVm2TMLxC1ijNL
         6lUs+gGXNo6ONH04JWwgrJdlGhHuN0rE4PPBMoR9t8vOms7d2ik5EI+kjnJojYwaaXiS
         6hDltYmA6W/MIBfw8+iW6xyyZ5AnA8gBOdlbiV/rW56PkixGt7xn0JG5TSfOqqzUOblr
         mmdcKmxE3KuR6I9pDYegqYzcuq2tSV9rpBo3dvonDzUWKT99ZNfw5BmKseyvh+7uKOxP
         pntIiy0/FOVVrQqzLxmRQFuiV68khhE6VMcIB6Bb5eSlZ9l/oiEufOslvJI2QGWUFMhI
         O+CQ==
X-Gm-Message-State: APjAAAWICuIt+8BHUzn+8c0XPVjY5AGUIwD9p1U5U/lktPFuDMIwhooM
        io5Ro4gr67s+3BSIF55NsaIvuNc7cKc=
X-Google-Smtp-Source: APXvYqxFyXofFKE6Zeey7xQnU8YLwIDgT8s/sM+qoRk1z+Qwyj/0Wr3SW2ejOHE+F08ZDSzzBqBQnA==
X-Received: by 2002:a05:6402:6cb:: with SMTP id n11mr25900908edy.101.1561043039324;
        Thu, 20 Jun 2019 08:03:59 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:58 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 16/25] ibnbd: client: private header with client structs and functions
Date:   Thu, 20 Jun 2019 17:03:28 +0200
Message-Id: <20190620150337.7847-17-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This header describes main structs and functions used by ibnbd-client
module, mainly for managing IBNBD sessions and mapped block devices,
creating and destroying sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/ibnbd/ibnbd-clt.h | 166 ++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 drivers/block/ibnbd/ibnbd-clt.h

diff --git a/drivers/block/ibnbd/ibnbd-clt.h b/drivers/block/ibnbd/ibnbd-clt.h
new file mode 100644
index 000000000000..005becfb110f
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-clt.h
@@ -0,0 +1,166 @@
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
+
+#ifndef IBNBD_CLT_H
+#define IBNBD_CLT_H
+
+#include <linux/wait.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/blk-mq.h>
+#include <linux/refcount.h>
+
+#include "ibtrs.h"
+#include "ibnbd-proto.h"
+#include "ibnbd-log.h"
+
+#define BMAX_SEGMENTS 29
+#define RECONNECT_DELAY 30
+#define MAX_RECONNECTS -1
+
+enum ibnbd_clt_dev_state {
+	DEV_STATE_INIT,
+	DEV_STATE_MAPPED,
+	DEV_STATE_MAPPED_DISCONNECTED,
+	DEV_STATE_UNMAPPED,
+};
+
+struct ibnbd_iu_comp {
+	wait_queue_head_t wait;
+	int errno;
+};
+
+struct ibnbd_iu {
+	union {
+		struct request *rq; /* for block io */
+		void *buf; /* for user messages */
+	};
+	struct ibtrs_tag	*tag;
+	union {
+		/* use to send msg associated with a dev */
+		struct ibnbd_clt_dev *dev;
+		/* use to send msg associated with a sess */
+		struct ibnbd_clt_session *sess;
+	};
+	blk_status_t		status;
+	struct scatterlist	sglist[BMAX_SEGMENTS];
+	struct work_struct	work;
+	int			errno;
+	struct ibnbd_iu_comp	comp;
+	atomic_t		refcount;
+};
+
+struct ibnbd_cpu_qlist {
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	unsigned int		cpu;
+};
+
+struct ibnbd_clt_session {
+	struct list_head        list;
+	struct ibtrs_clt        *ibtrs;
+	wait_queue_head_t       ibtrs_waitq;
+	bool                    ibtrs_ready;
+	struct ibnbd_cpu_qlist	__percpu
+				*cpu_queues;
+	DECLARE_BITMAP(cpu_queues_bm, NR_CPUS);
+	int	__percpu	*cpu_rr; /* per-cpu var for CPU round-robin */
+	atomic_t		busy;
+	int			queue_depth;
+	u32			max_io_size;
+	struct blk_mq_tag_set	tag_set;
+	struct mutex		lock; /* protects state and devs_list */
+	struct list_head        devs_list; /* list of struct ibnbd_clt_dev */
+	refcount_t		refcount;
+	char			sessname[NAME_MAX];
+	u8			ver; /* protocol version */
+};
+
+/**
+ * Submission queues.
+ */
+struct ibnbd_queue {
+	struct list_head	requeue_list;
+	unsigned long		in_list;
+	struct ibnbd_clt_dev	*dev;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+struct ibnbd_clt_dev {
+	struct ibnbd_clt_session	*sess;
+	struct request_queue	*queue;
+	struct ibnbd_queue	*hw_queues;
+	u32			device_id;
+	/* local Idr index - used to track minor number allocations. */
+	u32			clt_device_id;
+	struct mutex		lock;
+	enum ibnbd_clt_dev_state	dev_state;
+	enum ibnbd_io_mode	io_mode; /* user requested */
+	enum ibnbd_io_mode	remote_io_mode; /* server really used */
+	char			pathname[NAME_MAX];
+	enum ibnbd_access_mode	access_mode;
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
+/* ibnbd-clt.c */
+
+struct ibnbd_clt_dev *ibnbd_clt_map_device(const char *sessname,
+					   struct ibtrs_addr *paths,
+					   size_t path_cnt,
+					   const char *pathname,
+					   enum ibnbd_access_mode access_mode,
+					   enum ibnbd_io_mode io_mode);
+int ibnbd_clt_unmap_device(struct ibnbd_clt_dev *dev, bool force,
+			   const struct attribute *sysfs_self);
+
+int ibnbd_clt_remap_device(struct ibnbd_clt_dev *dev);
+int ibnbd_clt_resize_disk(struct ibnbd_clt_dev *dev, size_t newsize);
+
+/* ibnbd-clt-sysfs.c */
+
+int ibnbd_clt_create_sysfs_files(void);
+
+void ibnbd_clt_destroy_sysfs_files(void);
+void ibnbd_clt_destroy_default_group(void);
+
+void ibnbd_clt_remove_dev_symlink(struct ibnbd_clt_dev *dev);
+
+#endif /* IBNBD_CLT_H */
-- 
2.17.1

