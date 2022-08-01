Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672025863EF
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiHAGQc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAGQb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 02:16:31 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681FBF7F;
        Sun, 31 Jul 2022 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659334588; i=@fujitsu.com;
        bh=SqdNfRUTtps9oPoA47tb8I8RRaOQ9D0X0B9W1LY6XLQ=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kxADbukhk4LaHWYdKWOZpIT1arI14wE6PnWUiR5OkuVNgDDy2BlhK+aHCwGdu/3oV
         Zt+5zNnce7mwh/685fB+aXugYoczAtsEKo41ZtHN5lUuSmdZvXDsdiC2GUjh4YfbEI
         VPpWzMJV4sQsKdsXXuTyHStPbMouSf6wBvbwi01gORJLKBNtOJYRextGvCjwTD8iL2
         sDIopFQsFrYtWAiFOAc6hdehVrL4fFh0hj1rYsYdiMg7YBLdk6zdXzOGTlXIsb/Ams
         FG08w08DsieRmgU12IHUMZP94+sbTBSenaNWICX0DCkwEdUJwLV31wgbLOuvc0v0k4
         6TUw3zZTZG1LQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8OxWXd3/vM
  kg64/IhYzZ5xgtJjyaymzxeVdc9gsnh3qZbH4MnUas8X5Y/3sDmweO2fdZffYtKqTzePzJjmP
  rZ9vswSwRLFm5iXlVySwZjw/u5C14KhQxa5/bg2MB/m7GLk4hAQ2Mkq0np7HCuEsZpI49msLc
  xcjJ5Czn1Fi7RwZEJtNQEPiXstNRhBbRKCTUWJbaxpIA7NAC6PE2aZFYA3CAuYSbxbeZAOxWQ
  RUJN4f/MkCYvMKOEqcXPkWLC4hoCAx5eF7Zoi4oMTJmU/AapgFJCQOvngBFOcAqlGSmNkdD1F
  eITFrVhsThK0mcfXcJuYJjPyzkHTPQtK9gJFpFaNNUlFmekZJbmJmjq6hgYGuoaGprqWZrpGh
  gV5ilW6iXmqpbl5+UUmGrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgkKcUJ1zawbhu3y+9Q4ySH
  ExKorxJec+ThPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwfsgFygkWpaanVqRl5gAjDiYtwcGjJM
  IbAdLKW1yQmFucmQ6ROsWoKCXOKwzSJwCSyCjNg2uDRfklRlkpYV5GBgYGIZ6C1KLczBJU+Ve
  M4hyMSsK8biDjeTLzSuCmvwJazAS0OEv0CcjikkSElFQDk84GFaOpbCq/VH6t3Mk4e/m0L2JG
  jxSfpwv9+bo+wTz05lp98+ANzw5mG2lxdJ2SV2DZ/W+BZdq5r3f5PQ/948/X+KIg46x8Znvms
  m2Gqy0+br27wPer8LRv7X+WX0mKvvxyoXWHXHNN6MnAn05OnQq2d7xW86y1DONzcn3A8+R5yM
  rEZYGL17z95FSYd1OWYWtH34pM1tibu9eErn3tPH/RZv6ve0LnWnUu69Fm35Y5pT9wZeaG3rZ
  Wj6tfa3m1HFZ+2OURKjnN73Pf5Yvnvk50VV10WkJpQc/pmPd8XqaiORaz4v3mmc/Mf6I17e/9
  42qzHqyYcdRhe+jmr8suu2WGnxWv6JjLetDH7dV6xiwlluKMREMt5qLiRACTGfaKbQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-8.tower-745.messagelabs.com!1659334586!549255!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5502 invoked from network); 1 Aug 2022 06:16:27 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-8.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Aug 2022 06:16:27 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id B44E014C;
        Mon,  1 Aug 2022 07:16:26 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id A73BE75;
        Mon,  1 Aug 2022 07:16:26 +0100 (BST)
Received: from be48d2029e82.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 1 Aug 2022 07:16:23 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <yangx.jy@fujitsu.com>, Bob Pearson <rpearsonhpe@gmail.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/RXE: Add send_common_ack() helper
Date:   Mon, 1 Aug 2022 06:23:30 +0000
Message-ID: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
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

Most code in send_ack() and send_atomic_ack() are duplicate, move them
to a new helper send_common_ack().

In newer IBA SPEC, some opcodes require acknowledge with a zero-length read
response, with this new helper, we can easily implement it later.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 43 ++++++++++++++----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..4c398fa220fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1028,50 +1028,41 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 }
 
-static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+
+static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
+				  int opcode, const char *msg)
 {
-	int err = 0;
+	int err;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
 
-	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
-				 0, psn, syndrome);
-	if (!skb) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
+	if (!skb)
+		return -ENOMEM;
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending ack\n");
+		pr_err_ratelimited("Failed sending %s\n", msg);
 
-err1:
 	return err;
 }
 
-static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 {
-	int err = 0;
-	struct rxe_pkt_info ack_pkt;
-	struct sk_buff *skb;
-
-	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
-				 0, psn, syndrome);
-	if (!skb) {
-		err = -ENOMEM;
-		goto out;
-	}
+	return send_common_ack(qp, syndrome, psn,
+			IB_OPCODE_RC_ACKNOWLEDGE, "ACK");
+}
 
-	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err)
-		pr_err_ratelimited("Failed sending atomic ack\n");
+static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+{
+	int ret = send_common_ack(qp, syndrome, psn,
+			IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, "ATOMIC ACK");
 
 	/* have to clear this since it is used to trigger
 	 * long read replies
 	 */
 	qp->resp.res = NULL;
-out:
-	return err;
+	return ret;
 }
 
 static enum resp_states acknowledge(struct rxe_qp *qp,
-- 
1.8.3.1

