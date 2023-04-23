Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177146EBC41
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 03:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDWB1k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 21:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjDWB1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 21:27:37 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46030D0;
        Sat, 22 Apr 2023 18:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682213253; i=@fujitsu.com;
        bh=W4sJFNaU5Kv134M+xnc5Z7XEkhGC4xXYWGqOZ13zAns=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=FJVHNU70chKRKd8zorz8HeF4+bCBlUzsWZwZfdNdjBKY/QKCcZyDIsEZtOtRpurfm
         O0OqecTCcBKaq+ME09Oo/l2quZVENvhs4dsvZ0az8XaE1K18mIBeJIycERXs+uj7n3
         8+9Gj+1PD2ggve3v0xEuM8NPU/3U8UovsOVvHaOtcMBpBDjlCWWaP+PeyOozLLHVxT
         QYiBviorB6g65LcWCxUE4yy60FgB4hSveTtjtugG6PPTM2J/Q16qXWi/L144DJOD7l
         MMPr2lZXxyH0vZcqsvJDgUcUeEA4J0QIZ38pDvI8A+LdHRXdl0jTVzvlYCMmfvV/Zv
         LUX1Xu5UMLF9Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsViZ8OxWbe50yX
  F4MV/TYsb0+Qstp3ewG4xc8YJRou3m6awWEz5tZTZ4vKuOWwWzw71sjiwe5x+c4fJY9OqTjaP
  hQ1TmT0+b5Lz2Pr5NksAaxRrZl5SfkUCa8a+hctZC06yVbStf8XcwHiWtYuRi0NIYCOjxNHD2
  5khnKVMEs3TmtkhnAOMEi2TPjJ1MXJysAloSNxruckIYosIlEocbtvHDmIzCyRJzLv9lhnEFh
  YIlJh/+jRYPYuAqsThbztYQWxeAUeJc+v62EBsCQEFiSkP34PVcwo4SSy//hCsXgio5sK0NYw
  Q9YISJ2c+YYGYLyFx8MULZoheRYkjnX9ZIOxKidYPv6BsNYmr5zYxT2AUnIWkfRaS9gWMTKsY
  TYtTi8pSi3RN9JKKMtMzSnITM3P0Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLN
  jECoyOlWKljB+P1nX/1DjFKcjApifK+2O2QIsSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC92ObS4
  qQYFFqempFWmYOMFJh0hIcPEoivFvLgNK8xQWJucWZ6RCpU4yKUuK8UzqAEgIgiYzSPLg2WHK
  4xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYVw9kCk9mXgnc9FdAi5mAFu/iBltckoiQkmpg
  qt2xUcziiuY38dpvXtr9N5pE69Jub9FeeC/2fkVMU2v7M/fbTA+c3Nf/V/7UwDNn53vTtr/Za
  xJ7ddiDrmmfTNkW7ibxS8E/4GSrn1zNvo/aZaFnDXMZbxatUy+3uhj3+uyPk8+4vA3P3SsNNt
  V7s3OHguveptjmQiYP9QsHc9U0bvX/YRd8bcvzLMPsc/TRsPeLBT6rf/xvU+ksemrPt8QyhT4
  1rntzDycnOt11vMF9hP9l+LVJmUxHJkzK0Xgn7F2Z+bo6qXCyGV9Dmsp9Lp7oNwrBUZx8KnuP
  PpvwcvI1jeToYwG9rpX7IuNTKj79OJ5RLxaX921S6JsrSnKzFJtjWXf4TxaeyPpH55cSS3FGo
  qEWc1FxIgDmC3JdiQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-18.tower-565.messagelabs.com!1682213251!159822!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 861 invoked from network); 23 Apr 2023 01:27:31 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-18.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Apr 2023 01:27:31 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5E8C4170;
        Sun, 23 Apr 2023 02:27:31 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 5249F150;
        Sun, 23 Apr 2023 02:27:31 +0100 (BST)
Received: from d3e152dc4f88.localdomain (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 23 Apr 2023 02:27:28 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2 2/3] RDMA/rtrs: Fix the last iu->buf leak in err path
Date:   Sun, 23 Apr 2023 01:26:51 +0000
Message-ID: <1682213212-2-3-git-send-email-lizhijian@fujitsu.com>
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

The last iu->buf will leak if ib_dma_mapping_error() fails.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: new patch to address memory leaking
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4bf9d868cc52..3696f367ff51 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size, gfp_t gfp_mask,
 			goto err;
 
 		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
-		if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
+		if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
+			kfree(iu->buf);
 			goto err;
+		}
 
 		iu->cqe.done  = done;
 		iu->size      = size;
-- 
2.29.2

