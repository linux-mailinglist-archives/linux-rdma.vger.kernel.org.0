Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14775480733
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhL1IC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:28 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47599 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235496AbhL1ICY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:24 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AzZyyYKB7kOjqQBVW/3fiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAVOw1GhxhDIPn2FOWGnVOv3fZGv9ctAiPY/n800Ou5SAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMmhfnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSngvY/AZpOWcSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkzDjfAukrR4jORari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72Y8sGZDtvZRLPSx1SM0gaCdQ1m+LArn3ydDtwq1+Po6czpW/Jw2R?=
 =?us-ascii?q?Z2bjkKt3TfvSMW8RZn0/erWXDl0z8CBUdP9y3zySE/nOlwOTImEvTXIMUCa399?=
 =?us-ascii?q?fNwhlCX7nIcBQdQVlahp/S9zEmkVLp3L00S5zprt6Q3/WS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+815ymfy6fM7kCSDwA5opRpADA9nJZuA2V0iRnSxJW0bQGDeYa9ERq1n?=
 =?us-ascii?q?op4ZxvoZUD59VM/WBI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9zTfxK6D+bQqeArINwPXwC7XdLJyesId70hD?=
 =?us-ascii?q?6qhwISY1TiX+rbHWoB17726NtN9/YgBCpTntAsa9qDbnhPpICOoqTNGftWvdyQ?=
 =?us-ascii?q?mVxehZhOOIqVCNJ8S9zJ876U4KSchD4bPLY2SS9fyKhTVQDexQvOWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXN7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGM7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2D2pme?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657423"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0CE9D4D15A21;
        Tue, 28 Dec 2021 16:01:55 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:54 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:52 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 10/10] RDMA/rxe: Add RD FLUSH service support
Date:   Tue, 28 Dec 2021 16:07:17 +0800
Message-ID: <20211228080717.10666-11-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0CE9D4D15A21.AF2B7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Although the SPEC said FLUSH is supported by RC/RD/XRC services, XRC has
not been supported by the rxe.

So XRC FLUSH will not be supported until rxe implements XRC service.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
I have not setup a RD environment to test this protocol
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 20 ++++++++++++++++++++
 include/rdma/ib_pack.h                 |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index d61c8b354af4..0d5f555f5ec5 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -919,6 +919,26 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 						+ RXE_RDETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RD_RDMA_FLUSH]			= {
+		.name	= "IB_OPCODE_RD_RDMA_FLUSH",
+		.mask	= RXE_RDETH_MASK | RXE_FETH_MASK | RXE_RETH_MASK
+				| RXE_FLUSH_MASK | RXE_START_MASK
+				| RXE_END_MASK | RXE_REQ_MASK,
+		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_RDETH]	= RXE_BTH_BYTES,
+			[RXE_FETH]	= RXE_BTH_BYTES
+							+ RXE_RDETH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES
+							+ RXE_RDETH_BYTES
+							+ RXE_FETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+							+ RXE_RDETH_BYTES
+							+ RXE_FETH_BYTES
+							+ RXE_RETH_BYTES,
+		}
+	},
 
 	/* UD */
 	[IB_OPCODE_UD_SEND_ONLY]			= {
diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index d19edb502de6..40568a33ead8 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -151,6 +151,7 @@ enum {
 	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
 	IB_OPCODE(RD, COMPARE_SWAP),
 	IB_OPCODE(RD, FETCH_ADD),
+	IB_OPCODE(RD, RDMA_FLUSH),
 
 	/* UD */
 	IB_OPCODE(UD, SEND_ONLY),
-- 
2.31.1



