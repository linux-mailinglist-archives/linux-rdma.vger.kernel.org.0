Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF31A98B0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895393AbgDOJYD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895391AbgDOJXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A02C061A41
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k1so11014609wrx.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SLvcFqs5w4hfWl2Hhi1C7GPR1D7sO2Co5b/7YXi8kg=;
        b=R+TzaHINeNfHXwKw+7LD4F+jSPkhsjl0ZwkWMMEKd0rcGy5pFO+UCtnE0is/yI7LOv
         H9q9/G7KKk1iM1VloYpw4j2nI2l0ZCU/S4PIpiyrX0/5hCX2JoIpG+FNtX1/h5J3y18f
         Hqi9zrOb8XDbskQhOu8OJdE+HxKazJ7qM8smgSpxIjpKAg5rE+LMKxvw2C5Y1rpWK85B
         oglOwwdhddAQBi+MULMZuT0r9GDKUFA2awj5Z38UlI5oyJND9rxQhOEtLMRCZgSqAnRa
         Lmrd+CnKnPwjjKdF/MJJbVXJABmFdcp9CwV5dVZVK2twNzHBCEnbVw3CBleYIzhmN9wN
         q01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SLvcFqs5w4hfWl2Hhi1C7GPR1D7sO2Co5b/7YXi8kg=;
        b=dVoy1Tn3stvTKmQDUTRyhglYT9Z+yiFXE3okWZHCTftaf51BMuZdKdsS/W6RFLOmXK
         zDcYyhVNt4CPrdK+rWYeviNwKNjHU2j3WtMmBpPdqEv4OpvjJLM2EvqVk3T/QbqbETi0
         qlHM1L9M/vBV9g8cEhyaMyfeOiT4kqCQfaZSi+0aqSYdmdNWi6Z/CfqfAH24A6Srw/T2
         Ga+/ADPcOcYsVMDVHdw7hj6vSBKmp4pKOxCZyL660SxffPWttyH/0Id7bygHRsxXfOLA
         BsI7TbOYjSNgbGnAF1d+xHW22VT+LqDvW+uyswOJ8yucIMbTj5UuTWU/HtI8RZ6xegOh
         o6iA==
X-Gm-Message-State: AGi0PuYXntClhrZaq0+YYq6NSY8V58hfr7Jvtye6QsPyKQX2+FFjJz83
        RYZKT9dlD8fuBxa2gYos9vFQ
X-Google-Smtp-Source: APiQypLb5VWM1l/U2LUwzxF2SJ+k9K/Z5wWPGGs7W1NiWt34wVxS55OSqO0X23ctvcuMGPdJHVQNPA==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr29868698wrr.358.1586942580631;
        Wed, 15 Apr 2020 02:23:00 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:00 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 15/25] block/rnbd: private headers with rnbd protocol structs and helpers
Date:   Wed, 15 Apr 2020 11:20:35 +0200
Message-Id: <20200415092045.4729-16-danil.kipnis@cloud.ionos.com>
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

These are common private headers with rnbd protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-common.c |  23 +++
 drivers/block/rnbd/rnbd-log.h    |  41 +++++
 drivers/block/rnbd/rnbd-proto.h  | 303 +++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-common.c
 create mode 100644 drivers/block/rnbd/rnbd-log.h
 create mode 100644 drivers/block/rnbd/rnbd-proto.h

diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
new file mode 100644
index 000000000000..596c3f732403
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-common.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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
index 000000000000..136e7d6c3451
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-log.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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
index 000000000000..ca166241452c
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
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
+/* The default port number the RTRS server is listening on. */
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
+	return flags & RNBD_OP_MASK;
+}
+
+static inline u32 rnbd_flags(u32 flags)
+{
+	return flags & ~RNBD_OP_MASK;
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
2.20.1

