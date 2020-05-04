Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C91C3C2E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgEDOCm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgEDOCl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D4C061A0F
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so21089825wrx.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVBhZt03wXB09SQpaisoaWTctJpSMvKx9AU5bhdDfRw=;
        b=DA10nYLaxL//zXE4fa1gLq3XDvm0VCiZdFjqHJGGeFsV/iPmyA5ifMFJJDp/uEsW9W
         cTDcfOYI2zD17tVGI6Wyc/IlSOUUcgp5RU0+llxd53eCXk8yFZo8xUAJX28Ng6q/vgl7
         Ybe+4I9TtlIDbMLEXo1PQBmFrS8KjpdGRygaMGN6T7XaQy0/YvkJcfFCj0xSuO1AtLOh
         sUWZdRRFKtPDy+sKhUefDx9qBNz3KrCpCeTa0bVJ7BFQnRb9IvtTylSNnUnzKsivGxOv
         AEGfTYJu6lpI38dlZr6qdcukNT75sQWnGJ8BHjZ06jP2wlZcvRjziY5SaSywt3bN2k05
         wc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVBhZt03wXB09SQpaisoaWTctJpSMvKx9AU5bhdDfRw=;
        b=hyfenqnL4TMO+obERafTp5NK+YZ9zcGdtIPxZkCHDCsQffUBUJJp5Ivut/MbijBN4v
         vuHKSW5bf7HuER8gXGEskcoFLe/MPFszmOXl/wYXIi1SOekaMjoeo8dg8+b8CmRbiYD3
         9xaPGG1HderyfbsnAbMBhuwzaa2DIp9gRE/iqOjPLJGyZ+b2i+eqjp/m7kbm170vnH8V
         Vagb/yFkENN989IB4umG2xJYWTS6w1XCYg/gZZgR/ZUIZuyPmvEmLYYpxNQHab863jl4
         Q5goawZd9DEQybm6HElW4tdAl+k7bhmMggYZwaOnCk9ZsStNJQr2JQsygJPOMnEuAqeH
         E1FQ==
X-Gm-Message-State: AGi0PuZJTYXU3fZ2iKqYO7M7Z/RITwVlliZ+A1vsjzIJQrL3fIJAvK+m
        rmoCekpEsvjpaR8xM5j3RBH9
X-Google-Smtp-Source: APiQypJUK3OXBNFbVJeKcjjfZH2sIuQyqS4P+jFp50kLJqANkaXKxgUIG8mg6h/yYkn1XC6rHbb1ZA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr20850721wrh.410.1588600960295;
        Mon, 04 May 2020 07:02:40 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:39 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 19/25] block/rnbd: server: private header with server structs and functions
Date:   Mon,  4 May 2020 16:01:09 +0200
Message-Id: <20200504140115.15533-20-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
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
 drivers/block/rnbd/rnbd-srv.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..5a8544b5e74f
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,78 @@
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
+#include <rtrs.h>
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
+	struct xarray		index_idr;
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

