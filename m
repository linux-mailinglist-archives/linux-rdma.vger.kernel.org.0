Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB8167B4B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgBUKrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36156 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBUKrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so1799990edp.3;
        Fri, 21 Feb 2020 02:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/MVL3CEK/kLX6jLzMHjBUm0aMsjexndhbwNNGgUxkYI=;
        b=lRIKCuiHZnOqJ8L8i3OdknAuoMYAk/y4Jsq/01RfgwCkZhomDnNwDggi/aWXkB5PHN
         lEQZ+IDNMJ3JreN3l52W95VuBvX5zwOalaZzqVtq/wdT02WrYY9WgDH7YqzJIZgvIV56
         RXIj/Lk/FGRQLsR/zqBbtbChJnOFB/Mi4Abpyx318sbXkwVl/65whvmyHRHbi5RBXybU
         qh4vjIsgrdvWrMffqB1ggzQg8YhUHq32isi1WPin18FGSxAuerlqN3QjlX4BO5vs8aA4
         grPNpIrgpeUB0vM07w1ioOfoGJ200W+L8NWWYo+QZ87Pj93C72boax7OO3v6p7iZwemE
         8PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/MVL3CEK/kLX6jLzMHjBUm0aMsjexndhbwNNGgUxkYI=;
        b=F3CiYbuU3Y2AKtTv93eClm3WeDHeZeeZvq3Ut2dE51aPx38p8l7R1Evnv2LRb+Yujb
         NEuXaziWRc4vfsGsQS0yfbwjcGTgVlsd7fTbvx78fvNauZGi65B55GnSpgFtTR8D1oYq
         x72/Lh4FSBiFEtw/XMVrwlBpmomkLFSkd99cQrFaG5hvleSoMYS9oPL0rW61o6SoIghF
         FQkZ/L0ewkTY8icTLbVcXdwfr+vLPMQgPZwbebyuf27Y444TCA7eJI013N42dlZod4u8
         prg6+aakexsQpMIVZqty1PJqqZAvCXnRSsxoZKQjs6lj1PMq5KRXHGUqvxVRGkeC8528
         osLg==
X-Gm-Message-State: APjAAAWWuwtoxVN2fDF74eTvNFcQjSUF6ft51x19v7o3supUFOoVCbWW
        Ebq4d+dtvFF7bCsxiB/7uWv5qybB
X-Google-Smtp-Source: APXvYqyIgm8ynOMhTNbHu8SYbnLO/QPF1QeR9A+h28KLR9Fo11z/6eAp8zrZnCOBZSME0e9qtZEAVQ==
X-Received: by 2002:aa7:c6d7:: with SMTP id b23mr32813587eds.156.1582282063607;
        Fri, 21 Feb 2020 02:47:43 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:43 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 19/25] block/rnbd: server: private header with server structs and functions
Date:   Fri, 21 Feb 2020 11:47:15 +0100
Message-Id: <20200221104721.350-20-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
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

