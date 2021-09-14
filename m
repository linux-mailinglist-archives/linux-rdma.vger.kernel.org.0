Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21640A769
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhINHct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 03:32:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25073 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240783AbhINHct (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 03:32:49 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AYW0rwqIFe4C0d3P0FE+R6ZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC8gWx30TIEnGsWD2uBPayMYjCnft92OY3g9E9X7ZPQz4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAkhPjUHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnYfEbpuCbcBBTtuTWlSUqaUDE0eRsHlA0Z9VAos54BGh?=
 =?us-ascii?q?P8boTLzVlRhSCgf+mhai3T+BEmMsuNo/oMZkZt3UmyivWZd4kTp/rUaTH/dIe1?=
 =?us-ascii?q?z5YuyzkNZ4yfOJAMXw2MkuGOEYJZz8q5FsFtL/ArhHCn/dw8Tp5fZYK3lU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWQo6cq6klcNi3IBeTgPXwVuBI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZFiY6TiXIra+TdaoguSMc6AxwZJkh8erwXpVoZUmsiKKdhrNhQYtKPTOWwl?=
 =?us-ascii?q?dASbsC0WKM+UyEJ8STzJ846U4kSdkANDSSNykLsS+Z2njBLz9I+rDum8rE9ISu?=
 =?us-ascii?q?rQYfcegpUdAa0+4QMHfrLqQcfng+OXNWLuv62iIRzADQB0j/I/7LSkUtbqzmnZ?=
 =?us-ascii?q?nmhZjmaRkJC1oO7xSPtyqh7PrfHwKD1hkTfjtTyfN6mFK13TDR1+GGibWW2xXc?=
 =?us-ascii?q?32jc49B/n8bg8MJKAIiphtIOIjvhpw60bMBKWqGEvhoyvOazgWxa3+XkklMFBY?=
 =?us-ascii?q?Be+nnRdma6rV/E3BTh6i8n7zvYxVqRkRLY0IfEbQN/L/AEqZNScxPf5UZllsp7?=
 =?us-ascii?q?yrh302WQsIcSJQ/cnQzmjuK4FC1Cpw6Rmz4PgOQTh3tQXc81c7lKt7ES+0tTDd?=
 =?us-ascii?q?MpAD/60oY6C+NjZfuspMq+SWnqKkwxg1MfhOBFBh8Ib1C7qwk5y42oOgFt7TJE?=
 =?us-ascii?q?JxBy/r1Yop8CnKhNA6Wsqd60a5iBOdl1P7grhJlGdZI8qP2MeyXwqCL3QRCvyG?=
 =?us-ascii?q?vcZdU60lL22tTKCeYOlayXkKJh9upFpH2GaiIBiVIP?=
X-IronPort-AV: E=Sophos;i="5.85,292,1624291200"; 
   d="scan'208";a="114456749"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Sep 2021 15:31:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4FDA74CE84EF;
        Tue, 14 Sep 2021 15:31:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:31:22 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Sep 2021 15:31:21 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 3/3] RDMA/rxe: Remove unused WR_READ_WRITE_OR_SEND_MASK
Date:   Tue, 14 Sep 2021 16:02:53 +0800
Message-ID: <20210914080253.1145353-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
References: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4FDA74CE84EF.ABDDC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index e3a46b287c15..8f9aaaf260f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -22,7 +22,6 @@ enum rxe_wr_mask {
 	WR_LOCAL_OP_MASK		= BIT(5),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
-	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
 	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
 };
-- 
2.23.0



