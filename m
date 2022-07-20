Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EEA57B34D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiGTI4x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGTI4t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 04:56:49 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBE6BC27
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658307406; i=@fujitsu.com;
        bh=exwYpHRudrNXVQdZIG8MptKqNawZdKpVdTio4sV4GlA=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=G2D+ar4Uf8Y0x28dWv2DMBcGq9VAbRqa57lxsL8Eghi6Z8pDlEoGjM8QXc3LdQUwr
         P/mEmFhUzEsPeMFOq3re/LolGGcSgAuqrnNQacsqx/pC1cyfHdhHbvSOmN+3CPQZrj
         zmIaDQjq88E/WeR1DToIIM0IT5YQPc1hVfBeSRk+s2ctRAKhqq+/edufAps78eW7Wt
         xgIPSp+di6eBCVuFYZkgNk4SEc6AjY9KkPPt+qwKb//nOWuAG415qSpLVDjzAXhI5X
         uG6TeeV+PgRP+YJFeOpcHTRWD9vtxi6diJKwhjWro5+igPZP1xq8Dx3tEHZ6M9u+3u
         KQ4ySVEhfQABw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsViZ8ORqOt7+Hq
  SQcM/TYtjKzezWCz48JbFYuaME4wWU34tZbZ4dqiXxeLL1GnMFsennGN3YPfYOesuu8emVZ1s
  HjsfWnosbJjK7PHx6S0Wj8+b5Dy2fr7NEsAexZqZl5RfkcCa8XfPLuaCT6wVDxe9Ym9g/MbSx
  cjFISSwhVHi1PR7jBDOciaJ97MmMEE4+xglvt5Yzt7FyMnBJqAhca/lJiOILSJwnVHi0RZZEJ
  tZwFfi4vnDQA0cHMICrhKL5lmChFkEVCWur9jCAmLzCrhINH/eAWZLCChITHn4nhnE5gQqn/J
  2LzNIqxBQzZfXqRDlghInZz5hgZguIXHwxQtmiFZFiSOdf6HGVEi8PnwJKq4mcfXcJuYJjIKz
  kLTPQtK+gJFpFaNNUlFmekZJbmJmjq6hgYGuoaGprqWZrqGxkV5ilW6iXmqpbl5+UUmGrqFeY
  nmxXmpxsV5xZW5yTopeXmrJJkZg7KQUJ7TsYLy975feIUZJDiYlUV6bxdeThPiS8lMqMxKLM+
  KLSnNSiw8xynBwKEnwVh8EygkWpaanVqRl5gDjGCYtwcGjJMKrC5LmLS5IzC3OTIdInWLU5Zg
  3+99+ZiGWvPy8VClx3kcgRQIgRRmleXAjYCnlEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh
  3l8HgKbwZOaVwG16BXQEE9ARk5yugBxRkoiQkmpgSr293NyGi1PqrOz1P5wTEvw+M17z9XCLK
  GS+2ZNYW7JnabuHS1mJorl47TR7HaUJZyfrGaxgXOen5n/R7tgyt80CTxcflTwcoKu6b0bj0n
  juR0L91/znJb1X4uqfL9GkffSQtjpjsgnz8j/K9bzTKqwSmjq2nFnRdGXzpDvFx1z/MuhETLz
  51e3Lsg1yL8NOnJ3RvN/jCvuHx8ed43fuj/z2+ZTfLfYNvu+fGxtxPKxVeDXr+0v3rrv8f778
  /9yivXvuJuaN28792br9Y+zxZYuFVgexl/6dcPr5E+VKk7B1R+6+Y3t0XU5iS1O6dvyNk2VXF
  jLOLV5vub/X4tadI3sU6iwXLXjdO5N9jc79wo9KLMUZiYZazEXFiQCBdQHKpAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-7.tower-728.messagelabs.com!1658307405!45336!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15051 invoked from network); 20 Jul 2022 08:56:45 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-7.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 08:56:45 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0C38E100190;
        Wed, 20 Jul 2022 09:56:45 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 00007100043;
        Wed, 20 Jul 2022 09:56:44 +0100 (BST)
Received: from centos-smtp.localdomain (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 09:56:41 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RESEND for-next v6 4/4] RDMA/rxe: Fix typo in comment
Date:   Wed, 20 Jul 2022 04:56:08 -0400
Message-ID: <1658307368-1851-5-git-send-email-lizhijian@fujitsu.com>
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

Fix a spelling mistake

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 0c4db5bb17d7..c9b80410cd5b 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -67,7 +67,7 @@ void rxe_do_task(struct tasklet_struct *t)
 				cont = 1;
 			break;
 
-		/* soneone tried to run the task since the last time we called
+		/* someone tried to run the task since the last time we called
 		 * func, so we will call one more time regardless of the
 		 * return value
 		 */
-- 
2.31.1

