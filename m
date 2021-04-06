Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF513552B2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbhDFLvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDFLvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:51:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E32C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:51:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so15165867ejk.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY09X4RTVMVyeB0fH2ImyZ21ASNAdawwO8xe2KM82Ns=;
        b=Nxu8t+x6Z5EDg6DFek+8zg5oIoqKTWPM7Wx4IGLFkKVIiBeUDTGjz6B3UFwpZ6DwLB
         rXiNw0FoDhVc28NR52K4nVPnlyc1Be8QjVUTwM0bvNMpMBb7mXCxEizgUh1CfO45zPoF
         c+g3dPSvs5f8tzKPRCHTliWmhNEe5ny9VlFTrZZHTEeTeWSBazHu8/OHQJsPoI+RNzB4
         We4k1+5MW3Keez+u24AyTV8gfVnmWaDmX6pCkgmHY/gYeGCu6rxIkwYNurG6Vz5xCf1+
         HuWGd7UAqTHiCMdwKG3GrZ3h+FhchFrS0qqoRu95huPU4Vh+sGjHFrxh+bJIC+/DtrnF
         92yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY09X4RTVMVyeB0fH2ImyZ21ASNAdawwO8xe2KM82Ns=;
        b=l9qYJ/1wzCZ0Jme+NYWXFh+PuqxAa5vV/wgKw63EoPZo26jgO3xx2pwICE2qLjX7uc
         1ZklR4AXBh0ndfnemP6WfSIRTYpHVhwgrlVnSlF8mCvajpSxF8egn9TR6G+87FDDK2k1
         s7AQnD85tKOR3DfNGeTpL13fF3RRutaWQWZchTypu2vyOWTb8dhGpObLlQOKVZtaqlmy
         YtW/9/G883OBWkZStCfA3a9d1Kjzb7TpBh+k6UEaHfk1K2PnAZzomtMnRgjiq2fEzu9K
         BHArMGcesagbHb+zbMgaCCQPHukvsh0gNtoFa1GsFJfiP00Lty4xbvdA3r+3/Iw4xFWJ
         vrNw==
X-Gm-Message-State: AOAM531UwXzswGyl72C12ZjAQ0Y0pMMN1qgvYqJh3jQSLC4mdj6P2CcD
        PmSPylHzbBmLGv2GuURLnIWYy6B7Q0t9mds8
X-Google-Smtp-Source: ABdhPJxuBPAfOpHJMUfQ/58YJMeCgYPYUTmuwiTzPf09cx6RGvjWNw/u1z+tKbPgxKvIM2cxcYgeJw==
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr31489686ejm.130.1617709859099;
        Tue, 06 Apr 2021 04:50:59 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id t1sm855964eds.53.2021.04.06.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:50:58 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        akinobu.mita@gmail.com, corbet@lwn.net,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 1/4] RDMA/rtrs: Enable the fault-injection
Date:   Tue,  6 Apr 2021 13:50:46 +0200
Message-Id: <20210406115049.196527-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115049.196527-1-gi-oh.kim@ionos.com>
References: <20210406115049.196527-1-gi-oh.kim@ionos.com>
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

