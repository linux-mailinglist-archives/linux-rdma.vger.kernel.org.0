Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5088127FDF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLTPvW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTPvV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so9863096wrm.11;
        Fri, 20 Dec 2019 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BW7j3Y5wzL6ngfUQMiJfkYq1UmDbdPnjyEWOVVHgleg=;
        b=orwZVpztNGXXM/cP1lB5w1lFFwL3eqxSRnaeZBxgow5WZWiOCsYJZ0Krjf2crFPHII
         JAeocpsZ0iue05BO43mGKEtf/4vwSmmGAf8HviSYmnZX08QyusZwz9RLtyfM9LkrAa+z
         Bd02D9xS1Vo71PE1ZT2fi1daTOhmDHAGu7LX9Qa6B0Fy8lXDx/q5QqKQNbiYO9HJf1Sq
         WVxQy22/EGBzLe4whFy6m21Aai+yiMaD9u+klqrEc1UDEGB/omZAkn4XTE3MdqV7J0SX
         EKc+61C//kJWegy5qDB3vVMYvOEhGW3DYBphIOcFNF6pLn0pX08t2a7AWKXAsmetR8C5
         MSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BW7j3Y5wzL6ngfUQMiJfkYq1UmDbdPnjyEWOVVHgleg=;
        b=WzoWcvy/NpyZ58poEu/K515cYLnKFfjQxN/LMZWKqFQBEPWYdoq56jdruTEZG0xqXF
         1GXwk36Z6PX5S1bsov0q4KU3l6407RJIgeBALHOWAVf6b/LzX20WcG55PZMA6kGPuctp
         z3d8ivIP3hJ7MgE6lfZqGc8q0MsSICwE2R0KeLbUceVm3U90fQhL/HFovO9sL2uFozNC
         ShWjE9Xxe87OsM1cjp5YjYAR6G7f3tSzbLcHmfOybATblZ7e8OzoZTzQeNsleLGrswDo
         aGTQQkMPoCHz+7EPGv8EO7Ysg24cuZBGqW3xzX1Kz+cSuH0zgKuH/hMD5/zUfhFfP7kd
         ES+g==
X-Gm-Message-State: APjAAAUEbd48xQek7BWrVRS95/7zEWLo64kXs6GY/L3J2mB2aQ059IsW
        +N/LBbXy8KoYW1qXmoBh6dnOtO+oMQs=
X-Google-Smtp-Source: APXvYqzaop1Dy+5iIqt2/PeYaC+fH2il0XWQqtWdpklaEBRBV6v2P0ghycMsG1GnPxBbMoOyht72kA==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr16489650wrv.146.1576857078406;
        Fri, 20 Dec 2019 07:51:18 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:17 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 05/25] rtrs: client: private header with client structs and functions
Date:   Fri, 20 Dec 2019 16:50:49 +0100
Message-Id: <20191220155109.8959-6-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 314 +++++++++++++++++++++++++
 1 file changed, 314 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
new file mode 100644
index 000000000000..df774ab3f9b5
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -0,0 +1,314 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+ *          Swapnil Ingle <swapnil.ingle@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jinpu Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
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

