Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F934220F07
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGOORV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91179C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s26so2155831pfm.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1BezVWUnbAdhVulFlwwfpsWBQxSAXXUvw++74lWHuk=;
        b=cJTLItsaHqEuIz4+AetLcR3B3o02CW1ZV5Jv+nur5Tn56ddH1ODBcUf3W4fhDBy87s
         haVFszCnT7cZ9ldhkdIQhrV45C3R/2LXpN5p+S7naQMfjhQiYNxjA6uSX942egg7sUzn
         DtnEQdRGJYBZ8kePyF3EWqCGGxfCLZQMm1tkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1BezVWUnbAdhVulFlwwfpsWBQxSAXXUvw++74lWHuk=;
        b=rc+AOGw9hmK2voKEU0+kBdBPYqkgmoJzNccln7SvnsUl4EdQ7mDIjtiQFa2c9ijy2P
         wGfn79A7wYeRJhof9xfiaCknr7kE2U6WVpKpyZl7k9i5xmuhgQh2gXXbY5wlg/9CVvll
         tt8/Rhqdoqo3YXWo/6PXg4vg+JydJXb2QRqx0bXgcBYUpSsio0xwit7lrJ/2REmRvvM5
         Csli++cO9m/hDVSPLDlhDzqnLW9aPdWCLmKIig7zl4Xammtwlsa0TA8YBt5xzNoF22/6
         1oKvfPjxOJ93B+2w4YdIYMFK9ARoMmO9TVLnVU8ctchIiNxtDMDJVsHOv/s68CmFPywo
         tVSw==
X-Gm-Message-State: AOAM5302Tl/ldPTEMR6jWKnpMnk8TUfvNhJjI/mc9k1L3TyRPsVo85gG
        KRQnDkBExY2lrSeCdmUvJ+IecskPggZ4x7V79faM4P22I9mpZH9Uq3hQ4cAf3OZqMs+XOM28enV
        Wb7NgZXy8E3ug5DuOE2LXbEVLhRRka62npV9lnG5/U+3LZGWpY1jqfEyRduoP0NuHwdQIX8LgjU
        6Nmh8=
X-Google-Smtp-Source: ABdhPJwd5r7Ds5nsGfB75CMn/YYpPQoW8h7rP05Sh19ioIZzLGi1Pvkq8bWGQekEe4tBM72KiTsHJQ==
X-Received: by 2002:a62:7790:: with SMTP id s138mr8662110pfc.65.1594822639636;
        Wed, 15 Jul 2020 07:17:19 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:19 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 4/6] RDMA/bnxt_re: Add helper data structures
Date:   Wed, 15 Jul 2020 10:16:57 -0400
Message-Id: <1594822619-4098-5-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding few helper data structure which are useful
to initialize hardware send wqe in variable wqe mode.

Adding a qp flag in HSI to indicate variable wqe is
enabled for this qp.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 45 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 50e4f79..bf96a74 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -39,6 +39,51 @@
 #ifndef __BNXT_QPLIB_FP_H__
 #define __BNXT_QPLIB_FP_H__
 
+/* Few helper structures temporarily defined here
+ * should get rid of these when roce_hsi.h is updated
+ * in original code base
+ */
+struct sq_ud_ext_hdr {
+	__le32 dst_qp;
+	__le32 avid;
+	__le64 rsvd;
+};
+
+struct sq_raw_ext_hdr {
+	__le32 cfa_meta;
+	__le32 rsvd0;
+	__le64 rsvd1;
+};
+
+struct sq_rdma_ext_hdr {
+	__le64 remote_va;
+	__le32 remote_key;
+	__le32 rsvd;
+};
+
+struct sq_atomic_ext_hdr {
+	__le64 swap_data;
+	__le64 cmp_data;
+};
+
+struct sq_fr_pmr_ext_hdr {
+	__le64 pblptr;
+	__le64 va;
+};
+
+struct sq_bind_ext_hdr {
+	__le64 va;
+	__le32 length_lo;
+	__le32 length_hi;
+};
+
+struct rq_ext_hdr {
+	__le64 rsvd1;
+	__le64 rsvd2;
+};
+
+/* Helper structures end */
+
 struct bnxt_qplib_srq {
 	struct bnxt_qplib_pd		*pd;
 	struct bnxt_qplib_dpi		*dpi;
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 6f00f07..3e40e0d 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -1126,6 +1126,7 @@ struct cmdq_create_qp {
 	#define CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION	   0x2UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE      0x4UL
 	#define CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED		   0x8UL
+	#define CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED 0x10UL
 	u8 type;
 	#define CMDQ_CREATE_QP_TYPE_RC				   0x2UL
 	#define CMDQ_CREATE_QP_TYPE_UD				   0x4UL
-- 
1.8.3.1

