Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597E11CDBFB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgEKNxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730250AbgEKNxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:53:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73690C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so11086040wrq.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=Zltqf7LfmNXAxRzZhaM3M7n2rU8SOtPCfo5Uyj0zMrqiRqarF7rMHPmSQF3+ZuD+/j
         UzmC2p9twEekhAqcehsKQp4PF7kCfptluzVwBd1s69wYHrFYh7KFzPObkC55K7nRUKX/
         w0O4FJUbl8gZzvQvC57yzmSHDoQ9yJzbGNSrJZbxb8oei5lp6OX7gEzZXrfCPVOZI4nc
         7gjrhDHv0mpvg/FXdfJKpFR3inFE08jEpIsrIReCQG5kEPqnNfjQPVb0KJQcsEuv//YC
         tH5Kgns+3RIF64d2/cvEmMZVHnD9nrODoM+GaZGdcVGhET9QmeLdPlkdNg41bqZKDE64
         6pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=B2DFWpsST4uIN7WSgn2/yZuCE3om0dVKKPZMAdaettn1qNFn/CdvZ5K8OP2T6ovAKs
         LMddlga9xBaA06lGoBP1IWQEEXKDFfEiqFFst6kserY52jSH+ahDxElQeAdD/40jAJcs
         D8ro4+RuV1OneWt4oUkovjdF0xYvpt7UDdY0GQxfHc8ocb8R4oxeDZfeXlJ0idOhmDHf
         UHQlRaGMsEE3h4Ehs88/7k7pbTtqdPy6Sipk8W9HRSMKU7bTnG9vMLexpUrGVI4hW91U
         2A4lriNVBJ3k3BcsPMzuvHykxzb8d1BHMxy36I7UrEUVhhOZCzo2+9WgIEG9CVaCqNcE
         T6FQ==
X-Gm-Message-State: AGi0PuZF+qDFjB3HorGo+A7NTOB8xnxGk6F7M6grlyVFCeBWmgVmkULS
        FnLbeDVcVHpaBvVu8Djgfy8P
X-Google-Smtp-Source: APiQypKMs44zNDR0K+WzVMpey2m3M2wG3mE8SPhXWRcPQjAuPZYEtvMW4jGuDbNu4h0LUnnbD6adiw==
X-Received: by 2002:a05:6000:1045:: with SMTP id c5mr4881306wrx.31.1589205200139;
        Mon, 11 May 2020 06:53:20 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:19 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 11/25] RDMA/rtrs: server: statistics functions
Date:   Mon, 11 May 2020 15:51:17 +0200
Message-Id: <20200511135131.27580-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..e102b1368d0c
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,38 @@
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
+	struct rtrs_srv_sess *sess = stats->sess;
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
-- 
2.20.1

