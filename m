Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766A712CEC3
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfL3K3x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39861 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfL3K3w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so32199848eds.6;
        Mon, 30 Dec 2019 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwtE0uWXdKmxVJODrbuMNmNzeLwAALGAuXPNGL2Ahhs=;
        b=rsGj3ARPmD5DigIfaMg92HbFmXr/7NaWfXyOm0AqmfLiv3rL5HFtVKAI86fvjJDS+b
         JKvdry2kSSDy+3Y5SIZ2hoGynu9gymwBCyMIxbrjzhOyeruInF7EfFAT3yuSLWjnd5xU
         pfgI1wzFeh/728rRS5M1P0RB2sCAQVxlldHGKIu/r0JMtvG77JA7WYDI1m2NcGR0zdXc
         ASJZxDrK4Zd5NCrHS2+NIGiN9kJ2vBoPL1PBxTqr8bFsVPyw7f6FuX6NXobTLYhzsrkl
         u4FD+0G7FhNTpnYZHLkOqGRJ+8usfDpcT8P57P9lgvtjbovMn2AUp2rtUHZK4Y4pKyX3
         skyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwtE0uWXdKmxVJODrbuMNmNzeLwAALGAuXPNGL2Ahhs=;
        b=bdjU9cD56Shg9i9QYUjBS0PEBh9EhLUybEiARVJ78vEJNh5Jl8gUXHG4RUEONYMqAq
         4M+UDJtNINZwWA4w4x0iGECzDaRG9dVGzlrp2aGRCXNNq389JPN1XmaU5uwhJrRdJKQp
         07nM/zvTTAz2yhSQ0y3x9MA2KejqAzsUCyOH9HsQ65QKqzl8dQG0/5lRnirJJ7Lbs0ao
         oBFytW1SIzpngsplCLFwLWUYrED8SaNKcOnFnyAM/47bWchEwQUkHPEBVsUx9LWPc/2G
         B49DwZ1UjCyt1djc/DsTiciX0b4UFo8A9iktTqk0WIyakt5zqyUCkLltm4T7aWD4gxJY
         tUhw==
X-Gm-Message-State: APjAAAVeVueSKIggXOva+Ronk4EGLD6EbWW0SPdZvydsXbKNeXBnYvwd
        ZaS+l5HJWLPVyDqw+Z0WcY4LicV8
X-Google-Smtp-Source: APXvYqwzWXWSyiYVprRZWQ3LV58/REKDbd8x5qbbm66JuX8iQ9EMjqZ9e2RMY1bbtV2bAqGXT1Tqsg==
X-Received: by 2002:a17:906:1904:: with SMTP id a4mr56656291eje.134.1577701790050;
        Mon, 30 Dec 2019 02:29:50 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:49 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 05/25] rtrs: client: private header with client structs and functions
Date:   Mon, 30 Dec 2019 11:29:22 +0100
Message-Id: <20191230102942.18395-6-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rtrs-client
module, mainly for managing rtrs sessions, creating/destroying sysfs
entries, accounting statistics on client side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 296 +++++++++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
new file mode 100644
index 000000000000..99e8cf53c5d1
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -0,0 +1,296 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_CLT_H
+#define RTRS_CLT_H
+
+#include <linux/device.h>
+#include "rtrs-pri.h"
+
+/**
+ * enum rtrs_clt_state - Client states.
+ */
+enum rtrs_clt_state {
+	RTRS_CLT_CONNECTING,
+	RTRS_CLT_CONNECTING_ERR,
+	RTRS_CLT_RECONNECTING,
+	RTRS_CLT_CONNECTED,
+	RTRS_CLT_CLOSING,
+	RTRS_CLT_CLOSED,
+	RTRS_CLT_DEAD,
+};
+
+static inline const char *rtrs_clt_state_str(enum rtrs_clt_state state)
+{
+	switch (state) {
+	case RTRS_CLT_CONNECTING:
+		return "RTRS_CLT_CONNECTING";
+	case RTRS_CLT_CONNECTING_ERR:
+		return "RTRS_CLT_CONNECTING_ERR";
+	case RTRS_CLT_RECONNECTING:
+		return "RTRS_CLT_RECONNECTING";
+	case RTRS_CLT_CONNECTED:
+		return "RTRS_CLT_CONNECTED";
+	case RTRS_CLT_CLOSING:
+		return "RTRS_CLT_CLOSING";
+	case RTRS_CLT_CLOSED:
+		return "RTRS_CLT_CLOSED";
+	case RTRS_CLT_DEAD:
+		return "RTRS_CLT_DEAD";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+enum rtrs_mp_policy {
+	MP_POLICY_RR,
+	MP_POLICY_MIN_INFLIGHT,
+};
+
+struct rtrs_clt_stats_reconnects {
+	int successful_cnt;
+	int fail_cnt;
+};
+
+struct rtrs_clt_stats_wc_comp {
+	u32 cnt;
+	u64 total_cnt;
+};
+
+struct rtrs_clt_stats_cpu_migr {
+	atomic_t from;
+	int to;
+};
+
+struct rtrs_clt_stats_rdma {
+	struct {
+		u64 cnt;
+		u64 size_total;
+	} dir[2];
+
+	u64 failover_cnt;
+};
+
+struct rtrs_clt_stats_rdma_lat {
+	u64 read;
+	u64 write;
+};
+
+#define MIN_LOG_SG 2
+#define MAX_LOG_SG 5
+#define MAX_LIN_SG BIT(MIN_LOG_SG)
+#define SG_DISTR_SZ (MAX_LOG_SG - MIN_LOG_SG + MAX_LIN_SG + 2)
+
+#define MAX_LOG_LAT 16
+#define MIN_LOG_LAT 0
+#define LOG_LAT_SZ (MAX_LOG_LAT - MIN_LOG_LAT + 2)
+
+struct rtrs_clt_stats_pcpu {
+	struct rtrs_clt_stats_cpu_migr		cpu_migr;
+	struct rtrs_clt_stats_rdma		rdma;
+	u64					sg_list_total;
+	u64					sg_list_distr[SG_DISTR_SZ];
+	struct rtrs_clt_stats_rdma_lat		rdma_lat_distr[LOG_LAT_SZ];
+	struct rtrs_clt_stats_rdma_lat		rdma_lat_max;
+	struct rtrs_clt_stats_wc_comp		wc_comp;
+};
+
+struct rtrs_clt_stats {
+	bool					enable_rdma_lat;
+	struct rtrs_clt_stats_pcpu    __percpu	*pcpu_stats;
+	struct rtrs_clt_stats_reconnects	reconnects;
+	atomic_t				inflight;
+};
+
+struct rtrs_clt_con {
+	struct rtrs_con	c;
+	struct rtrs_iu		*rsp_ius;
+	u32			queue_size;
+	unsigned int		cpu;
+	atomic_t		io_cnt;
+	int			cm_err;
+};
+
+/**
+ * rtrs_permit - permits the memory allocation for future RDMA operation
+ */
+struct rtrs_permit {
+	enum rtrs_clt_con_type con_type;
+	unsigned int cpu_id;
+	unsigned int mem_id;
+	unsigned int mem_off;
+};
+
+/**
+ * rtrs_clt_io_req - describes one inflight IO request
+ */
+struct rtrs_clt_io_req {
+	struct list_head        list;
+	struct rtrs_iu		*iu;
+	struct scatterlist	*sglist; /* list holding user data */
+	unsigned int		sg_cnt;
+	unsigned int		sg_size;
+	unsigned int		data_len;
+	unsigned int		usr_len;
+	void			*priv;
+	bool			in_use;
+	struct rtrs_clt_con	*con;
+	struct rtrs_sg_desc	*desc;
+	struct ib_sge		*sge;
+	struct rtrs_permit	*permit;
+	enum dma_data_direction dir;
+	rtrs_conf_fn		*conf;
+	unsigned long		start_jiffies;
+
+	struct ib_mr		*mr;
+	struct ib_cqe		inv_cqe;
+	struct completion	inv_comp;
+	int			inv_errno;
+	bool			need_inv_comp;
+	bool			need_inv;
+};
+
+struct rtrs_rbuf {
+	u64 addr;
+	u32 rkey;
+};
+
+struct rtrs_clt_sess {
+	struct rtrs_sess	s;
+	struct rtrs_clt	*clt;
+	wait_queue_head_t	state_wq;
+	enum rtrs_clt_state	state;
+	atomic_t		connected_cnt;
+	struct mutex		init_mutex;
+	struct rtrs_clt_io_req	*reqs;
+	struct delayed_work	reconnect_dwork;
+	struct work_struct	close_work;
+	unsigned int		reconnect_attempts;
+	bool			established;
+	struct rtrs_rbuf	*rbufs;
+	size_t			max_io_size;
+	u32			max_hdr_size;
+	u32			chunk_size;
+	size_t			queue_depth;
+	u32			max_pages_per_mr;
+	int			max_send_sge;
+	u32			flags;
+	struct kobject		kobj;
+	struct kobject		kobj_stats;
+	struct rtrs_clt_stats  stats;
+	/* cache hca_port and hca_name to display in sysfs */
+	u8			hca_port;
+	char                    hca_name[IB_DEVICE_NAME_MAX];
+	struct list_head __percpu
+				*mp_skip_entry;
+};
+
+struct rtrs_clt {
+	struct list_head   /* __rcu */ paths_list;
+	size_t			       paths_num;
+	struct rtrs_clt_sess
+		      __rcu * __percpu *pcpu_path;
+
+	bool			opened;
+	uuid_t			paths_uuid;
+	int			paths_up;
+	struct mutex		paths_mutex;
+	struct mutex		paths_ev_mutex;
+	char			sessname[NAME_MAX];
+	short			port;
+	unsigned int		max_reconnect_attempts;
+	unsigned int		reconnect_delay_sec;
+	unsigned int		max_segments;
+	void			*permits;
+	unsigned long		*permits_map;
+	size_t			queue_depth;
+	size_t			max_io_size;
+	wait_queue_head_t	permits_wait;
+	size_t			pdu_sz;
+	void			*priv;
+	link_clt_ev_fn		*link_ev;
+	struct device		dev;
+	struct kobject		kobj_paths;
+	enum rtrs_mp_policy	mp_policy;
+};
+
+static inline struct rtrs_clt_con *to_clt_con(struct rtrs_con *c)
+{
+	return container_of(c, struct rtrs_clt_con, c);
+}
+
+static inline struct rtrs_clt_sess *to_clt_sess(struct rtrs_sess *s)
+{
+	return container_of(s, struct rtrs_clt_sess, s);
+}
+
+#define PERMIT_SIZE(clt) (sizeof(struct rtrs_permit) + (clt)->pdu_sz)
+#define GET_PERMIT(clt, idx) ((clt)->permits + PERMIT_SIZE(clt) * idx)
+
+int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess);
+int rtrs_clt_disconnect_from_sysfs(struct rtrs_clt_sess *sess);
+int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
+				     struct rtrs_addr *addr);
+int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
+				     const struct attribute *sysfs_self);
+
+void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt *clt, int value);
+int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt *clt);
+
+/* rtrs-clt-stats.c */
+
+int rtrs_clt_init_stats(struct rtrs_clt_stats *stats);
+void rtrs_clt_free_stats(struct rtrs_clt_stats *stats);
+
+void rtrs_clt_decrease_inflight(struct rtrs_clt_stats *s);
+void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *s);
+
+void rtrs_clt_update_rdma_lat(struct rtrs_clt_stats *s, bool read,
+			       unsigned long ms);
+void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con);
+void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir);
+
+int rtrs_clt_reset_sg_list_distr_stats(struct rtrs_clt_stats *stats,
+					bool enable);
+int rtrs_clt_stats_sg_list_distr_to_str(struct rtrs_clt_stats *stats,
+					 char *buf, size_t len);
+int rtrs_clt_reset_rdma_lat_distr_stats(struct rtrs_clt_stats *stats,
+					 bool enable);
+ssize_t rtrs_clt_stats_rdma_lat_distr_to_str(struct rtrs_clt_stats *stats,
+					      char *page, size_t len);
+int rtrs_clt_reset_cpu_migr_stats(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf,
+					 size_t len);
+int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
+				      size_t len);
+int rtrs_clt_reset_wc_comp_stats(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_wc_completion_to_str(struct rtrs_clt_stats *stats, char *buf,
+					 size_t len);
+int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable);
+ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
+				    char *page, size_t len);
+int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *stats, bool enable);
+ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
+				 char *page, size_t len);
+
+/* rtrs-clt-sysfs.c */
+
+int rtrs_clt_create_sysfs_root_folders(struct rtrs_clt *clt);
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt);
+
+int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess);
+void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
+				  const struct attribute *sysfs_self);
+
+#endif /* RTRS_CLT_H */
-- 
2.17.1

