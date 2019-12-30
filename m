Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC612CECA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfL3K35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41093 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfL3K35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so32183971eds.8;
        Mon, 30 Dec 2019 02:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ryU3//0vC4i5IC6EgEGSsu8rQStd1vh1l2X8hFC/kY=;
        b=Fmn1fT4+u0FomHF/8c3hh8hGIET8GhH/Jl5mDjcSEdyPr2slVbNIyciN1/5qpBnH+R
         wDV3T1Y9A8tFdnzdVH6UHfZoCJxv/imjQCh/7sL97uRKHGUoTfJcl+wXYkh1tYcJ3MKo
         ADJqeZ/ryDlQX6sVvP2/C1IELR3X7fMXrS9b85Thch3oq3jU5gL2ayRDsWop+8OwF5/O
         xpig4zDD2ttEHktsPI2kyycE2LCF7AaVm2yGNXr7EeNYUDhmS/JDz/CG4/3YygyHoPbX
         KypXVPQrRYzbAlYNwOwWgLxsLqkzkEapn+O0B1YHs/NLnFrMn8QyIQyQkOuJ752I19m8
         Xqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ryU3//0vC4i5IC6EgEGSsu8rQStd1vh1l2X8hFC/kY=;
        b=SKYiHoUa4gVMTvAItg5yVrMspsYWgDXwpPyp/zCxV4LDm5nklXL8UvBsCQVTh4RA+O
         v+mIiqPopUP+NWSiyNqeUsdtxcU1cFL0ysOTwLCrEVafL3GEsOOBe0uQQpH1JVn6twa/
         ayUMFz7K+fn3AjQ/y9Aum9L7GHfTsPW4o68mLJR/+eX5z6Fl22hAjViK7+gjOJKCI0Tx
         HJX40HoWy11BrsH8Mhajn+ZgbgrQ/4HLqkO8uQVD3mfoGoM7L2gwPsoHjhfTqtXbSkCj
         +zt9owE09SA34RnNjv7pg3N919otALhxfAwpVC+bz0HHVVRk7NTA4YLWQ2sRpVpxJbKd
         nozw==
X-Gm-Message-State: APjAAAXtO4Pcdqp8K9XtVJD8nGSeJiLcwL2o7vDAy6eysB+hLdiRhusJ
        nCPh/OZ5kp3Q/9PAEfYQIxotePT9
X-Google-Smtp-Source: APXvYqwGT875RmJ5qCEPtvMn6aJld9lzKwNrZORyXNhvmm3BNbODHYC67GPsAYPDs+OBn9iQC83xfA==
X-Received: by 2002:a05:6402:1694:: with SMTP id a20mr70277962edv.211.1577701794817;
        Mon, 30 Dec 2019 02:29:54 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:54 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 09/25] rtrs: server: private header with server structs and functions
Date:   Mon, 30 Dec 2019 11:29:26 +0100
Message-Id: <20191230102942.18395-10-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rtrs-server
module, mainly for accepting rtrs sessions, creating/destroying
sysfs entries, accounting statistics on server side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 141 +++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
new file mode 100644
index 000000000000..6ab6e2d3f564
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -0,0 +1,141 @@
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
+#ifndef RTRS_SRV_H
+#define RTRS_SRV_H
+
+#include <linux/device.h>
+#include <linux/refcount.h>
+#include "rtrs-pri.h"
+
+/**
+ * enum rtrs_srv_state - Server states.
+ */
+enum rtrs_srv_state {
+	RTRS_SRV_CONNECTING,
+	RTRS_SRV_CONNECTED,
+	RTRS_SRV_CLOSING,
+	RTRS_SRV_CLOSED,
+};
+
+struct rtrs_stats_wc_comp {
+	atomic64_t	calls;
+	atomic64_t	total_wc_cnt;
+};
+
+struct rtrs_srv_stats_rdma_stats {
+	struct {
+		atomic64_t	cnt;
+		atomic64_t	size_total;
+	} dir[2];
+};
+
+struct rtrs_srv_stats {
+	struct rtrs_srv_stats_rdma_stats	rdma_stats;
+	struct rtrs_stats_wc_comp		wc_comp;
+};
+
+struct rtrs_srv_con {
+	struct rtrs_con	c;
+	atomic_t		wr_cnt;
+};
+
+struct rtrs_srv_op {
+	struct rtrs_srv_con		*con;
+	u32				msg_id;
+	u8				dir;
+	struct rtrs_msg_rdma_read	*rd_msg;
+	struct ib_rdma_wr		*tx_wr;
+	struct ib_sge			*tx_sg;
+};
+
+struct rtrs_srv_mr {
+	struct ib_mr	*mr;
+	struct sg_table	sgt;
+	struct ib_cqe	inv_cqe; /* only for always_invalidate=true */
+	u32		msg_id; /* only for always_invalidate=true */
+	u32		msg_off; /* only for always_invalidate=true */
+	struct rtrs_iu	*iu; /* send buffer for new rkey msg */
+};
+
+struct rtrs_srv_sess {
+	struct rtrs_sess	s;
+	struct rtrs_srv	*srv;
+	struct work_struct	close_work;
+	enum rtrs_srv_state	state;
+	spinlock_t		state_lock;
+	int			cur_cq_vector;
+	struct rtrs_srv_op	**ops_ids;
+	atomic_t		ids_inflight;
+	wait_queue_head_t	ids_waitq;
+	struct rtrs_srv_mr	*mrs;
+	unsigned int		mrs_num;
+	dma_addr_t		*dma_addr;
+	bool			established;
+	unsigned int		mem_bits;
+	struct kobject		kobj;
+	struct kobject		kobj_stats;
+	struct rtrs_srv_stats	stats;
+};
+
+struct rtrs_srv {
+	struct list_head	paths_list;
+	int			paths_up;
+	struct mutex		paths_ev_mutex;
+	size_t			paths_num;
+	struct mutex		paths_mutex;
+	uuid_t			paths_uuid;
+	refcount_t		refcount;
+	struct rtrs_srv_ctx	*ctx;
+	struct list_head	ctx_list;
+	void			*priv;
+	size_t			queue_depth;
+	struct page		**chunks;
+	struct device		dev;
+	unsigned int		dev_ref;
+	struct kobject		kobj_paths;
+};
+
+struct rtrs_srv_ctx {
+	rdma_ev_fn *rdma_ev;
+	link_ev_fn *link_ev;
+	struct rdma_cm_id *cm_id_ip;
+	struct rdma_cm_id *cm_id_ib;
+	struct mutex srv_mutex;
+	struct list_head srv_list;
+};
+
+extern struct class *rtrs_dev_class;
+
+void close_sess(struct rtrs_srv_sess *sess);
+
+/* rtrs-srv-stats.c */
+
+void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s, size_t size, int d);
+void rtrs_srv_update_wc_stats(struct rtrs_srv_stats *s);
+
+int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable);
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
+				    char *page, size_t len);
+int rtrs_srv_reset_wc_completion_stats(struct rtrs_srv_stats *stats,
+					bool enable);
+int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats, char *buf,
+					 size_t len);
+int rtrs_srv_reset_all_stats(struct rtrs_srv_stats *stats, bool enable);
+ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
+				 char *page, size_t len);
+
+/* rtrs-srv-sysfs.c */
+
+int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess);
+void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess);
+
+#endif /* RTRS_SRV_H */
-- 
2.17.1

