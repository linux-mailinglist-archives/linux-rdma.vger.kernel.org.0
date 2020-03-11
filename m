Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751FA181D6F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgCKQNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgCKQNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:13:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so2779383wme.5
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bFZMoThFPsHK0B7YajbqOi+az87fjoCNRv6x74L1yQw=;
        b=XUSCIc2vg81QArsPrFjGIATBT/7XBhisM/O9c03wLofDDzA+YLXoOsBuHxtv2WtGEk
         DMVP2+KMWoBiS+euMk70M7CMO59sSBEn8PjYqOccYNK09SCOCv/9oLDe4/yv8qn/BQMV
         9VzPFBx8NgLs0Mnte4/w0Q53hMTG4zPs25SjAzvsSz2ZgKw/YGKUcZDX4DVfzd19yAhQ
         E/lbGuky9lAMZyJMDQuTxItMqYnYsItcZIWLE/1IXT3osLQ04+ZrUk04I8zYB1Jj6oQ0
         oDj/4P8Ts4Ff/w/d32sUHRq2hnAy0UheWpEhdO3uNt1Z8tgFAW1HKtOU/nA7KY84g4w3
         5qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bFZMoThFPsHK0B7YajbqOi+az87fjoCNRv6x74L1yQw=;
        b=JXBBIT7+x2cIZAK+GfnJUmh++Dah+x24A6qw2O4SdSk3gB7uruX8ld61uDYm5qMzbO
         QrKbeHf/sOOW7V5FpvE6jGhde3JdWkO3JYN4zirChyh8pViX7vLDHo98aTkl1PCwwTfW
         LM/sL/FEMxtRuNjRxqNE5qotKUw3+SLF9P/3vrfBxZy2gUB/a3Rv8DmsqAZGL40fihOV
         cl3s4NZcupIt+cWwO8p90jtUS7X1vF73aZz3zBoYXoTa9tkWiXBhTtCw3taiwkCTTCGv
         8Nxj2cdPO+lI1hl2KQ0dR74Uox+Uenr2WRVY6Bt8a9e9V/+Rj26KPV4vGzPPSr+GOHJB
         4e1g==
X-Gm-Message-State: ANhLgQ3V9Ftq13oNLJSL9+DffR0SJkCF2cDkB/mWEUEAAkMbJcteB6P5
        RZMCOfN1JBjzZ2MO8bc9OkNOuA==
X-Google-Smtp-Source: ADFU+vsnDCIDkp6D7HZNDKoicjF+w0U2+A0uGJBrO7trouFugz068oqqG6RoBeKkSpP+Gqbe1c+3FQ==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr4189636wmh.132.1583943193379;
        Wed, 11 Mar 2020 09:13:13 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:12 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 20/26] block/rnbd: server: private header with server structs and functions
Date:   Wed, 11 Mar 2020 17:12:34 +0100
Message-Id: <20200311161240.30190-21-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This header describes main structs and functions used by rnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv.h | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..27cbcb86bc38
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,77 @@
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
+	struct rnbd_dev			*rnbd_dev;
+	struct rnbd_srv_session		*sess;
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
+			      struct block_device *bdev,
+			      const char *dir_name);
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+int rnbd_srv_create_sysfs_files(void);
+void rnbd_srv_destroy_sysfs_files(void);
+
+#endif /* RNBD_SRV_H */
-- 
2.17.1

