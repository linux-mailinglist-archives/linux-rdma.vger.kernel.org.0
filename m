Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D738FA7B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEYGJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:09:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:63859 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhEYGJU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 02:09:20 -0400
IronPort-SDR: S0VoJzJKqVDUSG3jtl6buVqF8156WCfmDF/Wx27vfj8Cn4srA0PezxBhqO6RkNbomyMMD9EKSf
 p7H8L7r1MzQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="287685396"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="287685396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 23:07:50 -0700
IronPort-SDR: 0uhjj8xJ/xFaqaiIDJUtfVV+RZqkKdA+oOaQzacYoLXE+WOBFzSv7nZ6brLRIXCOFHE/B+5hOy
 3WWPXzIswn3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="443182805"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2021 23:07:49 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com,
        dledford@redhat.com, leonro@nvidia.com
Subject: [PATCH 1/1] Update kernel headers
Date:   Tue, 25 May 2021 18:32:22 -0400
Message-Id: <20210525223222.17636-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

After the patches "RDMA/rxe: Implement memory windows", the kernel headers
are changed. This causes about 17 errors and 1 failure when running
"run_test.py" with rxe.
This commit will fix these errors and failures.

Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index 068433e2..90ea477f 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -99,7 +99,17 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32		rkey;
+			__u32		access;
+			__u32		flags;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +118,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.30.2

