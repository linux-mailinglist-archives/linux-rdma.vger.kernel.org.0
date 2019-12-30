Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5881A12CECE
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfL3K37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45809 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfL3K37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so32139497edw.12;
        Mon, 30 Dec 2019 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QY0EiQFrTAmxLGS2oP6RvDNkVaiVsAETX8WwWC04eWE=;
        b=qWIeuvuMvjRgxBG+yQfp9XzDxn4Ag7E6s9Y7U+HPpNU1dQMdczX4haPuOMfmBDFs/o
         CVuH6J7sBh/kMkrrKuAhSHCydwbxGjm3eHcrMEZ1YxtDA65J6AbDUUfYjBW9tmUGXepb
         fOih+qFmFUHvy9D3Ksm2b0TNPYXkqE6TS/31699BXU32laU4fkOzeExEbZ7dQAyyVB6G
         07DUBJYP1p1PJ+JlpkNrzfG/hqdJLIK3MiA7AtgNzWES9nkln9adF45VjJbduEg4+pq+
         mBl2tw7C+sWc2zFr4TO4pRlnLit0e/qxbyUiDGirLuKkjgV2CgEAHnQs6pBB/f136iMS
         utwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QY0EiQFrTAmxLGS2oP6RvDNkVaiVsAETX8WwWC04eWE=;
        b=R75zWdFKIONmszX7E2588K6QpAUOhyANaBRu934FfhWmtgmP1wQ7atfALJCeyMQq1Y
         t8nBD0enXnhQeugGzj09GlAF4t0AjaG2fmCi2i1qGqAw4YpUqLX8csMF542LPNucCOoK
         oGtUjijPo2eRrSOcJ9tGHTX4cWfW/tuBvNRxhMY3mxu86CF6LseNG55pg3z3oE17jiI9
         jv+frCquwvrolRDgJSHfSeV888moRDvq6LDSLSlrFbNsF74oMGi/e/fvOqBJPHTJ6CcV
         fxOOQ8s6lYD6xZIvk3jxlHEbZPyDRqWaGwFApTxeD5ooMgWgzcmT5njlJiCugYQy4ImU
         Cu9Q==
X-Gm-Message-State: APjAAAV5vMWFkr1acBgd5R8DkrGuilGJzSQqr58JhwlDMkb7wp2HPApd
        tzS5EJfNhshWnWcPye0v68BhASkM
X-Google-Smtp-Source: APXvYqzkn8RC/3UXvZEuSBnHrh04zpko/pd0IlxrdQ+AOFxfX7oiW2zt51FPKBQGiPDPcWsLWEPTWQ==
X-Received: by 2002:a17:906:3796:: with SMTP id n22mr68481881ejc.222.1577701797041;
        Mon, 30 Dec 2019 02:29:57 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:56 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 11/25] rtrs: server: statistics functions
Date:   Mon, 30 Dec 2019 11:29:28 +0100
Message-Id: <20191230102942.18395-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
index 000000000000..515f7088db71
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
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

