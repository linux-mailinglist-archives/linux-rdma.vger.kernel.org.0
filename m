Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C711B4D9888
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiCOKOe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbiCOKO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:28 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAB8E03B;
        Tue, 15 Mar 2022 03:13:12 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A9Ma4CaL5kAEfsEsZFE+R3pQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC93TJ3gjdVzTBJWGnXbvmLM2v1Kd1xboTloEwA75+Bm4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/cYpO+eeCLXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TXYBPApXp3FW6jM6vdYw?=
 =?us-ascii?q?T4vi8EIFvHbD+IVYDwpblLfYhlLO14SE7o/mvulgj/0dDgwgE6SoKMs8S7c1gt?=
 =?us-ascii?q?02bT/M9v9e9qWSMETlUGdzkrC8mP/KhIXLtqSzXyC6H3ErubPlDn8XoY6EqO5+?=
 =?us-ascii?q?v9jxlaUwwQ7DRcSUlC7if+ni0K/UpRULEl80jYpqIAu/UizQ8i7VBq9yFaAvxg?=
 =?us-ascii?q?BS59THvc85QWl1KXZ+UCaC3ICQzoHb8Yp3OcyRDo3xhqTk9bgLSJgvafTSn+H8?=
 =?us-ascii?q?LqQ6zSoNkA9L2ANTT0FQBMIpdLqyLzfJDqnos1LSfbz14OqX2qrhW3ikcT3vJ1?=
 =?us-ascii?q?L5eZj6klx1Qyvb+qQm6X0?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxuRKR6CppNkkEqrlHelI55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKJyC9Ffbo8fxG/c5rrCMc5wxwZJhNo7y90ey7MBbhHP1OkO4s1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKn/baknDH4VmtJuIHZIQNDSJNykZsS/l2njEL/8QhMmA7LuzhfrT?=
 =?us-ascii?q?i1NkTQRRYalm6AtjYzzraXFedU1XA4YjDpqA6o5irzqkQ34eacO2HT0rRO7Gzu?=
 =?us-ascii?q?e77q7OUFoXAQI98gmSgXeN4L7+KRKR2RATSHdu7N4ZgBD4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648112"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:09 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7D69D4D16FD9;
        Tue, 15 Mar 2022 18:13:06 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:08 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:13:04 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 7/7] RDMA/rxe: Add RD FLUSH service support
Date:   Tue, 15 Mar 2022 18:18:45 +0800
Message-ID: <20220315101845.4166983-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7D69D4D16FD9.AFFE1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since XRC has not been supported by the rxe, XRC FLUSH will not be
supported until rxe implements XRC service.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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



