Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0B380D2B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhENPdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:33:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:25047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhENPdS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 11:33:18 -0400
IronPort-SDR: 2EcO8wJmbSgiUxtx+dmrQyTazZqQFJBqOLDov1nh8ttW61Pm6thSaSReUZIwpx5C3dxy6d5iNC
 0hxM8i9nJuiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197107485"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197107485"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:32:06 -0700
IronPort-SDR: dzCkvcA/jKuEN+CC4Ah8MYw12W8UvCdfx6NKN4Sqv5dWpDkTmtoKQ9BXyy13y86+nvg26BEnFx
 Dg5ZMRCI+pbg==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="624738920"
Received: from sremersa-mobl1.amr.corp.intel.com (HELO tenikolo-mobl1.amr.corp.intel.com) ([10.209.178.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:32:05 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH 4/5] rdma-core/irdma: Add library setup and utility definitions
Date:   Fri, 14 May 2021 10:31:34 -0500
Message-Id: <20210514153135.1972-5-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210514153135.1972-1-tatyana.e.nikolova@intel.com>
References: <20210514153135.1972-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add definitions to allocate context for user apps,
recognize HW devices and exchange context with device,
set up callback tables and device attributes and add
utility definitions and headers.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 providers/irdma/defs.h        | 334 ++++++++++++++++++++++++++++++++
 providers/irdma/i40e_devids.h |  36 ++++
 providers/irdma/i40iw_hw.h    |  31 +++
 providers/irdma/ice_devids.h  |  59 ++++++
 providers/irdma/osdep.h       |  21 ++
 providers/irdma/status.h      |  72 +++++++
 providers/irdma/umain.c       | 233 ++++++++++++++++++++++
 providers/irdma/umain.h       | 204 ++++++++++++++++++++
 providers/irdma/user.h        | 439 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1429 insertions(+)
 create mode 100644 providers/irdma/defs.h
 create mode 100644 providers/irdma/i40e_devids.h
 create mode 100644 providers/irdma/i40iw_hw.h
 create mode 100644 providers/irdma/ice_devids.h
 create mode 100644 providers/irdma/osdep.h
 create mode 100644 providers/irdma/status.h
 create mode 100644 providers/irdma/umain.c
 create mode 100644 providers/irdma/umain.h
 create mode 100644 providers/irdma/user.h

diff --git a/providers/irdma/defs.h b/providers/irdma/defs.h
new file mode 100644
index 0000000..9d27c72
--- /dev/null
+++ b/providers/irdma/defs.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2021 Intel Corporation */
+#ifndef IRDMA_DEFS_H
+#define IRDMA_DEFS_H
+
+#include "osdep.h"
+
+
+#define IRDMA_QP_TYPE_IWARP	1
+#define IRDMA_QP_TYPE_UDA	2
+#define IRDMA_QP_TYPE_ROCE_RC	3
+#define IRDMA_QP_TYPE_ROCE_UD	4
+
+#define IRDMA_HW_PAGE_SIZE	4096
+#define IRDMA_HW_PAGE_SHIFT	12
+#define IRDMA_CQE_QTYPE_RQ	0
+#define IRDMA_CQE_QTYPE_SQ	1
+
+#define IRDMA_QP_SW_MIN_WQSIZE	8u /* in WRs*/
+#define IRDMA_QP_WQE_MIN_SIZE	32
+#define IRDMA_QP_WQE_MAX_SIZE	256
+#define IRDMA_QP_WQE_MIN_QUANTA 1
+#define IRDMA_MAX_RQ_WQE_SHIFT_GEN1 2
+#define IRDMA_MAX_RQ_WQE_SHIFT_GEN2 3
+
+#define IRDMA_SQ_RSVD	258
+#define IRDMA_RQ_RSVD	1
+
+#define IRDMA_FEATURE_RTS_AE			1ULL
+#define IRDMA_FEATURE_CQ_RESIZE			2ULL
+#define IRDMAQP_OP_RDMA_WRITE			0x00
+#define IRDMAQP_OP_RDMA_READ			0x01
+#define IRDMAQP_OP_RDMA_SEND			0x03
+#define IRDMAQP_OP_RDMA_SEND_INV		0x04
+#define IRDMAQP_OP_RDMA_SEND_SOL_EVENT		0x05
+#define IRDMAQP_OP_RDMA_SEND_SOL_EVENT_INV	0x06
+#define IRDMAQP_OP_BIND_MW			0x08
+#define IRDMAQP_OP_FAST_REGISTER		0x09
+#define IRDMAQP_OP_LOCAL_INVALIDATE		0x0a
+#define IRDMAQP_OP_RDMA_READ_LOC_INV		0x0b
+#define IRDMAQP_OP_NOP				0x0c
+
+#define IRDMA_CQPHC_QPCTX GENMASK_ULL(63, 0)
+#define IRDMA_QP_DBSA_HW_SQ_TAIL GENMASK_ULL(14, 0)
+#define IRDMA_CQ_DBSA_CQEIDX GENMASK_ULL(19, 0)
+#define IRDMA_CQ_DBSA_SW_CQ_SELECT GENMASK_ULL(13, 0)
+#define IRDMA_CQ_DBSA_ARM_NEXT BIT_ULL(14)
+#define IRDMA_CQ_DBSA_ARM_NEXT_SE BIT_ULL(15)
+#define IRDMA_CQ_DBSA_ARM_SEQ_NUM GENMASK_ULL(17, 16)
+
+/* CQP and iWARP Completion Queue */
+#define IRDMA_CQ_QPCTX IRDMA_CQPHC_QPCTX
+
+#define IRDMA_CQ_MINERR GENMASK_ULL(15, 0)
+#define IRDMA_CQ_MAJERR GENMASK_ULL(31, 16)
+#define IRDMA_CQ_WQEIDX GENMASK_ULL(46, 32)
+#define IRDMA_CQ_EXTCQE BIT_ULL(50)
+#define IRDMA_OOO_CMPL BIT_ULL(54)
+#define IRDMA_CQ_ERROR BIT_ULL(55)
+#define IRDMA_CQ_SQ BIT_ULL(62)
+
+#define IRDMA_CQ_VALID BIT_ULL(63)
+#define IRDMA_CQ_IMMVALID BIT_ULL(62)
+#define IRDMA_CQ_UDSMACVALID BIT_ULL(61)
+#define IRDMA_CQ_UDVLANVALID BIT_ULL(60)
+#define IRDMA_CQ_UDSMAC GENMASK_ULL(47, 0)
+#define IRDMA_CQ_UDVLAN GENMASK_ULL(63, 48)
+
+#define IRDMA_CQ_IMMDATA_S 0
+#define IRDMA_CQ_IMMDATA_M (0xffffffffffffffffULL << IRDMA_CQ_IMMVALID_S)
+#define IRDMA_CQ_IMMDATALOW32 GENMASK_ULL(31, 0)
+#define IRDMA_CQ_IMMDATAUP32 GENMASK_ULL(63, 32)
+#define IRDMACQ_PAYLDLEN GENMASK_ULL(31, 0)
+#define IRDMACQ_TCPSEQNUMRTT GENMASK_ULL(63, 32)
+#define IRDMACQ_INVSTAG GENMASK_ULL(31, 0)
+#define IRDMACQ_QPID GENMASK_ULL(55, 32)
+
+#define IRDMACQ_UDSRCQPN GENMASK_ULL(31, 0)
+#define IRDMACQ_PSHDROP BIT_ULL(51)
+#define IRDMACQ_STAG BIT_ULL(53)
+#define IRDMACQ_IPV4 BIT_ULL(53)
+#define IRDMACQ_SOEVENT BIT_ULL(54)
+#define IRDMACQ_OP GENMASK_ULL(61, 56)
+
+/* Manage Push Page - MPP */
+#define IRDMA_INVALID_PUSH_PAGE_INDEX_GEN_1 0xffff
+#define IRDMA_INVALID_PUSH_PAGE_INDEX 0xffffffff
+
+#define IRDMAQPSQ_OPCODE GENMASK_ULL(37, 32)
+#define IRDMAQPSQ_COPY_HOST_PBL BIT_ULL(43)
+#define IRDMAQPSQ_ADDFRAGCNT GENMASK_ULL(41, 38)
+#define IRDMAQPSQ_PUSHWQE BIT_ULL(56)
+#define IRDMAQPSQ_STREAMMODE BIT_ULL(58)
+#define IRDMAQPSQ_WAITFORRCVPDU BIT_ULL(59)
+#define IRDMAQPSQ_READFENCE BIT_ULL(60)
+#define IRDMAQPSQ_LOCALFENCE BIT_ULL(61)
+#define IRDMAQPSQ_UDPHEADER BIT_ULL(61)
+#define IRDMAQPSQ_L4LEN GENMASK_ULL(45, 42)
+#define IRDMAQPSQ_SIGCOMPL BIT_ULL(62)
+#define IRDMAQPSQ_VALID BIT_ULL(63)
+
+#define IRDMAQPSQ_FRAG_TO IRDMA_CQPHC_QPCTX
+#define IRDMAQPSQ_FRAG_VALID BIT_ULL(63)
+#define IRDMAQPSQ_FRAG_LEN GENMASK_ULL(62, 32)
+#define IRDMAQPSQ_FRAG_STAG GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_GEN1_FRAG_LEN GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_GEN1_FRAG_STAG GENMASK_ULL(63, 32)
+#define IRDMAQPSQ_REMSTAGINV GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_DESTQKEY GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_DESTQPN GENMASK_ULL(55, 32)
+#define IRDMAQPSQ_AHID GENMASK_ULL(16, 0)
+#define IRDMAQPSQ_INLINEDATAFLAG BIT_ULL(57)
+
+#define IRDMA_INLINE_VALID_S 7
+#define IRDMAQPSQ_INLINEDATALEN GENMASK_ULL(55, 48)
+#define IRDMAQPSQ_IMMDATAFLAG BIT_ULL(47)
+#define IRDMAQPSQ_REPORTRTT BIT_ULL(46)
+
+#define IRDMAQPSQ_IMMDATA GENMASK_ULL(63, 0)
+#define IRDMAQPSQ_REMSTAG GENMASK_ULL(31, 0)
+
+#define IRDMAQPSQ_REMTO IRDMA_CQPHC_QPCTX
+
+#define IRDMAQPSQ_STAGRIGHTS GENMASK_ULL(52, 48)
+#define IRDMAQPSQ_VABASEDTO BIT_ULL(53)
+#define IRDMAQPSQ_MEMWINDOWTYPE BIT_ULL(54)
+
+#define IRDMAQPSQ_MWLEN IRDMA_CQPHC_QPCTX
+#define IRDMAQPSQ_PARENTMRSTAG GENMASK_ULL(63, 32)
+#define IRDMAQPSQ_MWSTAG GENMASK_ULL(31, 0)
+
+#define IRDMAQPSQ_BASEVA_TO_FBO IRDMA_CQPHC_QPCTX
+
+#define IRDMAQPSQ_LOCSTAG GENMASK_ULL(31, 0)
+
+/* iwarp QP RQ WQE common fields */
+#define IRDMAQPRQ_ADDFRAGCNT IRDMAQPSQ_ADDFRAGCNT
+#define IRDMAQPRQ_VALID IRDMAQPSQ_VALID
+#define IRDMAQPRQ_COMPLCTX IRDMA_CQPHC_QPCTX
+#define IRDMAQPRQ_FRAG_LEN IRDMAQPSQ_FRAG_LEN
+#define IRDMAQPRQ_STAG IRDMAQPSQ_FRAG_STAG
+#define IRDMAQPRQ_TO IRDMAQPSQ_FRAG_TO
+
+#define IRDMAPFINT_OICR_HMC_ERR_M BIT(26)
+#define IRDMAPFINT_OICR_PE_PUSH_M BIT(27)
+#define IRDMAPFINT_OICR_PE_CRITERR_M BIT(28)
+
+#define IRDMA_CQP_INIT_WQE(wqe) memset(wqe, 0, 64)
+
+#define IRDMA_GET_CURRENT_CQ_ELEM(_cq) \
+	( \
+		(_cq)->cq_base[IRDMA_RING_CURRENT_HEAD((_cq)->cq_ring)].buf  \
+	)
+#define IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(_cq) \
+	( \
+		((struct irdma_extended_cqe *) \
+		((_cq)->cq_base))[IRDMA_RING_CURRENT_HEAD((_cq)->cq_ring)].buf \
+	)
+
+#define IRDMA_RING_INIT(_ring, _size) \
+	{ \
+		(_ring).head = 0; \
+		(_ring).tail = 0; \
+		(_ring).size = (_size); \
+	}
+#define IRDMA_RING_SIZE(_ring) ((_ring).size)
+#define IRDMA_RING_CURRENT_HEAD(_ring) ((_ring).head)
+#define IRDMA_RING_CURRENT_TAIL(_ring) ((_ring).tail)
+
+#define IRDMA_RING_MOVE_HEAD(_ring, _retcode) \
+	{ \
+		register __u32 size; \
+		size = (_ring).size;  \
+		if (!IRDMA_RING_FULL_ERR(_ring)) { \
+			(_ring).head = ((_ring).head + 1) % size; \
+			(_retcode) = 0; \
+		} else { \
+			(_retcode) = IRDMA_ERR_RING_FULL; \
+		} \
+	}
+#define IRDMA_RING_MOVE_HEAD_BY_COUNT(_ring, _count, _retcode) \
+	{ \
+		register __u32 size; \
+		size = (_ring).size; \
+		if ((IRDMA_RING_USED_QUANTA(_ring) + (_count)) < size) { \
+			(_ring).head = ((_ring).head + (_count)) % size; \
+			(_retcode) = 0; \
+		} else { \
+			(_retcode) = IRDMA_ERR_RING_FULL; \
+		} \
+	}
+#define IRDMA_SQ_RING_MOVE_HEAD(_ring, _retcode) \
+	{ \
+		register __u32 size; \
+		size = (_ring).size;  \
+		if (!IRDMA_SQ_RING_FULL_ERR(_ring)) { \
+			(_ring).head = ((_ring).head + 1) % size; \
+			(_retcode) = 0; \
+		} else { \
+			(_retcode) = IRDMA_ERR_RING_FULL; \
+		} \
+	}
+#define IRDMA_SQ_RING_MOVE_HEAD_BY_COUNT(_ring, _count, _retcode) \
+	{ \
+		register __u32 size; \
+		size = (_ring).size; \
+		if ((IRDMA_RING_USED_QUANTA(_ring) + (_count)) < (size - 256)) { \
+			(_ring).head = ((_ring).head + (_count)) % size; \
+			(_retcode) = 0; \
+		} else { \
+			(_retcode) = IRDMA_ERR_RING_FULL; \
+		} \
+	}
+#define IRDMA_RING_MOVE_HEAD_BY_COUNT_NOCHECK(_ring, _count) \
+	(_ring).head = ((_ring).head + (_count)) % (_ring).size
+
+#define IRDMA_RING_MOVE_TAIL(_ring) \
+	(_ring).tail = ((_ring).tail + 1) % (_ring).size
+
+#define IRDMA_RING_MOVE_HEAD_NOCHECK(_ring) \
+	(_ring).head = ((_ring).head + 1) % (_ring).size
+
+#define IRDMA_RING_MOVE_TAIL_BY_COUNT(_ring, _count) \
+	(_ring).tail = ((_ring).tail + (_count)) % (_ring).size
+
+#define IRDMA_RING_SET_TAIL(_ring, _pos) \
+	(_ring).tail = (_pos) % (_ring).size
+
+#define IRDMA_RING_FULL_ERR(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 1))  \
+	)
+
+#define IRDMA_ERR_RING_FULL2(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 2))  \
+	)
+
+#define IRDMA_ERR_RING_FULL3(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 3))  \
+	)
+
+#define IRDMA_SQ_RING_FULL_ERR(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 257))  \
+	)
+
+#define IRDMA_ERR_SQ_RING_FULL2(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 258))  \
+	)
+#define IRDMA_ERR_SQ_RING_FULL3(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) == ((_ring).size - 259))  \
+	)
+#define IRDMA_RING_MORE_WORK(_ring) \
+	( \
+		(IRDMA_RING_USED_QUANTA(_ring) != 0) \
+	)
+
+#define IRDMA_RING_USED_QUANTA(_ring) \
+	( \
+		(((_ring).head + (_ring).size - (_ring).tail) % (_ring).size) \
+	)
+
+#define IRDMA_RING_FREE_QUANTA(_ring) \
+	( \
+		((_ring).size - IRDMA_RING_USED_QUANTA(_ring) - 1) \
+	)
+
+#define IRDMA_SQ_RING_FREE_QUANTA(_ring) \
+	( \
+		((_ring).size - IRDMA_RING_USED_QUANTA(_ring) - 257) \
+	)
+
+#define IRDMA_ATOMIC_RING_MOVE_HEAD(_ring, index, _retcode) \
+	{ \
+		index = IRDMA_RING_CURRENT_HEAD(_ring); \
+		IRDMA_RING_MOVE_HEAD(_ring, _retcode); \
+	}
+
+enum irdma_qp_wqe_size {
+	IRDMA_WQE_SIZE_32  = 32,
+	IRDMA_WQE_SIZE_64  = 64,
+	IRDMA_WQE_SIZE_96  = 96,
+	IRDMA_WQE_SIZE_128 = 128,
+	IRDMA_WQE_SIZE_256 = 256,
+};
+
+/**
+ * set_64bit_val - set 64 bit value to hw wqe
+ * @wqe_words: wqe addr to write
+ * @byte_index: index in wqe
+ * @val: value to write
+ **/
+static inline void set_64bit_val(__le64 *wqe_words, __u32 byte_index, __u64 val)
+{
+	wqe_words[byte_index >> 3] = htole64(val);
+}
+
+/**
+ * set_32bit_val - set 32 bit value to hw wqe
+ * @wqe_words: wqe addr to write
+ * @byte_index: index in wqe
+ * @val: value to write
+ **/
+static inline void set_32bit_val(__le32 *wqe_words, __u32 byte_index, __u32 val)
+{
+	wqe_words[byte_index >> 2] = htole32(val);
+}
+
+/**
+ * get_64bit_val - read 64 bit value from wqe
+ * @wqe_words: wqe addr
+ * @byte_index: index to read from
+ * @val: read value
+ **/
+static inline void get_64bit_val(__le64 *wqe_words, __u32 byte_index, __u64 *val)
+{
+	*val = le64toh(wqe_words[byte_index >> 3]);
+}
+
+/**
+ * get_32bit_val - read 32 bit value from wqe
+ * @wqe_words: wqe addr
+ * @byte_index: index to reaad from
+ * @val: return 32 bit value
+ **/
+static inline void get_32bit_val(__le32 *wqe_words, __u32 byte_index, __u32 *val)
+{
+	*val = le32toh(wqe_words[byte_index >> 2]);
+}
+#endif /* IRDMA_DEFS_H */
diff --git a/providers/irdma/i40e_devids.h b/providers/irdma/i40e_devids.h
new file mode 100644
index 0000000..2ea4f2d
--- /dev/null
+++ b/providers/irdma/i40e_devids.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2019 Intel Corporation */
+#ifndef I40E_DEVIDS_H
+#define I40E_DEVIDS_H
+
+/* Vendor ID */
+#define I40E_INTEL_VENDOR_ID		0x8086
+
+/* Device IDs */
+#define I40E_DEV_ID_SFP_XL710		0x1572
+#define I40E_DEV_ID_QEMU		0x1574
+#define I40E_DEV_ID_KX_B		0x1580
+#define I40E_DEV_ID_KX_C		0x1581
+#define I40E_DEV_ID_QSFP_A		0x1583
+#define I40E_DEV_ID_QSFP_B		0x1584
+#define I40E_DEV_ID_QSFP_C		0x1585
+#define I40E_DEV_ID_10G_BASE_T		0x1586
+#define I40E_DEV_ID_20G_KR2		0x1587
+#define I40E_DEV_ID_20G_KR2_A		0x1588
+#define I40E_DEV_ID_10G_BASE_T4		0x1589
+#define I40E_DEV_ID_25G_B		0x158A
+#define I40E_DEV_ID_25G_SFP28		0x158B
+#define I40E_DEV_ID_VF			0x154C
+#define I40E_DEV_ID_VF_HV		0x1571
+#define I40E_DEV_ID_X722_A0		0x374C
+#define I40E_DEV_ID_X722_A0_VF		0x374D
+#define I40E_DEV_ID_KX_X722		0x37CE
+#define I40E_DEV_ID_QSFP_X722		0x37CF
+#define I40E_DEV_ID_SFP_X722		0x37D0
+#define I40E_DEV_ID_1G_BASE_T_X722	0x37D1
+#define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
+#define I40E_DEV_ID_SFP_I_X722		0x37D3
+#define I40E_DEV_ID_X722_VF		0x37CD
+#define I40E_DEV_ID_X722_VF_HV		0x37D9
+
+#endif /* I40E_DEVIDS_H */
diff --git a/providers/irdma/i40iw_hw.h b/providers/irdma/i40iw_hw.h
new file mode 100644
index 0000000..a0a2848
--- /dev/null
+++ b/providers/irdma/i40iw_hw.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2021 Intel Corporation */
+#ifndef I40IW_HW_H
+#define I40IW_HW_H
+
+enum i40iw_device_caps_const {
+	I40IW_MAX_WQ_FRAGMENT_COUNT		= 3,
+	I40IW_MAX_SGE_RD			= 1,
+	I40IW_MAX_PUSH_PAGE_COUNT		= 0,
+	I40IW_MAX_INLINE_DATA_SIZE		= 48,
+	I40IW_MAX_IRD_SIZE			= 63,
+	I40IW_MAX_ORD_SIZE			= 127,
+	I40IW_MAX_WQ_ENTRIES			= 2048,
+	I40IW_MAX_WQE_SIZE_RQ			= 128,
+	I40IW_MAX_PDS				= 32768,
+	I40IW_MAX_STATS_COUNT			= 16,
+	I40IW_MAX_CQ_SIZE			= 1048575,
+	I40IW_MAX_OUTBOUND_MSG_SIZE		= 2147483647,
+	I40IW_MAX_INBOUND_MSG_SIZE		= 2147483647,
+};
+
+#define I40IW_QP_WQE_MIN_SIZE   32
+#define I40IW_QP_WQE_MAX_SIZE   128
+#define I40IW_QP_SW_MIN_WQSIZE  4
+#define I40IW_MAX_RQ_WQE_SHIFT  2
+#define I40IW_MAX_QUANTA_PER_WR 2
+
+#define I40IW_QP_SW_MAX_SQ_QUANTA 2048
+#define I40IW_QP_SW_MAX_RQ_QUANTA 16384
+#define I40IW_QP_SW_MAX_WQ_QUANTA 2048
+#endif /* I40IW_HW_H */
diff --git a/providers/irdma/ice_devids.h b/providers/irdma/ice_devids.h
new file mode 100644
index 0000000..655a1d6
--- /dev/null
+++ b/providers/irdma/ice_devids.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2019 - 2020 Intel Corporation */
+#ifndef ICE_DEVIDS_H
+#define ICE_DEVIDS_H
+
+#define PCI_VENDOR_ID_INTEL		0x8086
+
+/* Device IDs */
+/* Intel(R) Ethernet Connection E823-L for backplane */
+#define ICE_DEV_ID_E823L_BACKPLANE      0x124C
+/* Intel(R) Ethernet Connection E823-L for SFP */
+#define ICE_DEV_ID_E823L_SFP            0x124D
+/* Intel(R) Ethernet Connection E823-L/X557-AT 10GBASE-T */
+#define ICE_DEV_ID_E823L_10G_BASE_T     0x124E
+/* Intel(R) Ethernet Connection E823-L 1GbE */
+#define ICE_DEV_ID_E823L_1GBE           0x124F
+/* Intel(R) Ethernet Connection E823-L for QSFP */
+#define ICE_DEV_ID_E823L_QSFP           0x151D
+/* Intel(R) Ethernet Controller E810-C for backplane */
+#define ICE_DEV_ID_E810C_BACKPLANE      0x1591
+/* Intel(R) Ethernet Controller E810-C for QSFP */
+#define ICE_DEV_ID_E810C_QSFP           0x1592
+/* Intel(R) Ethernet Controller E810-C for SFP */
+#define ICE_DEV_ID_E810C_SFP            0x1593
+/* Intel(R) Ethernet Controller E810-XXV for backplane */
+#define ICE_DEV_ID_E810_XXV_BACKPLANE   0x1599
+/* Intel(R) Ethernet Controller E810-XXV for QSFP */
+#define ICE_DEV_ID_E810_XXV_QSFP        0x159A
+/* Intel(R) Ethernet Controller E810-XXV for SFP */
+#define ICE_DEV_ID_E810_XXV_SFP         0x159B
+/* Intel(R) Ethernet Connection E823-C for backplane */
+#define ICE_DEV_ID_E823C_BACKPLANE      0x188A
+/* Intel(R) Ethernet Connection E823-C for QSFP */
+#define ICE_DEV_ID_E823C_QSFP           0x188B
+/* Intel(R) Ethernet Connection E823-C for SFP */
+#define ICE_DEV_ID_E823C_SFP            0x188C
+/* Intel(R) Ethernet Connection E823-C/X557-AT 10GBASE-T */
+#define ICE_DEV_ID_E823C_10G_BASE_T     0x188D
+/* Intel(R) Ethernet Connection E823-C 1GbE */
+#define ICE_DEV_ID_E823C_SGMII          0x188E
+/* Intel(R) Ethernet Connection C822N for backplane */
+#define ICE_DEV_ID_C822N_BACKPLANE      0x1890
+/* Intel(R) Ethernet Connection C822N for QSFP */
+#define ICE_DEV_ID_C822N_QSFP           0x1891
+/* Intel(R) Ethernet Connection C822N for SFP */
+#define ICE_DEV_ID_C822N_SFP            0x1892
+/* Intel(R) Ethernet Connection E822-C/X557-AT 10GBASE-T */
+#define ICE_DEV_ID_E822C_10G_BASE_T     0x1893
+/* Intel(R) Ethernet Connection E822-C 1GbE */
+#define ICE_DEV_ID_E822C_SGMII          0x1894
+/* Intel(R) Ethernet Connection E822-L for backplane */
+#define ICE_DEV_ID_E822L_BACKPLANE      0x1897
+/* Intel(R) Ethernet Connection E822-L for SFP */
+#define ICE_DEV_ID_E822L_SFP            0x1898
+/* Intel(R) Ethernet Connection E822-L/X557-AT 10GBASE-T */
+#define ICE_DEV_ID_E822L_10G_BASE_T     0x1899
+/* Intel(R) Ethernet Connection E822-L 1GbE */
+#define ICE_DEV_ID_E822L_SGMII          0x189A
+#endif /* ICE_DEVIDS_H */
diff --git a/providers/irdma/osdep.h b/providers/irdma/osdep.h
new file mode 100644
index 0000000..2abfb19
--- /dev/null
+++ b/providers/irdma/osdep.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2021 Intel Corporation */
+#ifndef IRDMA_OSDEP_H
+#define IRDMA_OSDEP_H
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdatomic.h>
+#include <util/udma_barrier.h>
+#include <util/util.h>
+#include <linux/types.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <endian.h>
+
+static inline void db_wr32(__u32 val, __u32 *wqe_word)
+{
+	*wqe_word = val;
+}
+#endif /* IRDMA_OSDEP_H */
diff --git a/providers/irdma/status.h b/providers/irdma/status.h
new file mode 100644
index 0000000..8c8cdb6
--- /dev/null
+++ b/providers/irdma/status.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2020 Intel Corporation */
+#ifndef IRDMA_STATUS_H
+#define IRDMA_STATUS_H
+
+/* Error Codes */
+enum irdma_status_code {
+	IRDMA_SUCCESS				= 0,
+	IRDMA_ERR_NVM				= -1,
+	IRDMA_ERR_NVM_CHECKSUM			= -2,
+	IRDMA_ERR_CFG				= -4,
+	IRDMA_ERR_PARAM				= -5,
+	IRDMA_ERR_DEVICE_NOT_SUPPORTED		= -6,
+	IRDMA_ERR_RESET_FAILED			= -7,
+	IRDMA_ERR_SWFW_SYNC			= -8,
+	IRDMA_ERR_NO_MEMORY			= -9,
+	IRDMA_ERR_BAD_PTR			= -10,
+	IRDMA_ERR_INVALID_PD_ID			= -11,
+	IRDMA_ERR_INVALID_QP_ID			= -12,
+	IRDMA_ERR_INVALID_CQ_ID			= -13,
+	IRDMA_ERR_INVALID_CEQ_ID		= -14,
+	IRDMA_ERR_INVALID_AEQ_ID		= -15,
+	IRDMA_ERR_INVALID_SIZE			= -16,
+	IRDMA_ERR_INVALID_ARP_INDEX		= -17,
+	IRDMA_ERR_INVALID_FPM_FUNC_ID		= -18,
+	IRDMA_ERR_QP_INVALID_MSG_SIZE		= -19,
+	IRDMA_ERR_QP_TOOMANY_WRS_POSTED		= -20,
+	IRDMA_ERR_INVALID_FRAG_COUNT		= -21,
+	IRDMA_ERR_Q_EMPTY			= -22,
+	IRDMA_ERR_INVALID_ALIGNMENT		= -23,
+	IRDMA_ERR_FLUSHED_Q			= -24,
+	IRDMA_ERR_INVALID_PUSH_PAGE_INDEX	= -25,
+	IRDMA_ERR_INVALID_INLINE_DATA_SIZE	= -26,
+	IRDMA_ERR_TIMEOUT			= -27,
+	IRDMA_ERR_OPCODE_MISMATCH		= -28,
+	IRDMA_ERR_CQP_COMPL_ERROR		= -29,
+	IRDMA_ERR_INVALID_VF_ID			= -30,
+	IRDMA_ERR_INVALID_HMCFN_ID		= -31,
+	IRDMA_ERR_BACKING_PAGE_ERROR		= -32,
+	IRDMA_ERR_NO_PBLCHUNKS_AVAILABLE	= -33,
+	IRDMA_ERR_INVALID_PBLE_INDEX		= -34,
+	IRDMA_ERR_INVALID_SD_INDEX		= -35,
+	IRDMA_ERR_INVALID_PAGE_DESC_INDEX	= -36,
+	IRDMA_ERR_INVALID_SD_TYPE		= -37,
+	IRDMA_ERR_MEMCPY_FAILED			= -38,
+	IRDMA_ERR_INVALID_HMC_OBJ_INDEX		= -39,
+	IRDMA_ERR_INVALID_HMC_OBJ_COUNT		= -40,
+	IRDMA_ERR_BUF_TOO_SHORT			= -43,
+	IRDMA_ERR_BAD_IWARP_CQE			= -44,
+	IRDMA_ERR_NVM_BLANK_MODE		= -45,
+	IRDMA_ERR_NOT_IMPL			= -46,
+	IRDMA_ERR_PE_DOORBELL_NOT_ENA		= -47,
+	IRDMA_ERR_NOT_READY			= -48,
+	IRDMA_NOT_SUPPORTED			= -49,
+	IRDMA_ERR_FIRMWARE_API_VER		= -50,
+	IRDMA_ERR_RING_FULL			= -51,
+	IRDMA_ERR_MPA_CRC			= -61,
+	IRDMA_ERR_NO_TXBUFS			= -62,
+	IRDMA_ERR_SEQ_NUM			= -63,
+	IRDMA_ERR_LIST_EMPTY			= -64,
+	IRDMA_ERR_INVALID_MAC_ADDR		= -65,
+	IRDMA_ERR_BAD_STAG			= -66,
+	IRDMA_ERR_CQ_COMPL_ERROR		= -67,
+	IRDMA_ERR_Q_DESTROYED			= -68,
+	IRDMA_ERR_INVALID_FEAT_CNT		= -69,
+	IRDMA_ERR_REG_CQ_FULL			= -70,
+	IRDMA_ERR_VF_MSG_ERROR			= -71,
+	IRDMA_ERR_NO_INTR			= -72,
+	IRDMA_ERR_REG_QSET			= -73,
+	IRDMA_ERR_FEATURES_OP                   = -74,
+};
+#endif /* IRDMA_STATUS_H */
diff --git a/providers/irdma/umain.c b/providers/irdma/umain.c
new file mode 100644
index 0000000..469a864
--- /dev/null
+++ b/providers/irdma/umain.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+/* Copyright (C) 2019 - 2020 Intel Corporation */
+#include <config.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "ice_devids.h"
+#include "i40e_devids.h"
+#include "umain.h"
+#include "abi.h"
+
+#define INTEL_HCA(v, d) VERBS_PCI_MATCH(v, d, NULL)
+static const struct verbs_match_ent hca_table[] = {
+	VERBS_DRIVER_ID(RDMA_DRIVER_IRDMA),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_10G_BASE_T),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_1GBE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823L_QSFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810C_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810C_QSFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810C_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810_XXV_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810_XXV_QSFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E810_XXV_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823C_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823C_QSFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823C_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823C_10G_BASE_T),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E823C_SGMII),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_C822N_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_C822N_QSFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_C822N_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822C_10G_BASE_T),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822C_SGMII),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822L_BACKPLANE),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822L_SFP),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822L_10G_BASE_T),
+	INTEL_HCA(PCI_VENDOR_ID_INTEL, ICE_DEV_ID_E822L_SGMII),
+
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_X722_A0),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_X722_A0_VF),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_KX_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_QSFP_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_SFP_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_1G_BASE_T_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_10G_BASE_T_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_SFP_I_X722),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_X722_VF),
+	INTEL_HCA(I40E_INTEL_VENDOR_ID, I40E_DEV_ID_X722_VF_HV),
+
+	{}
+};
+
+/**
+ * irdma_ufree_context - free context that was allocated
+ * @ibctx: context allocated ptr
+ */
+static void irdma_ufree_context(struct ibv_context *ibctx)
+{
+	struct irdma_uvcontext *iwvctx = to_irdma_uctx(ibctx);
+
+	irdma_ufree_pd(&iwvctx->iwupd->ibv_pd);
+	irdma_munmap(iwvctx->db);
+	verbs_uninit_context(&iwvctx->ibv_ctx);
+	free(iwvctx);
+}
+
+static const struct verbs_context_ops irdma_uctx_ops = {
+	.alloc_mw = irdma_ualloc_mw,
+	.alloc_pd = irdma_ualloc_pd,
+	.attach_mcast = irdma_uattach_mcast,
+	.bind_mw = irdma_ubind_mw,
+	.cq_event = irdma_cq_event,
+	.create_ah = irdma_ucreate_ah,
+	.create_cq = irdma_ucreate_cq,
+	.create_cq_ex = irdma_ucreate_cq_ex,
+	.create_qp = irdma_ucreate_qp,
+	.dealloc_mw = irdma_udealloc_mw,
+	.dealloc_pd = irdma_ufree_pd,
+	.dereg_mr = irdma_udereg_mr,
+	.destroy_ah = irdma_udestroy_ah,
+	.destroy_cq = irdma_udestroy_cq,
+	.destroy_qp = irdma_udestroy_qp,
+	.detach_mcast = irdma_udetach_mcast,
+	.modify_qp = irdma_umodify_qp,
+	.poll_cq = irdma_upoll_cq,
+	.post_recv = irdma_upost_recv,
+	.post_send = irdma_upost_send,
+	.query_device_ex = irdma_uquery_device_ex,
+	.query_port = irdma_uquery_port,
+	.query_qp = irdma_uquery_qp,
+	.reg_mr = irdma_ureg_mr,
+	.req_notify_cq = irdma_uarm_cq,
+	.resize_cq = irdma_uresize_cq,
+	.free_context = irdma_ufree_context,
+};
+
+/**
+ * i40iw_set_hw_attrs - set the hw attributes
+ * @attrs: pointer to hw attributes
+ *
+ * Set the device attibutes to allow user mode to work with
+ * driver on older ABI version.
+ */
+static void i40iw_set_hw_attrs(struct irdma_uk_attrs *attrs)
+{
+	attrs->hw_rev = IRDMA_GEN_1;
+	attrs->max_hw_wq_frags = I40IW_MAX_WQ_FRAGMENT_COUNT;
+	attrs->max_hw_read_sges = I40IW_MAX_SGE_RD;
+	attrs->max_hw_inline = I40IW_MAX_INLINE_DATA_SIZE;
+	attrs->max_hw_rq_quanta = I40IW_QP_SW_MAX_RQ_QUANTA;
+	attrs->max_hw_wq_quanta = I40IW_QP_SW_MAX_WQ_QUANTA;
+	attrs->max_hw_sq_chunk = I40IW_MAX_QUANTA_PER_WR;
+	attrs->max_hw_cq_size = I40IW_MAX_CQ_SIZE;
+	attrs->min_hw_cq_size = IRDMA_MIN_CQ_SIZE;
+}
+
+/**
+ * irdma_ualloc_context - allocate context for user app
+ * @ibdev: ib device created during irdma_driver_init
+ * @cmd_fd: save fd for the device
+ * @private_data: device private data
+ *
+ * Returns callback routine table and calls driver for allocating
+ * context and getting back resource information to return as ibv_context.
+ */
+static struct verbs_context *irdma_ualloc_context(struct ibv_device *ibdev,
+						  int cmd_fd, void *private_data)
+{
+	struct ibv_pd *ibv_pd;
+	struct irdma_uvcontext *iwvctx;
+	struct irdma_get_context cmd;
+	struct irdma_get_context_resp resp = {};
+	__u64 mmap_key;
+	__u8 user_ver = IRDMA_ABI_VER;
+
+	iwvctx = verbs_init_and_alloc_context(ibdev, cmd_fd, iwvctx, ibv_ctx,
+					      RDMA_DRIVER_IRDMA);
+	if (!iwvctx)
+		return NULL;
+
+	cmd.userspace_ver = user_ver;
+	if (ibv_cmd_get_context(&iwvctx->ibv_ctx,
+				(struct ibv_get_context *)&cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp))) {
+		cmd.userspace_ver = 4;
+		if (ibv_cmd_get_context(&iwvctx->ibv_ctx,
+					(struct ibv_get_context *)&cmd, sizeof(cmd),
+					&resp.ibv_resp, sizeof(resp)))
+			goto err_free;
+		user_ver = cmd.userspace_ver;
+	}
+
+	verbs_set_ops(&iwvctx->ibv_ctx, &irdma_uctx_ops);
+
+	/* Legacy i40iw does not populate hw_rev. The irdma driver always sets it */
+	if (!resp.hw_rev) {
+		i40iw_set_hw_attrs(&iwvctx->uk_attrs);
+		iwvctx->abi_ver = resp.kernel_ver;
+		iwvctx->legacy_mode = true;
+		mmap_key = 0;
+	} else {
+		iwvctx->uk_attrs.feature_flags = resp.feature_flags;
+		iwvctx->uk_attrs.hw_rev = resp.hw_rev;
+		iwvctx->uk_attrs.max_hw_wq_frags = resp.max_hw_wq_frags;
+		iwvctx->uk_attrs.max_hw_read_sges = resp.max_hw_read_sges;
+		iwvctx->uk_attrs.max_hw_inline = resp.max_hw_inline;
+		iwvctx->uk_attrs.max_hw_rq_quanta = resp.max_hw_rq_quanta;
+		iwvctx->uk_attrs.max_hw_wq_quanta = resp.max_hw_wq_quanta;
+		iwvctx->uk_attrs.max_hw_sq_chunk = resp.max_hw_sq_chunk;
+		iwvctx->uk_attrs.max_hw_cq_size = resp.max_hw_cq_size;
+		iwvctx->uk_attrs.min_hw_cq_size = resp.min_hw_cq_size;
+		iwvctx->abi_ver = user_ver;
+		mmap_key = resp.db_mmap_key;
+	}
+
+	iwvctx->db = irdma_mmap(cmd_fd, mmap_key);
+	if (iwvctx->db == MAP_FAILED)
+		goto err_free;
+
+	ibv_pd = irdma_ualloc_pd(&iwvctx->ibv_ctx.context);
+	if (!ibv_pd) {
+		irdma_munmap(iwvctx->db);
+		goto err_free;
+	}
+
+	ibv_pd->context = &iwvctx->ibv_ctx.context;
+	iwvctx->iwupd = to_irdma_upd(ibv_pd);
+	return &iwvctx->ibv_ctx;
+
+err_free:
+	free(iwvctx);
+
+	return NULL;
+}
+
+static void irdma_uninit_device(struct verbs_device *verbs_device)
+{
+	struct irdma_udevice *dev = to_irdma_udev(&verbs_device->device);
+
+	free(dev);
+}
+
+static struct verbs_device *irdma_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
+{
+	struct irdma_udevice *dev;
+
+	dev = calloc(1, sizeof(*dev));
+	if (!dev)
+		return NULL;
+
+	return &dev->ibv_dev;
+}
+
+static const struct verbs_device_ops irdma_udev_ops = {
+	.alloc_context = irdma_ualloc_context,
+	.alloc_device = irdma_device_alloc,
+	.match_max_abi_version = IRDMA_MAX_ABI_VERSION,
+	.match_min_abi_version = IRDMA_MIN_ABI_VERSION,
+	.match_table = hca_table,
+	.name = "irdma",
+	.uninit_device = irdma_uninit_device,
+};
+
+PROVIDER_DRIVER(irdma, irdma_udev_ops);
diff --git a/providers/irdma/umain.h b/providers/irdma/umain.h
new file mode 100644
index 0000000..02becfa
--- /dev/null
+++ b/providers/irdma/umain.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (C) 2019 - 2020 Intel Corporation */
+#ifndef IRDMA_UMAIN_H
+#define IRDMA_UMAIN_H
+
+#include <inttypes.h>
+#include <stddef.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <infiniband/driver.h>
+
+#include "osdep.h"
+#include "irdma.h"
+#include "defs.h"
+#include "i40iw_hw.h"
+#include "status.h"
+#include "user.h"
+
+#define PFX	"libirdma-"
+
+#define IRDMA_BASE_PUSH_PAGE		1
+#define IRDMA_U_MINCQ_SIZE		4
+#define IRDMA_DB_SHADOW_AREA_SIZE	64
+#define IRDMA_DB_CQ_OFFSET		64
+
+enum irdma_supported_wc_flags {
+	IRDMA_CQ_SUPPORTED_WC_FLAGS = IBV_WC_EX_WITH_BYTE_LEN
+				    | IBV_WC_EX_WITH_IMM
+				    | IBV_WC_EX_WITH_QP_NUM
+				    | IBV_WC_EX_WITH_SRC_QP
+				    | IBV_WC_EX_WITH_SLID
+				    | IBV_WC_EX_WITH_SL
+				    | IBV_WC_EX_WITH_DLID_PATH_BITS
+				    | IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK
+				    | IBV_WC_EX_WITH_COMPLETION_TIMESTAMP,
+};
+
+struct irdma_udevice {
+	struct verbs_device ibv_dev;
+};
+
+struct irdma_uah {
+	struct ibv_ah ibv_ah;
+	uint32_t ah_id;
+	struct ibv_global_route grh;
+};
+
+struct irdma_upd {
+	struct ibv_pd ibv_pd;
+	void *arm_cq_page;
+	void *arm_cq;
+	uint32_t pd_id;
+};
+
+struct irdma_uvcontext {
+	struct verbs_context ibv_ctx;
+	struct irdma_upd *iwupd;
+	struct irdma_uk_attrs uk_attrs;
+	void *db;
+	int abi_ver;
+	bool legacy_mode;
+};
+
+struct irdma_uqp;
+
+struct irdma_cq_buf {
+	struct list_node list;
+	struct irdma_cq_uk cq;
+	struct verbs_mr vmr;
+};
+
+struct irdma_ucq {
+	struct verbs_cq verbs_cq;
+	struct verbs_mr vmr;
+	struct verbs_mr vmr_shadow_area;
+	pthread_spinlock_t lock;
+	size_t buf_size;
+	bool is_armed;
+	bool skip_arm;
+	bool arm_sol;
+	bool skip_sol;
+	int comp_vector;
+	uint32_t report_rtt;
+	struct irdma_uqp *uqp;
+	struct irdma_cq_uk cq;
+	struct list_head resize_list;
+	/* for extended CQ completion fields */
+	struct irdma_cq_poll_info cur_cqe;
+};
+
+struct irdma_uqp {
+	struct ibv_qp ibv_qp;
+	struct ibv_qp_attr attr;
+	struct irdma_ucq *send_cq;
+	struct irdma_ucq *recv_cq;
+	struct verbs_mr vmr;
+	size_t buf_size;
+	uint32_t irdma_drv_opt;
+	pthread_spinlock_t lock;
+	uint16_t sq_sig_all;
+	uint16_t qperr;
+	uint16_t rsvd;
+	uint32_t pending_rcvs;
+	uint32_t wq_size;
+	struct ibv_recv_wr *pend_rx_wr;
+	struct irdma_qp_uk qp;
+	enum ibv_qp_type qp_type;
+	enum ibv_qp_attr_mask attr_mask;
+	struct irdma_sge *recv_sges;
+};
+
+struct irdma_umr {
+	struct verbs_mr vmr;
+	uint32_t acc_flags;
+};
+
+#define to_irdma_uxxx(xxx, type)                                               \
+	container_of(ib##xxx, struct irdma_u##type, ibv_##xxx)
+
+static inline struct irdma_udevice *to_irdma_udev(struct ibv_device *ibdev)
+{
+	return container_of(ibdev, struct irdma_udevice, ibv_dev.device);
+}
+
+static inline struct irdma_uvcontext *to_irdma_uctx(struct ibv_context *ibctx)
+{
+	return container_of(ibctx, struct irdma_uvcontext, ibv_ctx.context);
+}
+
+static inline struct irdma_uah *to_irdma_uah(struct ibv_ah *ibah)
+{
+	return to_irdma_uxxx(ah, ah);
+}
+
+static inline struct irdma_upd *to_irdma_upd(struct ibv_pd *ibpd)
+{
+	return to_irdma_uxxx(pd, pd);
+}
+
+static inline struct irdma_ucq *to_irdma_ucq(struct ibv_cq *ibcq)
+{
+	return container_of(ibcq, struct irdma_ucq, verbs_cq.cq);
+}
+
+static inline struct irdma_ucq *to_irdma_ucq_ex(struct ibv_cq_ex *ibcq_ex)
+{
+	return container_of(ibcq_ex, struct irdma_ucq, verbs_cq.cq_ex);
+}
+
+static inline struct irdma_uqp *to_irdma_uqp(struct ibv_qp *ibqp)
+{
+	return to_irdma_uxxx(qp, qp);
+}
+
+/* irdma_uverbs.c */
+int irdma_uquery_device_ex(struct ibv_context *context,
+			   const struct ibv_query_device_ex_input *input,
+			   struct ibv_device_attr_ex *attr, size_t attr_size);
+int irdma_uquery_port(struct ibv_context *context, uint8_t port,
+		      struct ibv_port_attr *attr);
+struct ibv_pd *irdma_ualloc_pd(struct ibv_context *context);
+int irdma_ufree_pd(struct ibv_pd *pd);
+struct ibv_mr *irdma_ureg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			     uint64_t hca_va, int access);
+int irdma_udereg_mr(struct verbs_mr *vmr);
+struct ibv_mw *irdma_ualloc_mw(struct ibv_pd *pd, enum ibv_mw_type type);
+int irdma_ubind_mw(struct ibv_qp *qp, struct ibv_mw *mw,
+		   struct ibv_mw_bind *mw_bind);
+int irdma_udealloc_mw(struct ibv_mw *mw);
+struct ibv_cq *irdma_ucreate_cq(struct ibv_context *context, int cqe,
+				struct ibv_comp_channel *channel,
+				int comp_vector);
+struct ibv_cq_ex *irdma_ucreate_cq_ex(struct ibv_context *context,
+				      struct ibv_cq_init_attr_ex *attr_ex);
+void irdma_ibvcq_ex_fill_priv_funcs(struct irdma_ucq *iwucq,
+				    struct ibv_cq_init_attr_ex *attr_ex);
+int irdma_uresize_cq(struct ibv_cq *cq, int cqe);
+int irdma_udestroy_cq(struct ibv_cq *cq);
+int irdma_upoll_cq(struct ibv_cq *cq, int entries, struct ibv_wc *entry);
+int irdma_uarm_cq(struct ibv_cq *cq, int solicited);
+void irdma_cq_event(struct ibv_cq *cq);
+struct ibv_qp *irdma_ucreate_qp(struct ibv_pd *pd,
+				struct ibv_qp_init_attr *attr);
+int irdma_uquery_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr, int attr_mask,
+		    struct ibv_qp_init_attr *init_attr);
+int irdma_umodify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
+		     int attr_mask);
+int irdma_udestroy_qp(struct ibv_qp *qp);
+int irdma_upost_send(struct ibv_qp *ib_qp, struct ibv_send_wr *ib_wr,
+		     struct ibv_send_wr **bad_wr);
+int irdma_upost_recv(struct ibv_qp *ib_qp, struct ibv_recv_wr *ib_wr,
+		     struct ibv_recv_wr **bad_wr);
+struct ibv_ah *irdma_ucreate_ah(struct ibv_pd *ibpd, struct ibv_ah_attr *attr);
+int irdma_udestroy_ah(struct ibv_ah *ibah);
+int irdma_uattach_mcast(struct ibv_qp *qp, const union ibv_gid *gid,
+			uint16_t lid);
+int irdma_udetach_mcast(struct ibv_qp *qp, const union ibv_gid *gid,
+			uint16_t lid);
+void irdma_async_event(struct ibv_context *context,
+		       struct ibv_async_event *event);
+void irdma_set_hw_attrs(struct irdma_hw_attrs *attrs);
+void *irdma_mmap(int fd, off_t offset);
+void irdma_munmap(void *map);
+#endif /* IRDMA_UMAIN_H */
diff --git a/providers/irdma/user.h b/providers/irdma/user.h
new file mode 100644
index 0000000..c7a2091
--- /dev/null
+++ b/providers/irdma/user.h
@@ -0,0 +1,439 @@
+/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* Copyright (c) 2015 - 2020 Intel Corporation */
+#ifndef IRDMA_USER_H
+#define IRDMA_USER_H
+
+#include "osdep.h"
+
+#define irdma_handle void *
+#define irdma_adapter_handle irdma_handle
+#define irdma_qp_handle irdma_handle
+#define irdma_cq_handle irdma_handle
+#define irdma_pd_id irdma_handle
+#define irdma_stag_handle irdma_handle
+#define irdma_stag_index __u32
+#define irdma_stag __u32
+#define irdma_stag_key __u8
+#define irdma_tagged_offset __u64
+#define irdma_access_privileges __u32
+#define irdma_physical_fragment __u64
+#define irdma_address_list __u64 *
+#define irdma_sgl struct irdma_sge *
+
+#define	IRDMA_MAX_MR_SIZE       0x200000000000ULL
+
+#define IRDMA_ACCESS_FLAGS_LOCALREAD		0x01
+#define IRDMA_ACCESS_FLAGS_LOCALWRITE		0x02
+#define IRDMA_ACCESS_FLAGS_REMOTEREAD_ONLY	0x04
+#define IRDMA_ACCESS_FLAGS_REMOTEREAD		0x05
+#define IRDMA_ACCESS_FLAGS_REMOTEWRITE_ONLY	0x08
+#define IRDMA_ACCESS_FLAGS_REMOTEWRITE		0x0a
+#define IRDMA_ACCESS_FLAGS_BIND_WINDOW		0x10
+#define IRDMA_ACCESS_FLAGS_ZERO_BASED		0x20
+#define IRDMA_ACCESS_FLAGS_ALL			0x3f
+
+#define IRDMA_OP_TYPE_RDMA_WRITE		0x00
+#define IRDMA_OP_TYPE_RDMA_READ			0x01
+#define IRDMA_OP_TYPE_SEND			0x03
+#define IRDMA_OP_TYPE_SEND_INV			0x04
+#define IRDMA_OP_TYPE_SEND_SOL			0x05
+#define IRDMA_OP_TYPE_SEND_SOL_INV		0x06
+#define IRDMA_OP_TYPE_RDMA_WRITE_SOL		0x0d
+#define IRDMA_OP_TYPE_BIND_MW			0x08
+#define IRDMA_OP_TYPE_FAST_REG_NSMR		0x09
+#define IRDMA_OP_TYPE_INV_STAG			0x0a
+#define IRDMA_OP_TYPE_RDMA_READ_INV_STAG	0x0b
+#define IRDMA_OP_TYPE_NOP			0x0c
+#define IRDMA_OP_TYPE_REC	0x3e
+#define IRDMA_OP_TYPE_REC_IMM	0x3f
+
+#define IRDMA_FLUSH_MAJOR_ERR	1
+
+enum irdma_device_caps_const {
+	IRDMA_WQE_SIZE =			4,
+	IRDMA_CQP_WQE_SIZE =			8,
+	IRDMA_CQE_SIZE =			4,
+	IRDMA_EXTENDED_CQE_SIZE =		8,
+	IRDMA_AEQE_SIZE =			2,
+	IRDMA_CEQE_SIZE =			1,
+	IRDMA_CQP_CTX_SIZE =			8,
+	IRDMA_SHADOW_AREA_SIZE =		8,
+	IRDMA_GATHER_STATS_BUF_SIZE =		1024,
+	IRDMA_MIN_IW_QP_ID =			0,
+	IRDMA_QUERY_FPM_BUF_SIZE =		176,
+	IRDMA_COMMIT_FPM_BUF_SIZE =		176,
+	IRDMA_MAX_IW_QP_ID =			262143,
+	IRDMA_MIN_CEQID =			0,
+	IRDMA_MAX_CEQID =			1023,
+	IRDMA_CEQ_MAX_COUNT =			IRDMA_MAX_CEQID + 1,
+	IRDMA_MIN_CQID =			0,
+	IRDMA_MAX_CQID =			524287,
+	IRDMA_MIN_AEQ_ENTRIES =			1,
+	IRDMA_MAX_AEQ_ENTRIES =			524287,
+	IRDMA_MIN_CEQ_ENTRIES =			1,
+	IRDMA_MAX_CEQ_ENTRIES =			262143,
+	IRDMA_MIN_CQ_SIZE =			1,
+	IRDMA_MAX_CQ_SIZE =			1048575,
+	IRDMA_DB_ID_ZERO =			0,
+	IRDMA_MAX_WQ_FRAGMENT_COUNT =		13,
+	IRDMA_MAX_SGE_RD =			13,
+	IRDMA_MAX_OUTBOUND_MSG_SIZE =		2147483647,
+	IRDMA_MAX_INBOUND_MSG_SIZE =		2147483647,
+	IRDMA_MAX_PUSH_PAGE_COUNT =		1024,
+	IRDMA_MAX_PE_ENA_VF_COUNT =		32,
+	IRDMA_MAX_VF_FPM_ID =			47,
+	IRDMA_MAX_SQ_PAYLOAD_SIZE =		2145386496,
+	IRDMA_MAX_INLINE_DATA_SIZE =		101,
+	IRDMA_MAX_WQ_ENTRIES =			32768,
+	IRDMA_Q2_BUF_SIZE =			256,
+	IRDMA_QP_CTX_SIZE =			256,
+	IRDMA_MAX_PDS =				262144,
+};
+
+enum irdma_addressing_type {
+	IRDMA_ADDR_TYPE_ZERO_BASED = 0,
+	IRDMA_ADDR_TYPE_VA_BASED   = 1,
+};
+
+enum irdma_flush_opcode {
+	FLUSH_INVALID = 0,
+	FLUSH_GENERAL_ERR,
+	FLUSH_PROT_ERR,
+	FLUSH_REM_ACCESS_ERR,
+	FLUSH_LOC_QP_OP_ERR,
+	FLUSH_REM_OP_ERR,
+	FLUSH_LOC_LEN_ERR,
+	FLUSH_FATAL_ERR,
+};
+
+enum irdma_cmpl_status {
+	IRDMA_COMPL_STATUS_SUCCESS = 0,
+	IRDMA_COMPL_STATUS_FLUSHED,
+	IRDMA_COMPL_STATUS_INVALID_WQE,
+	IRDMA_COMPL_STATUS_QP_CATASTROPHIC,
+	IRDMA_COMPL_STATUS_REMOTE_TERMINATION,
+	IRDMA_COMPL_STATUS_INVALID_STAG,
+	IRDMA_COMPL_STATUS_BASE_BOUND_VIOLATION,
+	IRDMA_COMPL_STATUS_ACCESS_VIOLATION,
+	IRDMA_COMPL_STATUS_INVALID_PD_ID,
+	IRDMA_COMPL_STATUS_WRAP_ERROR,
+	IRDMA_COMPL_STATUS_STAG_INVALID_PDID,
+	IRDMA_COMPL_STATUS_RDMA_READ_ZERO_ORD,
+	IRDMA_COMPL_STATUS_QP_NOT_PRIVLEDGED,
+	IRDMA_COMPL_STATUS_STAG_NOT_INVALID,
+	IRDMA_COMPL_STATUS_INVALID_PHYS_BUF_SIZE,
+	IRDMA_COMPL_STATUS_INVALID_PHYS_BUF_ENTRY,
+	IRDMA_COMPL_STATUS_INVALID_FBO,
+	IRDMA_COMPL_STATUS_INVALID_LEN,
+	IRDMA_COMPL_STATUS_INVALID_ACCESS,
+	IRDMA_COMPL_STATUS_PHYS_BUF_LIST_TOO_LONG,
+	IRDMA_COMPL_STATUS_INVALID_VIRT_ADDRESS,
+	IRDMA_COMPL_STATUS_INVALID_REGION,
+	IRDMA_COMPL_STATUS_INVALID_WINDOW,
+	IRDMA_COMPL_STATUS_INVALID_TOTAL_LEN,
+	IRDMA_COMPL_STATUS_UNKNOWN,
+};
+
+enum irdma_cmpl_notify {
+	IRDMA_CQ_COMPL_EVENT     = 0,
+	IRDMA_CQ_COMPL_SOLICITED = 1,
+};
+
+enum irdma_qp_caps {
+	IRDMA_WRITE_WITH_IMM = 1,
+	IRDMA_SEND_WITH_IMM  = 2,
+	IRDMA_ROCE	     = 4,
+	IRDMA_PUSH_MODE      = 8,
+};
+
+struct irdma_qp_uk;
+struct irdma_cq_uk;
+struct irdma_qp_uk_init_info;
+struct irdma_cq_uk_init_info;
+
+struct irdma_sge {
+	irdma_tagged_offset tag_off;
+	__u32 len;
+	irdma_stag stag;
+};
+
+struct irdma_ring {
+	__u32 head;
+	__u32 tail;
+	__u32 size;
+};
+
+struct irdma_cqe {
+	__le64 buf[IRDMA_CQE_SIZE];
+};
+
+struct irdma_extended_cqe {
+	__le64 buf[IRDMA_EXTENDED_CQE_SIZE];
+};
+
+struct irdma_post_send {
+	irdma_sgl sg_list;
+	__u32 num_sges;
+	__u32 qkey;
+	__u32 dest_qp;
+	__u32 ah_id;
+};
+
+struct irdma_post_inline_send {
+	void *data;
+	__u32 len;
+	__u32 qkey;
+	__u32 dest_qp;
+	__u32 ah_id;
+};
+
+struct irdma_post_rq_info {
+	__u64 wr_id;
+	irdma_sgl sg_list;
+	__u32 num_sges;
+};
+
+struct irdma_rdma_write {
+	irdma_sgl lo_sg_list;
+	__u32 num_lo_sges;
+	struct irdma_sge rem_addr;
+};
+
+struct irdma_inline_rdma_write {
+	void *data;
+	__u32 len;
+	struct irdma_sge rem_addr;
+};
+
+struct irdma_rdma_read {
+	irdma_sgl lo_sg_list;
+	__u32 num_lo_sges;
+	struct irdma_sge rem_addr;
+};
+
+struct irdma_bind_window {
+	irdma_stag mr_stag;
+	__u64 bind_len;
+	void *va;
+	enum irdma_addressing_type addressing_type;
+	bool ena_reads:1;
+	bool ena_writes:1;
+	irdma_stag mw_stag;
+	bool mem_window_type_1:1;
+};
+
+struct irdma_inv_local_stag {
+	irdma_stag target_stag;
+};
+
+struct irdma_post_sq_info {
+	__u64 wr_id;
+	__u8 op_type;
+	__u8 l4len;
+	bool signaled:1;
+	bool read_fence:1;
+	bool local_fence:1;
+	bool inline_data:1;
+	bool imm_data_valid:1;
+	bool push_wqe:1;
+	bool report_rtt:1;
+	bool udp_hdr:1;
+	bool defer_flag:1;
+	__u32 imm_data;
+	__u32 stag_to_inv;
+	union {
+		struct irdma_post_send send;
+		struct irdma_rdma_write rdma_write;
+		struct irdma_rdma_read rdma_read;
+		struct irdma_bind_window bind_window;
+		struct irdma_inv_local_stag inv_local_stag;
+		struct irdma_inline_rdma_write inline_rdma_write;
+		struct irdma_post_inline_send inline_send;
+	} op;
+};
+
+struct irdma_cq_poll_info {
+	__u64 wr_id;
+	irdma_qp_handle qp_handle;
+	__u32 bytes_xfered;
+	__u32 tcp_seq_num_rtt;
+	__u32 qp_id;
+	__u32 ud_src_qpn;
+	__u32 imm_data;
+	irdma_stag inv_stag; /* or L_R_Key */
+	enum irdma_cmpl_status comp_status;
+	__u16 major_err;
+	__u16 minor_err;
+	__u16 ud_vlan;
+	__u8 ud_smac[6];
+	__u8 op_type;
+	bool stag_invalid_set:1; /* or L_R_Key set */
+	bool push_dropped:1;
+	bool error:1;
+	bool solicited_event:1;
+	bool ipv4:1;
+	bool ud_vlan_valid:1;
+	bool ud_smac_valid:1;
+	bool imm_valid:1;
+};
+
+enum irdma_status_code irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
+						  struct irdma_post_sq_info *info,
+						  bool post_sq);
+enum irdma_status_code irdma_uk_inline_send(struct irdma_qp_uk *qp,
+					    struct irdma_post_sq_info *info,
+					    bool post_sq);
+enum irdma_status_code irdma_uk_mw_bind(struct irdma_qp_uk *qp,
+					struct irdma_post_sq_info *info,
+					bool post_sq);
+enum irdma_status_code irdma_uk_post_nop(struct irdma_qp_uk *qp, __u64 wr_id,
+					 bool signaled, bool post_sq);
+enum irdma_status_code irdma_uk_post_receive(struct irdma_qp_uk *qp,
+					     struct irdma_post_rq_info *info);
+void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp);
+enum irdma_status_code irdma_uk_rdma_read(struct irdma_qp_uk *qp,
+					  struct irdma_post_sq_info *info,
+					  bool inv_stag, bool post_sq);
+enum irdma_status_code irdma_uk_rdma_write(struct irdma_qp_uk *qp,
+					   struct irdma_post_sq_info *info,
+					   bool post_sq);
+enum irdma_status_code irdma_uk_send(struct irdma_qp_uk *qp,
+				     struct irdma_post_sq_info *info, bool post_sq);
+enum irdma_status_code irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
+						      struct irdma_post_sq_info *info,
+						      bool post_sq);
+
+struct irdma_wqe_uk_ops {
+	void (*iw_copy_inline_data)(__u8 *dest, __u8 *src, __u32 len, __u8 polarity);
+	__u16 (*iw_inline_data_size_to_quanta)(__u32 data_size);
+	void (*iw_set_fragment)(__le64 *wqe, __u32 offset, struct irdma_sge *sge,
+				__u8 valid);
+	void (*iw_set_mw_bind_wqe)(__le64 *wqe,
+				   struct irdma_bind_window *op_info);
+};
+
+enum irdma_status_code irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
+					     struct irdma_cq_poll_info *info);
+void irdma_uk_cq_request_notification(struct irdma_cq_uk *cq,
+				      enum irdma_cmpl_notify cq_notify);
+void irdma_uk_cq_resize(struct irdma_cq_uk *cq, void *cq_base, int size);
+void irdma_uk_cq_set_resized_cnt(struct irdma_cq_uk *qp, __u16 cnt);
+enum irdma_status_code irdma_uk_cq_init(struct irdma_cq_uk *cq,
+					struct irdma_cq_uk_init_info *info);
+enum irdma_status_code irdma_uk_qp_init(struct irdma_qp_uk *qp,
+					struct irdma_qp_uk_init_info *info);
+struct irdma_sq_uk_wr_trk_info {
+	__u64 wrid;
+	__u32 wr_len;
+	__u16 quanta;
+	__u8 reserved[2];
+};
+
+struct irdma_qp_quanta {
+	__le64 elem[IRDMA_WQE_SIZE];
+};
+
+struct irdma_qp_uk {
+	struct irdma_qp_quanta *sq_base;
+	struct irdma_qp_quanta *rq_base;
+	struct irdma_uk_attrs *uk_attrs;
+	__u32 *wqe_alloc_db;
+	struct irdma_sq_uk_wr_trk_info *sq_wrtrk_array;
+	__u64 *rq_wrid_array;
+	__le64 *shadow_area;
+	__le32 *push_db;
+	__le64 *push_wqe;
+	struct irdma_ring sq_ring;
+	struct irdma_ring rq_ring;
+	struct irdma_ring initial_ring;
+	__u32 qp_id;
+	__u32 qp_caps;
+	__u32 sq_size;
+	__u32 rq_size;
+	__u32 max_sq_frag_cnt;
+	__u32 max_rq_frag_cnt;
+	__u32 max_inline_data;
+	struct irdma_wqe_uk_ops wqe_ops;
+	__u16 conn_wqes;
+	__u8 qp_type;
+	__u8 swqe_polarity;
+	__u8 swqe_polarity_deferred;
+	__u8 rwqe_polarity;
+	__u8 rq_wqe_size;
+	__u8 rq_wqe_size_multiplier;
+	bool deferred_flag:1;
+	bool push_mode:1; /* whether the last post wqe was pushed */
+	bool push_dropped:1;
+	bool first_sq_wq:1;
+	bool sq_flush_complete:1; /* Indicates flush was seen and SQ was empty after the flush */
+	bool rq_flush_complete:1; /* Indicates flush was seen and RQ was empty after the flush */
+	bool destroy_pending:1; /* Indicates the QP is being destroyed */
+	void *back_qp;
+	pthread_spinlock_t *lock;
+	__u8 dbg_rq_flushed;
+	__u8 sq_flush_seen;
+	__u8 rq_flush_seen;
+};
+
+struct irdma_cq_uk {
+	struct irdma_cqe *cq_base;
+	__u32 *cqe_alloc_db;
+	__u32 *cq_ack_db;
+	__le64 *shadow_area;
+	__u32 cq_id;
+	__u32 cq_size;
+	struct irdma_ring cq_ring;
+	__u8 polarity;
+	bool avoid_mem_cflct:1;
+};
+
+struct irdma_qp_uk_init_info {
+	struct irdma_qp_quanta *sq;
+	struct irdma_qp_quanta *rq;
+	struct irdma_uk_attrs *uk_attrs;
+	__u32 *wqe_alloc_db;
+	__le64 *shadow_area;
+	struct irdma_sq_uk_wr_trk_info *sq_wrtrk_array;
+	__u64 *rq_wrid_array;
+	__u32 qp_id;
+	__u32 qp_caps;
+	__u32 sq_size;
+	__u32 rq_size;
+	__u32 max_sq_frag_cnt;
+	__u32 max_rq_frag_cnt;
+	__u32 max_inline_data;
+	__u8 first_sq_wq;
+	__u8 type;
+	int abi_ver;
+	bool legacy_mode;
+};
+
+struct irdma_cq_uk_init_info {
+	__u32 *cqe_alloc_db;
+	__u32 *cq_ack_db;
+	struct irdma_cqe *cq_base;
+	__le64 *shadow_area;
+	__u32 cq_size;
+	__u32 cq_id;
+	bool avoid_mem_cflct;
+};
+
+__le64 *irdma_qp_get_next_send_wqe(struct irdma_qp_uk *qp, __u32 *wqe_idx,
+				   __u16 quanta, __u32 total_size,
+				   struct irdma_post_sq_info *info);
+__le64 *irdma_qp_get_next_recv_wqe(struct irdma_qp_uk *qp, __u32 *wqe_idx);
+void irdma_uk_clean_cq(void *q, struct irdma_cq_uk *cq);
+enum irdma_status_code irdma_nop(struct irdma_qp_uk *qp, __u64 wr_id,
+				 bool signaled, bool post_sq);
+enum irdma_status_code irdma_fragcnt_to_quanta_sq(__u32 frag_cnt, __u16 *quanta);
+enum irdma_status_code irdma_fragcnt_to_wqesize_rq(__u32 frag_cnt, __u16 *wqe_size);
+void irdma_get_wqe_shift(struct irdma_uk_attrs *uk_attrs, __u32 sge,
+			 __u32 inline_data, __u8 *shift);
+enum irdma_status_code irdma_get_sqdepth(struct irdma_uk_attrs *uk_attrs,
+					 __u32 sq_size, __u8 shift, __u32 *wqdepth);
+enum irdma_status_code irdma_get_rqdepth(struct irdma_uk_attrs *uk_attrs,
+					 __u32 rq_size, __u8 shift, __u32 *wqdepth);
+void irdma_qp_push_wqe(struct irdma_qp_uk *qp, __le64 *wqe, __u16 quanta,
+		       __u32 wqe_idx, bool post_sq);
+void irdma_clr_wqes(struct irdma_qp_uk *qp, __u32 qp_wqe_idx);
+#endif /* IRDMA_USER_H */
-- 
1.8.3.1

