Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CE4D15D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfFTPDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38251 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbfFTPDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so5190510edo.5;
        Thu, 20 Jun 2019 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aXIBGgM8J5V1UAefTH43RF6bmjkdkJpROH50sTQShLs=;
        b=P+GsP0NKVuXrSC+zmyIsshDo6YarRrpcsNRTURqgtyl5sSsPNZyZZgJuyoBzA6K6hX
         d1dvVGEDLo0O/mF5lSYgqldxyWIbyDAx7dykcPZuT/op8krnxw5dGoJP+3KjeW1s6QqN
         zj+71pom3wPbT4kqyZ/3H7mc7haVJdVabTTpsmbt000s/HE586owysJqJlnGLQwR+qZ7
         WoPgFcrze6goujwdjXKGsvpkmnBjoihFKdJZW4AueuQSBK1tmrVRm8w916ydIeKXudvL
         wL2D3Em5toUvmxJs7KDu/6tv+Cp+xWP6kQ5frvZQ7EmvGgAYSLWjbT6ulwm1JTNdlHu0
         HKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aXIBGgM8J5V1UAefTH43RF6bmjkdkJpROH50sTQShLs=;
        b=fWt6gQCeaUsa1tOJ90pZ/nkcMKev1SbWECWSUPssLgbI1eB/01CBW1dDI9P9qyOiBQ
         85/yVQx2en3tADtGHkBXLdr/BviFOcMFibzULmATMOvwkGV3R2l8CX6eXROiPZq/pQ87
         ddR0cCsle/bV89uuIpu/yGKgPYLR46DcJRb53fxjLTbJigvh8vII5VkyaeaMH9c2eqNG
         BalWweIaJr80WFCwPvCSW85gOvya6/lE5bJVJJ5awWwAHnOCACLa2cGZpAVfH6oiE7tJ
         ircSDxE9Rr4EXWrcjxvi+c/xMs85ARxNP48Y2naEbbqklxfsPvTrveQYatZWRT+ei9uy
         hXww==
X-Gm-Message-State: APjAAAVOzERewj6A9hN6f6PwuKijpH6ACflQp/w50J1zeS8COWW83D2F
        PjKTW2SQPI6N4TOsUsYC+qwOz89wOPY=
X-Google-Smtp-Source: APXvYqyKw7fyaKI+FlZsJMjV8FJFzT3vXvC19bbr6vbuHJdFod9AXPucbPJun9HPaJerabmc9oHytg==
X-Received: by 2002:a50:c9c2:: with SMTP id c2mr101035660edi.183.1561043030904;
        Thu, 20 Jun 2019 08:03:50 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:50 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 09/25] ibtrs: server: private header with server structs and functions
Date:   Thu, 20 Jun 2019 17:03:21 +0200
Message-Id: <20190620150337.7847-10-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This header describes main structs and functions used by ibtrs-server
module, mainly for accepting IBTRS sessions, creating/destroying
sysfs entries, accounting statistics on server side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h | 170 +++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv.h

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-srv.h b/drivers/infiniband/ulp/ibtrs/ibtrs-srv.h
new file mode 100644
index 000000000000..6d3b77541d77
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-srv.h
@@ -0,0 +1,170 @@
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
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#ifndef IBTRS_SRV_H
+#define IBTRS_SRV_H
+
+#include <linux/device.h>
+#include <linux/refcount.h>
+#include "ibtrs-pri.h"
+
+/**
+ * enum ibtrs_srv_state - Server states.
+ */
+enum ibtrs_srv_state {
+	IBTRS_SRV_CONNECTING,
+	IBTRS_SRV_CONNECTED,
+	IBTRS_SRV_CLOSING,
+	IBTRS_SRV_CLOSED,
+};
+
+static inline const char *ibtrs_srv_state_str(enum ibtrs_srv_state state)
+{
+	switch (state) {
+	case IBTRS_SRV_CONNECTING:
+		return "IBTRS_SRV_CONNECTING";
+	case IBTRS_SRV_CONNECTED:
+		return "IBTRS_SRV_CONNECTED";
+	case IBTRS_SRV_CLOSING:
+		return "IBTRS_SRV_CLOSING";
+	case IBTRS_SRV_CLOSED:
+		return "IBTRS_SRV_CLOSED";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+struct ibtrs_stats_wc_comp {
+	atomic64_t	calls;
+	atomic64_t	total_wc_cnt;
+};
+
+struct ibtrs_srv_stats_rdma_stats {
+	struct {
+		atomic64_t	cnt;
+		atomic64_t	size_total;
+	} dir[2];
+};
+
+struct ibtrs_srv_stats {
+	struct ibtrs_srv_stats_rdma_stats	rdma_stats;
+	atomic_t				apm_cnt;
+	struct ibtrs_stats_wc_comp		wc_comp;
+};
+
+struct ibtrs_srv_con {
+	struct ibtrs_con	c;
+	atomic_t		wr_cnt;
+};
+
+struct ibtrs_srv_op {
+	struct ibtrs_srv_con		*con;
+	u32				msg_id;
+	u8				dir;
+	struct ibtrs_msg_rdma_read	*rd_msg;
+	struct ib_rdma_wr		*tx_wr;
+	struct ib_sge			*tx_sg;
+};
+
+struct ibtrs_srv_mr {
+	struct ib_mr	*mr;
+	struct sg_table	sgt;
+};
+
+struct ibtrs_srv_sess {
+	struct ibtrs_sess	s;
+	struct ibtrs_srv	*srv;
+	struct work_struct	close_work;
+	enum ibtrs_srv_state	state;
+	spinlock_t		state_lock;
+	int			cur_cq_vector;
+	struct ibtrs_srv_op	**ops_ids;
+	atomic_t		ids_inflight;
+	wait_queue_head_t	ids_waitq;
+	struct ibtrs_srv_mr	*mrs;
+	unsigned int		mrs_num;
+	dma_addr_t		*dma_addr;
+	bool			established;
+	unsigned int		mem_bits;
+	struct kobject		kobj;
+	struct kobject		kobj_stats;
+	struct ibtrs_srv_stats	stats;
+};
+
+struct ibtrs_srv {
+	struct list_head	paths_list;
+	int			paths_up;
+	struct mutex		paths_ev_mutex;
+	size_t			paths_num;
+	struct mutex		paths_mutex;
+	uuid_t			paths_uuid;
+	refcount_t		refcount;
+	struct ibtrs_srv_ctx	*ctx;
+	struct list_head	ctx_list;
+	void			*priv;
+	size_t			queue_depth;
+	struct page		**chunks;
+	struct device		dev;
+	u32			dev_ref;
+	struct kobject		kobj_paths;
+};
+
+struct ibtrs_srv_ctx {
+	rdma_ev_fn *rdma_ev;
+	link_ev_fn *link_ev;
+	struct rdma_cm_id *cm_id_ip;
+	struct rdma_cm_id *cm_id_ib;
+	struct mutex srv_mutex;
+	struct list_head srv_list;
+};
+
+extern struct class *ibtrs_dev_class;
+
+/* See ibtrs-log.h */
+#define TYPES_TO_SESSNAME(obj)						\
+	LIST(CASE(obj, struct ibtrs_srv_sess *, s.sessname))
+
+void ibtrs_srv_queue_close(struct ibtrs_srv_sess *sess);
+
+/* ibtrs-srv-stats.c */
+
+void ibtrs_srv_update_rdma_stats(struct ibtrs_srv_stats *s, size_t size, int d);
+void ibtrs_srv_update_wc_stats(struct ibtrs_srv_stats *s);
+
+int ibtrs_srv_reset_rdma_stats(struct ibtrs_srv_stats *stats, bool enable);
+ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
+				    char *page, size_t len);
+int ibtrs_srv_reset_wc_completion_stats(struct ibtrs_srv_stats *stats,
+					bool enable);
+int ibtrs_srv_stats_wc_completion_to_str(struct ibtrs_srv_stats *stats,
+					 char *buf, size_t len);
+int ibtrs_srv_reset_all_stats(struct ibtrs_srv_stats *stats, bool enable);
+ssize_t ibtrs_srv_reset_all_help(struct ibtrs_srv_stats *stats,
+				 char *page, size_t len);
+
+/* ibtrs-srv-sysfs.c */
+
+int ibtrs_srv_create_sess_files(struct ibtrs_srv_sess *sess);
+void ibtrs_srv_destroy_sess_files(struct ibtrs_srv_sess *sess);
+
+#endif /* IBTRS_SRV_H */
-- 
2.17.1

