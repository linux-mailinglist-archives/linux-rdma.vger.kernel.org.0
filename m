Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3A57B34A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGTI4o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGTI4m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 04:56:42 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A69367CB3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658307399; i=@fujitsu.com;
        bh=zB2ocOaaMAzpH4otIshXdWK3XaHkkri7AmHyrGMo6Fs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=TJBJLIKqKqniwgdO1pb2oEaT3klpIMeqUWpF/mmY1S0h9q2D4CePDEO8gO7PrsVay
         YsnA3FoCN/zUcor2JHo1gWuihNf7JXWeg9wZBVepdIdHxYZ6X8dIQt8yFUbDHPhe26
         p0k8P2ms+PuEevhrvwpZTE1rfA0IHJBLH6FOpyhOeFojj7D1W8I/Db8JhLe5n9LtEL
         lXedUzlF3sPuw+0Wbk3IbeXpcEug6YSAgmiMTKkK7QJQoAEi338GmEyZOh02T+22Bt
         kIYnEh63a0/bGFDiag6/Pkuzctglb0wApUJTJ5RNIkW92VZLb9nDi/BRU+FJryny8a
         jy+OGksyomQxA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsViZ8OxWdf98PU
  kg1l72CyOrdzMYrHgw1sWi5kzTjBaTPm1lNni2aFeFosvU6cxWxyfco7dgd1j56y77B6bVnWy
  eex8aOmxsGEqs8fHp7dYPD5vkvPY+vk2SwB7FGtmXlJ+RQJrxvfV8QXt3BWbv3UyNzAu5uxi5
  OIQEtjIKLFy5V2mLkZOIGcxk0TjK3uIxD5GiXnTD7CDJNgENCTutdxkBLFFBK4zSjzaIgtiMw
  v4Slw8fxisWVggQ+Lt6rUsIDaLgKrEyZY5bCA2r4CLxJx9t8B6JQQUJKY8fM8MYnMKuEpMebs
  XyOYAWuYi8eV1KkS5oMTJmU9YIMZLSBx88YIZolVR4kjnXxYIu0Li9eFLUHE1iavnNjFPYBSc
  haR9FpL2BYxMqxhtkooy0zNKchMzc3QNDQx0DQ1NgbShrqGpXmKVbqJeaqluXn5RSYauoV5ie
  bFeanGxXnFlbnJOil5easkmRmDkpBSn8u9gvLHvl94hRkkOJiVRXpvF15OE+JLyUyozEosz4o
  tKc1KLDzHKcHAoSfBWHwTKCRalpqdWpGXmAKMYJi3BwaMkwqsLkuYtLkjMLc5Mh0idYtTlOL9
  z/15mIZa8/LxUKXHeRyBFAiBFGaV5cCNgCeUSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe
  XweApvBk5pXAbXoFdAQT0BGTnK6AHFGSiJCSamCKVZ62akl21UVZ6VkK69/qLQrezHOSad8+s
  +4bd2qD2wXlfq2KXfuKYVuX8Ia2OzX3vu7b1BRglCMXzyG35sCOCiPGRTJGQhlSi3WEzJUWed
  21yQt0Zyv9e2v1heAJN+reHu3+rXfgTJ6U831li7gkA9+6fxKcvx7dX7puU6jUTMGwDz6fpwf
  oCZgys1/VV27WP7KzZtrbogq/SS7s2TP+OZ2I8tc98TRPRSFofp7tsWkPBPmjrus6X5yb3Cza
  851dw8TVz1dupY1UbVT2ju3z211PV+1t4DOb8dhs383SDNsN6fz6y052B8sLhCyQalkpeMD+Y
  ekR7m8aH3WLL/Af/MBgzhYQkfnOJku8T4mlOCPRUIu5qDgRAGbkOP2jAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-9.tower-732.messagelabs.com!1658307398!318012!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8051 invoked from network); 20 Jul 2022 08:56:39 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-9.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 08:56:39 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 6FD95150;
        Wed, 20 Jul 2022 09:56:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 61C8C7B;
        Wed, 20 Jul 2022 09:56:38 +0100 (BST)
Received: from centos-smtp.localdomain (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 09:56:34 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RESEND for-next v6 2/4] RDMA/rxe: Generate error completion for error requester QP state
Date:   Wed, 20 Jul 2022 04:56:06 -0400
Message-ID: <1658307368-1851-3-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
References: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
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

As per IBTA specification, all subsequent WQEs while QP is in error
state should be completed with a flush error.

Here we check QP_STATE_ERROR after req_next_wqe() so that rxe_completer()
has chance to be called where it will set CQ state to FLUSH ERROR and the
completion can associate with its WQE.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: parentheses issue # Cheng Xu
V4: check QP ERROR before QP RESET # Bob
V3: unlikely() optimization # Cheng Xu <chengyou@linux.alibaba.com>
    update commit log # Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c187deeb6e6b..cbb2ce2d7b50 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -611,9 +611,20 @@ int rxe_requester(void *arg)
 		return -EAGAIN;
 
 next_wqe:
-	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
+	if (unlikely(!qp->valid))
 		goto exit;
 
+	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
+		wqe = req_next_wqe(qp);
+		if (wqe)
+			/*
+			 * Generate an error completion for error qp state
+			 */
+			goto err;
+		else
+			goto exit;
+	}
+
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
 		qp->req.wqe_index = queue_get_consumer(q,
 						QUEUE_TYPE_FROM_CLIENT);
-- 
2.31.1

