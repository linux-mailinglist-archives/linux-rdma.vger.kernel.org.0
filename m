Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F364313DAD8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgAPM7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43021 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgAPM7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so18818811edb.10;
        Thu, 16 Jan 2020 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVjQi3swTQZaHX7BvuhI5SPAK3nHmXGIgLpzhc0EkUk=;
        b=VL25YhchKdS5equNQjq4rKmEvAV5GfcaCroUhozWbQwSPgyANwgLFjxxNtJaYwlf+P
         28XcUO+Bey6tuxFaBemiZRMk+R15I6ZEFWDmRfEGLcBDS6PlEqDPLRkYWt0b7vFEqPT9
         Ejy6wcApKwarQuJwcky8Qc/2nWylhOhcfwNE6BH08xLRsQj6sWQBX/MKSdqfCvNrjVQc
         SGOw3AHLs9a6NqCxLEEYRZhrf9+/2KUkfWQODaWxhbOE7szdKmhJH9h95VQCNrJHPzvY
         ec7l+pi9gZhBs6mowP1ixJnwBr8/6Z0ICT6myJaTg+elGgeV3SY6WMD5eiK0BLfBcjDE
         hDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YVjQi3swTQZaHX7BvuhI5SPAK3nHmXGIgLpzhc0EkUk=;
        b=A+vINW4hrUdmIHJVlTxwg4Mh2jz8HwF8v78jFLeOonmHM7/HNOfquElNOn98qunHcO
         GC3QTaKWRgwuAGdjB2SvY+bCyc8ZLJmW4Omg6+5sFU2kCvcGN+6ZT8X5NqLFlapFyfKY
         KeBuBHFzwrvgMCk5jypYkaqqSomM18ag8Kqq4VcciRv7CReCJx13phCYOv6LCb7boxEB
         iSMzq2LG11+Z3Q6ic20x4f1Psa1Ty8rYtS0jvIOU5BgbOoAKiTrqgt3ppVlgMcXbcTTZ
         ehvTK+exaehhJfGm424eMyETOAUjGubfjdeMzwOpSpK1BqVg5YEYEmKBJZJR/59xh7hA
         UTBQ==
X-Gm-Message-State: APjAAAU+kXizW3vEKfC3aKAiSMl3QDCUC7mr3rgIydmxOaLkz/bDSxo5
        taohY2WslqRpO4CF1HOKMLoJzhRt
X-Google-Smtp-Source: APXvYqxbhgTGe8D334gbcN9p6qHRxOEF9CaIY7GdoXdKFvFqM3vCa68+lmnvR+VOtUGo+XcaZRawhQ==
X-Received: by 2002:a17:906:52d7:: with SMTP id w23mr2780770ejn.74.1579179572522;
        Thu, 16 Jan 2020 04:59:32 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:32 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 11/25] RDMA/rtrs: server: statistics functions
Date:   Thu, 16 Jan 2020 13:59:01 +0100
Message-Id: <20200116125915.14815-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 91 ++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..fe00c55719d6
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-srv.h"
+
+void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
+				 size_t size, int d)
+{
+	atomic64_inc(&s->rdma_stats.dir[d].cnt);
+	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+}
+
+void rtrs_srv_update_wc_stats(struct rtrs_srv_stats *s)
+{
+	atomic64_inc(&s->wc_comp.calls);
+	atomic64_inc(&s->wc_comp.total_wc_cnt);
+}
+
+int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+
+		memset(r, 0, sizeof(*r));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
+				    char *page, size_t len)
+{
+	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	struct rtrs_srv_sess *sess;
+
+	sess = container_of(stats, typeof(*sess), stats);
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
+
+int rtrs_srv_reset_wc_completion_stats(struct rtrs_srv_stats *stats,
+					bool enable)
+{
+	if (enable) {
+		memset(&stats->wc_comp, 0, sizeof(stats->wc_comp));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats,
+					 char *buf, size_t len)
+{
+	return snprintf(buf, len, "%lld %lld\n",
+			(s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
+			(s64)atomic64_read(&stats->wc_comp.calls));
+}
+
+ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
+				 char *page, size_t len)
+{
+	return scnprintf(page, PAGE_SIZE, "echo 1 to reset all statistics\n");
+}
+
+int rtrs_srv_reset_all_stats(struct rtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		rtrs_srv_reset_wc_completion_stats(stats, enable);
+		rtrs_srv_reset_rdma_stats(stats, enable);
+		return 0;
+	}
+
+	return -EINVAL;
+}
-- 
2.17.1

