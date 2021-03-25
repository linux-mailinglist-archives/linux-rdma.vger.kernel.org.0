Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640FC349597
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYPdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhCYPdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA9C061760
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j3so2852926edp.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY09X4RTVMVyeB0fH2ImyZ21ASNAdawwO8xe2KM82Ns=;
        b=Gy7UdzTCmzua7izN1hus7K41iSJjpU7Ul1rGebmS7DeKl9e1C0V4gv7r99s6YxghgB
         Dhfw2wyjdNomENKNssxjwkBTUnkayvwnFsdLNN5mcJ7Fq5a+1TtODZ7kPIBeKj4JUScg
         P//e2HYpocVBmlk7Snz20K6gRHckmKnX/zJq8Ol+Lnn2OO0hfDQOKkSHo3RrO6VWoQPC
         J3rMqp4CseMJo1xlY7QCWA444rWaThmKWK/fV/5i72yJQM3gTdt7p7w5T1fNOb1KX2ga
         E3wElo6XrggvqGhwVUOnyffcGr1IwGUGzR08OYdhKlcf8qt0QXjUminjCBZUiQuOPnCj
         M67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY09X4RTVMVyeB0fH2ImyZ21ASNAdawwO8xe2KM82Ns=;
        b=im5mPQDjx4o4XFo46r7vuh7oCfOlkKgPAr+82l2u/cqzl/H9LKH4UxpECwlcAwMXAq
         oEhNsBHq/u9TKmCMC+JCsu10YDlhHegZOH+nxnne89zL6WEEE+k/VP7doUzYrVPysMqe
         ci9VHDWaZtXg2zUAV/81tX7J7COnd/6wqGqSITrVlSriu8GIvKYSqSQ/HOO9fmXUYys+
         p2gJCdQc1D9Xg0r1zMUJRU4e413pdEwFYeGG/SrsSmDnQbiIuypgv4c9EtEoDbh41PeC
         M84j6yD92lVVfYWlm5+I4456SUNnIe5awYY4daLSRNr8Y/oUi0MMy643SQaDvhHHHz0D
         z/AA==
X-Gm-Message-State: AOAM532D3NaVv1D5fk0LT3dNiaxE3cEqWjIzsU9i5VP7DCYa1jlQ+MJ5
        2dTYuIwyu1TcF0S91SwCEcbaxUp8ajBZOQjG
X-Google-Smtp-Source: ABdhPJwFpfRbivlCjrUhKhliFUGpwlQhMY1GbdVMfM1k3CTpXL1l5uzZcsFPy39L95Hfkv37j2dNGQ==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr9848085edb.306.1616686394927;
        Thu, 25 Mar 2021 08:33:14 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:14 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 02/22] RDMA/rtrs: Enable the fault-injection
Date:   Thu, 25 Mar 2021 16:32:48 +0100
Message-Id: <20210325153308.1214057-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

This patch introduces some functions to enable the fault-injection
for RTRS.
* rtrs_fault_inject_init/final initialize the fault-injection
and create a debugfs directory.
* rtrs_fault_inject_add creates a debugfs entry to enable
the fault-injection point.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/Makefile     |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-fault.c | 52 ++++++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-fault.h | 28 +++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.h

diff --git a/drivers/infiniband/ulp/rtrs/Makefile b/drivers/infiniband/ulp/rtrs/Makefile
index 3898509be270..3490f66bb7f2 100644
--- a/drivers/infiniband/ulp/rtrs/Makefile
+++ b/drivers/infiniband/ulp/rtrs/Makefile
@@ -3,10 +3,12 @@
 rtrs-client-y := rtrs-clt.o \
 		  rtrs-clt-stats.o \
 		  rtrs-clt-sysfs.o
+rtrs-client-$(CONFIG_FAULT_INJECTION_DEBUG_FS) += rtrs-fault.o
 
 rtrs-server-y := rtrs-srv.o \
 		  rtrs-srv-stats.o \
 		  rtrs-srv-sysfs.o
+rtrs-server-$(CONFIG_FAULT_INJECTION_DEBUG_FS) += rtrs-fault.o
 
 rtrs-core-y := rtrs.o
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-fault.c b/drivers/infiniband/ulp/rtrs/rtrs-fault.c
new file mode 100644
index 000000000000..af475c814c29
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-fault.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#include "rtrs-fault.h"
+
+static DECLARE_FAULT_ATTR(fail_default_attr);
+
+void rtrs_fault_inject_init(struct rtrs_fault_inject *fj,
+			    const char *dir_name,
+			    u32 err_status)
+{
+	struct dentry *dir, *parent;
+	struct fault_attr *attr = &fj->attr;
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(dir_name, NULL);
+	if (!parent) {
+		pr_warn("%s: failed to create debugfs directory\n", dir_name);
+		return;
+	}
+
+	*attr = fail_default_attr;
+	dir = fault_create_debugfs_attr("fault_inject", parent, attr);
+	if (IS_ERR(dir)) {
+		pr_warn("%s: failed to create debugfs attr\n", dir_name);
+		debugfs_remove_recursive(parent);
+		return;
+	}
+	fj->parent = parent;
+	fj->dir = dir;
+
+	/* create debugfs for status code */
+	fj->status = err_status;
+	debugfs_create_u32("status", 0600, dir,	&fj->status);
+}
+
+void rtrs_fault_inject_final(struct rtrs_fault_inject *fj)
+{
+	/* remove debugfs directories */
+	debugfs_remove_recursive(fj->parent);
+}
+
+void rtrs_fault_inject_add(struct dentry *dir, const char *fname, bool *value)
+{
+	debugfs_create_bool(fname, 0600, dir, value);
+}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-fault.h b/drivers/infiniband/ulp/rtrs/rtrs-fault.h
new file mode 100644
index 000000000000..8c1acffb2b16
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-fault.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_FAULT_H
+#define RTRS_FAULT_H
+
+#include <linux/fault-inject.h>
+
+struct rtrs_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct fault_attr attr;
+	struct dentry *parent;
+	struct dentry *dir;
+	u32 status;
+#endif
+};
+
+void rtrs_fault_inject_init(struct rtrs_fault_inject *fj,
+			    const char *dev_name, u32 err_status);
+void rtrs_fault_inject_add(struct dentry *dir, const char *fname, bool *value);
+void rtrs_fault_inject_final(struct rtrs_fault_inject *fj);
+#endif /* RTRS_FAULT_H */
-- 
2.25.1

