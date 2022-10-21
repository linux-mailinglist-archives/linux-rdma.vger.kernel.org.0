Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92070607178
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJUHxW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUHxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 03:53:21 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8203247E22;
        Fri, 21 Oct 2022 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666338797; i=@fujitsu.com;
        bh=szLPaMCwWt2GPt2jeJIVDwTUnrQYN4R0TZFNJZtF4F0=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=hjYtH5HnBrGXyHODtjGkU2kFODdH4Ey1XykB++B7nkrK/WwJvQqzBhhFivYiLOST3
         xzm/ARdZXZ2UPzjnvdnep7M4B/4hCmBRb00USLG608JEoEwQtZar3Uzp1H8WdvbNg0
         4GhlkAREvpSRAXNj0ucb5UG7urfKRe/IgEwu5/ECi5uIqNAFacP9TcrcZPi8KabZhi
         ci+Rb66nMCaKr4H352uGVJb99NaK+WsQSG2veeDwdE+YoTYU4Xp9DXcC3FJYTtK1yL
         rCNxCXrbwT7wb7+LhRCTMXYXIhKKvPZxvJ2aRiycU0uqrmKyVhP9rvNqnOrXioiJVQ
         vhBr1YyZDh/UA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8OxWfeNf1C
  ywdOJahYzZ5xgtJjyaymzxeVdc9gsnh3qZbE4f6yf3YHVY+esu+wem1Z1snl83iTnsfXzbZYA
  lijWzLyk/IoE1ozeBe3sBZs4K55MW8bewPiZvYuRi0NIYCOjxMorz1ggnCVMEpOOT4TKHGCUm
  LalDSjDycEmoCFxr+UmI4gtIhAj8e/YLzCbWcBNYtOb2ewgtrCAh8SJSwfA4iwCqhJ9D48zgd
  i8Ao4SD04vBauREFCQmPLwPTNEXFDi5MwnLBBzJCQOvngBFOcAqlGSmNkdD1FeITFrVhsThK0
  mcfXcJuYJjPyzkHTPQtK9gJFpFaN5cWpRWWqRrqGpXlJRZnpGSW5iZo5eYpVuol5qqW5eflFJ
  hq6hXmJ5sV5qcbFecWVuck6KXl5qySZGYEinFCdw72B8tOyP3iFGSQ4mJVFeIYWgZCG+pPyUy
  ozE4oz4otKc1OJDjDIcHEoSvHN9gHKCRanpqRVpmTnA+IJJS3DwKInw9noBpXmLCxJzizPTIV
  KnGBWlxHmX+AElBEASGaV5cG2wmL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg3H2Q8T2Z
  eCdz0V0CLmYAWm27xA1lckoiQkmpg8j7nYJ/9P2TKshPaOb/r4vddeLnQ5F84J/fkt2uluP6v
  zv6w2GSt2gmvGoPrrt92WX9PlLH6FGdiftF+rfHCK7yxnLfW9hpwT43RyniytqX0xqZmfd81Z
  x/MCzA7kPP3bs/FuKkyrd8a5nLUprv4fmszXVdStukZz7uOzPk73FKaCyu2ri3SyygpstnIue
  soa/ILx60lT+JKD4izLfU15LD8YyoXv/bFRnXDJ4mTWhqNr5xR07aukJ8xp/TGHvVPIsJbbm7
  5IWfPl75dpq7wS73Ita3b31pcfP1GfkaJxf0l1/9ss5NZWbprJlfB+XxrDu3UmOeMeydZCKhZ
  fNlfY715m36fbfy9j2v12AXfKbEUZyQaajEXFScCAG+7r19kAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-8.tower-732.messagelabs.com!1666338796!137848!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3584 invoked from network); 21 Oct 2022 07:53:16 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-8.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Oct 2022 07:53:16 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 1A429155;
        Fri, 21 Oct 2022 08:53:16 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 0CF9D153;
        Fri, 21 Oct 2022 08:53:16 +0100 (BST)
Received: from 988193f0f739.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 21 Oct 2022 08:53:13 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Date:   Fri, 21 Oct 2022 07:52:43 +0000
Message-ID: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before the testing, we already passed it to rxe_mr_copy() where mr could
be dereferenced. so this checking is not exactly correct.

I tried to figure out the details how/when mr could be NULL, but failed
at last. Add a WARN_ON(!mr) to that path to tell us more when it
happends.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..218c14fb07c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (res->state == rdatm_res_state_new) {
 		if (!res->replay) {
 			mr = qp->resp.mr;
+			WARN_ON(!mr);
 			qp->resp.mr = NULL;
 		} else {
 			mr = rxe_recheck_mr(qp, res->read.rkey);
@@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 		    payload, RXE_FROM_MR_OBJ);
-	if (mr)
-		rxe_put(mr);
+	rxe_put(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
-- 
2.31.1

