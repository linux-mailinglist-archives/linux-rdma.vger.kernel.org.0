Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A71BA5CE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgD0OL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgD0OL0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 10:11:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCAC03C1A7
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so20682990wml.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=QYbBK9DbOIfDjpvixqC9gH7peta7Q8hgFgX/dWyl5yBC445GyVm08wphqL+dq3i42u
         vFU8y0HTd8j6VzfqJAM/vbgV1j6D+kj9ZTA0c3gB68SUg5iPlZJZopx8KP2+EQF5KOJ7
         AlMasXN4HARmhvgDlur4GG8wssC2FyLav0Y2uW6Kco58L+4beDMREb0bXofQw7ZO+8HQ
         FUUjoIcxT/jyP3NNRo7sXoO2MOqXMLWZ2zV8STWjXtfjOxfBzToTRUNl2RVvgniQRDmW
         ofiy1Wl59IbzFBkpw6OLRsWQI+4hdNdt0cH6KAS/bCpUr+7kbK8gs2vUJW5LfV+aviLz
         k08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=aYKT+VkOK7y66l1KupjCbvWN4at7qkWynlipWqv+pDYMQLUB2Pl3gVNKrJAhKQZ81A
         5j1STnLiHwGcJeBsnO8WFYIXWrCW6hsuRDhc52LPuHZPlLgQIZiw0mpfErXvEdIoKQ4x
         bD4Pmus7MaU2ioSC/g94fFKoG/CIfMlC1LJ5krAlFAaFAQE6vd3u1+GZzgnpaXqfxCY+
         UfPLzcsSsJ7th8M+/4ikNo29fq6Ub7ihrIO4DzsgWOOMJFX/q+yhaf4QvJN4Xjz+p7Ms
         0PiFfHrrzsNygmCOtbIXX9PqZiujhcgmes4DPKLXe+7mGGYf442OVAlTdZvBMBKzO59P
         +lLw==
X-Gm-Message-State: AGi0PuYG5Cx0u95iVGqWMmoSJhzC9Yi1ovyJ+9Veyyi2WbXQHuuZodA3
        UijJvfkjLwyFmGU0wMHyIXq0
X-Google-Smtp-Source: APiQypLDhKoekXoK8t8GosTdbst2JwUpSEc3ZZyd0LtRviotWrk833PTXPg7VH3OdHQYsuKvsbjfLA==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr25871930wmg.36.1587996683512;
        Mon, 27 Apr 2020 07:11:23 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:22 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 11/25] RDMA/rtrs: server: statistics functions
Date:   Mon, 27 Apr 2020 16:10:06 +0200
Message-Id: <20200427141020.655-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
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

