Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D89181D54
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgCKQNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:00 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53508 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgCKQM7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:12:59 -0400
Received: by mail-wm1-f54.google.com with SMTP id 25so2733485wmk.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QrUuFuwDHpEyX4NVEQ+2Zs4EvqhO7KDlTvxm3/zqTiY=;
        b=gE/79vFa7E6aUJbT58iayUkc3qfPkMn7rJeiG0c7gVUAoXQcBWTur13OOxGl16nMmh
         kYy/Hj++EDX9Bs1xcu8iL7R/sAIVaGzg3CHqMtKh4MeJiu/QcMOPcO8RiNiBYAVSYVcf
         VDl5TzPRBCi7+etubV1bc24HEZa8/9TOomDDv2FHSkRLiNRH1wDOEeBHZx9RlkzXoGmj
         GF9UzOGn+KZoVtq6IH6pd1wrt0JTELU4TUvD2BGWQmFhfMqv7OjI65vBFjV4RLyIGFZU
         ana/9j0wtHa6vpUDzOMioxlxF1GNE3lbXTqRF97UAaJrpmfzQcACRrzh06u+KMizmxac
         VVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QrUuFuwDHpEyX4NVEQ+2Zs4EvqhO7KDlTvxm3/zqTiY=;
        b=s96JPVnFQt2S1GNGglz6TQOsquRJ3SwThmfmZ+2gF3e/c0/iDkih1VwSKoNnTPfl8u
         6/EmcRw2JT2024pNVohm2In7nVxeqVHJLEt3rIfB0d218d2aT8UEmlQtfFlIuw7NV1Z9
         4XSwIMpipD3G0m4vyOzsg11wSFlSCF/bAiNl5oBgZDjHccwC6cRnOiUuxznSKximmnmD
         JYvPxqr5zNjlN3/HO1+xTQ6CEgq5aiiGQS7Lntqudrsj6kwOXVTTV9WRu77o/J3oi4fq
         cfXxJj9SRiLK3FauiwQgEdTaAAT4moDsxWEf9UDVY6ErX44txEHOIhLfNAofAVVPZyqM
         HeQA==
X-Gm-Message-State: ANhLgQ1ZkDMNiHjGy7QrEAUnaX5WHT8W0WrKo68EfWngYOPOauiLw5V2
        r/gK6BRqu9F+g2f8b1cHlDsxYLyFEcw=
X-Google-Smtp-Source: ADFU+vshpQgp6PI0VDvK+mioTUAEzx9vDMDy5WymImW6Tpz9y7OcgmLOQhQA8fROVSulBulOkrMFbg==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr4385257wmi.158.1583943177471;
        Wed, 11 Mar 2020 09:12:57 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:12:57 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 09/26] RDMA/rtrs: server: private header with server structs and functions
Date:   Wed, 11 Mar 2020 17:12:23 +0100
Message-Id: <20200311161240.30190-10-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This header describes main structs and functions used by rtrs-server
module, mainly for accepting rtrs sessions, creating/destroying
sysfs entries, accounting statistics on server side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 149 +++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
new file mode 100644
index 000000000000..300adcd26a72
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_SRV_H
+#define RTRS_SRV_H
+
+#include <linux/device.h>
+#include <linux/refcount.h>
+#include "rtrs-pri.h"
+
+/*
+ * enum rtrs_srv_state - Server states.
+ */
+enum rtrs_srv_state {
+	RTRS_SRV_CONNECTING,
+	RTRS_SRV_CONNECTED,
+	RTRS_SRV_CLOSING,
+	RTRS_SRV_CLOSED,
+};
+
+/* stats for Read and write operation.
+ * see Documentation/ABI/testing/sysfs-class-rtrs-server for details
+ */
+struct rtrs_srv_stats_rdma_stats {
+	struct {
+		atomic64_t	cnt;
+		atomic64_t	size_total;
+	} dir[2];
+};
+
+struct rtrs_srv_stats {
+	struct rtrs_srv_stats_rdma_stats	rdma_stats;
+};
+
+struct rtrs_srv_con {
+	struct rtrs_con		c;
+	atomic_t		wr_cnt;
+	atomic_t		sq_wr_avail;
+	struct list_head	rsp_wr_wait_list;
+	spinlock_t		rsp_wr_wait_lock;
+};
+
+/* IO context in rtrs_srv, each io has one */
+struct rtrs_srv_op {
+	struct rtrs_srv_con		*con;
+	u32				msg_id;
+	u8				dir;
+	struct rtrs_msg_rdma_read	*rd_msg;
+	struct ib_rdma_wr		*tx_wr;
+	struct ib_sge			*tx_sg;
+	struct list_head		wait_list;
+	int				status;
+	int				send_wr_cnt;
+	struct ib_cqe			send_cqe;
+};
+
+/*
+ * server side memory region context, when always_invalidate=Y, we need
+ * queue_depth of memory regrion to invalidate each memory region.
+ */
+struct rtrs_srv_mr {
+	struct ib_mr	*mr;
+	struct sg_table	sgt;
+	struct ib_cqe	inv_cqe;	/* only for always_invalidate=true */
+	u32		msg_id;		/* only for always_invalidate=true */
+	u32		msg_off;	/* only for always_invalidate=true */
+	struct rtrs_iu	*iu;		/* send buffer for new rkey msg */
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
+	struct rtrs_srv_ops ops;
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
+static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
+					      size_t size, int d)
+{
+	atomic64_inc(&s->rdma_stats.dir[d].cnt);
+	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+}
+
+/* functions which are implemented in rtrs-srv-stats.c */
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
+/* functions which are implemented in rtrs-srv-sysfs.c */
+int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess);
+void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess);
+
+#endif /* RTRS_SRV_H */
-- 
2.17.1

