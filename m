Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A31A988B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895420AbgDOJXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895399AbgDOJXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B419C03C1A8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so18070708wma.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/LuLDh9YK1dQOSDUu8eDD6LepxCi9Ej7sBpxBWHxIk=;
        b=X5wK/PxV+v0PhlIErquewZDnjcAjz7CvIjJUl395sqLbV3XoQih+s3aSxmxQgaP7M8
         hPvkQpw2BXLAmZdQ/IKct6+7qRTCuRU6m6VpH3BZR8R2pA3uthF+JuQmPT3nYAItH0bY
         fJ9yAVyFtr521GEoD6tV/KJ7xkg+VPcf3d63rzHPbyBzcJl8MxdMLVUVSpzjLH8hb9wj
         S7aoOuul8eOTHVpU04fdBR5CYW9mryny35sBI7gQU7uOAOf34x4WsHIy+4jkaA1BqUtp
         A7qz5kAgdJ4A8ZCHWp0fMedLCWtqGwcyu6owkc9rGmZztxsAHgCOygkgBsULrQf4K259
         Z/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/LuLDh9YK1dQOSDUu8eDD6LepxCi9Ej7sBpxBWHxIk=;
        b=WHgfWhyOtugixUXRvGn2VkAZjuuvQVngzG3QevdUY93TxycB3W3/z8szBS3XosN3X1
         OuOa+iG8hlnog10CtPfxSOwka35CIr1H6lvNeNfoLU/9qxDPxXPnTeH0GQNU4zcJNDub
         t/Xla/dkIIbgF5hspJxuxdNq4Ousuvc2pNJ8wJXtaakymG6AFvG2trRnx9oDEMkW9DhW
         Hxf7ZkhTq8Cw8HjjIMNHyu1zXUGBeVuheRNaCGpp9aSmN5Vn4FNQdYlcuBqKeCn8LQv9
         yxtTwPr5eI4scfhJ0JtO9xjoUA3fSSb0LTCdxh+CU9/um1G+N8TQcxg1J2Z4gmeMBBGv
         kGyQ==
X-Gm-Message-State: AGi0PuYlo9npPN8iGtUOkjUKmdG8t4+sga7LDqrWzvD0UVmJS907GP0h
        8oz4jYoUfvBLX0EZa2uqvvky
X-Google-Smtp-Source: APiQypKszEVKbbHO0z7ZNvMqqp3jAQ68YFBEDSTjTqraWwb3GQz6LcKqsq5LJJbEWtEzHUmeg9c0SQ==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr2453931wmo.17.1586942587246;
        Wed, 15 Apr 2020 02:23:07 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:06 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 19/25] block/rnbd: server: private header with server structs and functions
Date:   Wed, 15 Apr 2020 11:20:39 +0200
Message-Id: <20200415092045.4729-20-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv.h | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..89218024325d
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
+	struct rtrs_srv		*rtrs;
+	char			sessname[NAME_MAX];
+	int			queue_depth;
+	struct bio_set		sess_bio_set;
+
+	spinlock_t              index_lock ____cacheline_aligned;
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
+	struct kobject                  *dev_sessions_kobj;
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
+	struct rnbd_dev			*rnbd_dev;
+	struct rnbd_srv_session		*sess;
+	struct rnbd_srv_dev		*dev;
+	struct kobject                  kobj;
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
+			      struct block_device *bdev,
+			      const char *dir_name);
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+int rnbd_srv_create_sysfs_files(void);
+void rnbd_srv_destroy_sysfs_files(void);
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev);
+
+#endif /* RNBD_SRV_H */
-- 
2.20.1

