Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9493C127FE1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLTPvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPvX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so9881894wro.2;
        Fri, 20 Dec 2019 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2UyM1ddhG6LAe+raY4p18Uxp2IfFHpyoTAZFUUfifo=;
        b=UEgicXUYamC2HjDJTaWOTxL4QPeEF+9T01KQ8k90GjC2xx9ZDDd3tWjn4nx7uW59mt
         exodXqn2B2ugx9ai+NdMLsTalNlFZR+VBnU2wF6Qd4SYG7X4+j21opBTH10f4CXLXUc6
         PWfWYe7iyHUOXJu1WHD7wQ9eRFV5mertJK8jCYvAralOJTIPCiql9yBRDs5cfZIN7iq+
         jTCI81TYHMJ7nBaFTMYS8h4Wlf7mXLbZa5Poz1ESx4X7k/pGuxn03kxJrDzVXVN7EyMn
         qnAWWk7cE7QWlOgWGMOa35xgJhj8pdP9Be+TcvWkeLy76OIB5bh2ecdsgamAVHpQXr36
         bbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2UyM1ddhG6LAe+raY4p18Uxp2IfFHpyoTAZFUUfifo=;
        b=ZPXi1fcSh1q2oGHY3aBATlo+aXyeKohyiu8Ecv/nlWYzackxXp/wYP9/yGqVjrg49F
         Hgdeazo3MDYn7/H9A/0e4s6gpz15jey7xbx3HIsfGudwKJdAvPnlYnqOOiBCYxujE1GZ
         mTF4x3PPoEPnBKC4mpGFXjNLHWhlvf8eDIfZ2YM2e//hikAU5qNdLVyQ3h0oOLwhmdC/
         tLTW8zqwB4JcwqSpsycon7sfy0Mmxe5ykgilLfGCqw2ecEVgtlsBHmfS2Mwtp8Pa5dCV
         SUXxJIzjroZj5MGx+qWTleCQKgzOeFoitFGD5tObQ1SpmMP6JmqCT1oDvAPYaOSWCMHg
         CvFg==
X-Gm-Message-State: APjAAAWVJBSJ/HvSA0XNnZKom+K0uWXsX/SNsoBeUvva32xhmPWWKld6
        VzSa9bUb1H8UK4nJ73+QDqD1h8X1kpU=
X-Google-Smtp-Source: APXvYqz2mKh5c3LSpjVdadt3yq3ZnX/qWSt+PM7ItkBVcNU8oA1xr7CyF7ADwb5P0rv3j5aIMkvjow==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr15440129wru.173.1576857081137;
        Fri, 20 Dec 2019 07:51:21 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:20 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 07/25] rtrs: client: statistics functions
Date:   Fri, 20 Dec 2019 16:50:51 +0100
Message-Id: <20191220155109.8959-8-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 453 +++++++++++++++++++
 1 file changed, 453 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
new file mode 100644
index 000000000000..421898f941a1
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -0,0 +1,453 @@
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

