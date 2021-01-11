Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B582F0EBD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 10:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAKJI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 04:08:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20015 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727884AbhAKJI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 04:08:29 -0500
X-IronPort-AV: E=Sophos;i="5.79,338,1602518400"; 
   d="scan'208";a="103359166"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2021 17:07:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C735A4CE5CE7;
        Mon, 11 Jan 2021 17:07:33 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 11 Jan 2021 17:07:35 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 11 Jan 2021 17:07:34 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <leonro@nvidia.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [rdma-core PATCH] verbs: Update the type of some variables in documents
Date:   Mon, 11 Jan 2021 16:57:24 +0800
Message-ID: <20210111085724.27641-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C735A4CE5CE7.AB369
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The type of some variables has been changed from int to
unsigned int thus update the corresponding documents.

Fixes: 8fe7f12f1723 ("verbs: Bitwise flag values should be unsigned")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 libibverbs/man/ibv_bind_mw.3      | 4 ++--
 libibverbs/man/ibv_create_cq_ex.3 | 2 +-
 libibverbs/man/ibv_modify_qp.3    | 2 +-
 libibverbs/man/ibv_poll_cq.3      | 2 +-
 libibverbs/man/ibv_post_send.3    | 4 ++--
 libibverbs/man/ibv_query_qp.3     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libibverbs/man/ibv_bind_mw.3 b/libibverbs/man/ibv_bind_mw.3
index af309d00..6b995af7 100644
--- a/libibverbs/man/ibv_bind_mw.3
+++ b/libibverbs/man/ibv_bind_mw.3
@@ -28,7 +28,7 @@ is an ibv_mw_bind struct, as defined in <infiniband/verbs.h>.
 struct ibv_mw_bind {
 .in +8
 uint64_t                     wr_id;           /* User defined WR ID */
-int                          send_flags;      /* Use ibv_send_flags */
+unsigned int                 send_flags;      /* Use ibv_send_flags */
 struct ibv_mw_bind_info      bind_info;       /* MW bind information */
 .in -8
 }
@@ -40,7 +40,7 @@ struct ibv_mw_bind_info {
 struct ibv_mr                *mr;             /* The MR to bind the MW to */
 uint64_t                     addr;            /* The address the MW should start at */
 uint64_t                     length;          /* The length (in bytes) the MW should span */
-int                          mw_access_flags; /* Access flags to the MW. Use ibv_access_flags */
+unsigned int                 mw_access_flags; /* Access flags to the MW. Use ibv_access_flags */
 .in -8
 };
 .fi
diff --git a/libibverbs/man/ibv_create_cq_ex.3 b/libibverbs/man/ibv_create_cq_ex.3
index 0f05693e..81eb37b9 100644
--- a/libibverbs/man/ibv_create_cq_ex.3
+++ b/libibverbs/man/ibv_create_cq_ex.3
@@ -122,7 +122,7 @@ Below members and functions are used in order to poll the current completion. Th
 .BI "uint32_t ibv_wc_read_src_qp(struct ibv_cq_ex " "*cq"); \c
  Get the source QP number field from the current completion.
 
-.BI "int ibv_wc_read_wc_flags(struct ibv_cq_ex " "*cq"); \c
+.BI "unsigned int ibv_wc_read_wc_flags(struct ibv_cq_ex " "*cq"); \c
  Get the QP flags field from the current completion.
 
 .BI "uint16_t ibv_wc_read_pkey_index(struct ibv_cq_ex " "*cq"); \c
diff --git a/libibverbs/man/ibv_modify_qp.3 b/libibverbs/man/ibv_modify_qp.3
index 52f06c0c..3a6563fd 100644
--- a/libibverbs/man/ibv_modify_qp.3
+++ b/libibverbs/man/ibv_modify_qp.3
@@ -32,7 +32,7 @@ uint32_t                qkey;                   /* Q_Key for the QP (valid only
 uint32_t                rq_psn;                 /* PSN for receive queue (valid only for RC/UC QPs) */
 uint32_t                sq_psn;                 /* PSN for send queue */
 uint32_t                dest_qp_num;            /* Destination QP number (valid only for RC/UC QPs) */
-int                     qp_access_flags;        /* Mask of enabled remote access operations (valid only for RC/UC QPs) */
+unsigned int            qp_access_flags;        /* Mask of enabled remote access operations (valid only for RC/UC QPs) */
 struct ibv_qp_cap       cap;                    /* QP capabilities (valid if HCA supports QP resizing) */
 struct ibv_ah_attr      ah_attr;                /* Primary path address vector (valid only for RC/UC QPs) */
 struct ibv_ah_attr      alt_ah_attr;            /* Alternate path address vector (valid only for RC/UC QPs) */
diff --git a/libibverbs/man/ibv_poll_cq.3 b/libibverbs/man/ibv_poll_cq.3
index 957fd151..82386580 100644
--- a/libibverbs/man/ibv_poll_cq.3
+++ b/libibverbs/man/ibv_poll_cq.3
@@ -39,7 +39,7 @@ uint32_t                invalidated_rkey; /* Local RKey that was invalidated */
 };
 uint32_t                qp_num;         /* Local QP number of completed WR */
 uint32_t                src_qp;         /* Source QP number (remote QP number) of completed WR (valid only for UD QPs) */
-int                     wc_flags;       /* Flags of the completed WR */
+unsigned int            wc_flags;       /* Flags of the completed WR */
 uint16_t                pkey_index;     /* P_Key index (valid only for GSI QPs) */
 uint16_t                slid;           /* Source LID */
 uint8_t                 sl;             /* Service Level */
diff --git a/libibverbs/man/ibv_post_send.3 b/libibverbs/man/ibv_post_send.3
index 4fb99f7c..2c488b09 100644
--- a/libibverbs/man/ibv_post_send.3
+++ b/libibverbs/man/ibv_post_send.3
@@ -34,7 +34,7 @@ struct ibv_send_wr     *next;                   /* Pointer to next WR in list, N
 struct ibv_sge         *sg_list;                /* Pointer to the s/g array */
 int                     num_sge;                /* Size of the s/g array */
 enum ibv_wr_opcode      opcode;                 /* Operation type */
-int                     send_flags;             /* Flags of the WR properties */
+unsigned int            send_flags;             /* Flags of the WR properties */
 union {
 .in +8
 __be32                  imm_data;               /* Immediate data (in network byte order) */
@@ -103,7 +103,7 @@ struct ibv_mw_bind_info {
 struct ibv_mr            *mr;             /* The Memory region (MR) to bind the MW to */
 uint64_t                 addr;           /* The address the MW should start at */
 uint64_t                 length;          /* The length (in bytes) the MW should span */
-int                      mw_access_flags; /* Access flags to the MW. Use ibv_access_flags */
+unsigned int             mw_access_flags; /* Access flags to the MW. Use ibv_access_flags */
 .in -8
 };
 .fi
diff --git a/libibverbs/man/ibv_query_qp.3 b/libibverbs/man/ibv_query_qp.3
index e9a596d9..e3eef0aa 100644
--- a/libibverbs/man/ibv_query_qp.3
+++ b/libibverbs/man/ibv_query_qp.3
@@ -37,7 +37,7 @@ uint32_t                qkey;                /* Q_Key of the QP (valid only for
 uint32_t                rq_psn;              /* PSN for receive queue (valid only for RC/UC QPs) */
 uint32_t                sq_psn;              /* PSN for send queue */
 uint32_t                dest_qp_num;         /* Destination QP number (valid only for RC/UC QPs) */
-int                     qp_access_flags;     /* Mask of enabled remote access operations (valid only for RC/UC QPs) */
+unsigned int            qp_access_flags;     /* Mask of enabled remote access operations (valid only for RC/UC QPs) */
 struct ibv_qp_cap       cap;                 /* QP capabilities */
 struct ibv_ah_attr      ah_attr;             /* Primary path address vector (valid only for RC/UC QPs) */
 struct ibv_ah_attr      alt_ah_attr;         /* Alternate path address vector (valid only for RC/UC QPs) */
-- 
2.21.0



