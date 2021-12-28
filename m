Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00EC480731
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhL1IC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:28 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47591 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235519AbhL1ICY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:24 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AtAOA9KB5HCWTOhVW/3fiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fB1a6hj4q0WBWx2FJD2iFaK6OYDf3fN9+Pojn/E0E7MeAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMmhfnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSngvY/AZpOWbSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkzDjfAukrR4jORari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72Y8sGZDtvZRLPSx1SM0gaCdQ1m+LArn3ydDtwq1+Po6czpW/Jw2R?=
 =?us-ascii?q?Z2bjkKt3TfvSMW8RZn0/erWXDl0z8CBUdP9y3zySE/nOlwOTImEvTXIMUCa399?=
 =?us-ascii?q?fNwhlCX7nIcBQdQVlahp/S9zEmkVLp3L00S5zprt6Q3/WS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+815ymfy6fM7kCSDwA5opRpADA9nJZuA2V0iRnSxJW0bQGDeYa9ERq1n?=
 =?us-ascii?q?op4ZxvoYkD59VM/WBI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AC35bv6HTqGBBuhHKpLqEDMeALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qaTdZUgpGbJYVkqOE3I9ertBEDEewK4yXcX2/h3AV7BZniEhI?=
 =?us-ascii?q?LAFugLhuGO/9SjIVybygc378ZdmsZFZ+EYdWIK7/oS/jPIbuoI8Z2W9ryyn+fC?=
 =?us-ascii?q?wzNIRQFuUatp6AB0EW+gYzZLbTgDFZwkD4Cd+8YCgzKhfE4cZsO9CmJAcPPEo7?=
 =?us-ascii?q?Tw5ejbSC9DFxg68xOPkD/tzLb7FiKT1hAYXygK4ZpKyxm8rzDE?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657424"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0CD2A4D15A20;
        Tue, 28 Dec 2021 16:01:54 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:53 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:51 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 09/10] RDMA/rxe: Implement flush completion
Date:   Tue, 28 Dec 2021 16:07:16 +0800
Message-ID: <20211228080717.10666-10-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0CD2A4D15A20.AE515
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
index d336f2f8bb69..d528f2c4eba0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -963,6 +963,7 @@ const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 enum ib_wc_opcode {
 	IB_WC_SEND = IB_UVERBS_WC_SEND,
 	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_FLUSH = IB_UVERBS_WC_FLUSH,
 	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
 	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
 	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index efa06f53c7c6..b9d6b3ca5708 100644
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



