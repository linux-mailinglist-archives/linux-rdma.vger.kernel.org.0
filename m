Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E181C3C10
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEDOCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgEDOCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62187C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so9176281wmc.5
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fr2JN2ONO27tDOSK0FyCuMu7oJhbwCmJkS6mD+zarkc=;
        b=OzISUluTIhXBPBDlEospuABpTcFzprc1oNAfDCXg1voTUO+7biYIjCOS7cBoG42fjM
         tA3j+9xoBGI8ksEOirytcKXoibeAm/gUWzfzfbHxSBitE9Gz3FR5WxX4KXXA0PIxbc37
         8m8TU4ub6H0iDzru5VSkSlpwwPUoHjYQGW25x1ECQ/UxlHw2EYAtkXolkil2TXKPGpt5
         44L3GgkyxoU2SjroUmY9YLnn+BgcJdkEcTpq2iE4Qcac6zXH50YB2lOLypcHq4OAWkyx
         G8rIKbsRStsaF+BvomM7UI4qf8kAUlfkreExcQRZoEUvGdKwDsQ0shker0HM8Uql7Lsi
         E2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fr2JN2ONO27tDOSK0FyCuMu7oJhbwCmJkS6mD+zarkc=;
        b=XFYexmTN9GNPS6afnXf7X7lqmZArQo9NlJy+RdzZlbwq0FXsf8P6+TcuTa7KQYwAr7
         7NXdOqfE1hOzyiDV32BRZVNsxLaHfLEVjUQqw+Aqh+OqzrppKEi/ROKe7nULFzpuNSAQ
         HdF+2Veb8PpBiZAjaxy3L9aXSKY0ecFiJparOmWmfj/Ls8Hoeyt/cZm5elqC9pgXFQl0
         7Z2PEnpbfrnNqpdnh8jaDzk/kEyC8OzOqDX5pQFz+fqObDEOlo9FAVluVuXUQ/mWqx5j
         iZJhBHUutXnPg/j315SO/LlsjaXlc1gesWo+GqXjiQw2cKhBUXk88jBr9XL5ljUo/uTI
         b3wg==
X-Gm-Message-State: AGi0PuZmN/PzU52OoJg2LLkRyPreX5TF1dkSu/TaflP5AV9c8C6ueMf4
        fS5KsXgInYRGg0G55NjZvP275/UOO0WFVTQ=
X-Google-Smtp-Source: APiQypLiSnh+p9OCjEwox+scLsMbuzapGGqQBpFHCA2/LQnXZVJckuI0pTr/wp3g86Q5Y+23l+ChcA==
X-Received: by 2002:a1c:990d:: with SMTP id b13mr14412936wme.179.1588600938079;
        Mon, 04 May 2020 07:02:18 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:17 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 07/25] RDMA/rtrs: client: statistics functions
Date:   Mon,  4 May 2020 16:00:57 +0200
Message-Id: <20200504140115.15533-8-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This introduces set of functions used on client side to account
statistics of RDMA data sent/received, amount of IOs inflight,
latency, cpu migrations, etc.  Almost all statistics are collected
using percpu variables.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 200 +++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
new file mode 100644
index 000000000000..26bbe5d6dff5
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -0,0 +1,200 @@
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
+#include "rtrs-clt.h"
+
+void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
+{
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_stats *stats = sess->stats;
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	cpu = raw_smp_processor_id();
+	s = this_cpu_ptr(stats->pcpu_stats);
+	if (unlikely(con->cpu != cpu)) {
+		s->cpu_migr.to++;
+
+		/* Careful here, override s pointer */
+		s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
+		atomic_inc(&s->cpu_migr.from);
+	}
+}
+
+void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
+{
+	struct rtrs_clt_stats_pcpu *s;
+
+	s = this_cpu_ptr(stats->pcpu_stats);
+	s->rdma.failover_cnt++;
+}
+
+int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
+					 char *buf, size_t len)
+{
+	struct rtrs_clt_stats_pcpu *s;
+
+	size_t used;
+	int cpu;
+
+	used = scnprintf(buf, len, "    ");
+	for_each_possible_cpu(cpu)
+		used += scnprintf(buf + used, len - used, " CPU%u", cpu);
+
+	used += scnprintf(buf + used, len - used, "\nfrom:");
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		used += scnprintf(buf + used, len - used, " %d",
+				  atomic_read(&s->cpu_migr.from));
+	}
+
+	used += scnprintf(buf + used, len - used, "\nto  :");
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		used += scnprintf(buf + used, len - used, " %d",
+				  s->cpu_migr.to);
+	}
+	used += scnprintf(buf + used, len - used, "\n");
+
+	return used;
+}
+
+int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
+				      size_t len)
+{
+	return scnprintf(buf, len, "%d %d\n",
+			 stats->reconnects.successful_cnt,
+			 stats->reconnects.fail_cnt);
+}
+
+ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
+				    char *page, size_t len)
+{
+	struct rtrs_clt_stats_rdma sum;
+	struct rtrs_clt_stats_rdma *r;
+	int cpu;
+
+	memset(&sum, 0, sizeof(sum));
+
+	for_each_possible_cpu(cpu) {
+		r = &per_cpu_ptr(stats->pcpu_stats, cpu)->rdma;
+
+		sum.dir[READ].cnt	  += r->dir[READ].cnt;
+		sum.dir[READ].size_total  += r->dir[READ].size_total;
+		sum.dir[WRITE].cnt	  += r->dir[WRITE].cnt;
+		sum.dir[WRITE].size_total += r->dir[WRITE].size_total;
+		sum.failover_cnt	  += r->failover_cnt;
+	}
+
+	return scnprintf(page, len, "%llu %llu %llu %llu %u %llu\n",
+			 sum.dir[READ].cnt, sum.dir[READ].size_total,
+			 sum.dir[WRITE].cnt, sum.dir[WRITE].size_total,
+			 atomic_read(&stats->inflight), sum.failover_cnt);
+}
+
+ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *s,
+				 char *page, size_t len)
+{
+	return scnprintf(page, len, "echo 1 to reset all statistics\n");
+}
+
+int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	if (!enable)
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->rdma, 0, sizeof(s->rdma));
+	}
+
+	return 0;
+}
+
+int rtrs_clt_reset_cpu_migr_stats(struct rtrs_clt_stats *stats, bool enable)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	if (!enable)
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->cpu_migr, 0, sizeof(s->cpu_migr));
+	}
+
+	return 0;
+}
+
+int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable)
+{
+	if (!enable)
+		return -EINVAL;
+
+	memset(&stats->reconnects, 0, sizeof(stats->reconnects));
+
+	return 0;
+}
+
+int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *s, bool enable)
+{
+	if (enable) {
+		rtrs_clt_reset_rdma_stats(s, enable);
+		rtrs_clt_reset_cpu_migr_stats(s, enable);
+		rtrs_clt_reset_reconnects_stat(s, enable);
+		atomic_set(&s->inflight, 0);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
+					       size_t size, int d)
+{
+	struct rtrs_clt_stats_pcpu *s;
+
+	s = this_cpu_ptr(stats->pcpu_stats);
+	s->rdma.dir[d].cnt++;
+	s->rdma.dir[d].size_total += size;
+}
+
+void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
+{
+	struct rtrs_clt_con *con = req->con;
+	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
+	struct rtrs_clt_stats *stats = sess->stats;
+	unsigned int len;
+
+	len = req->usr_len + req->data_len;
+	rtrs_clt_update_rdma_stats(stats, len, dir);
+	if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+		atomic_inc(&stats->inflight);
+}
+
+int rtrs_clt_init_stats(struct rtrs_clt_stats *stats)
+{
+	stats->pcpu_stats = alloc_percpu(typeof(*stats->pcpu_stats));
+	if (!stats->pcpu_stats)
+		return -ENOMEM;
+
+	/*
+	 * successful_cnt will be set to 0 after session
+	 * is established for the first time
+	 */
+	stats->reconnects.successful_cnt = -1;
+
+	return 0;
+}
-- 
2.20.1

