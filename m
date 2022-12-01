Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8163F2FE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiLAOhu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiLAOhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:37:47 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639A8975E5
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905462; i=@fujitsu.com;
        bh=CHRjduN0NRDYe/8JGKufm07sxOvCo8berBiCOjsK8eE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dBMtyD9KnkGOOVYK3/HogNcg1S16YUxq4yXVZhGbMCn8Oof4X8MsHWYEAAfWAKeBM
         hmYt1LZJFczAMVp2WnwgHDsSgIqBIZxwrBMEhOlgCsDJNToFhs68ZvhmeGFKulaVRo
         iIWqQW4tIFNRTL0CfKR2nycJmnG42uB8DPxkjpT7682lIbGtWEpbtFt0fCT7KA8EpF
         AsMeAtfnLZuXm2WcVAqDH4iWxJnKnjuXhvPgyOhn2UUxqJL6TS/NFrDAe6L0asFDD3
         urIDb3SrPikRH5Ej8waLLZc8qk4BzBT8pfPK0S6BBvheGfpNKHYHzn7BMSyEUmumZZ
         noB63gub3ukmA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRWlGSWpSXmKPExsViZ8OxWdd0T0e
  ywc/tOhZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNWPjpVWsBQcEK5Y9kmxg3MrXxcjFISSwkVFiYvMLli5GTiBnCZPEzvPmEIl9j
  BI/mnYygiTYBNQkdk5/CVYkIuAtsePGCWYQm1mgXuLw0U1gNcICQRLL+n4CxTk4WARUJNru5I
  KEeQUcJZ6sgCiREFCQmPLwPVgJp4CTxJLrORBrHSXeL+5kgygXlDg58wkLxHQJiYMvXjBDtCp
  KtC35xw5hV0jMmtXGBGGrSVw9t4l5AqPgLCTts5C0L2BkWsVoWpxaVJZapGukl1SUmZ5RkpuY
  maOXWKWbqJdaqlueWlwClEksL9ZLLS7WK67MTc5J0ctLLdnECAz8lGKF7zsYu5f+0TvEKMnBp
  CTKW93ZkSzEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgvfkTqCcYFFqempFWmYOMAph0hIcPEoivL
  zrgdK8xQWJucWZ6RCpU4y6HFNn/9vPLMSSl5+XKiXO27MLqEgApCijNA9uBCwhXGKUlRLmZWR
  gYBDiKUgtys0sQZV/xSjOwagkzLttG9AUnsy8ErhNr4COYAI6IlKsDeSIkkSElFQD0+K3r2Zv
  fZ8+v+hM4qTef3eCQmp2eR1r6xT++tepZt4f0//VXhtkLhxiPdJlqeOTMmmrmjXLT7XNLto7T
  dSPr52865dO5MnXHGdZrkSdfywlF5RxdYrZ7zj/8xnO6q4PC6cW3Dhg++nUg+DlzpvPrCwTdl
  59SVDxwQW2cy9UPry5NU/b/rhVwqzy9g0vN76rMJDbys6hUKWQVc5f9HGBrq/ckttScy2633v
  siLvjIBCU8k5xiVJ38/xvfVELt3b7n1g/3aWv4FfuUptt79t5L2eXFml8FZ3LKe7x3//9db8T
  /9O/BX9Ku8+xRuOU0LQ1b6Sva75/+L93elfjjTbfuBmWUtYnJ5q//uKRzx9nn67EUpyRaKjFX
  FScCACwfzzYgwMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-15.tower-565.messagelabs.com!1669905461!136039!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24075 invoked from network); 1 Dec 2022 14:37:41 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-15.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:37:41 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 6A2EC15A;
        Thu,  1 Dec 2022 14:37:41 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 5D02C159;
        Thu,  1 Dec 2022 14:37:41 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:37:38 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 4/8] RDMA/rxe: Extend rxe packet format to support atomic write
Date:   Thu, 1 Dec 2022 14:37:08 +0000
Message-ID: <1669905432-14-5-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
References: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_wr_opcode_info[] and rxe_opcode[] for new atomic write opcode.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index d4ba4d506f17..fb196029048e 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_ATOMIC_WRITE]                       = {
+		.name   = "IB_WR_ATOMIC_WRITE",
+		.mask   = {
+			[IB_QPT_RC]     = WR_ATOMIC_WRITE_MASK,
+		},
+	},
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
@@ -378,6 +384,18 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 					  RXE_IETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_ATOMIC_WRITE]                        = {
+		.name   = "IB_OPCODE_RC_ATOMIC_WRITE",
+		.mask   = RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_ATOMIC_WRITE_MASK | RXE_START_MASK |
+			  RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]       = 0,
+			[RXE_RETH]      = RXE_BTH_BYTES,
+			[RXE_PAYLOAD]   = RXE_BTH_BYTES + RXE_RETH_BYTES,
+		}
+	},
 
 	/* UC */
 	[IB_OPCODE_UC_SEND_FIRST]			= {
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..a470e9b0b884 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -20,6 +20,7 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_OP_MASK		= BIT(5),
+	WR_ATOMIC_WRITE_MASK		= BIT(7),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
@@ -81,6 +82,8 @@ enum rxe_hdr_mask {
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
 
+	RXE_ATOMIC_WRITE_MASK   = BIT(NUM_HDR_TYPES + 14),
+
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
 	RXE_READ_OR_WRITE_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK),
-- 
2.34.1

