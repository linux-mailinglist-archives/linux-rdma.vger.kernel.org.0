Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D706ED981
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 03:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjDYBEq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 21:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDYBEm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 21:04:42 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590A4B468;
        Mon, 24 Apr 2023 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682384665; i=@fujitsu.com;
        bh=1lOrz3WkF8WW2Sm93QlBxTpItpbsuBYyhX73hc+vyXw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=xdPv68VjjDrapfyV6edaawjiHuptKdVLwrVQw49Zql7B6fLNT9k3X6RWOufAupU+K
         3ikOXCj0KXMB1NSdg6ynfcLzNRDkx6XxeeNNS0hENd03/Bczttj4tfUMl4QRhTIwrr
         ZfG5QyCQbdLU3xGDC0aezZTvU8pFi7MvIprKQNw+T9zoVl4XEOCjZdAAGme7v0YIBT
         H9GCJc9o41WSVAPkntlR/U0se45uU+qdqErnRt7Cis72K4XfPNDlRUV2QEv3f1fx+j
         K/ic6lDmw340ri4xc7LX6WbCNRcne7vlJmx3WokekMjC8jGYLz+k0VKUKAnXNwsDCS
         byGrJvP7AsAOA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRWlGSWpSXmKPExsViZ8ORpCuh7p5
  isPeKhMWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNePt4XXsBYs5Kn7c62VpYOxl72Lk4hAS2MgocePHQ
  mYIZymTxPafj1khnIOMEm+e/mbsYuTkYBPQkLjXchPMFhEIkli65jUTSBGzQCujxJGmScwgCW
  GBQIn7kzrAbBYBVYkrH5ezg9i8Ao4Sy7fMZgGxJQQUJKY8fA9WwyngJLHpbScbiC0EVDNl8w0
  WiHpBiZMzn4DZzAISEgdfvGCG6FWSuPj1DiuEXSnR+uEX1Ew1iavnNjFPYBSchaR9FpL2BYxM
  qxhNi1OLylKLdI31kooy0zNKchMzc/QSq3QT9VJLdctTi0t0jfQSy4v1UouL9Yorc5NzUvTyU
  ks2MQLjI6VYWW4H4+mdf/UOMUpyMCmJ8nKFuaUI8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuC9oO
  qeIiRYlJqeWpGWmQOMVZi0BAePkgjvUiWgNG9xQWJucWY6ROoUo6KUOK8sSJ8ASCKjNA+uDZY
  eLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5o1UA5rCk5lXAjf9FdBiJqDFu7hdQBaXJCKk
  pBqYsrdbLr7h27ohq3Ci1J58Tr4XWz8tSzxr+Yk5QHjusY2rs5b+1daU2ezpsd0/5YPr5zkXX
  87oqt60a9UGUb48t087nFl27LD1mlBU4ycQE7B+0p6nmXUlF62/WW91l9ZZUdl60eN8c/6ZBd
  EPiu8ufrJVReAp4xLrH2IhLc89elzfBDKuq7giZNSu6PVLJV++nenQptsnsuWSz+koGU86eOX
  68QCxs1WGYszMc48vi6tjfHVeKOWmel7UHv/9q77LTjK6c1H/ytL5QvImN6QO2rKdni4Svld6
  VZvy4fyr2pnZdzJiJrzwkz7/990WtSP+O8TO3Dq7MOFi2DZ5pQ/CTxY4Ox4K005ez2W4xiO+Q
  YmlOCPRUIu5qDgRAMBUMrSKAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1682384664!308683!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11972 invoked from network); 25 Apr 2023 01:04:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 01:04:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 195BE1BC;
        Tue, 25 Apr 2023 02:04:24 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 0D05F1C0;
        Tue, 25 Apr 2023 02:04:24 +0100 (BST)
Received: from 0819309620d6.localdomain (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 02:04:20 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <guoqing.jiang@linux.dev>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v3 2/3] RDMA/rtrs: Fix the last iu->buf leak in err path
Date:   Tue, 25 Apr 2023 01:02:42 +0000
Message-ID: <1682384563-2-3-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The last iu->buf will leak if ib_dma_mapping_error() fails.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
V3: add fixes and acked tags
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

