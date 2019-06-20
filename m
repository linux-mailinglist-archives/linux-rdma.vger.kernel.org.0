Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3965A4D162
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfFTPD4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35448 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbfFTPDz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so5214730edr.2;
        Thu, 20 Jun 2019 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/4+WJUF6wFlj/gINxWkXulMUA1zWaeQmx3yasj0RNI=;
        b=YFRaoTBu1nBvG8aRoO5sV11peZJlnLnA4VQoPKVqiNtAiskIeZUYfpCMbr2iXFteKt
         PDPPmut4L3B3QYKrGuCLjRFvvuQsXL1farWnhWvBusTOVRlFyNMImsXfb0EYtqXcIMEx
         pqBT2Vp68a48ItrrZmJO8ivLJY4LABYT9tdOHYgIv6LEJwKiNIkfMOWjJuP4TvXZkZWS
         xPaklmRVzAKkJ0xJjsyUjMD70JH/B+FQlq/StYIRo3CHaMzkDWa0+cpswnZNF8r8RtpY
         LVywdA/KpuduXTipXNejHgKhCacTH/QEYWBuOpOQkozYHBOu4yQz+Ya27iiN2O0g85m+
         2C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/4+WJUF6wFlj/gINxWkXulMUA1zWaeQmx3yasj0RNI=;
        b=GLS6mA3M7aGquR7gFn2WoNw9WDJhc0d4yQeOLmb4aaedoSHeonSXnEdPcsbu6N1iNM
         hpMqINHCaSEzbjQANuEMcmAzg8FocXdl3e36+0af7XJssOZckrIWCitKOQJWzcho9YGo
         L5dyZoz6Mu/fvlcQpD3HR5TmjPEH5hFOFJmSLhj6S3cDv4tc0sCa45OQEHXK4Tfm6gYy
         MP6cyIng0EJ9nPCy2PyRE5eRCVWhkhhyEm2Ydtc3N7uNEvjXi8+K8BiqC0pg3WGM113e
         aJ9L1oHMCOGYx9GJJFhozmejZUvlDf6/XgsJp+HK9iJOrlUYJtEwEQU3gM6sr1dc1dNk
         UHpg==
X-Gm-Message-State: APjAAAWyVSeZHohFDhJXGiotBsnCpOGvT79GLw8A3LJfz0CqwfbN6Ri+
        EVP2iZK2AN/6C67UvJXKS9vJ3Gd7sug=
X-Google-Smtp-Source: APXvYqw5ZWmxL0IjWStvi2NnoJhhAfW/5yzmqLWcrCXTczkyw5tr9D8SjNMV/tm3xicR2RXJggGtpw==
X-Received: by 2002:a17:906:d549:: with SMTP id gk9mr94798483ejb.268.1561043033168;
        Thu, 20 Jun 2019 08:03:53 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:52 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 11/25] ibtrs: server: statistics functions
Date:   Thu, 20 Jun 2019 17:03:23 +0200
Message-Id: <20190620150337.7847-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 .../infiniband/ulp/ibtrs/ibtrs-srv-stats.c    | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
new file mode 100644
index 000000000000..47f8d6d2d88d
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
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
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "ibtrs-srv.h"
+
+void ibtrs_srv_update_rdma_stats(struct ibtrs_srv_stats *s,
+				 size_t size, int d)
+{
+	atomic64_inc(&s->rdma_stats.dir[d].cnt);
+	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+}
+
+void ibtrs_srv_update_wc_stats(struct ibtrs_srv_stats *s)
+{
+	atomic64_inc(&s->wc_comp.calls);
+	atomic64_inc(&s->wc_comp.total_wc_cnt);
+}
+
+int ibtrs_srv_reset_rdma_stats(struct ibtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+
+		memset(r, 0, sizeof(*r));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
+				    char *page, size_t len)
+{
+	struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	struct ibtrs_srv_sess *sess;
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
+int ibtrs_srv_reset_wc_completion_stats(struct ibtrs_srv_stats *stats,
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
+int ibtrs_srv_stats_wc_completion_to_str(struct ibtrs_srv_stats *stats,
+					 char *buf, size_t len)
+{
+	return snprintf(buf, len, "%lld %lld\n",
+			(s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
+			(s64)atomic64_read(&stats->wc_comp.calls));
+}
+
+ssize_t ibtrs_srv_reset_all_help(struct ibtrs_srv_stats *stats,
+				 char *page, size_t len)
+{
+	return scnprintf(page, PAGE_SIZE, "echo 1 to reset all statistics\n");
+}
+
+int ibtrs_srv_reset_all_stats(struct ibtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		ibtrs_srv_reset_wc_completion_stats(stats, enable);
+		ibtrs_srv_reset_rdma_stats(stats, enable);
+		return 0;
+	}
+
+	return -EINVAL;
+}
-- 
2.17.1

