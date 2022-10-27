Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C360F126
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiJ0Hbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiJ0Hbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 03:31:47 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9E164BFC
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666855904; i=@fujitsu.com;
        bh=Lc+DwelVEmusFivfLbjCEIhaIPGhK6fMwrBE5p6tAY4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Rd026vXVKKA3Fccp0/xrFBfs01EwzYmGamm96CVDB9eclFt4mG7a8Xb14O+9u2lPU
         t8jZyLtLG9Y3zQ7lSQ125hNte3+alpYsCpWR7ei0ZIc1joxpTuxGMgibZtr1DhZQSA
         9LtFIOafVzTY6C7q/rnEHwH+spn/hlxfkRpnEZGJUvUkA9OBTlXdCkRF5tizSwjHUl
         b17hUst08YDNroAsuKLWCkdIN8amRDgPDFLiVVJ6j0gptJrGBenOigmkXmP0WzLdqC
         RQ6xHxs/3A41FosyJxYh7szp5/C9TahVsTQ7ac4RX+1W6ZCHtFo+Gq1adN+PjUh0N3
         Gr6xBGsxU0a8A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8OxWfe+cVS
  ywapOJYuZM04wWkz5tZTZ4tmhXhYHZo9NqzrZPD5vkvPY+vk2SwBzFGtmXlJ+RQJrxptPR1kK
  brFWHGx7wd7A+J+li5GTQ0hgI6PEguXJXYxcQPYSJokVj9YwQyT2M0ocnCQMYrMJqEnsnP4Sr
  EFEQEHi38m9YDXMAu4S0++sZwWxhQW8JT7unA9mswioSmzduputi5GDg1fASWJygxRIWAKodc
  rD92CtvAKCEidnPmGBGCMhcfDFC2aIGkWJtiX/2CHsColZs9qYIGw1iavnNjFPYOSfhaR9FpL
  2BYxMqxjNilOLylKLdA1N9ZKKMtMzSnITM3P0Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OT
  c1L08lJLNjECwzWlWOHSDsY3y/7oHWKU5GBSEuVNZIpKFuJLyk+pzEgszogvKs1JLT7EqMHBI
  TDj3NzpTFIsefl5qUoSvHsMgOoEi1LTUyvSMnOAMQVTKsHBoyTCq68MlOYtLkjMLc5Mh0idYl
  SUEueNNQRKCIAkMkrz4NpgcXyJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvNcgUnsy8Erj
  pr4AWMwEtXjM3DGRxSSJCSqqBic90pxrn9f1rmYXTEm89ZvjyJa9Odt58i7UvRfrPfe04IZj5
  RL/Py/Jny6PLvC+ufvm5/4HH9Ms+N/6+n8PQzm13MueehUw//7czZte3c2yM+7z4tb2PQr7Pj
  ylOFqyhr64LvcjuPpfUVCw5Pe3L9a7n07acyJk5ydkj4eHWiFYW/9pZ3/eKuzA1Xv0xx+RwCv
  vJ9MXL2c6mNot35brJlOhGM/4UbOfekfhB6uUZhT8TWKKFnr9bn+3rrbjq+N27SS+ahXIC51m
  ff/Inav6c0sMhAnvm6uy68bJtwl6/VaFyK74vK3PIi5XnVHmSxjzR6faHlyWr84t4Xu1b/OHw
  8VVuf3RWxjvfbfwpEP/F/YESS3FGoqEWc1FxIgBrgr8UXgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-17.tower-548.messagelabs.com!1666855903!35264!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18516 invoked from network); 27 Oct 2022 07:31:43 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-17.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2022 07:31:43 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 47974155;
        Thu, 27 Oct 2022 08:31:43 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 3A80A153;
        Thu, 27 Oct 2022 08:31:43 +0100 (BST)
Received: from 24cc950b386d.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 27 Oct 2022 08:31:40 +0100
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove the duplicate assignment of mr->map_shift
Date:   Thu, 27 Oct 2022 07:31:33 +0000
Message-ID: <1666855893-145-1-git-send-email-yangx.jy@fujitsu.com>
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

mr->map_shift is set to ilog2(RXE_BUF_PER_MAP) in both rxe_mr_init()
and rxe_mr_alloc() so remove the duplicate one in rxe_mr_init().

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d4f10c2d1aa7..279fac4c21d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -62,7 +62,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->rkey = mr->ibmr.rkey = rkey;
 
 	mr->state = RXE_MR_STATE_INVALID;
-	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
-- 
2.34.1

