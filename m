Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CD49AEE6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452984AbiAYI4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:56:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7819 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452913AbiAYIvJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:51:09 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Af+t1z6NoIFg2P8rvrR2qlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQG/hTJzhjEAx2tJC2uAbKuDNGX1ft1xbNnk8k8HvZ7dm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yElj/zQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZf0dqeSYfxBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTDQC/k5TJbbTqPFzd9F1?=
 =?us-ascii?q?Sg9h4ZFGvO2T8YQb3xtKgvBZxlOM1IMIJM4gOqswHL4dlVwtFWQrLElpWfJywl?=
 =?us-ascii?q?43KruMfLUfMCHQYNemUPwjmbL+GLRARwAMtGbjz2f/RqEj+/GhyT9XKoUCry09?=
 =?us-ascii?q?/csi1qWrkQWAhkRXluTp+e4hk+3HdlYLiQ85i0rhbQ78FSmX5/2WBjQiHqFuAM?=
 =?us-ascii?q?MHtldCes37CmTxafOpQWUHG4JSnhGctNOnMs3QyE6k0WFmtrBGzNiqvuWRGib+?=
 =?us-ascii?q?7PSqim9UQAXImAqdy4JVQZD6NCLnW2ZpnojVf46SOjs0IKzQmq2nli3QOEFr+1?=
 =?us-ascii?q?7paY2O2+TpzgrWw6Rm6U=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcDoT2azdJwcasm1ok+CQKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839376"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:35 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id DE3824D15A5C;
        Tue, 25 Jan 2022 16:44:33 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:31 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:31 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 9/9] RDMA/rxe: Add RD FLUSH service support
Date:   Tue, 25 Jan 2022 16:50:41 +0800
Message-ID: <20220125085041.49175-10-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DE3824D15A5C.AEA72
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
index adea6c16dfb5..3d86129558f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -922,6 +922,26 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 					  RXE_RDETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RD_RDMA_FLUSH]			= {
+		.name	= "IB_OPCODE_RD_RDMA_FLUSH",
+		.mask	= RXE_RDETH_MASK | RXE_FETH_MASK | RXE_RETH_MASK |
+			  RXE_FLUSH_MASK | RXE_START_MASK |
+			  RXE_END_MASK | RXE_REQ_MASK,
+		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_RDETH]	= RXE_BTH_BYTES,
+			[RXE_FETH]	= RXE_BTH_BYTES +
+					  RXE_RDETH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_RDETH_BYTES +
+					  RXE_FETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_RDETH_BYTES +
+					  RXE_FETH_BYTES +
+					  RXE_RETH_BYTES,
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



