Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE48E164B3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfEGNio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40241 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726516AbfEGNio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:44 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:39 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdF1021865;
        Tue, 7 May 2019 16:38:39 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 01/25] RDMA/core: Introduce new header file for signature operations
Date:   Tue,  7 May 2019 16:38:15 +0300
Message-Id: <1557236319-9986-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ease the exhausted ib_verbs.h file and make the code more readable.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/rdma/ib_verbs.h  | 112 +------------------------------------------
 include/rdma/signature.h | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 111 deletions(-)
 create mode 100644 include/rdma/signature.h

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9b9e17bcc201..fb532c634e91 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -61,6 +61,7 @@
 #include <linux/cgroup_rdma.h>
 #include <uapi/rdma/ib_user_verbs.h>
 #include <rdma/restrack.h>
+#include <rdma/signature.h>
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
 
@@ -241,17 +242,6 @@ enum ib_device_cap_flags {
 	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
 };
 
-enum ib_signature_prot_cap {
-	IB_PROT_T10DIF_TYPE_1 = 1,
-	IB_PROT_T10DIF_TYPE_2 = 1 << 1,
-	IB_PROT_T10DIF_TYPE_3 = 1 << 2,
-};
-
-enum ib_signature_guard_cap {
-	IB_GUARD_T10DIF_CRC	= 1,
-	IB_GUARD_T10DIF_CSUM	= 1 << 1,
-};
-
 enum ib_atomic_cap {
 	IB_ATOMIC_NONE,
 	IB_ATOMIC_HCA,
@@ -776,106 +766,6 @@ enum ib_mr_type {
 	IB_MR_TYPE_SG_GAPS,
 };
 
-/**
- * Signature types
- * IB_SIG_TYPE_NONE: Unprotected.
- * IB_SIG_TYPE_T10_DIF: Type T10-DIF
- */
-enum ib_signature_type {
-	IB_SIG_TYPE_NONE,
-	IB_SIG_TYPE_T10_DIF,
-};
-
-/**
- * Signature T10-DIF block-guard types
- * IB_T10DIF_CRC: Corresponds to T10-PI mandated CRC checksum rules.
- * IB_T10DIF_CSUM: Corresponds to IP checksum rules.
- */
-enum ib_t10_dif_bg_type {
-	IB_T10DIF_CRC,
-	IB_T10DIF_CSUM
-};
-
-/**
- * struct ib_t10_dif_domain - Parameters specific for T10-DIF
- *     domain.
- * @bg_type: T10-DIF block guard type (CRC|CSUM)
- * @pi_interval: protection information interval.
- * @bg: seed of guard computation.
- * @app_tag: application tag of guard block
- * @ref_tag: initial guard block reference tag.
- * @ref_remap: Indicate wethear the reftag increments each block
- * @app_escape: Indicate to skip block check if apptag=0xffff
- * @ref_escape: Indicate to skip block check if reftag=0xffffffff
- * @apptag_check_mask: check bitmask of application tag.
- */
-struct ib_t10_dif_domain {
-	enum ib_t10_dif_bg_type bg_type;
-	u16			pi_interval;
-	u16			bg;
-	u16			app_tag;
-	u32			ref_tag;
-	bool			ref_remap;
-	bool			app_escape;
-	bool			ref_escape;
-	u16			apptag_check_mask;
-};
-
-/**
- * struct ib_sig_domain - Parameters for signature domain
- * @sig_type: specific signauture type
- * @sig: union of all signature domain attributes that may
- *     be used to set domain layout.
- */
-struct ib_sig_domain {
-	enum ib_signature_type sig_type;
-	union {
-		struct ib_t10_dif_domain dif;
-	} sig;
-};
-
-/**
- * struct ib_sig_attrs - Parameters for signature handover operation
- * @check_mask: bitmask for signature byte check (8 bytes)
- * @mem: memory domain layout desciptor.
- * @wire: wire domain layout desciptor.
- */
-struct ib_sig_attrs {
-	u8			check_mask;
-	struct ib_sig_domain	mem;
-	struct ib_sig_domain	wire;
-};
-
-enum ib_sig_err_type {
-	IB_SIG_BAD_GUARD,
-	IB_SIG_BAD_REFTAG,
-	IB_SIG_BAD_APPTAG,
-};
-
-/**
- * Signature check masks (8 bytes in total) according to the T10-PI standard:
- *  -------- -------- ------------
- * | GUARD  | APPTAG |   REFTAG   |
- * |  2B    |  2B    |    4B      |
- *  -------- -------- ------------
- */
-enum {
-	IB_SIG_CHECK_GUARD	= 0xc0,
-	IB_SIG_CHECK_APPTAG	= 0x30,
-	IB_SIG_CHECK_REFTAG	= 0x0f,
-};
-
-/**
- * struct ib_sig_err - signature error descriptor
- */
-struct ib_sig_err {
-	enum ib_sig_err_type	err_type;
-	u32			expected;
-	u32			actual;
-	u64			sig_err_offset;
-	u32			key;
-};
-
 enum ib_mr_status_check {
 	IB_MR_CHECK_SIG_STATUS = 1,
 };
diff --git a/include/rdma/signature.h b/include/rdma/signature.h
new file mode 100644
index 000000000000..5998fe94dfd4
--- /dev/null
+++ b/include/rdma/signature.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) */
+/*
+ * Copyright (c) 2017-2018 Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef _RDMA_SIGNATURE_H_
+#define _RDMA_SIGNATURE_H_
+
+enum ib_signature_prot_cap {
+	IB_PROT_T10DIF_TYPE_1 = 1,
+	IB_PROT_T10DIF_TYPE_2 = 1 << 1,
+	IB_PROT_T10DIF_TYPE_3 = 1 << 2,
+};
+
+enum ib_signature_guard_cap {
+	IB_GUARD_T10DIF_CRC	= 1,
+	IB_GUARD_T10DIF_CSUM	= 1 << 1,
+};
+
+/**
+ * enum ib_signature_type - Signature types
+ * @IB_SIG_TYPE_NONE: Unprotected.
+ * @IB_SIG_TYPE_T10_DIF: Type T10-DIF
+ */
+enum ib_signature_type {
+	IB_SIG_TYPE_NONE,
+	IB_SIG_TYPE_T10_DIF,
+};
+
+/**
+ * enum ib_t10_dif_bg_type - Signature T10-DIF block-guard types
+ * @IB_T10DIF_CRC: Corresponds to T10-PI mandated CRC checksum rules.
+ * @IB_T10DIF_CSUM: Corresponds to IP checksum rules.
+ */
+enum ib_t10_dif_bg_type {
+	IB_T10DIF_CRC,
+	IB_T10DIF_CSUM,
+};
+
+/**
+ * struct ib_t10_dif_domain - Parameters specific for T10-DIF
+ *     domain.
+ * @bg_type: T10-DIF block guard type (CRC|CSUM)
+ * @pi_interval: protection information interval.
+ * @bg: seed of guard computation.
+ * @app_tag: application tag of guard block
+ * @ref_tag: initial guard block reference tag.
+ * @ref_remap: Indicate wethear the reftag increments each block
+ * @app_escape: Indicate to skip block check if apptag=0xffff
+ * @ref_escape: Indicate to skip block check if reftag=0xffffffff
+ * @apptag_check_mask: check bitmask of application tag.
+ */
+struct ib_t10_dif_domain {
+	enum ib_t10_dif_bg_type bg_type;
+	u16			pi_interval;
+	u16			bg;
+	u16			app_tag;
+	u32			ref_tag;
+	bool			ref_remap;
+	bool			app_escape;
+	bool			ref_escape;
+	u16			apptag_check_mask;
+};
+
+/**
+ * struct ib_sig_domain - Parameters for signature domain
+ * @sig_type: specific signauture type
+ * @sig: union of all signature domain attributes that may
+ *     be used to set domain layout.
+ */
+struct ib_sig_domain {
+	enum ib_signature_type sig_type;
+	union {
+		struct ib_t10_dif_domain dif;
+	} sig;
+};
+
+/**
+ * struct ib_sig_attrs - Parameters for signature handover operation
+ * @check_mask: bitmask for signature byte check (8 bytes)
+ * @mem: memory domain layout descriptor.
+ * @wire: wire domain layout descriptor.
+ */
+struct ib_sig_attrs {
+	u8			check_mask;
+	struct ib_sig_domain	mem;
+	struct ib_sig_domain	wire;
+};
+
+enum ib_sig_err_type {
+	IB_SIG_BAD_GUARD,
+	IB_SIG_BAD_REFTAG,
+	IB_SIG_BAD_APPTAG,
+};
+
+/*
+ * Signature check masks (8 bytes in total) according to the T10-PI standard:
+ *  -------- -------- ------------
+ * | GUARD  | APPTAG |   REFTAG   |
+ * |  2B    |  2B    |    4B      |
+ *  -------- -------- ------------
+ */
+enum {
+	IB_SIG_CHECK_GUARD = 0xc0,
+	IB_SIG_CHECK_APPTAG = 0x30,
+	IB_SIG_CHECK_REFTAG = 0x0f,
+};
+
+/*
+ * struct ib_sig_err - signature error descriptor
+ */
+struct ib_sig_err {
+	enum ib_sig_err_type	err_type;
+	u32			expected;
+	u32			actual;
+	u64			sig_err_offset;
+	u32			key;
+};
+
+#endif /* _RDMA_SIGNATURE_H_ */
-- 
2.16.3

