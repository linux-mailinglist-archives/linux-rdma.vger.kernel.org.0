Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350B36098E7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJXDc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 23:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXDcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 23:32:25 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1B5D0DF;
        Sun, 23 Oct 2022 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666582342; i=@fujitsu.com;
        bh=gSj5HP5Q4BCk7l2MSunyvqKKrQUvd3/P7n/yyf89a9Y=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=m425p0/9V+EZbQHP7bevmi9ascdTJBdgsFZBInngWkEwmJkE47/sKEWAqbcS3A4DS
         QOF0dp+7/iKQcRbw8iQCIMn5KZUiT83VJWx+Y0/qsnT2Mbevodc7yIXTGq1kgELJKD
         CW30i8bxrxp5TzikvE4EFxo/8cCbE/kxBriim4rg13EQcQsI+x1dpwFZjtiJddamyk
         gsxbAJigcIqq5XuVCtoDACADUs63gGLlH8rXUMJAIP5wzBQGqaEZk2UUH6qiOCDbxk
         BHK3dHGihmN+k3Nu6IVQN5Gg0K1f5AUksR96BFo32wo6aVAu0FIXO2w+c4eK7KRxNW
         qRMhJ/53pYVcw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8MxSdeFPSz
  ZYOtuDouZM04wWkz5tZTZ4vKuOWwWzw71slh8mTqN2eL8sX52BzaPnbPusntsWtXJ5vF5k5zH
  1s+3WQJYolgz85LyKxJYM071WRTM4qqY9JOzgXEyRxcjJ4eQwBZGif6Hhl2MXED2ciaJrW/Os
  0E4Bxgl2hdNYgepYhPQkLjXcpMRxBYRiJH4d+wXmM0skCfx9c8uli5GDg5hAQ+JaXNEQUwWAV
  WJpgvOIBW8Ao4SbZMOgE2REFCQmPLwPTNEXFDi5MwnLBBTJCQOvnjBDNIqIaAkMbM7HqK8QmL
  WrDYmCFtN4uq5TcwTGPlnIemehaR7ASPTKkaz4tSistQiXUNTvaSizPSMktzEzBy9xCrdRL3U
  Ut3y1OISXUO9xPJivdTiYr3iytzknBS9vNSSTYzAgE4pZi/ewfhg2R+9Q4ySHExKorwr3gclC
  /El5adUZiQWZ8QXleakFh9ilOHgUJLgZf0amiwkWJSanlqRlpkDjC6YtAQHj5II7/2TQGne4o
  LE3OLMdIjUKUZFKXFeZrawZCEBkERGaR5cGyyiLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQ
  S5lVjBZrCk5lXAjf9FdBiJqDFl1YEgSwuSURISTUwJRnFLJr28oXYBFuFH6FXtvzMSO5ZVSzq
  c83367wsF8F33cn/P578FXtrdfjtJZfj7EPbfoctkDjvV7y/QkXDM+ZZnM7s9a0vV26XWeTJf
  HRzl8vkBe3fw868CbvjGeNps1+DXz763Bnv6V0RDa0/VwSqfFY4EqJy7O3ff4XlC+8Jvm+Ru+
  e5rPhNrdHvR/ah3xl5jyYqya5ZfyQjlTd0jVHPw+NO2+rkWKdXSuet+/3+2OIV1/RTxF12Kvj
  1Roh/TPnQlNiioHpCLj7cOojVfJN33btV09pvdzB19q069TcuTNmq2FtyS8k9cxGvXXffmoe4
  mJyYI1AnnsPZGFt86M4m/Rbpk6c/xZa0H7+pxFKckWioxVxUnAgAFpSigGMDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1666582339!189538!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25280 invoked from network); 24 Oct 2022 03:32:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Oct 2022 03:32:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B7F701000FB;
        Mon, 24 Oct 2022 04:32:19 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id AA3E11000E9;
        Mon, 24 Oct 2022 04:32:19 +0100 (BST)
Received: from e02445334835.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 24 Oct 2022 04:32:16 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>,
        "Bob Pearson" <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/2] RDMA/rxe: Remove unnecessary mr testing
Date:   Mon, 24 Oct 2022 03:31:54 +0000
Message-ID: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
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

Before the testing, we already passed it to rxe_mr_copy() where mr could
be dereferenced. so this checking is not needed.

The only way that mr is NULL is when it reaches below line 780 with
 'qp->resp.mr = NULL', which is not possible in Bob's explanation[1].

 778         if (res->state == rdatm_res_state_new) {
 779                 if (!res->replay) {
 780                         mr = qp->resp.mr;
 781                         qp->resp.mr = NULL;
 782                 } else {

[1] https://lore.kernel.org/lkml/30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com/

CC: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: remove WARN_ON # Yanjun and Bob
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..b02639cf8cba 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -811,8 +811,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 		    payload, RXE_FROM_MR_OBJ);
-	if (mr)
-		rxe_put(mr);
+	rxe_put(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
-- 
1.8.3.1

