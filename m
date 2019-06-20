Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDB4D175
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfFTPEG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44581 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732113AbfFTPEG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so5131638edr.11;
        Thu, 20 Jun 2019 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0C6pmOXmG/gE/MbIQjMO31ZruSKUFgH9D7mmB5BL35g=;
        b=qf4vnGoNvh7igZyIezC7XgU41jzUCImeZzQ+FUYUYzfdVp/uI235apBARjQ14QAbF5
         EfMXmfrGEHJqCAGax3/riYXUYR8yJERPncx114s+495nFzRuU2iI6eYYqqQMGtGiNLET
         MraKqd8VsHnVwiZva46gzE/DDEB9Vxzcm0AR1CZ7gdc2e+gw2tNTuF2f5L5AMhUdERCV
         KN59oAPrx+iYxIHaLNbJVceDoPK8zf1JDQNwLuzskbtmZ2IIGsHC2Z+DRGg3eOzEnmo+
         Z0beZYlxsCHIeNaqvLw5lnFp5dEwxqPs6730CO4a+cnfw5NS5N2Ya/tDdcM7Ihs/tbu+
         Gsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0C6pmOXmG/gE/MbIQjMO31ZruSKUFgH9D7mmB5BL35g=;
        b=GBfDavsl87aObURES/9gkNRldhJOFAU56Iw4CTCQHMqdiV3why8Xpq69/rDskorzkY
         Rp4LdJT2LeegK/x1eo5MxAiGLhIbbC4BwL5IMQwt9MGGAyrZrj9Ol6lxLBFXm//VFHJU
         6zKpTNBE8SIpSDT3pHVXbay59MLV8mD0VZ9bw7+AXq8txV/nAlLccqX0JDrEKJl7EGQ1
         z/XxT35GPWlqrvwI4a8vELda/vhN7qWOQm+AJZcJsniT+nKXHWcUYg5KTHuSrmrrdU+b
         K0M8DSR5Dqg8tsG+NIZOgT+L1QU7v2cPJgsaZJoHUaTcFrmxl8IiQtKGfFnDml1zVhiq
         ss0A==
X-Gm-Message-State: APjAAAUgsAP6eCCtEANUFEOCKSxijuPlEbJ+iG7O4PqDz68/o41L223I
        XRD9OQzSx5odY5/dIKA2u0bJxB31lmQ=
X-Google-Smtp-Source: APXvYqw2zVevNgTKWaR5gEQvRI0Xcaxw8pRN+pqYGm+M2yeVvbympWwmVcmdxGXC1lOI1vNZKXpxig==
X-Received: by 2002:a17:906:4950:: with SMTP id f16mr27672135ejt.259.1561043043878;
        Thu, 20 Jun 2019 08:04:03 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:03 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 19/25] ibnbd: server: private header with server structs and functions
Date:   Thu, 20 Jun 2019 17:03:31 +0200
Message-Id: <20190620150337.7847-20-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This header describes main structs and functions used by ibnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/ibnbd/ibnbd-srv.h | 94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 drivers/block/ibnbd/ibnbd-srv.h

diff --git a/drivers/block/ibnbd/ibnbd-srv.h b/drivers/block/ibnbd/ibnbd-srv.h
new file mode 100644
index 000000000000..6e46c3e97bf4
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-srv.h
@@ -0,0 +1,94 @@
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
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#ifndef IBNBD_SRV_H
+#define IBNBD_SRV_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+
+#include "ibtrs.h"
+#include "ibnbd-proto.h"
+#include "ibnbd-log.h"
+
+struct ibnbd_srv_session {
+	/* Entry inside global sess_list */
+	struct list_head        list;
+	struct ibtrs_srv	*ibtrs;
+	char			sessname[NAME_MAX];
+	int			queue_depth;
+	struct bio_set		sess_bio_set;
+
+	rwlock_t                index_lock ____cacheline_aligned;
+	struct idr              index_idr;
+	/* List of struct ibnbd_srv_sess_dev */
+	struct list_head        sess_dev_list;
+	struct mutex		lock;
+	u8			ver;
+};
+
+struct ibnbd_srv_dev {
+	/* Entry inside global dev_list */
+	struct list_head                list;
+	struct kobject                  dev_kobj;
+	struct kobject                  dev_sessions_kobj;
+	struct kref                     kref;
+	char				id[NAME_MAX];
+	/* List of ibnbd_srv_sess_dev structs */
+	struct list_head		sess_dev_list;
+	struct mutex			lock;
+	int				open_write_cnt;
+	enum ibnbd_io_mode		mode;
+};
+
+/* Structure which binds N devices and N sessions */
+struct ibnbd_srv_sess_dev {
+	/* Entry inside ibnbd_srv_dev struct */
+	struct list_head		dev_list;
+	/* Entry inside ibnbd_srv_session struct */
+	struct list_head		sess_list;
+	struct ibnbd_dev		*ibnbd_dev;
+	struct ibnbd_srv_session        *sess;
+	struct ibnbd_srv_dev		*dev;
+	struct kobject                  kobj;
+	struct completion		*sysfs_release_compl;
+	u32                             device_id;
+	fmode_t                         open_flags;
+	struct kref			kref;
+	struct completion               *destroy_comp;
+	char				pathname[NAME_MAX];
+	enum ibnbd_access_mode		access_mode;
+};
+
+/* ibnbd-srv-sysfs.c */
+
+int ibnbd_srv_create_dev_sysfs(struct ibnbd_srv_dev *dev,
+			       struct block_device *bdev,
+			       const char *dir_name);
+void ibnbd_srv_destroy_dev_sysfs(struct ibnbd_srv_dev *dev);
+int ibnbd_srv_create_dev_session_sysfs(struct ibnbd_srv_sess_dev *sess_dev);
+void ibnbd_srv_destroy_dev_session_sysfs(struct ibnbd_srv_sess_dev *sess_dev);
+int ibnbd_srv_create_sysfs_files(void);
+void ibnbd_srv_destroy_sysfs_files(void);
+
+#endif /* IBNBD_SRV_H */
-- 
2.17.1

