Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B417E1A98B8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895376AbgDOJYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895381AbgDOJWy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:22:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD73C061A0F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so18248611wrs.9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=fT4GFIXZn0LdH2O3jexh5tR05kC3C08OQTnfBXovn96TVTw2FQszc9bd4Lpc1Wyesc
         n2xgEwNdrM46oigKhuIAvfhjRuAi4FRHwDTG5UO6BgljSoAua1lXZ8BRTqu12Hf5bnST
         UZ2xcCo6DRdAEYx4mPWsjgKEFvyGD9TbhWHBxsdScM0+Cqvuf9sTNDQsLkqXFE08qbKY
         YpxiCrOVkn11KpQUrEQAl/SibhFOv6pXQGbu20PE+bA6vE+KuDb/03xpUTUBejWNoWxw
         +E+1pRsHCvg3ePXctUgFYHzfXORq7C9l3Hrkx3XqUXKS7wTCohXujqBPdjJT+1X6DrAb
         GjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=aPPjo6RHRFg/rTKLtAOCLOfZatwOo02duIs2yTuG9gOm9PNFYum1LpDjAbbzoWbbqW
         8UT6Eg0v/dCOJNzoThaiFB0DCm4MWNdgT/nwv1RLyMv9Furr6/X5e55D6WYTZsPkfi3A
         16r+lH0fZK1T/NSsWUTfPpmYIU1ZD86N2EfiL0Tcdzsm3lde31PXAtoaYwzOCJ6x4w+U
         iedHUR6Bh3WHeZ7AtAKCeM1DKv10q3bE04hx2JusozIV3Vfr8EiApKtb7B0vhAQqMNzk
         lqjiFwlyWBhiEWtBI9CUCEoBEYyLPJtTtGq+Vn1E/eIE14JNCckvxJclQrj1eT+fYff8
         SH+w==
X-Gm-Message-State: AGi0PuZ97VgL7eaUfw5zIFqC7i+lOb+gPWSq0H56cwA2bJCR2TtTeRp2
        zaLIkkN0WqoVnbfqrRMid8UQ
X-Google-Smtp-Source: APiQypIdo8ZFfD75rcxtr/FKSu7YnGl/Y9+hygOj2X1xLx6HoRZtqVTSNmlLOH/0VdeMEqVSiwTpGw==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr18170005wrw.198.1586942573378;
        Wed, 15 Apr 2020 02:22:53 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:22:52 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 11/25] RDMA/rtrs: server: statistics functions
Date:   Wed, 15 Apr 2020 11:20:31 +0200
Message-Id: <20200415092045.4729-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
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

