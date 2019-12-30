Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C269D12CEDD
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfL3KaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42205 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfL3KaH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so32201576edv.9;
        Mon, 30 Dec 2019 02:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s/6vUy/TLU86ZpkxgO9qxjH3WLg1Wnd5JbMovJ0Wadw=;
        b=mSnYi9CTIEsk6W5LfszP7bXuneyK69ybiczzVy1gPXLRHrjdgFadY/YE32hdf8j+71
         bLDMw6HEuY4dUn5E2EtH8IElvDbAlGraScKv8ahq1k6USj/tfI/2okqPRQNSZVRJid7d
         Qy/ifFIFSzAq7hpOtZCtcKC/3F6E+M2Gak3eMEQCJVWynpqMjPeqIkI7X2iG6As+vP6/
         S7yzHeWqVO2jKbNaH9hS6NsdV0qaN7g7T+nTPgqvwI81H4aF23H497aj67n7p9kS5tFE
         DSQa4Gg5FRLpK4wS3PnZ7rzJsv4vzLXcMT1KW5q/gWNxbr92ndYplTcXnHDPnZ4EqYhM
         ucQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s/6vUy/TLU86ZpkxgO9qxjH3WLg1Wnd5JbMovJ0Wadw=;
        b=NQ0Krpw4+I0it91D3xqOlK0FF8FrMwFkH2sXmRlijmkFU5SQa+qfhNIgsDR9BdCMBZ
         x/rzedjRj7XvhqW9IbX3y09Z8RASjttDcbFnjfl2xT3pskzz7pB/FOxT2dRBEwRKStKf
         8de9CXizyrD0IjKL8CBC6UDKFwTAdLFD/znU2DNefzHjSDbSfuBF12CE2Cds4UwakIaT
         3F3HopXFXwPRMy+y1wgPFOmE8gZU2GB5QKbKVn8oJmS13OJm6wQUN3Uo/uI40aEP96+9
         JFAlArSMh9l0wQbP669l4YPgdjf+ngjZtEKzNwrNUzvrVqZX0qUuHQJ/ankS2OsjGe66
         d3tg==
X-Gm-Message-State: APjAAAX++miUhwn8hVaOsLGm28vIBJpPaBL34TOiUCzGjDnhgda3BD9d
        YcK2LPxFN0rhPJisuzXnOXGtvka+
X-Google-Smtp-Source: APXvYqw90pYJlvmSaN4pLFXCY0VKLjvobLPQu9V+WxqzEQJlbxXCoyi2M87zUJGkZ6V+CrIczeHTww==
X-Received: by 2002:a17:907:11cc:: with SMTP id va12mr69734620ejb.164.1577701805363;
        Mon, 30 Dec 2019 02:30:05 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:04 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 19/25] rnbd: server: private header with server structs and functions
Date:   Mon, 30 Dec 2019 11:29:36 +0100
Message-Id: <20191230102942.18395-20-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
index 000000000000..2c1f4c302ab1
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,81 @@
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

