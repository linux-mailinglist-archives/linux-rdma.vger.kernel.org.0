Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721B4FCC53
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 04:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiDLCYw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 22:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiDLCYu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 22:24:50 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21E62E9D2;
        Mon, 11 Apr 2022 19:22:34 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AytdQmaA2u98BCBVW//Dhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBAXrhTIl02YGyWVLWDqOPv2LZ2akLotxaozg/UoAsMOAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnslYf0WpOWXSZS4mYnJp6HcSFP+0vd8HUNsZdVA0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglahGFmvLzw7+hTORortosIdOtP44FvHxkizbDAp4ORZHFXrWP/9Nd1?=
 =?us-ascii?q?R8uic1UW/XTfcwUbXxodhuoSx9ANX8FCZ8mkaGjjxHCn5dwwL6OjfNvpTGNk0o?=
 =?us-ascii?q?qi/6wWOc5s+eiHa199nt0bEqal4ghPiwnCQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6EyDRqvw/Yzs9+eQQw1pcvwj7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123488428"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Apr 2022 10:22:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id EA3E74D16FC6;
        Tue, 12 Apr 2022 10:22:27 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 12 Apr 2022 10:22:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 12 Apr 2022 10:22:26 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/3] RDMA/rxe: Remove useless parameters for update_state()
Date:   Tue, 12 Apr 2022 10:29:01 +0800
Message-ID: <20220412022903.574238-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: EA3E74D16FC6.A02E7
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

wqe was not used by update_state() so far.

aaaf62e06623 ("RDMA/rxe: Remove useless argument for update_state()")
just did a partial fixes.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 5f7348b11268..bf7493bab9b9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -525,8 +525,7 @@ static void rollback_state(struct rxe_send_wqe *wqe,
 	qp->req.psn    = rollback_psn;
 }
 
-static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			 struct rxe_pkt_info *pkt)
+static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	qp->req.opcode = pkt->opcode;
 
@@ -753,7 +752,7 @@ int rxe_requester(void *arg)
 		goto err;
 	}
 
-	update_state(qp, wqe, &pkt);
+	update_state(qp, &pkt);
 
 	goto next_wqe;
 
-- 
2.31.1



