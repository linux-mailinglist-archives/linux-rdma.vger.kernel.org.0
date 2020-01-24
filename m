Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4DC148F9F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbgAXUsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44966 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgAXUsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so3914694edb.11;
        Fri, 24 Jan 2020 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEzy+WmDWi5XG1oEL7yQVbhTv2WQEJrqrV12AuX9k3g=;
        b=Pcw+4oAHOd5b71uwfwxZPr9BiQpmyc3KISwCsJ7cTaXnpBWU8vinxOCE7iOr8OZRMK
         DTKx9IpYDSB7orWeOE+RS5V204VxldW4iyjox4JmM1zZdJZa14L1O++VbsVwAJ8dCcpe
         H7UdavOV68alCfOyW0tXsHVbUP2z5O7W7Q1H3SNKy8xTFR5k6B50+q3OXJg7l20qR4S9
         /tLukBTug01JKKSMVpi5MhPdIXC+emzcGzJtAIxqpcOSaI8iyoZrTrJr2HJlEvMfEYhO
         20dFslC3GDzibp2JveDneNgBzT+TBOUiKsj8FixuvBjKA+WzQbUPZfAgUlfeSJc+oQU3
         g0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEzy+WmDWi5XG1oEL7yQVbhTv2WQEJrqrV12AuX9k3g=;
        b=MNVL4ZfChlQ7tosiNTALoKMUNEmTOwefacdyz9yirRXMKHnNAnbrxTfK/TWX3MRwLJ
         IG0SMKqqXiMuphb65xqzUkYCx8v5U/+kbMNPsciHOosZaKUfMBZ3lsd3hXS0rdSGxoyb
         dBCPR1edPLBM4JneTUXqVfYbmYB8N0U+hIF+rdIt6a5fQY5LLpq99aposF6++VcaUZlV
         +Rm+CGj7zZJWtdsAAeygtvR1OI4sS9ZSivx5Ehfua6TTsY35gmCbhKDI4REUtL28s8Qw
         rZ6z6txsY/GXzimcQfxjtsYv+9T/PkV61w72Hd67XdIQdgutv0TVEzANVGT3zWVz6cMJ
         vQ3g==
X-Gm-Message-State: APjAAAWRl1X/DCadML5yLnz7XRF64zSjRkyIDvnby5/cmynwnb3tyJXO
        tTfKACboMzQ1WQzMIeQnQvRUXN4q
X-Google-Smtp-Source: APXvYqyEprgwL6hQ5+rx584kk+8fo9/Avf4Hi2yni1wmMQN5Y2BD74K2g21z7wo20iGQD6dnMFUeHQ==
X-Received: by 2002:a05:6402:3059:: with SMTP id bu25mr4451377edb.216.1579898885573;
        Fri, 24 Jan 2020 12:48:05 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:05 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 07/25] RDMA/rtrs: client: statistics functions
Date:   Fri, 24 Jan 2020 21:47:35 +0100
Message-Id: <20200124204753.13154-8-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 209 +++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
new file mode 100644
index 000000000000..0925d8c4677c
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -0,0 +1,209 @@
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
+void rtrs_clt_decrease_inflight(struct rtrs_clt_stats *stats)
+{
+	atomic_dec(&stats->inflight);
+}
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
+	atomic_inc(&stats->inflight);
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

