Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B827318CD9B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCTMRQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgCTMRP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so7175289wrv.5
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnJlkgAeBOnqnHx7Vaj78zqK/hIRfn2aCVmlMB4QPmY=;
        b=IejPVyBfoDB56b+PDzJv1WgtJCBJmOUOoJu+vNgWu1PbsZPhLdDjOPCOKmbO/Nz14G
         lbmyB+0B2V6ldOZYBiePH2fv91Ln7T6FDLb3fVbe5cLjd/V8CKg6J7+SkUHwavjf08We
         998JX2qlaKG84XVbEDDyWZjxGQj0cCr03WzB2+zlhmgH8erEJ0pffi9FDnqhOGQ9um7P
         r27fs8niuGRe7eR7JQZCWgbgGHCzsGsahGR/ujcbAkYjrrEL6QqrEkaNE8uG6x9kgR8D
         qCkqdXTO/dUUl1ub9vCEhUig1YAGnCLrpSG924yKWKyQkShoii3GnZOFZFqqSwv9kLaK
         yb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnJlkgAeBOnqnHx7Vaj78zqK/hIRfn2aCVmlMB4QPmY=;
        b=NDpQp2QY9DLv/jeEJgCP1JiLw/HRJOWKzXPnlwpFs1H1Sj7r/j7gxGHCaxI7FYm8QB
         VYr0q5gt0YkPGHsYj54iWvx38SDUNOgyPTyXMgyFtQX0KAgM+IDK1aqUgLXGuBrd5xRl
         jjBMB4DPTmhsH9iJ27jKJctl/gArfgT2/jZqOHCqr9p8U5m9yymIvJL6og/s0hZ23M19
         algFjZ+pH8tyWb7odN0IaYn/2bAlqBTdmDCLl3h463DkonqiVH7AhSM+rjM1SDC93m8g
         ni0eWWQ9r1pWYcAsZoe2jmHrlwO+GQuTIBzqW0UlEcz21WQW5yEf6kuX/ydseMTR/YwI
         LFYg==
X-Gm-Message-State: ANhLgQ1QOsMEqWQXJlR/6gceh2AmEu/noD4RFDhUv0GeEvuGnozHx3+p
        lA8Itm0gSwNHR/HNw1UN463UmA==
X-Google-Smtp-Source: ADFU+vsojldP/3b7v7DsFva6pGt6Z1PTEcBap8v/5Jt+BuSbYCB1yR8Hi3EsJcVP/LQlGL5vYtRuoA==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr10548340wrm.160.1584706632185;
        Fri, 20 Mar 2020 05:17:12 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:11 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 07/26] RDMA/rtrs: client: statistics functions
Date:   Fri, 20 Mar 2020 13:16:38 +0100
Message-Id: <20200320121657.1165-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This introduces set of functions used on client side to account
statistics of RDMA data sent/received, amount of IOs inflight,
latency, cpu migrations, etc.  Almost all statistics are collected
using percpu variables.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 205 +++++++++++++++++++
 1 file changed, 205 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
new file mode 100644
index 000000000000..3f556b884a4e
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -0,0 +1,205 @@
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
+	struct rtrs_clt_stats *stats = &sess->stats;
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
+	struct rtrs_clt_stats *stats = &sess->stats;
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
+
+void rtrs_clt_free_stats(struct rtrs_clt_stats *stats)
+{
+	free_percpu(stats->pcpu_stats);
+}
-- 
2.17.1

