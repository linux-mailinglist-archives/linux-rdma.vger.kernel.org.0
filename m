Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB957B349
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGTI4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTI4h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 04:56:37 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8AD20F73
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658307395; i=@fujitsu.com;
        bh=WWvTr9oZhgTy9NzyKlfCg+FUhx6T8/rIpXev7udUMt4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=xKKgWMEKkyMMplSOBTwZVfwxTmAsJj2QAHZnJXFCaCDPskPRamzTPPtEPehPdQejp
         MyhB/CaIEHSGYZ2J9xnrnJkxfsWxx7fH+5F4N4ewHFNf6XH2q9Zs1LYMKyKinqUZim
         YhhL1qMVwYY4MaNa2pHS+ubD8r2lgOkidbVCRfzZUN1oH77udyYk1fqoZMS9It0+t/
         uwwN66OC19mpwZu6/gOVcopb+ZgNZ8HmYmYQiJJnOnp489l1PJYcvSh04bvfeiMWKk
         UyOYcgZpQoKEWAtvafIO6c9QDyRIWVkGbMX8puvnKw3GFg6PjFadSGL7M6z82yZirY
         rdleXdjDam4zA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleJIrShJLcpLzFFi42Kxs+FI1HU6fD3
  JYNFLKYtjKzezWCz48JbFYuaME4wWU34tZbZ4dqiXxeLL1GnMFsennGN3YPfYOesuu8emVZ1s
  HjsfWnosbJjK7PHx6S0Wj8+b5Dy2fr7NEsAexZqZl5RfkcCaserPB/aC6+wVz9/8ZmlgvM3Wx
  cjFISSwhVHiX+NHRghnOZPE14k/gDKcQM4+Ron9e3xAbDYBDYl7LTcZQWwRgeuMEo+2yILYzA
  K+EhfPH2YCsYUFEiS2/DjEDmKzCKhKrH/8kRXE5hVwkdj9fj8ziC0hoCAx5eF7MJtTwFViytu
  9QDYH0C4XiS+vUyHKBSVOznzCAjFeQuLgixdQrYoSRzr/skDYFRKvD1+CiqtJXD23iXkCo+As
  JO2zkLQvYGRaxWidVJSZnlGSm5iZo2toYKBraGiqa2wEZJroJVbpJuqlluqWpxaX6BrpJZYX6
  6UWF+sVV+Ym56To5aWWbGIERk5KsULGDsbvK3/qHWKU5GBSEuW1WXw9SYgvKT+lMiOxOCO+qD
  QntfgQowwHh5IEb/VBoJxgUWp6akVaZg4wimHSEhw8SiK8uiBp3uKCxNzizHSI1ClGRSlx3kc
  gCQGQREZpHlwbLHFcYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM++sA0BSezLwSuOmvgBYz
  AS2e5HQFZHFJIkJKqoHp6Plnl6dVChWI73c98fNHtcmFNsX37fafd8w/tGChzMy7OvJfI//1e
  Og2FhT0fJgZKqdmsZ+LJTLL4drjxY4GU52/np8jq/5RvW1peafSE22VrDWH6nauy4xtZY/61/
  a//cwhc5X8j3MCPhzkkyta8PPmdT+VA4k29wV+bpN4MoP3aPrd0OMiIrqn1z3wZmO69ODK1T0
  R5fdb6iZcdr3v4lfDOPvN93DpzYGJa6plg7l/XftR+m/dg0lqB35veCpmx1DEaHmR+9Pf1xuP
  s35xfeUieeOGw3zdsu93A5pONkQE8E6Yf9tZnTH835VdAskVF7gvss41f6ndL8U0w5L18A7Hq
  fLTdkzVbVR++CrlhRJLcUaioRZzUXEiAAgfxb6XAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-5.tower-571.messagelabs.com!1658307394!160602!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4467 invoked from network); 20 Jul 2022 08:56:34 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-5.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 08:56:34 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 19C79100191;
        Wed, 20 Jul 2022 09:56:34 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0CF32100190;
        Wed, 20 Jul 2022 09:56:34 +0100 (BST)
Received: from centos-smtp.localdomain (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 09:56:30 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RESEND for-next v6 1/4] RDMA/rxe: Update wqe_index for each wqe error completion
Date:   Wed, 20 Jul 2022 04:56:05 -0400
Message-ID: <1658307368-1851-2-git-send-email-lizhijian@fujitsu.com>
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

Previously, if user space keeps sending abnormal wqe, queue.index will
keep increasing while qp->req.wqe_index doesn't. Once
qp->req.wqe_index==queue.index in next round, req_next_wqe() will treat queue
as empty. In such case, no new completion would be generated.

Update wqe_index for each wqe completion so that req_next_wqe() can get
next wqe properly.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index dec4ddaca70f..c187deeb6e6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -760,6 +760,8 @@ int rxe_requester(void *arg)
 	if (ah)
 		rxe_put(ah);
 err:
+	/* update wqe_index for each wqe completion */
+	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 
-- 
2.31.1

