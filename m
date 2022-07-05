Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5A566A19
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiGELqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiGELqN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 07:46:13 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 519FE17069
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 04:46:11 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A7orUs6yQBeOtbDDncJd6t+fXxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDwrhDAGzGAZC2mOPv2LNGGkc4xwady//E1SvJOAm4RkHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhjtl3x8ULt42YR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPcZouCZeCfu2SCU5wicG5f2+N10FEw/J5Yf/OZvDEl?=
 =?us-ascii?q?B8PUZLHYGaRXrr/CnwqCqSLM03pwLI8ziPYdZsXZlpRndAPEgaZPOWaPH4Zlfx?=
 =?us-ascii?q?jhYrsRPG+vOItAVbDNHchvNeVtMN00RBZZ4m/2n7lH9fDJwulOYvadx6GG78eD?=
 =?us-ascii?q?b+NABK/KMIprTG5oTxR3e+wr7E63CKklyHLSiJfCtqxpAXtPyoB4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApX1qQawWX7hAjoyQJbDRKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127276179"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jul 2022 19:46:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id A00084D1716E;
        Tue,  5 Jul 2022 19:46:09 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 5 Jul 2022 19:46:08 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 5 Jul 2022 19:46:10 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Date:   Tue, 5 Jul 2022 19:46:03 +0800
Message-ID: <20220705114603.6768-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705114603.6768-1-yangx.jy@fujitsu.com>
References: <20220705114603.6768-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A00084D1716E.A6D31
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's better to use the unified naming format.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5536582b8fe4..265e46fe050f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -595,7 +595,7 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
-static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
+static enum resp_states atomic_reply(struct rxe_qp *qp,
 					 struct rxe_pkt_info *pkt)
 {
 	u64 *vaddr;
@@ -1333,7 +1333,7 @@ int rxe_responder(void *arg)
 			state = read_reply(qp, pkt);
 			break;
 		case RESPST_ATOMIC_REPLY:
-			state = rxe_atomic_reply(qp, pkt);
+			state = atomic_reply(qp, pkt);
 			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
-- 
2.34.1



