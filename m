Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6F12CEE1
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfL3KaE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40059 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfL3KaD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id b8so32202737edx.7;
        Mon, 30 Dec 2019 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nUCcKLzZ0Fe/j6n5dLq9tNHppDOH//2bCtnbivXybsY=;
        b=ScLUCLGD+4cpw0ncoA+avtO5f1zTeT57A/Fw0jt48fectVUzVVTNJ7Hv9/6M8TUVuB
         EEOzlKSk0F9wLIt5CMM7QTZi61hXZB5bc4TkSi/ykltlQ6kpnTiw7IZbxDSmLHZl5klF
         wWE9zITJKwbU8d92QoU4ATIsWFFCfc01w2uJwCSoiCXme+FoS43b6M5DQSf/yzfhJ/GS
         Nz/4rZrZnnWSmjWq0GUdYJ1Mjv49RfZ65OGYkeeX8znc0ctBCxJAGL1dCKpecqG5H/Uu
         Z2j9+OBzK/HpC6+FHjZoepY1LRB1KFixrAAwz29Jb/7t3VywO6RdYRLQadHIOgmbtRVR
         xLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nUCcKLzZ0Fe/j6n5dLq9tNHppDOH//2bCtnbivXybsY=;
        b=FFjVtKPAMOKRCozVPmTQcZuJ8dOgHloqwZdFWipHGW7f7Yrxf/2ERWJIV9zjWVpPEs
         PSicW41nRCGSnEszvx8Zg54MkZj2ud4YphW7gFoCkqL1vQ6zG7WlEqaTNen+02DdAdk+
         7/Tqcjz3BD1qEt+aUHf6xUcWH5hp3V6Xpt6y4eH1OnzbP25zh6I/O0dSnHVNEDg9xBUC
         0ursLVsYjz1hFvHglyYjKCUSmwIb9g3eHueB8LmfVn2zIXak5a/V0CxQK6Vn6ZyFAgCw
         tXm0IhI3VIocngIxby7VdlYxLgZvqw4BCRu8IptKXEz3yz1bY8KafSkDAMfI8iRog1/M
         N6pQ==
X-Gm-Message-State: APjAAAXzCug45sFqi3//gGmmHoo6/0mlfMD/+lKE1+8/IIusGFDjpu3y
        ejjj7dlbNqVlIwln2c7LrLiFZmuS
X-Google-Smtp-Source: APXvYqzm0qnLCKbSwTl4LbPceGrIDVNptKXz34P95tN0fnQNCBI423zBLsAWIMgLdq2wkKWgzV+h7g==
X-Received: by 2002:aa7:ca06:: with SMTP id y6mr49943773eds.299.1577701801083;
        Mon, 30 Dec 2019 02:30:01 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:00 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 15/25] rnbd: private headers with rnbd protocol structs and helpers
Date:   Mon, 30 Dec 2019 11:29:32 +0100
Message-Id: <20191230102942.18395-16-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

These are common private headers with rnbd protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-common.c |  25 +++
 drivers/block/rnbd/rnbd-log.h    |  43 +++++
 drivers/block/rnbd/rnbd-proto.h  | 307 +++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-common.c
 create mode 100644 drivers/block/rnbd/rnbd-log.h
 create mode 100644 drivers/block/rnbd/rnbd-proto.h

diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
new file mode 100644
index 000000000000..4de9df8cedb3
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-common.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#include "rnbd-proto.h"
+
+const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
+{
+	switch (mode) {
+	case RNBD_ACCESS_RO:
+		return "ro";
+	case RNBD_ACCESS_RW:
+		return "rw";
+	case RNBD_ACCESS_MIGRATION:
+		return "migration";
+	default:
+		return "unknown";
+	}
+}
diff --git a/drivers/block/rnbd/rnbd-log.h b/drivers/block/rnbd/rnbd-log.h
new file mode 100644
index 000000000000..14e22bff1821
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-log.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_LOG_H
+#define RNBD_LOG_H
+
+#include "rnbd-clt.h"
+#include "rnbd-srv.h"
+
+#define rnbd_clt_log(fn, dev, fmt, ...) (				\
+		fn("<%s@%s> " fmt, (dev)->pathname,			\
+		(dev)->sess->sessname,					\
+		   ##__VA_ARGS__))
+#define rnbd_srv_log(fn, dev, fmt, ...) (				\
+			fn("<%s@%s>: " fmt, (dev)->pathname,		\
+			   (dev)->sess->sessname, ##__VA_ARGS__))
+
+#define rnbd_clt_err(dev, fmt, ...)	\
+	rnbd_clt_log(pr_err, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_err_rl(dev, fmt, ...)	\
+	rnbd_clt_log(pr_err_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_info(dev, fmt, ...) \
+	rnbd_clt_log(pr_info, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_info_rl(dev, fmt, ...) \
+	rnbd_clt_log(pr_info_ratelimited, dev, fmt, ##__VA_ARGS__)
+
+#define rnbd_srv_err(dev, fmt, ...)	\
+	rnbd_srv_log(pr_err, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_err_rl(dev, fmt, ...)	\
+	rnbd_srv_log(pr_err_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_info(dev, fmt, ...) \
+	rnbd_srv_log(pr_info, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_info_rl(dev, fmt, ...) \
+	rnbd_srv_log(pr_info_ratelimited, dev, fmt, ##__VA_ARGS__)
+
+#endif /* RNBD_LOG_H */
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
new file mode 100644
index 000000000000..069df2d1ae5e
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -0,0 +1,307 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_PROTO_H
+#define RNBD_PROTO_H
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/limits.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <rdma/ib.h>
+
+#define RNBD_PROTO_VER_MAJOR 2
+#define RNBD_PROTO_VER_MINOR 0
+
+#define RNBD_PROTO_VER_STRING __stringify(RNBD_PROTO_VER_MAJOR) "." \
+			       __stringify(RNBD_PROTO_VER_MINOR)
+
+#define RTRS_PORT 1234
+
+/**
+ * enum rnbd_msg_types - RNBD message types
+ * @RNBD_MSG_SESS_INFO:	initial session info from client to server
+ * @RNBD_MSG_SESS_INFO_RSP:	initial session info from server to client
+ * @RNBD_MSG_OPEN:		open (map) device request
+ * @RNBD_MSG_OPEN_RSP:		response to an @RNBD_MSG_OPEN
+ * @RNBD_MSG_IO:		block IO request operation
+ * @RNBD_MSG_CLOSE:		close (unmap) device request
+ */
+enum rnbd_msg_type {
+	RNBD_MSG_SESS_INFO,
+	RNBD_MSG_SESS_INFO_RSP,
+	RNBD_MSG_OPEN,
+	RNBD_MSG_OPEN_RSP,
+	RNBD_MSG_IO,
+	RNBD_MSG_CLOSE,
+};
+
+/**
+ * struct rnbd_msg_hdr - header of RNBD messages
+ * @type:	Message type, valid values see: enum rnbd_msg_types
+ */
+struct rnbd_msg_hdr {
+	__le16		type;
+	__le16		__padding;
+};
+
+/**
+ * We allow to map RO many times and RW only once. We allow to map yet another
+ * time RW, if MIGRATION is provided (second RW export can be required for
+ * example for VM migration)
+ */
+enum rnbd_access_mode {
+	RNBD_ACCESS_RO,
+	RNBD_ACCESS_RW,
+	RNBD_ACCESS_MIGRATION,
+};
+
+/**
+ * struct rnbd_msg_sess_info - initial session info from client to server
+ * @hdr:		message header
+ * @ver:		RNBD protocol version
+ */
+struct rnbd_msg_sess_info {
+	struct rnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct rnbd_msg_sess_info_rsp - initial session info from server to client
+ * @hdr:		message header
+ * @ver:		RNBD protocol version
+ */
+struct rnbd_msg_sess_info_rsp {
+	struct rnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct rnbd_msg_open - request to open a remote device.
+ * @hdr:		message header
+ * @access_mode:	the mode to open remote device, valid values see:
+ *			enum rnbd_access_mode
+ * @device_name:	device path on remote side
+ */
+struct rnbd_msg_open {
+	struct rnbd_msg_hdr hdr;
+	u8		access_mode;
+	u8		resv1;
+	s8		dev_name[NAME_MAX];
+	u8		reserved[3];
+};
+
+/**
+ * struct rnbd_msg_close - request to close a remote device.
+ * @hdr:	message header
+ * @device_id:	device_id on server side to identify the device
+ */
+struct rnbd_msg_close {
+	struct rnbd_msg_hdr hdr;
+	__le32		device_id;
+};
+
+/**
+ * struct rnbd_msg_open_rsp - response message to RNBD_MSG_OPEN
+ * @hdr:		message header
+ * @device_id:		device_id on server side to identify the device
+ * @nsectors:		number of sectors in the usual 512b unit
+ * @max_hw_sectors:	max hardware sectors in the usual 512b unit
+ * @max_write_same_sectors: max sectors for WRITE SAME in the 512b unit
+ * @max_discard_sectors: max. sectors that can be discarded at once in 512b
+ * unit.
+ * @discard_granularity: size of the internal discard allocation unit in bytes
+ * @discard_alignment: offset from internal allocation assignment in bytes
+ * @physical_block_size: physical block size device supports in bytes
+ * @logical_block_size: logical block size device supports in bytes
+ * @max_segments:	max segments hardware support in one transfer
+ * @secure_discard:	supports secure discard
+ * @rotation:		is a rotational disc?
+ */
+struct rnbd_msg_open_rsp {
+	struct rnbd_msg_hdr	hdr;
+	__le32			device_id;
+	__le64			nsectors;
+	__le32			max_hw_sectors;
+	__le32			max_write_same_sectors;
+	__le32			max_discard_sectors;
+	__le32			discard_granularity;
+	__le32			discard_alignment;
+	__le16			physical_block_size;
+	__le16			logical_block_size;
+	__le16			max_segments;
+	__le16			secure_discard;
+	u8			rotational;
+	u8			reserved[11];
+};
+
+/**
+ * struct rnbd_msg_io - message for I/O read/write
+ * @hdr:	message header
+ * @device_id:	device_id on server side to find the right device
+ * @sector:	bi_sector attribute from struct bio
+ * @rw:		valid values are defined in enum rnbd_io_flags
+ * @bi_size:    number of bytes for I/O read/write
+ * @prio:       priority
+ */
+struct rnbd_msg_io {
+	struct rnbd_msg_hdr hdr;
+	__le32		device_id;
+	__le64		sector;
+	__le32		rw;
+	__le32		bi_size;
+	__le16		prio;
+};
+
+#define RNBD_OP_BITS  8
+#define RNBD_OP_MASK  ((1 << RNBD_OP_BITS) - 1)
+
+/**
+ * enum rnbd_io_flags - RNBD request types from rq_flag_bits
+ * @RNBD_OP_READ:	     read sectors from the device
+ * @RNBD_OP_WRITE:	     write sectors to the device
+ * @RNBD_OP_FLUSH:	     flush the volatile write cache
+ * @RNBD_OP_DISCARD:        discard sectors
+ * @RNBD_OP_SECURE_ERASE:   securely erase sectors
+ * @RNBD_OP_WRITE_SAME:     write the same sectors many times
+
+ * @RNBD_F_SYNC:	     request is sync (sync write or read)
+ * @RNBD_F_FUA:             forced unit access
+ */
+enum rnbd_io_flags {
+
+	/* Operations */
+
+	RNBD_OP_READ		= 0,
+	RNBD_OP_WRITE		= 1,
+	RNBD_OP_FLUSH		= 2,
+	RNBD_OP_DISCARD	= 3,
+	RNBD_OP_SECURE_ERASE	= 4,
+	RNBD_OP_WRITE_SAME	= 5,
+
+	RNBD_OP_LAST,
+
+	/* Flags */
+
+	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
+	RNBD_F_FUA   = 1<<(RNBD_OP_BITS + 1),
+
+	RNBD_F_ALL   = (RNBD_F_SYNC | RNBD_F_FUA)
+
+};
+
+static inline u32 rnbd_op(u32 flags)
+{
+	return (flags & RNBD_OP_MASK);
+}
+
+static inline u32 rnbd_flags(u32 flags)
+{
+	return (flags & ~RNBD_OP_MASK);
+}
+
+static inline bool rnbd_flags_supported(u32 flags)
+{
+	u32 op;
+
+	op = rnbd_op(flags);
+	flags = rnbd_flags(flags);
+
+	if (op >= RNBD_OP_LAST)
+		return false;
+	if (flags & ~RNBD_F_ALL)
+		return false;
+
+	return true;
+}
+
+static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
+{
+	u32 bio_opf;
+
+	switch (rnbd_op(rnbd_opf)) {
+	case RNBD_OP_READ:
+		bio_opf = REQ_OP_READ;
+		break;
+	case RNBD_OP_WRITE:
+		bio_opf = REQ_OP_WRITE;
+		break;
+	case RNBD_OP_FLUSH:
+		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		break;
+	case RNBD_OP_DISCARD:
+		bio_opf = REQ_OP_DISCARD;
+		break;
+	case RNBD_OP_SECURE_ERASE:
+		bio_opf = REQ_OP_SECURE_ERASE;
+		break;
+	case RNBD_OP_WRITE_SAME:
+		bio_opf = REQ_OP_WRITE_SAME;
+		break;
+	default:
+		WARN(1, "Unknown RNBD type: %d (flags %d)\n",
+		     rnbd_op(rnbd_opf), rnbd_opf);
+		bio_opf = 0;
+	}
+
+	if (rnbd_opf & RNBD_F_SYNC)
+		bio_opf |= REQ_SYNC;
+
+	if (rnbd_opf & RNBD_F_FUA)
+		bio_opf |= REQ_FUA;
+
+	return bio_opf;
+}
+
+static inline u32 rq_to_rnbd_flags(struct request *rq)
+{
+	u32 rnbd_opf;
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		rnbd_opf = RNBD_OP_READ;
+		break;
+	case REQ_OP_WRITE:
+		rnbd_opf = RNBD_OP_WRITE;
+		break;
+	case REQ_OP_DISCARD:
+		rnbd_opf = RNBD_OP_DISCARD;
+		break;
+	case REQ_OP_SECURE_ERASE:
+		rnbd_opf = RNBD_OP_SECURE_ERASE;
+		break;
+	case REQ_OP_WRITE_SAME:
+		rnbd_opf = RNBD_OP_WRITE_SAME;
+		break;
+	case REQ_OP_FLUSH:
+		rnbd_opf = RNBD_OP_FLUSH;
+		break;
+	default:
+		WARN(1, "Unknown request type %d (flags %llu)\n",
+		     req_op(rq), (unsigned long long)rq->cmd_flags);
+		rnbd_opf = 0;
+	}
+
+	if (op_is_sync(rq->cmd_flags))
+		rnbd_opf |= RNBD_F_SYNC;
+
+	if (op_is_flush(rq->cmd_flags))
+		rnbd_opf |= RNBD_F_FUA;
+
+	return rnbd_opf;
+}
+
+const char *rnbd_access_mode_str(enum rnbd_access_mode mode);
+
+#endif /* RNBD_PROTO_H */
-- 
2.17.1

