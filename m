Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CA12CEC7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfL3K3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39865 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfL3K3z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so32199938eds.6;
        Mon, 30 Dec 2019 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eL9BOK55Bg2YAMH7VG9tOL+c5nWMKWEoQ6qaWFa88cc=;
        b=NINqGLyhmrqZIavJTh1UOq1CA9XX6U4vPMCCg1SsYhI8x6o/Ki+YOk+8Nogti4gdgX
         GhsDIFscRKaaEYewBXpBSCtnpgSJAmrq+Q0QySpuDmahYRup6yc0RQJ088uOYkyVbrvw
         RhuPP9u33lpTxWG8xUTdnM8Y3o9YdLfZGOVccEvVra4VAqbtvwTv1i+LP/MCtPPfmGF5
         X5aJ38hUdzCLEQiLtm04XDKY1IhsrGE7cdFN+cf7YgGzdHHEjDRwNRWz5oHyMSSdMAL/
         5Qx0t5AnElm9ZtTnnjtZFyKqg8p3lLKMub6dd/z2q6LoVZTpezMYdbeTA0jqsoshBIkD
         iWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eL9BOK55Bg2YAMH7VG9tOL+c5nWMKWEoQ6qaWFa88cc=;
        b=Pjv/Ov/8Enhn21bMmbz0L47rL4Vz6s6c3tMgX6Ff3sEwn/2TaOQ/ENBr73ZPFJp48b
         ZjVW34i/rF5VcGcDBwEiMZdt4NlLhhtSjRS86PAI/1ndm2lN2JXxZeukQJYd2ge2tObI
         T06mDmF+i5oaFd/3yAzbhyuKXH3wcMXVP1Afn5Jj86QAcmxBgwePzvWjf8mHBKWlmhBh
         HawQwhVyJaP7aTg7dHFzFBUApgcw8qgCWdkFpXRzOHvWcFhO0H4xgIXbuD3RJq0Izqx8
         XpoLKj9VlS5iMUE8YJ0pU6UNpKPcq8g5Fr+aaJ2WbdfB4TBQTUBsPPw93ydH/qdoE6aB
         7Rzg==
X-Gm-Message-State: APjAAAXFNSrj8kmjE4vhE3ym5c2/wzSo8JTUSDtch/kpO8YRCW0knhrZ
        fEbB8JTY2LSz95X8MLBSXx6qJBeo
X-Google-Smtp-Source: APXvYqwXCqGJdcbzyCfp0vsfGnrhRhhO7xk2j1LkP7rmJ+GHVE3WTtzw7bGrPqZVOzSzv7ERPrl/WQ==
X-Received: by 2002:aa7:cd7c:: with SMTP id ca28mr70706603edb.101.1577701792475;
        Mon, 30 Dec 2019 02:29:52 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:52 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 07/25] rtrs: client: statistics functions
Date:   Mon, 30 Dec 2019 11:29:24 +0100
Message-Id: <20191230102942.18395-8-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This introduces set of functions used on client side to account
statistics of RDMA data sent/received, amount of IOs inflight,
latency, cpu migrations, etc.  Almost all statistics is collected
using percpu variables.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 435 +++++++++++++++++++
 1 file changed, 435 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
new file mode 100644
index 000000000000..aff8ebd3b9f7
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-clt.h"
+
+static inline int rtrs_clt_ms_to_id(unsigned long ms)
+{
+	int id = ms ? ilog2(ms) - MIN_LOG_LAT + 1 : 0;
+
+	return clamp(id, 0, LOG_LAT_SZ - 1);
+}
+
+void rtrs_clt_update_rdma_lat(struct rtrs_clt_stats *stats, bool read,
+			       unsigned long ms)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int id;
+
+	id = rtrs_clt_ms_to_id(ms);
+	s = this_cpu_ptr(stats->pcpu_stats);
+	if (read) {
+		s->rdma_lat_distr[id].read++;
+		if (s->rdma_lat_max.read < ms)
+			s->rdma_lat_max.read = ms;
+	} else {
+		s->rdma_lat_distr[id].write++;
+		if (s->rdma_lat_max.write < ms)
+			s->rdma_lat_max.write = ms;
+	}
+}
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
+	s->wc_comp.cnt++;
+	s->wc_comp.total_cnt++;
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
+static inline u32 rtrs_clt_stats_get_avg_wc_cnt(struct rtrs_clt_stats *stats)
+{
+	u32 cnt = 0;
+	u64 sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct rtrs_clt_stats_pcpu *s;
+
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		sum += s->wc_comp.total_cnt;
+		cnt += s->wc_comp.cnt;
+	}
+
+	return cnt ? sum / cnt : 0;
+}
+
+int rtrs_clt_stats_wc_completion_to_str(struct rtrs_clt_stats *stats,
+					 char *buf, size_t len)
+{
+	return scnprintf(buf, len, "%u\n",
+			 rtrs_clt_stats_get_avg_wc_cnt(stats));
+}
+
+ssize_t rtrs_clt_stats_rdma_lat_distr_to_str(struct rtrs_clt_stats *stats,
+					      char *page, size_t len)
+{
+	struct rtrs_clt_stats_rdma_lat res[LOG_LAT_SZ];
+	struct rtrs_clt_stats_rdma_lat max;
+	struct rtrs_clt_stats_pcpu *s;
+
+	ssize_t cnt = 0;
+	int i, cpu;
+
+	max.write = 0;
+	max.read = 0;
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+
+		if (max.write < s->rdma_lat_max.write)
+			max.write = s->rdma_lat_max.write;
+		if (max.read < s->rdma_lat_max.read)
+			max.read = s->rdma_lat_max.read;
+	}
+	for (i = 0; i < ARRAY_SIZE(res); i++) {
+		res[i].write = 0;
+		res[i].read = 0;
+		for_each_possible_cpu(cpu) {
+			s = per_cpu_ptr(stats->pcpu_stats, cpu);
+
+			res[i].write += s->rdma_lat_distr[i].write;
+			res[i].read += s->rdma_lat_distr[i].read;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(res) - 1; i++)
+		cnt += scnprintf(page + cnt, len - cnt,
+				 "< %6d ms: %llu %llu\n",
+				 1 << (i + MIN_LOG_LAT), res[i].read,
+				 res[i].write);
+	cnt += scnprintf(page + cnt, len - cnt, ">= %5d ms: %llu %llu\n",
+			 1 << (i - 1 + MIN_LOG_LAT), res[i].read,
+			 res[i].write);
+	cnt += scnprintf(page + cnt, len - cnt, " maximum ms: %llu %llu\n",
+			 max.read, max.write);
+
+	return cnt;
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
+int rtrs_clt_stats_sg_list_distr_to_str(struct rtrs_clt_stats *stats,
+					 char *buf, size_t len)
+{
+	struct rtrs_clt_stats_pcpu *s;
+
+	int i, cpu, cnt;
+
+	cnt = scnprintf(buf, len, "n\\cpu:");
+	for_each_possible_cpu(cpu)
+		cnt += scnprintf(buf + cnt, len - cnt, "%5d", cpu);
+
+	for (i = 0; i < SG_DISTR_SZ; i++) {
+		if (i <= MAX_LIN_SG)
+			cnt += scnprintf(buf + cnt, len - cnt, "\n= %3d:", i);
+		else if (i < SG_DISTR_SZ - 1)
+			cnt += scnprintf(buf + cnt, len - cnt, "\n< %3d:",
+					 1 << (i + MIN_LOG_SG - MAX_LIN_SG));
+		else
+			cnt += scnprintf(buf + cnt, len - cnt, "\n>=%3d:",
+					 1 << (i + MIN_LOG_SG -
+					       MAX_LIN_SG - 1));
+
+		for_each_possible_cpu(cpu) {
+			unsigned int p, p_i, p_f;
+			u64 total, distr;
+
+			s = per_cpu_ptr(stats->pcpu_stats, cpu);
+			total = s->sg_list_total;
+			distr = s->sg_list_distr[i];
+
+			p = total ? distr * 1000 / total : 0;
+			p_i = p / 10;
+			p_f = p % 10;
+
+			if (distr)
+				cnt += scnprintf(buf + cnt, len - cnt,
+						 " %2u.%01u", p_i, p_f);
+			else
+				cnt += scnprintf(buf + cnt, len - cnt, "    0");
+		}
+	}
+
+	cnt += scnprintf(buf + cnt, len - cnt, "\ntotal:");
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		cnt += scnprintf(buf + cnt, len - cnt, " %llu",
+				 s->sg_list_total);
+	}
+	cnt += scnprintf(buf + cnt, len - cnt, "\n");
+
+	return cnt;
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
+	if (unlikely(!enable))
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
+int rtrs_clt_reset_rdma_lat_distr_stats(struct rtrs_clt_stats *stats,
+					 bool enable)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	if (enable) {
+		for_each_possible_cpu(cpu) {
+			s = per_cpu_ptr(stats->pcpu_stats, cpu);
+			memset(&s->rdma_lat_max, 0, sizeof(s->rdma_lat_max));
+			memset(&s->rdma_lat_distr, 0,
+			       sizeof(s->rdma_lat_distr));
+		}
+	}
+	stats->enable_rdma_lat = enable;
+
+	return 0;
+}
+
+int rtrs_clt_reset_sg_list_distr_stats(struct rtrs_clt_stats *stats,
+					bool enable)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->sg_list_total, 0, sizeof(s->sg_list_total));
+		memset(&s->sg_list_distr, 0, sizeof(s->sg_list_distr));
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
+	if (unlikely(!enable))
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
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	memset(&stats->reconnects, 0, sizeof(stats->reconnects));
+
+	return 0;
+}
+
+int rtrs_clt_reset_wc_comp_stats(struct rtrs_clt_stats *stats, bool enable)
+{
+	struct rtrs_clt_stats_pcpu *s;
+	int cpu;
+
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->wc_comp, 0, sizeof(s->wc_comp));
+	}
+
+	return 0;
+}
+
+int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *s, bool enable)
+{
+	if (enable) {
+		rtrs_clt_reset_rdma_stats(s, enable);
+		rtrs_clt_reset_rdma_lat_distr_stats(s, enable);
+		rtrs_clt_reset_sg_list_distr_stats(s, enable);
+		rtrs_clt_reset_cpu_migr_stats(s, enable);
+		rtrs_clt_reset_reconnects_stat(s, enable);
+		rtrs_clt_reset_wc_comp_stats(s, enable);
+		atomic_set(&s->inflight, 0);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static inline void rtrs_clt_record_sg_distr(u64 stat[SG_DISTR_SZ], u64 *total,
+					     unsigned int cnt)
+{
+	int i;
+
+	i = cnt > MAX_LIN_SG ? ilog2(cnt) + MAX_LIN_SG - MIN_LOG_SG + 1 : cnt;
+	i = i < SG_DISTR_SZ ? i : SG_DISTR_SZ - 1;
+
+	stat[i]++;
+	(*total)++;
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
+	struct rtrs_clt_stats_pcpu *s;
+
+	s = this_cpu_ptr(stats->pcpu_stats);
+	rtrs_clt_record_sg_distr(s->sg_list_distr, &s->sg_list_total,
+				  req->sg_cnt);
+	len = req->usr_len + req->data_len;
+	rtrs_clt_update_rdma_stats(stats, len, dir);
+	atomic_inc(&stats->inflight);
+}
+
+int rtrs_clt_init_stats(struct rtrs_clt_stats *stats)
+{
+	stats->enable_rdma_lat = false;
+	stats->pcpu_stats = alloc_percpu(typeof(*stats->pcpu_stats));
+	if (unlikely(!stats->pcpu_stats))
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

