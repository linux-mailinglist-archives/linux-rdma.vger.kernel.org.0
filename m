Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70364167B37
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgBUKri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39004 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgBUKrh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so1779777edb.6;
        Fri, 21 Feb 2020 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdySojQZqpYa7EKDo0NLeJ1K0iCrqM0lXjyeevcXQKM=;
        b=nA1vWiE4bp3uL4eT1GfGCCj6C3O+qTtA8QT43p+HT62XYnqTtlZQK33T2GZckPc3De
         /UhS+5W3B5akm7U4v0Fgj30JPFKsgutCJugrXU+/tb1PPTpcIEVIcObwgBGov+Ek6Mul
         6kEnBLLWcPn9kNVEF3fLED25316k90hdfLGkZmGvtGMTsh//vQ/4xnAIIfKc6XK7wH9Q
         Ji6SEz0PdtYaa0iM0BfcmOE6mTSUonHLcjXCbSoK4ExjtfuVe+xW2j8Cc2NmC7D+FR/T
         /a1k7qUIdCLofQlEGXl8SZFV4ug34DWkRjcU7ou5hFHQpsYOhQwIy7R6cr8muceqt3G1
         kwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdySojQZqpYa7EKDo0NLeJ1K0iCrqM0lXjyeevcXQKM=;
        b=OAmSa2sIWIZU0qK7Z58tf70ihsahavz/UT9dzt7hTpXcfd0WYUuL4NaANAOMBSCYAU
         kj9UlAZ2O0P38JgbZScMUH8p3OjDleZCqb9Wvt0t9f6x8bKj6CmUfuuyQTmc2LgoiQnX
         lY9+DErrBvCYKXn7fqiwk1mP3Wz7KxsoZ915+iKkvktO3bmsy7DzB9C6k80Uakylp6OI
         caQgaf7SdSrrtbkjaagYGhvegsROAk9uefyS/bZPb8mZWeiXNXT2Mg4DuSph4yaJy7Yp
         /IHYUmrFxlN4ZR9fGumDZ6zbHvcvXUuPId8AHBIzlSKW0g0wLMmaF1XQol0TAs+qzbz9
         UYHQ==
X-Gm-Message-State: APjAAAWMQxlNphrZwE11aEtr1Is4ChtunIpuW7yX5/hRyC0uN93sN1ZK
        3VpYNrEZ4uyiLgbvqKqogkMY3s5c
X-Google-Smtp-Source: APXvYqzDENIb/3Krpwjxbnr35QjR1aHE0yhPUb5LpwZTcoDuYo977fCHM2lQPaFWz8k1BUxzHSSrSw==
X-Received: by 2002:aa7:db44:: with SMTP id n4mr32285319edt.357.1582282055158;
        Fri, 21 Feb 2020 02:47:35 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:34 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 11/25] RDMA/rtrs: server: statistics functions
Date:   Fri, 21 Feb 2020 11:47:07 +0100
Message-Id: <20200221104721.350-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..33e729349e9d
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
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
-- 
2.17.1

