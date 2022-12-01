Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62363F30A
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiLAOjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiLAOjq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:39:46 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020BDAFCC2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905580; i=@fujitsu.com;
        bh=BKzEvjXkcQC50MMgVexxlOQl8mdnH76V6VZPI07bbHE=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=cgcyHYk7dlAvla2aZC63FM6adR4XGLWANUVsZH33QVXbD4L+eKY08YU8WhjnXCZZ1
         e5M5K2Cugsj7xIe0h2wSaw1xhlIbiDdqxAbmTWU2lw1yexd8+++D9TdPt+4JYzlvf2
         0AjD+5u4bP69kFiqF+W4cJAhVwbCFLopVVVIsDYp59pPyS/pRvvdcSuVosDqHfhAzX
         C49G3kZe3HPixJpcBCg+Y7GH9Npmf6cdoInTgpYPoKEWJloJzGy3nsQ6k8AWbPnm+W
         LGfP9ZdVuGGuWTF6LJENUjTwg/C5DwRXVD9MywcB7bJj8V5W1ZoiZ7P/HMUPC73RxT
         9NN8Yf0UAPMiw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsViZ8ORpLt6T0e
  ywem/xhZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNePhuT2sBRd5Kta8PMrcwHiKq4uRi0NIYCOjxMLJXewQzhImiam77jFBOPsYJ
  U7OvcDSxcjJwSagJrFz+kswW0TAW2LHjRPMIDazQL3E4aObGLsYOTiEBYIlXr43AQmzCKhITJ
  x8hR3E5hVwlOi8fIcVxJYQUJCY8vA9M0RcUOLkzCcsEGMkJA6+eMEMUaMo0bbkHzuEXSExa1Y
  bE4StJnH13CbmCYz8s5C0z0LSvoCRaRWjaXFqUVlqka6hXlJRZnpGSW5iZo5eYpVuol5qqW55
  anEJUCaxvFgvtbhYr7gyNzknRS8vtWQTIzCcU4rZWXcwvljyR+8QoyQHk5Iob3VnR7IQX1J+S
  mVGYnFGfFFpTmrxIUYZDg4lCd6TO4FygkWp6akVaZk5wNiCSUtw8CiJ8PKuB0rzFhck5hZnpk
  OkTjG6cpzfuX8vM8e81xeB5NTZ//YzcywHkzO/th1gFmLJy89LlRLnrdsN1CwA0pxRmgc3GpY
  WLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5t22DWgKT2ZeCdwFr4COYwI6LlKsDeS4kkSE
  lFQDk9xXBcPVB6VDr1qeXpqictEzpUc8JSTmmE543RKNt8wrZp6Nf73Jsz1wVlvQB7P/kpZxF
  36XTcuqWvL+8O97s54E8Ui/n/78xUabL7efVsX8a5Mp0d1j63Y6foPjU6MVb5e8y9M/vOdeD3
  PD9pyJenc6uLcFHH6vKcEmpPQp+GtU4flHt6/tbX2TwaezqePJIrvlbA6/t4QdchcL7dObv5t
  x6rGLDgLzv+1kFdz52OqgXXTMgZ8n3xVneMt23uWYkSzn075yifv5mfO/5d9d0hEjedeiid10
  h5DIJaYGmdQZLrI/djlfatCL9Dg9qfcZc5ap65wNL9/tNLf+URJ55IpTrcjyDbd84p4LTrCY0
  qPEUpyRaKjFXFScCABT0+w4hgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-11.tower-587.messagelabs.com!1669905579!102210!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24316 invoked from network); 1 Dec 2022 14:39:39 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-11.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:39:39 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 6CB031B9;
        Thu,  1 Dec 2022 14:39:39 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 617EF1B7;
        Thu,  1 Dec 2022 14:39:39 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:39:36 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 5/8] RDMA/rxe: Make requester support atomic write on RC service
Date:   Thu, 1 Dec 2022 14:39:25 +0000
Message-ID: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

Make requester process and send an atomic write request on RC service.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 4d45f508392f..2713e9058922 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -258,6 +258,10 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 		else
 			return fits ? IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
 				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_ATOMIC_WRITE:
+		return IB_OPCODE_RC_ATOMIC_WRITE;
+
 	case IB_WR_REG_MR:
 	case IB_WR_LOCAL_INV:
 		return opcode;
@@ -486,6 +490,11 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		}
 	}
 
+	if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		memcpy(payload_addr(pkt), wqe->dma.atomic_wr, payload);
+		wqe->dma.resid -= payload;
+	}
+
 	return 0;
 }
 
@@ -709,13 +718,15 @@ int rxe_requester(void *arg)
 	}
 
 	mask = rxe_opcode[opcode].mask;
-	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
+	if (unlikely(mask & (RXE_READ_OR_ATOMIC_MASK |
+			RXE_ATOMIC_WRITE_MASK))) {
 		if (check_init_depth(qp, wqe))
 			goto exit;
 	}
 
 	mtu = get_mtu(qp);
-	payload = (mask & RXE_WRITE_OR_SEND_MASK) ? wqe->dma.resid : 0;
+	payload = (mask & (RXE_WRITE_OR_SEND_MASK | RXE_ATOMIC_WRITE_MASK)) ?
+			wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
 			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
-- 
2.34.1

