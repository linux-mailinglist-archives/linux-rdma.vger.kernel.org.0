Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC011C3C0C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgEDOCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgEDOCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E20C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so8544473wmj.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WII8fZOBmX6pHdXChtNCEpBRNBTitIUdh5gRlcIoDY=;
        b=gCJKXGUIUisy8zrz6k3IL8fST6ppET1vLiaHmqL8RFboKs+7dBcALZRighoXgwaN3T
         k8CBPXG+YJzmbg5QNKESoljUXS7GU40bYcHk/RYLIREkuFcTShDGswj+suS0o73JVsq6
         JU8/a68Ibizgydo1mI15ACh3GautsvGfu0KPSfnLn71jlfHfGqp2K0GZ3M+Txyr8Z/92
         L3ekKHaKTI1+YLBmfMFsQAwW1MxZvWj1drCt5jCPhP4v5gNvjZaYVAAMv3n0JHg1i7/v
         YAO5uK3ud/gim2ZdMj9jiH1pvhtIsMmPdN/suGV+0Oexr6exzgyuCe7Vq+GJqOQE7uOM
         uaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WII8fZOBmX6pHdXChtNCEpBRNBTitIUdh5gRlcIoDY=;
        b=Gp8Bs5aPGSwHNM2ROmCyocd+do0ohycfuHXYNEe0Y06elZTLI9BG5YZoOylqZd2+xD
         PDzoSZnhJIk8faeHk76KW7dF0GtANvt7y/1sjUiRAes7Tz+niisSvaet9u37uddCXaNm
         f/z8cMWIfgyTP4Mf6F+hjifkqG9jb68+VutrOJd/VhUpqbnYAY484MQrC3uzh3XDRwCY
         o0n/07q6sdFb0c84tDwchAFEeFiV4snhQFxLvTKAAUJH980JkEVxVa/4+pL+BI2eqNgA
         9PSwQ20qNFXRhWd26sdtqiPqXRGENPzL0LI0K2k1ixngVOj7HKKDbXBKBzyUHZroMpj+
         RzjA==
X-Gm-Message-State: AGi0PuYF8x0f8N471Nwf2F53D+g4Gj2mzLmc+tP0rmhBk1DgL3bzlUsl
        xdAlmQMAhaUYsPJZITtLRsQL
X-Google-Smtp-Source: APiQypLLe0RYnuTrAHIUZRNIGCtPB3ETreYsdy2J1w9lSjg6nljVIIh4m9FRWUB7Ep8ZP0xgaTyNTA==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr15529122wmf.187.1588600931493;
        Mon, 04 May 2020 07:02:11 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:10 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 03/25] RDMA/rtrs: private headers with rtrs protocol structs and helpers
Date:   Mon,  4 May 2020 16:00:53 +0200
Message-Id: <20200504140115.15533-4-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

These are common private headers with rtrs protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-log.h |  28 ++
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 399 +++++++++++++++++++++++++
 2 files changed, 427 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-log.h b/drivers/infiniband/ulp/rtrs/rtrs-log.h
new file mode 100644
index 000000000000..53c785b992f2
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-log.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RTRS_LOG_H
+#define RTRS_LOG_H
+
+#define rtrs_log(fn, obj, fmt, ...)				\
+	fn("<%s>: " fmt, obj->sessname, ##__VA_ARGS__)
+
+#define rtrs_err(obj, fmt, ...)	\
+	rtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
+#define rtrs_err_rl(obj, fmt, ...)	\
+	rtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define rtrs_wrn(obj, fmt, ...)	\
+	rtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
+#define rtrs_wrn_rl(obj, fmt, ...) \
+	rtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define rtrs_info(obj, fmt, ...) \
+	rtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
+#define rtrs_info_rl(obj, fmt, ...) \
+	rtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
+
+#endif /* RTRS_LOG_H */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
new file mode 100644
index 000000000000..0a93c87ef92b
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -0,0 +1,399 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_PRI_H
+#define RTRS_PRI_H
+
+#include <linux/uuid.h>
+#include <rdma/rdma_cm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib.h>
+
+#include "rtrs.h"
+
+#define RTRS_PROTO_VER_MAJOR 2
+#define RTRS_PROTO_VER_MINOR 0
+
+#define RTRS_PROTO_VER_STRING __stringify(RTRS_PROTO_VER_MAJOR) "." \
+			       __stringify(RTRS_PROTO_VER_MINOR)
+
+enum rtrs_imm_const {
+	MAX_IMM_TYPE_BITS = 4,
+	MAX_IMM_TYPE_MASK = ((1 << MAX_IMM_TYPE_BITS) - 1),
+	MAX_IMM_PAYL_BITS = 28,
+	MAX_IMM_PAYL_MASK = ((1 << MAX_IMM_PAYL_BITS) - 1),
+};
+
+enum rtrs_imm_type {
+	RTRS_IO_REQ_IMM       = 0, /* client to server */
+	RTRS_IO_RSP_IMM       = 1, /* server to client */
+	RTRS_IO_RSP_W_INV_IMM = 2, /* server to client */
+
+	RTRS_HB_MSG_IMM = 8, /* HB: HeartBeat */
+	RTRS_HB_ACK_IMM = 9,
+
+	RTRS_LAST_IMM,
+};
+
+enum {
+	SERVICE_CON_QUEUE_DEPTH = 512,
+
+	MAX_PATHS_NUM = 128,
+
+	/*
+	 * With the size of struct rtrs_permit allocated on the client, 4K
+	 * is the maximum number of rtrs_permits we can allocate. This number is
+	 * also used on the client to allocate the IU for the user connection
+	 * to receive the RDMA addresses from the server.
+	 */
+	MAX_SESS_QUEUE_DEPTH = 4096,
+
+	RTRS_HB_INTERVAL_MS = 5000,
+	RTRS_HB_MISSED_MAX = 5,
+
+	RTRS_MAGIC = 0x1BBD,
+	RTRS_PROTO_VER = (RTRS_PROTO_VER_MAJOR << 8) | RTRS_PROTO_VER_MINOR,
+};
+
+struct rtrs_ib_dev;
+
+struct rtrs_rdma_dev_pd_ops {
+	struct rtrs_ib_dev *(*alloc)(void);
+	void (*free)(struct rtrs_ib_dev *dev);
+	int (*init)(struct rtrs_ib_dev *dev);
+	void (*deinit)(struct rtrs_ib_dev *dev);
+};
+
+struct rtrs_rdma_dev_pd {
+	struct mutex		mutex;
+	struct list_head	list;
+	enum ib_pd_flags	pd_flags;
+	const struct rtrs_rdma_dev_pd_ops *ops;
+};
+
+struct rtrs_ib_dev {
+	struct ib_device	 *ib_dev;
+	struct ib_pd		 *ib_pd;
+	struct kref		 ref;
+	struct list_head	 entry;
+	struct rtrs_rdma_dev_pd *pool;
+};
+
+struct rtrs_con {
+	struct rtrs_sess	*sess;
+	struct ib_qp		*qp;
+	struct ib_cq		*cq;
+	struct rdma_cm_id	*cm_id;
+	unsigned int		cid;
+};
+
+struct rtrs_sess {
+	struct list_head	entry;
+	struct sockaddr_storage dst_addr;
+	struct sockaddr_storage src_addr;
+	char			sessname[NAME_MAX];
+	uuid_t			uuid;
+	struct rtrs_con	**con;
+	unsigned int		con_num;
+	unsigned int		recon_cnt;
+	struct rtrs_ib_dev	*dev;
+	int			dev_ref;
+	struct ib_cqe		*hb_cqe;
+	void			(*hb_err_handler)(struct rtrs_con *con);
+	struct workqueue_struct *hb_wq;
+	struct delayed_work	hb_dwork;
+	unsigned int		hb_interval_ms;
+	unsigned int		hb_missed_cnt;
+	unsigned int		hb_missed_max;
+};
+
+/* rtrs information unit */
+struct rtrs_iu {
+	struct list_head        list;
+	struct ib_cqe           cqe;
+	dma_addr_t              dma_addr;
+	void                    *buf;
+	size_t                  size;
+	enum dma_data_direction direction;
+};
+
+/**
+ * enum rtrs_msg_types - RTRS message types, see also rtrs/README
+ * @RTRS_MSG_INFO_REQ:		Client additional info request to the server
+ * @RTRS_MSG_INFO_RSP:		Server additional info response to the client
+ * @RTRS_MSG_WRITE:		Client writes data per RDMA to server
+ * @RTRS_MSG_READ:		Client requests data transfer from server
+ * @RTRS_MSG_RKEY_RSP:		Server refreshed rkey for rbuf
+ */
+enum rtrs_msg_types {
+	RTRS_MSG_INFO_REQ,
+	RTRS_MSG_INFO_RSP,
+	RTRS_MSG_WRITE,
+	RTRS_MSG_READ,
+	RTRS_MSG_RKEY_RSP,
+};
+
+/**
+ * enum rtrs_msg_flags - RTRS message flags.
+ * @RTRS_NEED_INVAL:	Send invalidation in response.
+ * @RTRS_MSG_NEW_RKEY_F: Send refreshed rkey in response.
+ */
+enum rtrs_msg_flags {
+	RTRS_MSG_NEED_INVAL_F = 1 << 0,
+	RTRS_MSG_NEW_RKEY_F = 1 << 1,
+};
+
+/**
+ * struct rtrs_sg_desc - RDMA-Buffer entry description
+ * @addr:	Address of RDMA destination buffer
+ * @key:	Authorization rkey to write to the buffer
+ * @len:	Size of the buffer
+ */
+struct rtrs_sg_desc {
+	__le64			addr;
+	__le32			key;
+	__le32			len;
+};
+
+/**
+ * struct rtrs_msg_conn_req - Client connection request to the server
+ * @magic:	   RTRS magic
+ * @version:	   RTRS protocol version
+ * @cid:	   Current connection id
+ * @cid_num:	   Number of connections per session
+ * @recon_cnt:	   Reconnections counter
+ * @sess_uuid:	   UUID of a session (path)
+ * @paths_uuid:	   UUID of a group of sessions (paths)
+ *
+ * NOTE: max size 56 bytes, see man rdma_connect().
+ */
+struct rtrs_msg_conn_req {
+	/* Is set to 0 by cma.c in case of AF_IB, do not touch that.
+	 * see https://www.spinics.net/lists/linux-rdma/msg22397.html
+	 */
+	u8		__cma_version;
+	/* On sender side that should be set to 0, or cma_save_ip_info()
+	 * extract garbage and will fail.
+	 */
+	u8		__ip_version;
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
+ * struct rtrs_msg_conn_rsp - Server connection response to the client
+ * @magic:	   RTRS magic
+ * @version:	   RTRS protocol version
+ * @errno:	   If rdma_accept() then 0, if rdma_reject() indicates error
+ * @queue_depth:   max inflight messages (queue-depth) in this session
+ * @max_io_size:   max io size server supports
+ * @max_hdr_size:  max msg header size server supports
+ *
+ * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
+ */
+struct rtrs_msg_conn_rsp {
+	__le16		magic;
+	__le16		version;
+	__le16		errno;
+	__le16		queue_depth;
+	__le32		max_io_size;
+	__le32		max_hdr_size;
+	__le32		flags;
+	u8		reserved[36];
+};
+
+/**
+ * struct rtrs_msg_info_req
+ * @type:		@RTRS_MSG_INFO_REQ
+ * @sessname:		Session name chosen by client
+ */
+struct rtrs_msg_info_req {
+	__le16		type;
+	u8		sessname[NAME_MAX];
+	u8		reserved[15];
+};
+
+/**
+ * struct rtrs_msg_info_rsp
+ * @type:		@RTRS_MSG_INFO_RSP
+ * @sg_cnt:		Number of @desc entries
+ * @desc:		RDMA buffers where the client can write to server
+ */
+struct rtrs_msg_info_rsp {
+	__le16		type;
+	__le16          sg_cnt;
+	u8              reserved[4];
+	struct rtrs_sg_desc desc[];
+};
+
+/**
+ * struct rtrs_msg_rkey_rsp
+ * @type:		@RTRS_MSG_RKEY_RSP
+ * @buf_id:		RDMA buf_id of the new rkey
+ * @rkey:		new remote key for RDMA buffers id from server
+ */
+struct rtrs_msg_rkey_rsp {
+	__le16		type;
+	__le16          buf_id;
+	__le32		rkey;
+};
+
+/**
+ * struct rtrs_msg_rdma_read - RDMA data transfer request from client
+ * @type:		always @RTRS_MSG_READ
+ * @usr_len:		length of user payload
+ * @sg_cnt:		number of @desc entries
+ * @desc:		RDMA buffers where the server can write the result to
+ */
+struct rtrs_msg_rdma_read {
+	__le16			type;
+	__le16			usr_len;
+	__le16			flags;
+	__le16			sg_cnt;
+	struct rtrs_sg_desc    desc[];
+};
+
+/**
+ * struct_msg_rdma_write - Message transferred to server with RDMA-Write
+ * @type:		always @RTRS_MSG_WRITE
+ * @usr_len:		length of user payload
+ */
+struct rtrs_msg_rdma_write {
+	__le16			type;
+	__le16			usr_len;
+};
+
+/**
+ * struct_msg_rdma_hdr - header for read or write request
+ * @type:		@RTRS_MSG_WRITE | @RTRS_MSG_READ
+ */
+struct rtrs_msg_rdma_hdr {
+	__le16			type;
+};
+
+/* rtrs.c */
+
+struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
+			      struct ib_device *dev, enum dma_data_direction,
+			      void (*done)(struct ib_cq *cq, struct ib_wc *wc));
+void rtrs_iu_free(struct rtrs_iu *iu, enum dma_data_direction dir,
+		  struct ib_device *dev, u32 queue_size);
+int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
+int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
+		      struct ib_send_wr *head);
+int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
+				struct ib_sge *sge, unsigned int num_sge,
+				u32 rkey, u64 rdma_addr, u32 imm_data,
+				enum ib_send_flags flags,
+				struct ib_send_wr *head);
+
+int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe);
+int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
+				   u32 imm_data, enum ib_send_flags flags,
+				   struct ib_send_wr *head);
+
+int rtrs_cq_qp_create(struct rtrs_sess *rtrs_sess, struct rtrs_con *con,
+		      u32 max_send_sge, int cq_vector, u16 cq_size,
+		      u16 wr_queue_size, enum ib_poll_context poll_ctx);
+void rtrs_cq_qp_destroy(struct rtrs_con *con);
+
+void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
+		  unsigned int interval_ms, unsigned int missed_max,
+		  void (*err_handler)(struct rtrs_con *con),
+		  struct workqueue_struct *wq);
+void rtrs_start_hb(struct rtrs_sess *sess);
+void rtrs_stop_hb(struct rtrs_sess *sess);
+void rtrs_send_hb_ack(struct rtrs_sess *sess);
+
+void rtrs_rdma_dev_pd_init(enum ib_pd_flags pd_flags,
+			   struct rtrs_rdma_dev_pd *pool);
+void rtrs_rdma_dev_pd_deinit(struct rtrs_rdma_dev_pd *pool);
+
+struct rtrs_ib_dev *rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
+					    struct rtrs_rdma_dev_pd *pool);
+int rtrs_ib_dev_put(struct rtrs_ib_dev *dev);
+
+static inline u32 rtrs_to_imm(u32 type, u32 payload)
+{
+	BUILD_BUG_ON(MAX_IMM_PAYL_BITS + MAX_IMM_TYPE_BITS != 32);
+	BUILD_BUG_ON(RTRS_LAST_IMM > (1<<MAX_IMM_TYPE_BITS));
+	return ((type & MAX_IMM_TYPE_MASK) << MAX_IMM_PAYL_BITS) |
+		(payload & MAX_IMM_PAYL_MASK);
+}
+
+static inline void rtrs_from_imm(u32 imm, u32 *type, u32 *payload)
+{
+	*payload = imm & MAX_IMM_PAYL_MASK;
+	*type = imm >> MAX_IMM_PAYL_BITS;
+}
+
+static inline u32 rtrs_to_io_req_imm(u32 addr)
+{
+	return rtrs_to_imm(RTRS_IO_REQ_IMM, addr);
+}
+
+static inline u32 rtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
+{
+	enum rtrs_imm_type type;
+	u32 payload;
+
+	/* 9 bits for errno, 19 bits for msg_id */
+	payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
+	type = w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM;
+
+	return rtrs_to_imm(type, payload);
+}
+
+static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
+{
+	/* 9 bits for errno, 19 bits for msg_id */
+	*msg_id = payload & 0x7ffff;
+	*errno = -(int)((payload >> 19) & 0x1ff);
+}
+
+#define STAT_STORE_FUNC(type, set_value, reset)				\
+static ssize_t set_value##_store(struct kobject *kobj,			\
+			     struct kobj_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	int ret = -EINVAL;						\
+	type *stats = container_of(kobj, type, kobj_stats);		\
+									\
+	if (sysfs_streq(buf, "1"))					\
+		ret = reset(stats, true);			\
+	else if (sysfs_streq(buf, "0"))					\
+		ret = reset(stats, false);			\
+	if (ret)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+#define STAT_SHOW_FUNC(type, get_value, print)				\
+static ssize_t get_value##_show(struct kobject *kobj,			\
+			   struct kobj_attribute *attr,			\
+			   char *page)					\
+{									\
+	type *stats = container_of(kobj, type, kobj_stats);		\
+									\
+	return print(stats, page, PAGE_SIZE);			\
+}
+
+#define STAT_ATTR(type, stat, print, reset)				\
+STAT_STORE_FUNC(type, stat, reset)					\
+STAT_SHOW_FUNC(type, stat, print)					\
+static struct kobj_attribute stat##_attr = __ATTR_RW(stat)
+
+#endif /* RTRS_PRI_H */
-- 
2.20.1

