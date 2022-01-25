Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8149AE6E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452565AbiAYItn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:49:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27831 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452267AbiAYIre (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:47:34 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AVb5j4a79PNYVkIUtTJ+qOgxRtDfGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS3mYFymAWCjiAbPuIZGX0LdwnaoW1oBkBsZ+HzIc3HQc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuOmVba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/h1ycdNtJ6xQ?=
 =?us-ascii?q?AEBMLDOmfgGTl9TFCQW0ahuoeWfcSPu6pPJp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6KCqSPt9hJ57dJHDM4YWu3UmxjbcZd4iQJnFTLrH48dV2?=
 =?us-ascii?q?jgYht1HAvvfIcEebFJHYB3GJR8JJVYTDJM3mfyAh3/jfjkeo1WQzYIr5G3a1x4?=
 =?us-ascii?q?336LqNdPZaN+LbcRTgkuc4GnB+gzRBhwdMvScxCCD/3bqgfXA9QvyWIsIE7u83?=
 =?us-ascii?q?vh0gVGSzyoYDxh+fV6xpf6yima4RdNTKkVS8S0rxYAu80mDUtD5RxCp5nWDu3Y?=
 =?us-ascii?q?0X9tWDv1/6wyXzKfQyxiWC3JCTTNbbtEi8sgsSlQC0l6PgsOsHzBquZWLRn+Hs?=
 =?us-ascii?q?LSZtzW/PW4SN2BqTS0LQiMX4tT7rcc4h3ryonxLeEKupoStX2iunHbR925j74j?=
 =?us-ascii?q?/RPUjj82TlW0rSRr1znQRcjMI2w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEAghvq+zvOaM3GQ275Ruk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839372"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 74C444D169C8;
        Tue, 25 Jan 2022 16:44:32 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:33 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:31 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:29 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 7/9] RDMA/rxe: Implement flush completion
Date:   Tue, 25 Jan 2022 16:50:39 +0800
Message-ID: <20220125085041.49175-8-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 74C444D169C8.ADD38
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce a new IB_UVERBS_WC_FLUSH code to tell userspace a FLUSH
completion.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 +++-
 include/rdma/ib_verbs.h              | 1 +
 include/uapi/rdma/ib_user_verbs.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index f363fe3fa414..e5b9d07eba93 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_RDMA_FLUSH:			return IB_WC_RDMA_FLUSH;
 
 	default:
 		return 0xff;
@@ -261,7 +262,8 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		 */
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
 		if (wqe->wr.opcode != IB_WR_RDMA_READ &&
-		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV) {
+		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV &&
+		    wqe->wr.opcode != IB_WR_RDMA_FLUSH) {
 			wqe->status = IB_WC_FATAL_ERR;
 			return COMPST_ERROR;
 		}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d8555b6e4eba..5242acb73004 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -965,6 +965,7 @@ const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 enum ib_wc_opcode {
 	IB_WC_SEND = IB_UVERBS_WC_SEND,
 	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_FLUSH = IB_UVERBS_WC_FLUSH,
 	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
 	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
 	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index be1f9dca08a8..d43671fef93e 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -476,6 +476,7 @@ enum ib_uverbs_wc_opcode {
 	IB_UVERBS_WC_BIND_MW = 5,
 	IB_UVERBS_WC_LOCAL_INV = 6,
 	IB_UVERBS_WC_TSO = 7,
+	IB_UVERBS_WC_FLUSH = 8,
 };
 
 struct ib_uverbs_wc {
-- 
2.31.1



