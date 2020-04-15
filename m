Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1C1A98BA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895364AbgDOJYR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895379AbgDOJWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:22:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED784C061A0F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so18231279wrc.8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbEb4GO4bkclUwQzLx6sFQQlfkXtWxWn8YWxJIwHuCk=;
        b=bw2kls4gUWiVrbIlT0PHueDW8Jj7Du+kUZZeMWELgl04Uoeo3FMPkYqZ497JyqE9XB
         bVx6cYwAmREFtTaCRX8yfll1KLmD0VrJVj+r2Zavs6MfcvwwUvP/eNXJOOSKKP2AHfmF
         14qxG0Y0QogKwIY56TJ9lQtE+AGZkzhtB/0wPikqShNK5I/eG3b7gXLYPxF2B0srsWBM
         TPxX+U9TCLLZhATMWgqKev0T3wE4JpcGS2jGSkOR3f6sjFlmmF4lRTn1ck90+0bgU5Hp
         U1KpVwEU9wOCOyv0RvUR9AeJ4CCVSqg2XER9Iv/AAgJDmI2BmDs6LrLvrv4wEwZmlxOT
         VnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbEb4GO4bkclUwQzLx6sFQQlfkXtWxWn8YWxJIwHuCk=;
        b=JHZsbJuP8zW258cKCcQBY0ZKf1coP+QBbDqMKVYCpb4s7FEgL2rNfl+wY3zQ1XBr3X
         XPeLrY6ijPKa7guRnFwv26cUqipWAPQS8QSt1/uBohwKLkgsRl72f5Pzc1vCO6Nr0qNG
         Iv117Hm0PC4LyLXvh8p7tkne/X68qwk5hF3L/kpdgeXElGJWjJPRxqrl4dtAY6XW9FJt
         elMMCeS9khKPfBEXHrWDna3Ti74VTvKiRr8DWVrQVBtZeCWPmNnbeNeYNGGXgbW6PKXW
         0SNA5NK46Ud08k/O+PNEf8tJugPP/BZhXtae4EgzqoNLHjesAVug5CG+EHsG73I1M3/9
         XZZw==
X-Gm-Message-State: AGi0PuaWFX/+WZ4AQJVcv1jW9x2I2bES7AJn+V2oEjc5FWcGkuuI6i2P
        fQFIPyhlWZVWo3XVeDQnHuU1
X-Google-Smtp-Source: APiQypIaEosC9iI5V5PNJo866hIsO6Uz3F4J6UJj/yOZrY35LCMr8CCC3J+JP+P1zwYgyqNhFeJscQ==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr30149984wra.342.1586942569676;
        Wed, 15 Apr 2020 02:22:49 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:22:49 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 09/25] RDMA/rtrs: server: private header with server structs and functions
Date:   Wed, 15 Apr 2020 11:20:29 +0200
Message-Id: <20200415092045.4729-10-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 148 +++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
new file mode 100644
index 000000000000..dc95b0932f0d
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -0,0 +1,148 @@
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
+	struct kobject				kobj_stats;
+	struct rtrs_srv_stats_rdma_stats	rdma_stats;
+	struct rtrs_srv_sess			*sess;
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
+	struct ib_rdma_wr		tx_wr;
+	struct ib_sge			tx_sg;
+	struct list_head		wait_list;
+	int				status;
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
+	struct rtrs_srv_stats	*stats;
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
+	struct kobject		*kobj_paths;
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
2.20.1

