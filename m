Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AB6EBC3F
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 03:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDWB1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 21:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDWB1f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 21:27:35 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B227C2735;
        Sat, 22 Apr 2023 18:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682213251; i=@fujitsu.com;
        bh=O0kcifYVmFdHHYe5snDPuVQyH9cIgfpR9XX11fi5kg0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=irknPbmNxdYxTOoDsROLtXxBjQBinAWby00fXeXg7AzJ3y2URz/eG0NO1m13NG6mw
         sdRtpzT7y1vJvwXgEf1Ia9PwXHnbvcKqeZz2qbs6KyvHaok2WVFs5UUQoqDNOcryH0
         egjHixzE7EiDl1QG6q6KKaQ89VysMccQpHsMQywlQ16baZZxrcw5WRGKJI2TvOpq4W
         PLPSXO+6La5LzzRwejygiJ458pEOn4qEeZz3hKTR7GrlRP+9yHAfS2c2ipw17o6H55
         lT7aMBbTAkhMfqHFk+zXW5pVRO1oooWn4Om8tDt8Yud6u+iNhY1qXVDfMu8SzxCATs
         pHUtMOy9BoovA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+HYrNvQ6ZJ
  isGibrsWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNaPl/Vfmggc8FVcWfGZuYGzj7GLk4hAS2MgosfVFB
  1sXIyeQs5RJYtXMWojEAUaJD6evsIMk2AQ0JO613GQEsUUESiUOt+0DizMLJEnMu/2WGcQWFv
  CTeN3ezApiswioSszdsBgszivgKPFoxzMwW0JAQWLKw/dgNqeAk8Ty6w+ZIBY7SlyYtoYRol5
  Q4uTMJywQ8yUkDr54AdWrKHGk8y8LhF0p0frhF5StJnH13CbmCYyCs5C0z0LSvoCRaRWjWXFq
  UVlqka6lXlJRZnpGSW5iZo5eYpVuol5qqW5eflFJhq6hXmJ5sV5qcbFecWVuck6KXl5qySZGY
  HSkFKfO3sG4eNdfvUOMkhxMSqK8L3Y7pAjxJeWnVGYkFmfEF5XmpBYfYtTg4BCYcW7udCYplr
  z8vFQlCd6PbS4pQoJFqempFWmZOcAIhimV4OBREuHdWgaU5i0uSMwtzkyHSJ1iVJQS553SAZQ
  QAElklObBtcGSxiVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrx6IFN4MvNK4Ka/AlrMBLR4
  FzfY4pJEhJRUA5O1zyrVP+tttweIl+cmGrba+d6cFL1uFtO0qrsT5t16fOlP7c7TL/96iOVOD
  e9a/vmF+oy0tTfUHj4xiPojtOLavjLhax3/Jp064lKyoPN55J0Z555Fh1XeOxS1Ydqv361qF5
  eWCaTFXr8/M5z9G9NyveiNdyYd494VM/se47lXz1cUOT96UVKT9bTu5AmGlNU1EnOO79r2ujV
  u+dqnT5a/Mz51KMLkyZkEj57pL0VubNuj4uRVUS0TvP6f4Tbt65/W3X9/Tu3j/yfzD19da/KL
  J/iR2/8vJ2TEZkr6v/Q+tfksL5uKh5/BtEM/dDdX5NxWyn4/+2XM6v2P9Uqm/pxZZxFr2pEu/
  IL/nxvnxb7r7nJKLMUZiYZazEXFiQBByDHLlQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-7.tower-745.messagelabs.com!1682213248!234180!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30566 invoked from network); 23 Apr 2023 01:27:28 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-7.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Apr 2023 01:27:28 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 236B7170;
        Sun, 23 Apr 2023 02:27:28 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 175D1150;
        Sun, 23 Apr 2023 02:27:28 +0100 (BST)
Received: from d3e152dc4f88.localdomain (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 23 Apr 2023 02:27:24 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2 1/3] RDMA/rtrs: remove duplicate cq_num assignment
Date:   Sun, 23 Apr 2023 01:26:50 +0000
Message-ID: <1682213212-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

line 1701 and 1713 are duplicate:
> 1701         cq_num = max_send_wr + max_recv_wr;
 1702         /* alloc iu to recv new rkey reply when server reports flags set */
 1703         if (clt_path->flags & RTRS_MSG_NEW_RKEY_F || con->c.cid == 0) {
 1704                 con->rsp_ius = rtrs_iu_alloc(cq_num, sizeof(*rsp),
 1705                                               GFP_KERNEL,
 1706                                               clt_path->s.dev->ib_dev,
 1707                                               DMA_FROM_DEVICE,
 1708                                               rtrs_clt_rdma_done);
 1709                 if (!con->rsp_ius)
 1710                         return -ENOMEM;
 1711                 con->queue_num = cq_num;
 1712         }
> 1713         cq_num = max_send_wr + max_recv_wr;

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Add acked-by tags
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 80abf45a197a..c2065fc33a56 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1710,7 +1710,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			return -ENOMEM;
 		con->queue_num = cq_num;
 	}
-	cq_num = max_send_wr + max_recv_wr;
 	cq_vector = con->cpu % clt_path->s.dev->ib_dev->num_comp_vectors;
 	if (con->c.cid >= clt_path->s.irq_con_num)
 		err = rtrs_cq_qp_create(&clt_path->s, &con->c, max_send_sge,
-- 
2.29.2

