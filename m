Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECC13DAD5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgAPM7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44234 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAPM7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so18804594edb.11;
        Thu, 16 Jan 2020 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4OxfEA72FHanGpsUVkYY5LSTQRScUzKlAq3s2ZMXu0=;
        b=Gde+oFGMB7G2A4jUM+QS1Wulf6ihb7Pr9T92KrROsLywwC1dSbz6+AwLl5WUYEbu3i
         /38QHfywXtnqqvSDKGX4bBbDKPuud7qBYZ7I+JDsIGZZs0+/YHdAtQUOKkAttoOe/8AZ
         JP6070RDzIKgeTwyL0pxZQiCOUKX3IRqAkzA9ya0sPLEx8JVe7l80fHdwXXunxFAe2Qi
         fopBFYkeKamgWOrLZy4XnjdibS2OFyJ+UimOQ+UBPC0ZbzQ3GLL7WSvNAGeItzRrkRE/
         cILAqqaMMOQmwjiIUpeh66CZP2yvn8HLTtcvZEK1iYDOXXC6sXFKbXpYFedZ0qGWqW+H
         byhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4OxfEA72FHanGpsUVkYY5LSTQRScUzKlAq3s2ZMXu0=;
        b=R1VqGFo5tfPP7P++C8TB97aL9AlfLhbZf9SQf1XNWQkN+tw0y3CWgs93YMnG/nwPgQ
         pPRyuL1mJG22LXcBkAMgNnhNrL+kGaaUe6lpGCl0lFMLVJJlKtN+zyID9i4qIsXt7b9W
         lyJjhjmVjvZa+LG+3zxSmpq4MTy26gzTmqidE7kjFA3cEX5NsBbctqN/Thg5+A/alnbo
         hH11hatDhyUKs7jbZeM/iQM2uHdM70Z0OaEsPld50EPJWA8R8y3Z8Bq+RPG1Fg97vRiX
         /NKBGwUL7wFhahdQxPOk7BFbWs1zA6FhN69wbh4kjbjiAMdSyJvNmo+/SVM9AAu9Zej+
         lnyg==
X-Gm-Message-State: APjAAAWSUSsGHLAJNFfr1ZVI+XkBnnqS8Ps0DV7+Rt8Nq4qbLdPlSPve
        /yR+UI/AnHiroAYVykoTVhFpcfpZ
X-Google-Smtp-Source: APXvYqxJcdLR50OEM1sLuGvgAoEdtzsOO5bnVOPfG8jyoCGSfiI0KTUcsjNa89RV683kpQNEV47dfg==
X-Received: by 2002:a05:6402:1d05:: with SMTP id dg5mr35945583edb.74.1579179569976;
        Thu, 16 Jan 2020 04:59:29 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:29 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 09/25] RDMA/rtrs: server: private header with server structs and functions
Date:   Thu, 16 Jan 2020 13:58:59 +0100
Message-Id: <20200116125915.14815-10-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 144 +++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
new file mode 100644
index 000000000000..139ecdb1f213
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
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
+	struct rtrs_con		c;
+	atomic_t		wr_cnt;
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
+/* functions which are implemented in rtrs-srv-stats.c */
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
+/* functions which are implemented in rtrs-srv-sysfs.c */
+int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess);
+void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess);
+
+#endif /* RTRS_SRV_H */
-- 
2.17.1

