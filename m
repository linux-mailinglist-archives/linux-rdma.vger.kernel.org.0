Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A283148FB6
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbgAXUsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34503 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgAXUsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id r18so3980093edl.1;
        Fri, 24 Jan 2020 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/MVL3CEK/kLX6jLzMHjBUm0aMsjexndhbwNNGgUxkYI=;
        b=kOxENQj8H5hCvsOtPjuKh8WYQglrd51aGcJs+mDMTwUggW0ZLJK0Tq+i8Jb1Py7DbC
         UfqM/4qHGlxOXZUn8IYDHt75inOM4tLTFrCffk1HdyOsQs9cNyMNiePBhYQ4NanRKcKn
         VC23pTkXQG71bC9YQdii7zyl86wkMIUVp3sn+twLTq9TBKDL+5si9M2G5X6Zs3Yj9jFK
         YYvO8CVmDjd93JQ5cH0NNVXZNbLZol06ycj5PJPW0qfvn3LV6NPMQj4cBCzmhPJj33y+
         SPDJmEC/1wm3/yNeF1Klase+442cKYliIRUGQu5jbYdTXYWpxngaf/y9izZsAqUama4X
         4Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/MVL3CEK/kLX6jLzMHjBUm0aMsjexndhbwNNGgUxkYI=;
        b=QbtaQA7q7sspnjzWfnf2598H1Ht7U9WvpOGgycDD+bB79Cio5pJYQtwvvC4jWNzMKa
         4HTzG3UXzpxnO5QPTttr5CiuAbtArIGZb+RdgLnGGzVoZ9wrz5bgxxcUSAwtTtdJv5+M
         T5Y8gn1TIDaMxccQjxTqq0lmucLKk29uByERPLSsitew+Qjdd+KuU/1xY5MmLk0amojJ
         63kvZSNFG48jAyqM0RUAnR0k6eW/YfcIQMDJAT9fSkiS+BTjQxtdaBni6KF2WdKQQ4FX
         bIenAYfPEx/IZk8SjrmzBnlVyNIhTjAI2t5WNKZvMsYcRPB39L1GptIjViT6Zgn8KhCr
         ChlQ==
X-Gm-Message-State: APjAAAWQogCIEWb39JLL/3GQ3/mTVN0bo5hWEK0z8k5y6G2jeAImq536
        Ax9lY4KawNtxqu6oBq3ElpINNHUp
X-Google-Smtp-Source: APXvYqz1CJRsTXOgQ2A7JTW0WwsO4CRTE2LpmqgjseqRkQlM7RqXrgm7WXAk4bB6nQVj68MV8Qi9Lw==
X-Received: by 2002:a05:6402:1257:: with SMTP id l23mr4569042edw.342.1579898901659;
        Fri, 24 Jan 2020 12:48:21 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:21 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 19/25] block/rnbd: server: private header with server structs and functions
Date:   Fri, 24 Jan 2020 21:47:47 +0100
Message-Id: <20200124204753.13154-20-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv.h | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..8bae852aa778
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_SRV_H
+#define RNBD_SRV_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+
+#include "rtrs.h"
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+struct rnbd_srv_session {
+	/* Entry inside global sess_list */
+	struct list_head        list;
+	struct rtrs_srv	*rtrs;
+	char			sessname[NAME_MAX];
+	int			queue_depth;
+	struct bio_set		sess_bio_set;
+
+	rwlock_t                index_lock ____cacheline_aligned;
+	struct idr              index_idr;
+	/* List of struct rnbd_srv_sess_dev */
+	struct list_head        sess_dev_list;
+	struct mutex		lock;
+	u8			ver;
+};
+
+struct rnbd_srv_dev {
+	/* Entry inside global dev_list */
+	struct list_head                list;
+	struct kobject                  dev_kobj;
+	struct kobject                  dev_sessions_kobj;
+	struct kref                     kref;
+	char				id[NAME_MAX];
+	/* List of rnbd_srv_sess_dev structs */
+	struct list_head		sess_dev_list;
+	struct mutex			lock;
+	int				open_write_cnt;
+};
+
+/* Structure which binds N devices and N sessions */
+struct rnbd_srv_sess_dev {
+	/* Entry inside rnbd_srv_dev struct */
+	struct list_head		dev_list;
+	/* Entry inside rnbd_srv_session struct */
+	struct list_head		sess_list;
+	struct rnbd_dev		*rnbd_dev;
+	struct rnbd_srv_session        *sess;
+	struct rnbd_srv_dev		*dev;
+	struct kobject                  kobj;
+	struct completion		*sysfs_release_compl;
+	u32                             device_id;
+	fmode_t                         open_flags;
+	struct kref			kref;
+	struct completion               *destroy_comp;
+	char				pathname[NAME_MAX];
+	enum rnbd_access_mode		access_mode;
+};
+
+/* rnbd-srv-sysfs.c */
+
+int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
+			       struct block_device *bdev,
+			       const char *dir_name);
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+int rnbd_srv_create_sysfs_files(void);
+void rnbd_srv_destroy_sysfs_files(void);
+
+#endif /* RNBD_SRV_H */
-- 
2.17.1

