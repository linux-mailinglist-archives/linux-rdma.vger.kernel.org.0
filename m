Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41A0148FA6
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbgAXUsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37905 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgAXUsM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so3956710edr.5;
        Fri, 24 Jan 2020 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdySojQZqpYa7EKDo0NLeJ1K0iCrqM0lXjyeevcXQKM=;
        b=EHn+rS5l0rM58VT1+ABZbRZwk7RDKKoXUFctxjDScp1Vyt19mefROyhNxK75nhol45
         P2W561BTORPIPFQobAx4ZJW/t2pzfJARSNC6L45pyvZnuSdvFeXz+1f285MabCkOmvaS
         ayF1K1IAiYKsYJMlw67eoPH6+pffiRfKwcCAvj+BO1EX1hVlc6LE2a5i3mBeieGvBBf7
         RtmQdGXyHIBUf4BTK9tBdGOYo6eutrJyo9jc9mtPnSg03XNnm9hmQa374Z8NXBOc5lPn
         /Ms2rPR+74ufkOAclISIvCA8hS4cfYosuJTWDnnEsM6JPZDDHBavcfSFKORGs2/gRbtD
         Yd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdySojQZqpYa7EKDo0NLeJ1K0iCrqM0lXjyeevcXQKM=;
        b=NCC2Ja/6QaXTFDaJkLEQqCIsXNamRsKWHHBgCPS+Xm7rq9ECFBe/1QRiFh6TQkQS4i
         zo+1HRY6uaxQZ8/FsBMpaSf0eiHYweCLyaOlGB36gQvmRxhCeg3NNTM+hfekNDJMTMKf
         iVi+o4hRIK1MR+07X0/f/Eogm5MXSZHWlS2/eh6eFAFLhZUVSzMUf9ryvSQ0UTYzKUGS
         zkZjYpXGJX5RkXPC0BbIFiQxetSEfF7SLz6q+4FJOsuMH8KStnpwPvA+/XHh8hWBEUlD
         df+8hvBZUHEEGFDNeIRtpG7vXK5R9LpSV4qcG6jgxJbTZV8NNv3baAVRnySxHscmAOAZ
         PI6Q==
X-Gm-Message-State: APjAAAU35Fs7PaGU0vs51e5WuwPEdwGEV00CSPdhy+qjtQFF+NPHwtGm
        /etxbBf30oV2w/tlYEWTIgy2Jpa2
X-Google-Smtp-Source: APXvYqxNjVGvQEPRfeDobPniWY15+Fbqj7zRWQ13SmxexJuy2Fmkq21PmIKjVhSlhSilcLeBuUvSqg==
X-Received: by 2002:a05:6402:b71:: with SMTP id cb17mr4526830edb.125.1579898890863;
        Fri, 24 Jan 2020 12:48:10 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:10 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 11/25] RDMA/rtrs: server: statistics functions
Date:   Fri, 24 Jan 2020 21:47:39 +0100
Message-Id: <20200124204753.13154-12-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
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

