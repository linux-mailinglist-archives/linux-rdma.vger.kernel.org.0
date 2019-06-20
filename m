Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26CA4D16D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfFTPEB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38942 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTPEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so5181101edv.6;
        Thu, 20 Jun 2019 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBlbhTNbcEpg58V+Ond+IUR7mxpWAWG1nL35yoWp8Bg=;
        b=tV+80JG5lBoxTPtfLCLOeQ0jUeVd4A+uiu8ziUHTSj9CWVX81lpnaRUafNjyRBPLa8
         DZVcdPsky6C6dC80L0EA0xurvkpnKnySUPVUhHPpb6NuGTYcM3wabTmOt3ux94fb9K/i
         fhPZPIBq/d4wzpjBm8gEAwBb/rErp1lGSvsOJ0X+/5z1qVeYW8hQZZzF4UE5StDF8bKR
         pciEazpHPdzwalTzGsc5UEh1DCtZtTk1d/iLwxy4BS0XhgIASb7WI1tNsn4AkENPr4sm
         1jMMitiVYLqWIMCU7pVYYK8+Gp8y52F0o8UhpQ7L0V3TKFjZRAP9rbrkPsKzOG8gh+Oe
         8tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBlbhTNbcEpg58V+Ond+IUR7mxpWAWG1nL35yoWp8Bg=;
        b=NWIh4euzAjBiepjBNF0DzM0zxK5admn78musDgUAe+QRbBqmEdOzNFAKssdiKVGwjn
         1EShXqoe0Orj1AkzT1AuIRA7SXGG/bss/CWXO9lW3c8cayVfGrLB8XPAtn5jKqbxHqUn
         dR+46pQ+AdH5FhI8O29kgMTErW/ObFZLxLI/QhP6nl2kHRukFjN4kIHzP3JAH9by8rBc
         vTNvTPrDNrc6akk4mfHgHJ7MVe0d0NB8sH/Y5Y/4x2Zdz9krz08sdHxicnn0z8o+LLhJ
         ehBuevKQBbvstMJ56ln88iGCzGVYlpz5K3DkPceh1yT894CULR9jI+XY1g3xodZTj97n
         s4pw==
X-Gm-Message-State: APjAAAXO+gTqj9oAX8mQI9/SD51mERsLvRug/Q5eH3PzIB1egyKeruyT
        uKEVcvtCy9ApsxcTMjcR+g0VpMutcNM=
X-Google-Smtp-Source: APXvYqxSfyrwGHp981aCa/TV+CmAV6x/hLD2DOML0vfNvLbEPoaz+GjUVwBv8Z8LGp/WrXHvprbAXQ==
X-Received: by 2002:a50:b14b:: with SMTP id l11mr113632326edd.76.1561043037914;
        Thu, 20 Jun 2019 08:03:57 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:57 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol structs and helpers
Date:   Thu, 20 Jun 2019 17:03:27 +0200
Message-Id: <20190620150337.7847-16-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

These are common private headers with IBNBD protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/ibnbd/ibnbd-log.h   |  59 +++++
 drivers/block/ibnbd/ibnbd-proto.h | 378 ++++++++++++++++++++++++++++++
 2 files changed, 437 insertions(+)
 create mode 100644 drivers/block/ibnbd/ibnbd-log.h
 create mode 100644 drivers/block/ibnbd/ibnbd-proto.h

diff --git a/drivers/block/ibnbd/ibnbd-log.h b/drivers/block/ibnbd/ibnbd-log.h
new file mode 100644
index 000000000000..7a7ac3908564
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-log.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
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
+#ifndef IBNBD_LOG_H
+#define IBNBD_LOG_H
+
+#include "ibnbd-clt.h"
+#include "ibnbd-srv.h"
+
+void unknown_type(void);
+
+#define ibnbd_log(fn, dev, fmt, ...) ({				\
+	__builtin_choose_expr(						\
+		__builtin_types_compatible_p(				\
+			typeof(dev), struct ibnbd_clt_dev *),		\
+		fn("<%s@%s> " fmt, (dev)->pathname,			\
+		(dev)->sess->sessname,					\
+		   ##__VA_ARGS__),					\
+		__builtin_choose_expr(					\
+			__builtin_types_compatible_p(typeof(dev),	\
+					struct ibnbd_srv_sess_dev *),	\
+			fn("<%s@%s>: " fmt, (dev)->pathname,		\
+			   (dev)->sess->sessname, ##__VA_ARGS__),	\
+			unknown_type()));				\
+})
+
+#define ibnbd_err(dev, fmt, ...)	\
+	ibnbd_log(pr_err, dev, fmt, ##__VA_ARGS__)
+#define ibnbd_err_rl(dev, fmt, ...)	\
+	ibnbd_log(pr_err_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define ibnbd_wrn(dev, fmt, ...)	\
+	ibnbd_log(pr_warn, dev, fmt, ##__VA_ARGS__)
+#define ibnbd_wrn_rl(dev, fmt, ...) \
+	ibnbd_log(pr_warn_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define ibnbd_info(dev, fmt, ...) \
+	ibnbd_log(pr_info, dev, fmt, ##__VA_ARGS__)
+#define ibnbd_info_rl(dev, fmt, ...) \
+	ibnbd_log(pr_info_ratelimited, dev, fmt, ##__VA_ARGS__)
+
+#endif /* IBNBD_LOG_H */
diff --git a/drivers/block/ibnbd/ibnbd-proto.h b/drivers/block/ibnbd/ibnbd-proto.h
new file mode 100644
index 000000000000..e5a0a539447b
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-proto.h
@@ -0,0 +1,378 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Network Block Driver
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
+#ifndef IBNBD_PROTO_H
+#define IBNBD_PROTO_H
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/limits.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <rdma/ib.h>
+
+#define IBNBD_PROTO_VER_MAJOR 2
+#define IBNBD_PROTO_VER_MINOR 0
+
+#define IBNBD_PROTO_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
+			       __stringify(IBNBD_PROTO_VER_MINOR)
+
+#ifndef IBNBD_VER_STRING
+#define IBNBD_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
+			 __stringify(IBNBD_PROTO_VER_MINOR)
+#endif
+
+/* TODO: should be configurable */
+#define IBTRS_PORT 1234
+
+/**
+ * enum ibnbd_msg_types - IBNBD message types
+ * @IBNBD_MSG_SESS_INFO:	initial session info from client to server
+ * @IBNBD_MSG_SESS_INFO_RSP:	initial session info from server to client
+ * @IBNBD_MSG_OPEN:		open (map) device request
+ * @IBNBD_MSG_OPEN_RSP:		response to an @IBNBD_MSG_OPEN
+ * @IBNBD_MSG_IO:		block IO request operation
+ * @IBNBD_MSG_CLOSE:		close (unmap) device request
+ */
+enum ibnbd_msg_type {
+	IBNBD_MSG_SESS_INFO,
+	IBNBD_MSG_SESS_INFO_RSP,
+	IBNBD_MSG_OPEN,
+	IBNBD_MSG_OPEN_RSP,
+	IBNBD_MSG_IO,
+	IBNBD_MSG_CLOSE,
+};
+
+/**
+ * struct ibnbd_msg_hdr - header of IBNBD messages
+ * @type:	Message type, valid values see: enum ibnbd_msg_types
+ */
+struct ibnbd_msg_hdr {
+	__le16		type;
+	__le16		__padding;
+};
+
+enum ibnbd_access_mode {
+	IBNBD_ACCESS_RO,
+	IBNBD_ACCESS_RW,
+	IBNBD_ACCESS_MIGRATION,
+};
+
+#define _IBNBD_FILEIO  0
+#define _IBNBD_BLOCKIO 1
+#define _IBNBD_AUTOIO  2
+
+enum ibnbd_io_mode {
+	IBNBD_FILEIO = _IBNBD_FILEIO,
+	IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
+	IBNBD_AUTOIO = _IBNBD_AUTOIO,
+};
+
+/**
+ * struct ibnbd_msg_sess_info - initial session info from client to server
+ * @hdr:		message header
+ * @ver:		IBNBD protocol version
+ */
+struct ibnbd_msg_sess_info {
+	struct ibnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct ibnbd_msg_sess_info_rsp - initial session info from server to client
+ * @hdr:		message header
+ * @ver:		IBNBD protocol version
+ */
+struct ibnbd_msg_sess_info_rsp {
+	struct ibnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct ibnbd_msg_open - request to open a remote device.
+ * @hdr:		message header
+ * @access_mode:	the mode to open remote device, valid values see:
+ *			enum ibnbd_access_mode
+ * @io_mode:		Open volume on server as block device or as file
+ * @device_name:	device path on remote side
+ */
+struct ibnbd_msg_open {
+	struct ibnbd_msg_hdr hdr;
+	u8		access_mode;
+	u8		io_mode;
+	s8		dev_name[NAME_MAX];
+	u8		__padding[3];
+};
+
+/**
+ * struct ibnbd_msg_close - request to close a remote device.
+ * @hdr:	message header
+ * @device_id:	device_id on server side to identify the device
+ */
+struct ibnbd_msg_close {
+	struct ibnbd_msg_hdr hdr;
+	__le32		device_id;
+};
+
+/**
+ * struct ibnbd_msg_open_rsp - response message to IBNBD_MSG_OPEN
+ * @hdr:		message header
+ * @nsectors:		number of sectors
+ * @device_id:		device_id on server side to identify the device
+ * @queue_flags:	queue_flags of the device on server side
+ * @max_hw_sectors:	max hardware sectors in the usual 512b unit
+ * @max_write_same_sectors: max sectors for WRITE SAME in the 512b unit
+ * @max_discard_sectors: max. sectors that can be discarded at once
+ * @discard_granularity: size of the internal discard allocation unit
+ * @discard_alignment: offset from internal allocation assignment
+ * @physical_block_size: physical block size device supports
+ * @logical_block_size: logical block size device supports
+ * @max_segments:	max segments hardware support in one transfer
+ * @secure_discard:	supports secure discard
+ * @rotation:		is a rotational disc?
+ * @io_mode:		io_mode device is opened.
+ */
+struct ibnbd_msg_open_rsp {
+	struct ibnbd_msg_hdr	hdr;
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
+	u8			io_mode;
+	u8			__padding[10];
+};
+
+/**
+ * struct ibnbd_msg_io_old - message for I/O read/write for 
+ * ver < IBNBD_PROTO_VER_MAJOR
+ * This structure is there only to know the size of the "old" message format
+ * @hdr:	message header
+ * @device_id:	device_id on server side to find the right device
+ * @sector:	bi_sector attribute from struct bio
+ * @rw:		bitmask, valid values are defined in enum ibnbd_io_flags
+ * @bi_size:    number of bytes for I/O read/write
+ * @prio:       priority
+ */
+struct ibnbd_msg_io_old {
+	struct ibnbd_msg_hdr hdr;
+	__le32		device_id;
+	__le64		sector;
+	__le32		rw;
+	__le32		bi_size;
+};
+
+/**
+ * struct ibnbd_msg_io - message for I/O read/write
+ * @hdr:	message header
+ * @device_id:	device_id on server side to find the right device
+ * @sector:	bi_sector attribute from struct bio
+ * @rw:		bitmask, valid values are defined in enum ibnbd_io_flags
+ * @bi_size:    number of bytes for I/O read/write
+ * @prio:       priority
+ */
+struct ibnbd_msg_io {
+	struct ibnbd_msg_hdr hdr;
+	__le32		device_id;
+	__le64		sector;
+	__le32		rw;
+	__le32		bi_size;
+	__le16		prio;
+};
+
+#define IBNBD_OP_BITS  8
+#define IBNBD_OP_MASK  ((1 << IBNBD_OP_BITS) - 1)
+
+/**
+ * enum ibnbd_io_flags - IBNBD request types from rq_flag_bits
+ * @IBNBD_OP_READ:	     read sectors from the device
+ * @IBNBD_OP_WRITE:	     write sectors to the device
+ * @IBNBD_OP_FLUSH:	     flush the volatile write cache
+ * @IBNBD_OP_DISCARD:        discard sectors
+ * @IBNBD_OP_SECURE_ERASE:   securely erase sectors
+ * @IBNBD_OP_WRITE_SAME:     write the same sectors many times
+
+ * @IBNBD_F_SYNC:	     request is sync (sync write or read)
+ * @IBNBD_F_FUA:             forced unit access
+ */
+enum ibnbd_io_flags {
+
+	/* Operations */
+
+	IBNBD_OP_READ		= 0,
+	IBNBD_OP_WRITE		= 1,
+	IBNBD_OP_FLUSH		= 2,
+	IBNBD_OP_DISCARD	= 3,
+	IBNBD_OP_SECURE_ERASE	= 4,
+	IBNBD_OP_WRITE_SAME	= 5,
+
+	IBNBD_OP_LAST,
+
+	/* Flags */
+
+	IBNBD_F_SYNC  = 1<<(IBNBD_OP_BITS + 0),
+	IBNBD_F_FUA   = 1<<(IBNBD_OP_BITS + 1),
+
+	IBNBD_F_ALL   = (IBNBD_F_SYNC | IBNBD_F_FUA)
+
+};
+
+static inline u32 ibnbd_op(u32 flags)
+{
+	return (flags & IBNBD_OP_MASK);
+}
+
+static inline u32 ibnbd_flags(u32 flags)
+{
+	return (flags & ~IBNBD_OP_MASK);
+}
+
+static inline bool ibnbd_flags_supported(u32 flags)
+{
+	u32 op;
+
+	op = ibnbd_op(flags);
+	flags = ibnbd_flags(flags);
+
+	if (op >= IBNBD_OP_LAST)
+		return false;
+	if (flags & ~IBNBD_F_ALL)
+		return false;
+
+	return true;
+}
+
+static inline u32 ibnbd_to_bio_flags(u32 ibnbd_flags)
+{
+	u32 bio_flags;
+
+	switch (ibnbd_op(ibnbd_flags)) {
+	case IBNBD_OP_READ:
+		bio_flags = REQ_OP_READ;
+		break;
+	case IBNBD_OP_WRITE:
+		bio_flags = REQ_OP_WRITE;
+		break;
+	case IBNBD_OP_FLUSH:
+		bio_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
+		break;
+	case IBNBD_OP_DISCARD:
+		bio_flags = REQ_OP_DISCARD;
+		break;
+	case IBNBD_OP_SECURE_ERASE:
+		bio_flags = REQ_OP_SECURE_ERASE;
+		break;
+	case IBNBD_OP_WRITE_SAME:
+		bio_flags = REQ_OP_WRITE_SAME;
+		break;
+	default:
+		WARN(1, "Unknown IBNBD type: %d (flags %d)\n",
+		     ibnbd_op(ibnbd_flags), ibnbd_flags);
+		bio_flags = 0;
+	}
+
+	if (ibnbd_flags & IBNBD_F_SYNC)
+		bio_flags |= REQ_SYNC;
+
+	if (ibnbd_flags & IBNBD_F_FUA)
+		bio_flags |= REQ_FUA;
+
+	return bio_flags;
+}
+
+static inline u32 rq_to_ibnbd_flags(struct request *rq)
+{
+	u32 ibnbd_flags;
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		ibnbd_flags = IBNBD_OP_READ;
+		break;
+	case REQ_OP_WRITE:
+		ibnbd_flags = IBNBD_OP_WRITE;
+		break;
+	case REQ_OP_DISCARD:
+		ibnbd_flags = IBNBD_OP_DISCARD;
+		break;
+	case REQ_OP_SECURE_ERASE:
+		ibnbd_flags = IBNBD_OP_SECURE_ERASE;
+		break;
+	case REQ_OP_WRITE_SAME:
+		ibnbd_flags = IBNBD_OP_WRITE_SAME;
+		break;
+	case REQ_OP_FLUSH:
+		ibnbd_flags = IBNBD_OP_FLUSH;
+		break;
+	default:
+		WARN(1, "Unknown request type %d (flags %llu)\n",
+		     req_op(rq), (unsigned long long)rq->cmd_flags);
+		ibnbd_flags = 0;
+	}
+
+	if (op_is_sync(rq->cmd_flags))
+		ibnbd_flags |= IBNBD_F_SYNC;
+
+	if (op_is_flush(rq->cmd_flags))
+		ibnbd_flags |= IBNBD_F_FUA;
+
+	return ibnbd_flags;
+}
+
+static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
+{
+	switch (mode) {
+	case IBNBD_FILEIO:
+		return "fileio";
+	case IBNBD_BLOCKIO:
+		return "blockio";
+	case IBNBD_AUTOIO:
+		return "autoio";
+	default:
+		return "unknown";
+	}
+}
+
+static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
+{
+	switch (mode) {
+	case IBNBD_ACCESS_RO:
+		return "ro";
+	case IBNBD_ACCESS_RW:
+		return "rw";
+	case IBNBD_ACCESS_MIGRATION:
+		return "migration";
+	default:
+		return "unknown";
+	}
+}
+
+#endif /* IBNBD_PROTO_H */
-- 
2.17.1

