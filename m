Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35C2127FF2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLTPv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so9835204wrj.12;
        Fri, 20 Dec 2019 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t4yiqL3ZZqVQjUuKBCEW+p/ROKFcObIsbh4bp07YReo=;
        b=RCoM2jZTa9tMNgHo/YY2qZUkKgJgVmGFLYalLOjHUw5Gg4y5bwmbyWK7kqd2mdXn2P
         p7jgtTeLYjsDdRV6iFqQZTm1PWKKmD0+IpxoJDqWzzimW1r1y/qR5cj6P/jBONHlxoyx
         HpL2x9zMrgxLarfwGiH0x9Pwy11fwKuAEGf+7H9u5buVWJvq1sDWmRo0kY3Yp9x6Lagv
         U+L3g3HQUozgzj3wvgud4CtN/vP6TupNvk6BE7g9+VTCglr9jgdJxBcaQ8gwVXJuTkBy
         mYvD6xl0bVNvbqSTM1ecpY1tPIP77Ya2qs3D/AgH/xUk4AgvVwCi+7Li+my/p3RgwGH6
         leRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t4yiqL3ZZqVQjUuKBCEW+p/ROKFcObIsbh4bp07YReo=;
        b=f4TBSNq9VFD4xwZdNLaCCziFQRllYf05oKLHBW9oAQkKeflDB2NHW+bfNo7g7MiYZe
         rr5Avx1xZa4EgxQVZcmO6AUSxzt/Q14eve9Lq11EDg8QJqg9L1SLa3Q+nruQvs0ga+Oi
         4DzTqzRVxV/ox4omZemFcJ8wjvlbSaAmxQ/Jl/d0vGatulveFZP8PjUYJQU+nvYZRPay
         1Y1FK68qb3UgyzZq4GVURbHq98qEHLzIJNLehEEQuY5mAeh2wvPEiwYt9Bxoaic/ha5L
         HXBVnOIIUYxY7Li9l85yl7Nh0kE3x84uE41MlM7SU0nTw0gVwEanpvshCLPJNFdmhsCM
         P0Ww==
X-Gm-Message-State: APjAAAVaCBd6neaBil8Q8asjkU42VL23a5eAJKTMSFBCz9QzsRvczJSm
        d3cVlrve5JJxwXK16Xrg7Z23ok2ZtCc=
X-Google-Smtp-Source: APXvYqwCJ0tvr/9P34VTkhAp0xV9q6Cv5ZpzNe52sI7A5LUb51COXARRhc7OWY4fxd4iWZk6bSJHmg==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr16614373wrh.121.1576857086949;
        Fri, 20 Dec 2019 07:51:26 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:26 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 11/25] rtrs: server: statistics functions
Date:   Fri, 20 Dec 2019 16:50:55 +0100
Message-Id: <20191220155109.8959-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 109 +++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..c5632d27fefc
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,109 @@
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
+ *          Jinpu Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
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

