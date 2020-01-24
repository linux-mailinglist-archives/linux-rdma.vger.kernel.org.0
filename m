Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363DD148FB8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgAXUsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36959 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388555AbgAXUsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so3972906edb.4;
        Fri, 24 Jan 2020 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2jVTzvFD5G7xZI5f/fXjUGqPAOfzN1uGCDbZngbVyE=;
        b=hWJyADJtTOPUkHX6+VBRz59RNmkDJnQR2QexUXCTUzyDLisf5hJfKpU2UoAG7Ervh1
         cLAmWIEb7DcQSVMPXYo3yTmQ9AsVm1j7Pzna3mCfnmaa08dnY1tEWumQ7BXZIIm9mHwi
         7NxwmyD00GzGh3eFq8jRDm5dNWSYYtCCRk8CdDovSEd9YPezlfOaDOvCJzH1bxMZYuET
         RiRJJs41mSj9ZpHDgOOVJ0Tmtnq/lp7VoKQgrdpduhkrKbqbcYQjqI88+wbH3eB3l5a6
         yD86TWFzxTT4KShxN0DvLDdHRxbo9SGEdwxsPomPe+vlIKxTC/VNU7416GwW1ZusUgvq
         lyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2jVTzvFD5G7xZI5f/fXjUGqPAOfzN1uGCDbZngbVyE=;
        b=cWYwosW8JAyT5G3wPU0oikrOL9vPbdnsOIatJbBQ96+zL04msVG+zzs9RsoAF69et+
         KcTNo3y/CScy5EzlWAr+2HC1jEXflUBElQy6RYt8W8KnWU6V1mI30ZbInUqd/xtFtA8H
         Ui6iJtQX9WUBNDdZ7AhT05XL+Mk5LM5eGJm3U+0C2iWTckgVwEIKWa+RT6k7v82NXxKX
         O0r1zkC5hHm7i2t60lowPMnEplmB3Q/s2I98jWX6LqnkKPNNr9fqj8Ld0N7F1cAApJHP
         7R5+dT2gTDBFu2XkNU5Yf6w9wVQY/FOV0aDH2dQ6tVRwJR88TkW1QIIL553qgWZyFiBH
         aeWQ==
X-Gm-Message-State: APjAAAXUwSRdCHO3aOrMKDUAlhMU0uwcuWOS0jjIIxMk2pUyS/Wi8TtA
        ET8nIZoPKGUbKYGjscqCm7hKF0iE
X-Google-Smtp-Source: APXvYqwEidWvnNhc37tp6yTkzHuuUGrnKbhtehZ9/Eicm99KgDi5z8jouaaJWJGSAvbjACshMk5uUw==
X-Received: by 2002:a50:875c:: with SMTP id 28mr4398628edv.271.1579898897524;
        Fri, 24 Jan 2020 12:48:17 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:17 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 16/25] block/rnbd: client: private header with client structs and functions
Date:   Fri, 24 Jan 2020 21:47:44 +0100
Message-Id: <20200124204753.13154-17-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
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
 drivers/block/rnbd/rnbd-clt.h | 148 ++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt.h

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
new file mode 100644
index 000000000000..276a3220f78f
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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

