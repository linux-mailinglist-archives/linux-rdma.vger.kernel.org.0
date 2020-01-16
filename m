Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2813DAE7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPM7q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44261 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAPM7o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so18805088edb.11;
        Thu, 16 Jan 2020 04:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnHPzVR0kWx+miQyR675GhAoMogD7WhgBujtPCHCi4s=;
        b=jDWwj+qk8qiHyeuh5/rMxVprwa/YgIUPQR9QRTrmAq9Z8mHpzKhMaGqSKQ4DTFwhxT
         4ap8+9D3SqQg9eK+gj4Oq2DlsrHqbgtM7osbZw1xhaMdqUZEcEN/opLrGgNC/ga79zyS
         GdXc32k9dRbI7uwDUfIPTF86VKDvhWt7lk4dEX5/1r0uGxWr4dckH9jbBxrZ25yNOU8A
         y2i5zj0ArtEmBrHN5QgLtlcjOYEAyB5Yc4qghvI+kHKVm/ILehwQIyK5DRkHWQGDoZT8
         W3OsJQyqApc4wtTIO1t5SRPOpdogz5eJWdBJ6CP6UNp75akaWJw9D1R4byxuZfsz66An
         jPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnHPzVR0kWx+miQyR675GhAoMogD7WhgBujtPCHCi4s=;
        b=g+K77ZiVBJpDWWTY5hKgCTEF+zoZ2gq9ikN9dpoIEC4Fc2MV6r+G3HIQ4W8tmfMNrU
         oDkU0nhiti1XW5bwcDE0CpGhU2iDx4jQRV3BjMHXm+D/pSz7zFYYH/UZK9RYvSLnSoOh
         OGL3nnwb4iXjmeoU6XsJLXiRKGuN6wla5XC9DdNEfsQ4VYP6yKlbDvPhmfc27dEd4p6k
         6kBEwj1v7bsRR+E0HkTA0jr4zEMysOIpspHcjtHcfoWIpLvAGoJTnrILDM1fCf8NhOeL
         EMM/DW1wdhjHTA32mfl6gP6tYoAtXHM4dWDImHti2JRW1v0xKqzJsW0mOy9OhcpchG7d
         GKEg==
X-Gm-Message-State: APjAAAXeev6E9yCFCRhydHYQL4nifLbrTDR8gUh/72lVWnEBIdW/TLgA
        5wt8yusYAqdY8yrVQSYGtnVVmuHs
X-Google-Smtp-Source: APXvYqxne9ojlxXgO5jvWJdhxMZdjrr767SpVTWkSCtQdOM4qf5Oe4tR9amy54qGFxuFC3wxcxH1NA==
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr36176368edr.223.1579179582522;
        Thu, 16 Jan 2020 04:59:42 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:42 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 19/25] block/rnbd: server: private header with server structs and functions
Date:   Thu, 16 Jan 2020 13:59:09 +0100
Message-Id: <20200116125915.14815-20-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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
 drivers/block/rnbd/rnbd-srv.h | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..7567d84dca4e
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,81 @@
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

