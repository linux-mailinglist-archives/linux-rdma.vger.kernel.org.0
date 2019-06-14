Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82A45FB9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfFNN6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbfFNN6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EDoorI096950
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4c5f2cyr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:57:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 14 Jun 2019 14:57:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 14:57:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDvrTE58327122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:57:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3240642045;
        Fri, 14 Jun 2019 13:57:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07E1942049;
        Fri, 14 Jun 2019 13:57:53 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:57:52 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 01/11] iWarp wire packet format
Date:   Fri, 14 Jun 2019 15:57:40 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190614135750.15874-1-bmt@zurich.ibm.com>
References: <20190614135750.15874-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061413-0008-0000-0000-000002F3C672
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0009-0000-0000-00002260D0FC
Message-Id: <20190614135750.15874-2-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/iwarp.h | 380 ++++++++++++++++++++++++++++++
 1 file changed, 380 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/iwarp.h

diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
new file mode 100644
index 000000000000..e8a04d9c89cb
--- /dev/null
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -0,0 +1,380 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#ifndef _IWARP_H
+#define _IWARP_H
+
+#include <rdma/rdma_user_cm.h> /* RDMA_MAX_PRIVATE_DATA */
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#define RDMAP_VERSION 1
+#define DDP_VERSION 1
+#define MPA_REVISION_1 1
+#define MPA_REVISION_2 2
+#define MPA_MAX_PRIVDATA RDMA_MAX_PRIVATE_DATA
+#define MPA_KEY_REQ "MPA ID Req Frame"
+#define MPA_KEY_REP "MPA ID Rep Frame"
+#define MPA_IRD_ORD_MASK 0x3fff
+
+struct mpa_rr_params {
+	__be16 bits;
+	__be16 pd_len;
+};
+
+/*
+ * MPA request/response header bits & fields
+ */
+enum {
+	MPA_RR_FLAG_MARKERS = cpu_to_be16(0x8000),
+	MPA_RR_FLAG_CRC = cpu_to_be16(0x4000),
+	MPA_RR_FLAG_REJECT = cpu_to_be16(0x2000),
+	MPA_RR_FLAG_ENHANCED = cpu_to_be16(0x1000),
+	MPA_RR_FLAG_GSO_EXP = cpu_to_be16(0x0800),
+	MPA_RR_MASK_REVISION = cpu_to_be16(0x00ff)
+};
+
+/*
+ * MPA request/reply header
+ */
+struct mpa_rr {
+	__u8 key[16];
+	struct mpa_rr_params params;
+};
+
+static inline void __mpa_rr_set_revision(__be16 *bits, u8 rev)
+{
+	*bits = (*bits & ~MPA_RR_MASK_REVISION) |
+		(cpu_to_be16(rev) & MPA_RR_MASK_REVISION);
+}
+
+static inline u8 __mpa_rr_revision(__be16 mpa_rr_bits)
+{
+	__be16 rev = mpa_rr_bits & MPA_RR_MASK_REVISION;
+
+	return be16_to_cpu(rev);
+}
+
+enum mpa_v2_ctrl {
+	MPA_V2_PEER_TO_PEER = cpu_to_be16(0x8000),
+	MPA_V2_ZERO_LENGTH_RTR = cpu_to_be16(0x4000),
+	MPA_V2_RDMA_WRITE_RTR = cpu_to_be16(0x8000),
+	MPA_V2_RDMA_READ_RTR = cpu_to_be16(0x4000),
+	MPA_V2_RDMA_NO_RTR = cpu_to_be16(0x0000),
+	MPA_V2_MASK_IRD_ORD = cpu_to_be16(0x3fff)
+};
+
+struct mpa_v2_data {
+	__be16 ird;
+	__be16 ord;
+};
+
+struct mpa_marker {
+	__be16 rsvd;
+	__be16 fpdu_hmd; /* FPDU header-marker distance (= MPA's FPDUPTR) */
+};
+
+/*
+ * maximum MPA trailer
+ */
+struct mpa_trailer {
+	__u8 pad[4];
+	__be32 crc;
+};
+
+#define MPA_HDR_SIZE 2
+#define MPA_CRC_SIZE 4
+
+/*
+ * Common portion of iWARP headers (MPA, DDP, RDMAP)
+ * for any FPDU
+ */
+struct iwarp_ctrl {
+	__be16 mpa_len;
+	__be16 ddp_rdmap_ctrl;
+};
+
+/*
+ * DDP/RDMAP Hdr bits & fields
+ */
+enum {
+	DDP_FLAG_TAGGED = cpu_to_be16(0x8000),
+	DDP_FLAG_LAST = cpu_to_be16(0x4000),
+	DDP_MASK_RESERVED = cpu_to_be16(0x3C00),
+	DDP_MASK_VERSION = cpu_to_be16(0x0300),
+	RDMAP_MASK_VERSION = cpu_to_be16(0x00C0),
+	RDMAP_MASK_RESERVED = cpu_to_be16(0x0030),
+	RDMAP_MASK_OPCODE = cpu_to_be16(0x000f)
+};
+
+static inline u8 __ddp_get_version(struct iwarp_ctrl *ctrl)
+{
+	return be16_to_cpu(ctrl->ddp_rdmap_ctrl & DDP_MASK_VERSION) >> 8;
+}
+
+static inline void __ddp_set_version(struct iwarp_ctrl *ctrl, u8 version)
+{
+	ctrl->ddp_rdmap_ctrl =
+		(ctrl->ddp_rdmap_ctrl & ~DDP_MASK_VERSION) |
+		(cpu_to_be16((u16)version << 8) & DDP_MASK_VERSION);
+}
+
+static inline u8 __rdmap_get_version(struct iwarp_ctrl *ctrl)
+{
+	__be16 ver = ctrl->ddp_rdmap_ctrl & RDMAP_MASK_VERSION;
+
+	return be16_to_cpu(ver) >> 6;
+}
+
+static inline void __rdmap_set_version(struct iwarp_ctrl *ctrl, u8 version)
+{
+	ctrl->ddp_rdmap_ctrl = (ctrl->ddp_rdmap_ctrl & ~RDMAP_MASK_VERSION) |
+			       (cpu_to_be16(version << 6) & RDMAP_MASK_VERSION);
+}
+
+static inline u8 __rdmap_get_opcode(struct iwarp_ctrl *ctrl)
+{
+	return be16_to_cpu(ctrl->ddp_rdmap_ctrl & RDMAP_MASK_OPCODE);
+}
+
+static inline void __rdmap_set_opcode(struct iwarp_ctrl *ctrl, u8 opcode)
+{
+	ctrl->ddp_rdmap_ctrl = (ctrl->ddp_rdmap_ctrl & ~RDMAP_MASK_OPCODE) |
+			       (cpu_to_be16(opcode) & RDMAP_MASK_OPCODE);
+}
+
+struct iwarp_rdma_write {
+	struct iwarp_ctrl ctrl;
+	__be32 sink_stag;
+	__be64 sink_to;
+};
+
+struct iwarp_rdma_rreq {
+	struct iwarp_ctrl ctrl;
+	__be32 rsvd;
+	__be32 ddp_qn;
+	__be32 ddp_msn;
+	__be32 ddp_mo;
+	__be32 sink_stag;
+	__be64 sink_to;
+	__be32 read_size;
+	__be32 source_stag;
+	__be64 source_to;
+};
+
+struct iwarp_rdma_rresp {
+	struct iwarp_ctrl ctrl;
+	__be32 sink_stag;
+	__be64 sink_to;
+};
+
+struct iwarp_send {
+	struct iwarp_ctrl ctrl;
+	__be32 rsvd;
+	__be32 ddp_qn;
+	__be32 ddp_msn;
+	__be32 ddp_mo;
+};
+
+struct iwarp_send_inv {
+	struct iwarp_ctrl ctrl;
+	__be32 inval_stag;
+	__be32 ddp_qn;
+	__be32 ddp_msn;
+	__be32 ddp_mo;
+};
+
+struct iwarp_terminate {
+	struct iwarp_ctrl ctrl;
+	__be32 rsvd;
+	__be32 ddp_qn;
+	__be32 ddp_msn;
+	__be32 ddp_mo;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__be32 layer : 4;
+	__be32 etype : 4;
+	__be32 ecode : 8;
+	__be32 flag_m : 1;
+	__be32 flag_d : 1;
+	__be32 flag_r : 1;
+	__be32 reserved : 13;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__be32 reserved : 13;
+	__be32 flag_r : 1;
+	__be32 flag_d : 1;
+	__be32 flag_m : 1;
+	__be32 ecode : 8;
+	__be32 etype : 4;
+	__be32 layer : 4;
+#else
+#error "undefined byte order"
+#endif
+};
+
+/*
+ * Terminate Hdr bits & fields
+ */
+enum {
+	TERM_MASK_LAYER = cpu_to_be32(0xf0000000),
+	TERM_MASK_ETYPE = cpu_to_be32(0x0f000000),
+	TERM_MASK_ECODE = cpu_to_be32(0x00ff0000),
+	TERM_FLAG_M = cpu_to_be32(0x00008000),
+	TERM_FLAG_D = cpu_to_be32(0x00004000),
+	TERM_FLAG_R = cpu_to_be32(0x00002000),
+	TERM_MASK_RESVD = cpu_to_be32(0x00001fff)
+};
+
+static inline u8 __rdmap_term_layer(struct iwarp_terminate *term)
+{
+	return term->layer;
+}
+
+static inline void __rdmap_term_set_layer(struct iwarp_terminate *term,
+					  u8 layer)
+{
+	term->layer = layer & 0xf;
+}
+
+static inline u8 __rdmap_term_etype(struct iwarp_terminate *term)
+{
+	return term->etype;
+}
+
+static inline void __rdmap_term_set_etype(struct iwarp_terminate *term,
+					  u8 etype)
+{
+	term->etype = etype & 0xf;
+}
+
+static inline u8 __rdmap_term_ecode(struct iwarp_terminate *term)
+{
+	return term->ecode;
+}
+
+static inline void __rdmap_term_set_ecode(struct iwarp_terminate *term,
+					  u8 ecode)
+{
+	term->ecode = ecode;
+}
+
+/*
+ * Common portion of iWARP headers (MPA, DDP, RDMAP)
+ * for an FPDU carrying an untagged DDP segment
+ */
+struct iwarp_ctrl_untagged {
+	struct iwarp_ctrl ctrl;
+	__be32 rsvd;
+	__be32 ddp_qn;
+	__be32 ddp_msn;
+	__be32 ddp_mo;
+};
+
+/*
+ * Common portion of iWARP headers (MPA, DDP, RDMAP)
+ * for an FPDU carrying a tagged DDP segment
+ */
+struct iwarp_ctrl_tagged {
+	struct iwarp_ctrl ctrl;
+	__be32 ddp_stag;
+	__be64 ddp_to;
+};
+
+union iwarp_hdr {
+	struct iwarp_ctrl ctrl;
+	struct iwarp_ctrl_untagged c_untagged;
+	struct iwarp_ctrl_tagged c_tagged;
+	struct iwarp_rdma_write rwrite;
+	struct iwarp_rdma_rreq rreq;
+	struct iwarp_rdma_rresp rresp;
+	struct iwarp_terminate terminate;
+	struct iwarp_send send;
+	struct iwarp_send_inv send_inv;
+};
+
+enum term_elayer {
+	TERM_ERROR_LAYER_RDMAP = 0x00,
+	TERM_ERROR_LAYER_DDP = 0x01,
+	TERM_ERROR_LAYER_LLP = 0x02 /* eg., MPA */
+};
+
+enum ddp_etype {
+	DDP_ETYPE_CATASTROPHIC = 0x0,
+	DDP_ETYPE_TAGGED_BUF = 0x1,
+	DDP_ETYPE_UNTAGGED_BUF = 0x2,
+	DDP_ETYPE_RSVD = 0x3
+};
+
+enum ddp_ecode {
+	/* unspecified, set to zero */
+	DDP_ECODE_CATASTROPHIC = 0x00,
+	/* Tagged Buffer Errors */
+	DDP_ECODE_T_INVALID_STAG = 0x00,
+	DDP_ECODE_T_BASE_BOUNDS = 0x01,
+	DDP_ECODE_T_STAG_NOT_ASSOC = 0x02,
+	DDP_ECODE_T_TO_WRAP = 0x03,
+	DDP_ECODE_T_VERSION = 0x04,
+	/* Untagged Buffer Errors */
+	DDP_ECODE_UT_INVALID_QN = 0x01,
+	DDP_ECODE_UT_INVALID_MSN_NOBUF = 0x02,
+	DDP_ECODE_UT_INVALID_MSN_RANGE = 0x03,
+	DDP_ECODE_UT_INVALID_MO = 0x04,
+	DDP_ECODE_UT_MSG_TOOLONG = 0x05,
+	DDP_ECODE_UT_VERSION = 0x06
+};
+
+enum rdmap_untagged_qn {
+	RDMAP_UNTAGGED_QN_SEND = 0,
+	RDMAP_UNTAGGED_QN_RDMA_READ = 1,
+	RDMAP_UNTAGGED_QN_TERMINATE = 2,
+	RDMAP_UNTAGGED_QN_COUNT = 3
+};
+
+enum rdmap_etype {
+	RDMAP_ETYPE_CATASTROPHIC = 0x0,
+	RDMAP_ETYPE_REMOTE_PROTECTION = 0x1,
+	RDMAP_ETYPE_REMOTE_OPERATION = 0x2
+};
+
+enum rdmap_ecode {
+	RDMAP_ECODE_INVALID_STAG = 0x00,
+	RDMAP_ECODE_BASE_BOUNDS = 0x01,
+	RDMAP_ECODE_ACCESS_RIGHTS = 0x02,
+	RDMAP_ECODE_STAG_NOT_ASSOC = 0x03,
+	RDMAP_ECODE_TO_WRAP = 0x04,
+	RDMAP_ECODE_VERSION = 0x05,
+	RDMAP_ECODE_OPCODE = 0x06,
+	RDMAP_ECODE_CATASTROPHIC_STREAM = 0x07,
+	RDMAP_ECODE_CATASTROPHIC_GLOBAL = 0x08,
+	RDMAP_ECODE_CANNOT_INVALIDATE = 0x09,
+	RDMAP_ECODE_UNSPECIFIED = 0xff
+};
+
+enum llp_ecode {
+	LLP_ECODE_TCP_STREAM_LOST = 0x01, /* How to transfer this ?? */
+	LLP_ECODE_RECEIVED_CRC = 0x02,
+	LLP_ECODE_FPDU_START = 0x03,
+	LLP_ECODE_INVALID_REQ_RESP = 0x04,
+
+	/* Errors for Enhanced Connection Establishment only */
+	LLP_ECODE_LOCAL_CATASTROPHIC = 0x05,
+	LLP_ECODE_INSUFFICIENT_IRD = 0x06,
+	LLP_ECODE_NO_MATCHING_RTR = 0x07
+};
+
+enum llp_etype { LLP_ETYPE_MPA = 0x00 };
+
+enum rdma_opcode {
+	RDMAP_RDMA_WRITE = 0x0,
+	RDMAP_RDMA_READ_REQ = 0x1,
+	RDMAP_RDMA_READ_RESP = 0x2,
+	RDMAP_SEND = 0x3,
+	RDMAP_SEND_INVAL = 0x4,
+	RDMAP_SEND_SE = 0x5,
+	RDMAP_SEND_SE_INVAL = 0x6,
+	RDMAP_TERMINATE = 0x7,
+	RDMAP_NOT_SUPPORTED = RDMAP_TERMINATE + 1
+};
+
+#endif
-- 
2.17.2

