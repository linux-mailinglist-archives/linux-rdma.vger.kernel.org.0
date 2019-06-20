Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CB4D156
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfFTPDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41051 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbfFTPDr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so5156396eds.8;
        Thu, 20 Jun 2019 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4u7lee2B9jT1kccCfJ6KLeOPi4Lv46oaLkOWjUVlRZI=;
        b=Lj5jZJhV9dcgwe0557mUDnheFeDudD5OAwKd7QwHNrAMSM1TIXVH4ucC7Il5x+ljUe
         jEAQVEqv9v1ZWe4Qg+0arwjDDIQOeJof/d4g2s2n7oO72x333b8JX4iiYWb9meyJmT4B
         yQMXFV+fiWNCssxEOL01s4qxQ4L/0abgNxr+mCI678Q8jGOmhR4wbugiEbecl0bBtNmL
         Twg0/ggAJtZlUI6dzq8Xn1KO1tRvtYo+DxBnYEyDLTwSNDLp5rt6NmkTlKLHrNNdZGUS
         LcT3oqZzYz5dazCNYbVpxh4JZv2jYHcL4Tbk7o/b4NlA61waAJ69noqKsWBMeZj3ObYq
         LMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4u7lee2B9jT1kccCfJ6KLeOPi4Lv46oaLkOWjUVlRZI=;
        b=q+bAaA7kulGJDCy0AWvvGMZIYUKExP0z+BeQMtRj4Hz6Npe5GwBKOolwUp6kI/zDkX
         1gWdH7EbijNqpTBHaZLT1Hr72bP7d7UDDV12XQQDZT6jhZs5XODrEEYvSNERE+a2If2Y
         41bYPvT8jKC3EhwLP/hN4CMmO9ANwVcnkXCW2bD1DVU9wLogbD9GYZs1ddjb1m9K0sCF
         XZuTQA5Wpwyy9ncns0vjBk4FQzTu6wd1sDLuMKdtO31lyr4QSyToSaA+GMh+p/yVDAOj
         7Ay5/FRf43DLKV9Mp37YodMlYE9qpti0yl8Cj24EkKkHaPZJi9rqvoLbNG/TS+FsxCe7
         cQ9A==
X-Gm-Message-State: APjAAAU29Ph9Z7SX2HoThgrqXY3NAAwviUJvaHsHTOju8IHHoJ1biz0N
        egqZh8p+lZxE6ASPfqfYR1qbS2YvDv8=
X-Google-Smtp-Source: APXvYqxRiRB0pg2C/i3BzCBYNeDUVaPMp1BMXb6JPTBOiVsdoRwDRPETgGytIcsQIgsQpP7mh/TMZQ==
X-Received: by 2002:a17:906:2a98:: with SMTP id l24mr68704906eje.150.1561043023856;
        Thu, 20 Jun 2019 08:03:43 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:43 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol structs and helpers
Date:   Thu, 20 Jun 2019 17:03:15 +0200
Message-Id: <20190620150337.7847-4-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

These are common private headers with IBTRS protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/ibtrs/ibtrs-log.h |  84 ++++
 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h | 463 +++++++++++++++++++++++
 2 files changed, 547 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-log.h
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-pri.h

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-log.h b/drivers/infiniband/ulp/ibtrs/ibtrs-log.h
new file mode 100644
index 000000000000..fec816c935bc
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-log.h
@@ -0,0 +1,84 @@
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
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#ifndef IBTRS_LOG_H
+#define IBTRS_LOG_H
+
+#define P1 )
+#define P2 ))
+#define P3 )))
+#define P4 ))))
+#define P(N) P ## N
+
+#define CAT(a, ...) PRIMITIVE_CAT(a, __VA_ARGS__)
+#define PRIMITIVE_CAT(a, ...) a ## __VA_ARGS__
+
+#define LIST(...)						\
+	__VA_ARGS__,						\
+	({ unknown_type(); NULL; })				\
+	CAT(P, COUNT_ARGS(__VA_ARGS__))				\
+
+#define EMPTY()
+#define DEFER(id) id EMPTY()
+
+#define _CASE(obj, type, member)				\
+	__builtin_choose_expr(					\
+	__builtin_types_compatible_p(				\
+		typeof(obj), type),				\
+		((type)obj)->member
+#define CASE(o, t, m) DEFER(_CASE)(o, t, m)
+
+/*
+ * Below we define retrieving of sessname from common IBTRS types.
+ * Client or server related types have to be defined by special
+ * TYPES_TO_SESSNAME macro.
+ */
+
+void unknown_type(void);
+
+#ifndef TYPES_TO_SESSNAME
+#define TYPES_TO_SESSNAME(...) ({ unknown_type(); NULL; })
+#endif
+
+#define ibtrs_prefix(obj)					\
+	_CASE(obj, struct ibtrs_con *,  sess->sessname),	\
+	_CASE(obj, struct ibtrs_sess *, sessname),		\
+	TYPES_TO_SESSNAME(obj)					\
+	))
+
+#define ibtrs_log(fn, obj, fmt, ...)				\
+	fn("<%s>: " fmt, ibtrs_prefix(obj), ##__VA_ARGS__)
+
+#define ibtrs_err(obj, fmt, ...)	\
+	ibtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
+#define ibtrs_err_rl(obj, fmt, ...)	\
+	ibtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define ibtrs_wrn(obj, fmt, ...)	\
+	ibtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
+#define ibtrs_wrn_rl(obj, fmt, ...) \
+	ibtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define ibtrs_info(obj, fmt, ...) \
+	ibtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
+#define ibtrs_info_rl(obj, fmt, ...) \
+	ibtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
+
+#endif /* IBTRS_LOG_H */
diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-pri.h b/drivers/infiniband/ulp/ibtrs/ibtrs-pri.h
new file mode 100644
index 000000000000..5a180e5e19bc
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-pri.h
@@ -0,0 +1,463 @@
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
+#ifndef IBTRS_PRI_H
+#define IBTRS_PRI_H
+
+#include <linux/uuid.h>
+#include <rdma/rdma_cm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib.h>
+
+#include "ibtrs.h"
+
+#define IBTRS_PROTO_VER_MAJOR 2
+#define IBTRS_PROTO_VER_MINOR 0
+
+#define IBTRS_PROTO_VER_STRING __stringify(IBTRS_PROTO_VER_MAJOR) "." \
+			       __stringify(IBTRS_PROTO_VER_MINOR)
+
+#ifndef IBTRS_VER_STRING
+#define IBTRS_VER_STRING __stringify(IBTRS_PROTO_VER_MAJOR) "." \
+			 __stringify(IBTRS_PROTO_VER_MINOR)
+#endif
+
+enum ibtrs_imm_const {
+	MAX_IMM_TYPE_BITS = 4,
+	MAX_IMM_TYPE_MASK = ((1 << MAX_IMM_TYPE_BITS) - 1),
+	MAX_IMM_PAYL_BITS = 28,
+	MAX_IMM_PAYL_MASK = ((1 << MAX_IMM_PAYL_BITS) - 1),
+};
+
+enum ibtrs_imm_type {
+	IBTRS_IO_REQ_IMM       = 0, /* client to server */
+	IBTRS_IO_RSP_IMM       = 1, /* server to client */
+	IBTRS_IO_RSP_W_INV_IMM = 2, /* server to client */
+
+	IBTRS_HB_MSG_IMM = 8,
+	IBTRS_HB_ACK_IMM = 9,
+
+	IBTRS_LAST_IMM,
+};
+
+enum {
+	SERVICE_CON_QUEUE_DEPTH = 512,
+
+	MIN_RTR_CNT = 1,
+	MAX_RTR_CNT = 7,
+
+	MAX_PATHS_NUM = 128,
+
+	/*
+	 * With the current size of the tag allocated on the client, 4K
+	 * is the maximum number of tags we can allocate.  This number is
+	 * also used on the client to allocate the IU for the user connection
+	 * to receive the RDMA addresses from the server.
+	 */
+	MAX_SESS_QUEUE_DEPTH = 4096,
+
+	IBTRS_HB_INTERVAL_MS = 5000,
+	IBTRS_HB_MISSED_MAX = 5,
+
+	IBTRS_MAGIC = 0x1BBD,
+	IBTRS_PROTO_VER = (IBTRS_PROTO_VER_MAJOR << 8) | IBTRS_PROTO_VER_MINOR,
+};
+
+struct ibtrs_ib_dev;
+
+struct ibtrs_ib_dev_pool_ops {
+	struct ibtrs_ib_dev *(*alloc)(void);
+	void (*free)(struct ibtrs_ib_dev *);
+	int (*init)(struct ibtrs_ib_dev *);
+	void (*deinit)(struct ibtrs_ib_dev *);
+};
+
+struct ibtrs_ib_dev_pool {
+	struct mutex		mutex;
+	struct list_head	list;
+	enum ib_pd_flags	pd_flags;
+	const struct ibtrs_ib_dev_pool_ops *ops;
+};
+
+struct ibtrs_ib_dev {
+	struct ib_device	 *ib_dev;
+	struct ib_pd		 *ib_pd;
+	struct kref		 ref;
+	struct list_head	 entry;
+	struct ibtrs_ib_dev_pool *pool;
+};
+
+struct ibtrs_con {
+	struct ibtrs_sess	*sess;
+	struct ib_qp		*qp;
+	struct ib_cq		*cq;
+	struct rdma_cm_id	*cm_id;
+	u32			cid;
+};
+
+typedef void (ibtrs_hb_handler_t)(struct ibtrs_con *con, int err);
+
+struct ibtrs_sess {
+	struct list_head	entry;
+	struct sockaddr_storage dst_addr;
+	struct sockaddr_storage src_addr;
+	char			sessname[NAME_MAX];
+	uuid_t			uuid;
+	struct ibtrs_con	**con;
+	u32			con_num;
+	u32		recon_cnt;
+	struct ibtrs_ib_dev	*dev;
+	int			dev_ref;
+	struct ib_cqe		*hb_cqe;
+	ibtrs_hb_handler_t	*hb_err_handler;
+	struct workqueue_struct *hb_wq;
+	struct delayed_work	hb_dwork;
+	u32			hb_interval_ms;
+	u32			hb_missed_cnt;
+	u32			hb_missed_max;
+};
+
+struct ibtrs_iu {
+	struct list_head        list;
+	struct ib_cqe           cqe;
+	dma_addr_t              dma_addr;
+	void                    *buf;
+	size_t                  size;
+	enum dma_data_direction direction;
+	u32			tag;
+};
+
+/**
+ * enum ibtrs_msg_types - IBTRS message types.
+ * @IBTRS_MSG_INFO_REQ:		Client additional info request to the server
+ * @IBTRS_MSG_INFO_RSP:		Server additional info response to the client
+ * @IBTRS_MSG_WRITE:		Client writes data per RDMA to server
+ * @IBTRS_MSG_READ:		Client requests data transfer from server
+ */
+enum ibtrs_msg_types {
+	IBTRS_MSG_INFO_REQ,
+	IBTRS_MSG_INFO_RSP,
+	IBTRS_MSG_WRITE,
+	IBTRS_MSG_READ,
+};
+
+/**
+ * enum ibtrs_msg_flags - IBTRS message flags.
+ * @IBTRS_NEED_INVAL:	Send invalidation in response.
+ */
+enum ibtrs_msg_flags {
+	IBTRS_MSG_NEED_INVAL_F = 1<<0
+};
+
+/**
+ * struct ibtrs_sg_desc - RDMA-Buffer entry description
+ * @addr:	Address of RDMA destination buffer
+ * @key:	Authorization rkey to write to the buffer
+ * @len:	Size of the buffer
+ */
+struct ibtrs_sg_desc {
+	__le64			addr;
+	__le32			key;
+	__le32			len;
+};
+
+/**
+ * struct ibtrs_msg_conn_req - Client connection request to the server
+ * @magic:	   IBTRS magic
+ * @version:	   IBTRS protocol version
+ * @cid:	   Current connection id
+ * @cid_num:	   Number of connections per session
+ * @recon_cnt:	   Reconnections counter
+ * @sess_uuid:	   UUID of a session (path)
+ * @paths_uuid:	   UUID of a group of sessions (paths)
+ *
+ * NOTE: max size 56 bytes, see man rdma_connect().
+ */
+struct ibtrs_msg_conn_req {
+	u8		__cma_version; /* Is set to 0 by cma.c in case of
+					* AF_IB, do not touch that. */
+	u8		__ip_version;  /* On sender side that should be
+					* set to 0, or cma_save_ip_info()
+					* extract garbage and will fail. */
+	__le16		magic;
+	__le16		version;
+	__le16		cid;
+	__le16		cid_num;
+	__le16		recon_cnt;
+	uuid_t		sess_uuid;
+	uuid_t		paths_uuid;
+	u8		reserved[12];
+};
+
+/**
+ * struct ibtrs_msg_conn_rsp - Server connection response to the client
+ * @magic:	   IBTRS magic
+ * @version:	   IBTRS protocol version
+ * @errno:	   If rdma_accept() then 0, if rdma_reject() indicates error
+ * @queue_depth:   max inflight messages (queue-depth) in this session
+ * @max_io_size:   max io size server supports
+ * @max_hdr_size:  max msg header size server supports
+ *
+ * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
+ */
+struct ibtrs_msg_conn_rsp {
+	__le16		magic;
+	__le16		version;
+	__le16		errno;
+	__le16		queue_depth;
+	__le32		max_io_size;
+	__le32		max_hdr_size;
+	u8		reserved[40];
+};
+
+/**
+ * struct ibtrs_msg_info_req
+ * @type:		@IBTRS_MSG_INFO_REQ
+ * @sessname:		Session name chosen by client
+ */
+struct ibtrs_msg_info_req {
+	__le16		type;
+	u8		sessname[NAME_MAX];
+	u8		reserved[15];
+};
+
+/**
+ * struct ibtrs_msg_info_rsp
+ * @type:		@IBTRS_MSG_INFO_RSP
+ * @sg_cnt:		Number of @desc entries
+ * @desc:		RDMA buffers where the client can write to server
+ */
+struct ibtrs_msg_info_rsp {
+	__le16		type;
+	__le16          sg_cnt;
+	u8              reserved[4];
+	struct ibtrs_sg_desc desc[];
+};
+
+/**
+ * struct ibtrs_msg_rdma_read - RDMA data transfer request from client
+ * @type:		always @IBTRS_MSG_READ
+ * @usr_len:		length of user payload
+ * @sg_cnt:		number of @desc entries
+ * @desc:		RDMA buffers where the server can write the result to
+ */
+struct ibtrs_msg_rdma_read {
+	__le16			type;
+	__le16			usr_len;
+	__le16			flags;
+	__le16			sg_cnt;
+	struct ibtrs_sg_desc    desc[];
+};
+
+/**
+ * struct_msg_rdma_write - Message transferred to server with RDMA-Write
+ * @type:		always @IBTRS_MSG_WRITE
+ * @usr_len:		length of user payload
+ */
+struct ibtrs_msg_rdma_write {
+	__le16			type;
+	__le16			usr_len;
+};
+
+/**
+ * struct_msg_rdma_hdr - header for read or write request
+ * @type:		@IBTRS_MSG_WRITE | @IBTRS_MSG_READ
+ */
+struct ibtrs_msg_rdma_hdr {
+	__le16			type;
+};
+
+/* ibtrs.c */
+
+struct ibtrs_iu *ibtrs_iu_alloc(u32 tag, size_t size, gfp_t t,
+				struct ib_device *dev, enum dma_data_direction,
+				void (*done)(struct ib_cq *cq, struct ib_wc *wc));
+void ibtrs_iu_free(struct ibtrs_iu *iu, enum dma_data_direction dir,
+		   struct ib_device *dev);
+int ibtrs_iu_post_recv(struct ibtrs_con *con, struct ibtrs_iu *iu);
+int ibtrs_iu_post_send(struct ibtrs_con *con, struct ibtrs_iu *iu, size_t size,
+		       struct ib_send_wr *head);
+int ibtrs_iu_post_rdma_write_imm(struct ibtrs_con *con, struct ibtrs_iu *iu,
+				 struct ib_sge *sge, unsigned int num_sge,
+				 u32 rkey, u64 rdma_addr, u32 imm_data,
+				 enum ib_send_flags flags,
+				 struct ib_send_wr *head);
+
+int ibtrs_post_recv_empty(struct ibtrs_con *con, struct ib_cqe *cqe);
+int ibtrs_post_recv_empty_x2(struct ibtrs_con *con, struct ib_cqe *cqe);
+int ibtrs_post_rdma_write_imm_empty(struct ibtrs_con *con, struct ib_cqe *cqe,
+				    u32 imm_data, enum ib_send_flags flags,
+				    struct ib_send_wr *head);
+
+int ibtrs_cq_qp_create(struct ibtrs_sess *ibtrs_sess, struct ibtrs_con *con,
+		       u32 max_send_sge, int cq_vector, u16 cq_size,
+		       u16 wr_queue_size, enum ib_poll_context poll_ctx);
+void ibtrs_cq_qp_destroy(struct ibtrs_con *con);
+
+void ibtrs_init_hb(struct ibtrs_sess *sess, struct ib_cqe *cqe,
+		   u32 interval_ms, u32 missed_max,
+		   ibtrs_hb_handler_t *err_handler,
+		   struct workqueue_struct *wq);
+void ibtrs_start_hb(struct ibtrs_sess *sess);
+void ibtrs_stop_hb(struct ibtrs_sess *sess);
+void ibtrs_send_hb_ack(struct ibtrs_sess *sess);
+
+void ibtrs_ib_dev_pool_init(enum ib_pd_flags pd_flags,
+			    struct ibtrs_ib_dev_pool *pool);
+void ibtrs_ib_dev_pool_deinit(struct ibtrs_ib_dev_pool *pool);
+
+struct ibtrs_ib_dev *ibtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
+					      struct ibtrs_ib_dev_pool *pool);
+int ibtrs_ib_dev_put(struct ibtrs_ib_dev *dev);
+
+static inline int sockaddr_cmp(const struct sockaddr *a,
+			       const struct sockaddr *b)
+{
+	switch (a->sa_family) {
+	case AF_IB:
+		return memcmp(&((struct sockaddr_ib *)a)->sib_addr,
+			      &((struct sockaddr_ib *)b)->sib_addr,
+			      sizeof(struct ib_addr));
+	case AF_INET:
+		return memcmp(&((struct sockaddr_in *)a)->sin_addr,
+			      &((struct sockaddr_in *)b)->sin_addr,
+			      sizeof(struct in_addr));
+	case AF_INET6:
+		return memcmp(&((struct sockaddr_in6 *)a)->sin6_addr,
+			      &((struct sockaddr_in6 *)b)->sin6_addr,
+			      sizeof(struct in6_addr));
+	default:
+		return -ENOENT;
+	}
+}
+
+static inline int sockaddr_to_str(const struct sockaddr *addr,
+				   char *buf, size_t len)
+{
+	int cnt;
+
+	switch (addr->sa_family) {
+	case AF_IB:
+		cnt = scnprintf(buf, len, "gid:%pI6",
+			&((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
+		return cnt;
+	case AF_INET:
+		cnt = scnprintf(buf, len, "ip:%pI4",
+			&((struct sockaddr_in *)addr)->sin_addr);
+		return cnt;
+	case AF_INET6:
+		cnt = scnprintf(buf, len, "ip:%pI6c",
+			  &((struct sockaddr_in6 *)addr)->sin6_addr);
+		return cnt;
+	}
+	cnt = scnprintf(buf, len, "<invalid address family>");
+	pr_err("Invalid address family\n");
+	return cnt;
+}
+
+/**
+ * ibtrs_invalidate_flag() - returns proper flags for invalidation
+ *
+ * NOTE: This function is needed for compat layer, so think twice before
+ *       rename or remove.
+ */
+static inline u32 ibtrs_invalidate_flag(void)
+{
+	return IBTRS_MSG_NEED_INVAL_F;
+}
+
+static inline u32 ibtrs_to_imm(u32 type, u32 payload)
+{
+	BUILD_BUG_ON(MAX_IMM_PAYL_BITS + MAX_IMM_TYPE_BITS != 32);
+	BUILD_BUG_ON(IBTRS_LAST_IMM > (1<<MAX_IMM_TYPE_BITS));
+	return ((type & MAX_IMM_TYPE_MASK) << MAX_IMM_PAYL_BITS) |
+		(payload & MAX_IMM_PAYL_MASK);
+}
+
+static inline void ibtrs_from_imm(u32 imm, u32 *type, u32 *payload)
+{
+	*payload = (imm & MAX_IMM_PAYL_MASK);
+	*type = (imm >> MAX_IMM_PAYL_BITS);
+}
+
+static inline u32 ibtrs_to_io_req_imm(u32 addr)
+{
+	return ibtrs_to_imm(IBTRS_IO_REQ_IMM, addr);
+}
+
+static inline u32 ibtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
+{
+	enum ibtrs_imm_type type;
+	u32 payload;
+
+	/* 9 bits for errno, 19 bits for msg_id */
+	payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
+	type = (w_inval ? IBTRS_IO_RSP_W_INV_IMM : IBTRS_IO_RSP_IMM);
+
+	return ibtrs_to_imm(type, payload);
+}
+
+static inline void ibtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
+{
+	/* 9 bits for errno, 19 bits for msg_id */
+	*msg_id = (payload & 0x7ffff);
+	*errno = -(int)((payload >> 19) & 0x1ff);
+}
+
+#define STAT_STORE_FUNC(type, store, reset)				\
+static ssize_t store##_store(struct kobject *kobj,			\
+			     struct kobj_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	int ret = -EINVAL;						\
+	type *sess = container_of(kobj, type, kobj_stats);		\
+									\
+	if (sysfs_streq(buf, "1"))					\
+		ret = reset(&sess->stats, true);			\
+	else if (sysfs_streq(buf, "0"))					\
+		ret = reset(&sess->stats, false);			\
+	if (ret)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+#define STAT_SHOW_FUNC(type, show, print)				\
+static ssize_t show##_show(struct kobject *kobj,			\
+			   struct kobj_attribute *attr,			\
+			   char *page)					\
+{									\
+	type *sess = container_of(kobj, type, kobj_stats);		\
+									\
+	return print(&sess->stats, page, PAGE_SIZE);			\
+}
+
+#define STAT_ATTR(type, stat, print, reset)				\
+STAT_STORE_FUNC(type, stat, reset)					\
+STAT_SHOW_FUNC(type, stat, print)					\
+static struct kobj_attribute stat##_attr =				\
+		__ATTR(stat, 0644,					\
+		       stat##_show,					\
+		       stat##_store)
+
+#endif /* IBTRS_PRI_H */
-- 
2.17.1

