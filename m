Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776606DC3A1
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDJGnf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJGne (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 02:43:34 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7402D47;
        Sun,  9 Apr 2023 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1681109011; i=@fujitsu.com;
        bh=iAKmY6Rq8qBoVB2F0jD25UDcsKK0ZHwfKH5rHjKCtoI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=iHXTs0ZocBp7BXI9t24Fv1NRl28IFnlBd4lzD73WlPKfMulhkoW9ENvOzXXXYApMW
         672Lpppw3M2SNmZ3kv6qjMLdGVaA6HUdItq6jk7c4olXvYHjFOOxu6CkuVgglvgC1I
         Fk3dw4HYjZvDUYNElXmqJWJiyCwHH9l+lHhP0St9J1ayFLxouCRmOPQ3shixL625et
         EtQW3/OSRImZzaY2yeDUHI0R+yRM1L4KVfH4zEHyzfv/uR9E92ISqb3tCzxTzTLqN1
         bkbBCDXs/YYa5+fgvzoCgk5N0uEp/GyCnyUgiqFt2FNPT2W7xnWzkSTXebhSJXR7Lg
         jiSRBj2UP7y9A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Kxs+GYpCu0wTj
  FYFevrMWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNePs1Wa2gpfcFZen+TUwzuHoYuTiEBLYwiix/cwmF
  ghnOZPE50lbWSGc/UCZT/eZuhg5OdgENCTutdxkBLFFBEolDrftYwexmQWSJObdfssMYgsLeE
  usWXMYrJ5FQFXi8OXXbCA2r4CjxM7Fp8HiEgIKElMevger5xRwkmhovcgKYgsB1VxZ38gIUS8
  ocXLmExaI+RISB1+8YIboVZQ40vmXBcKukGicfghqpprE1XObmCcwCs5C0j4LSfsCRqZVjKbF
  qUVlqUW6RnpJRZnpGSW5iZk5eolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZsYg
  bGRUszWvYNxfe9fvUOMkhxMSqK8XVzGKUJ8SfkplRmJxRnxRaU5qcWHGDU4OARmnJs7nUmKJS
  8/L1VJgvf7AqA6waLU9NSKtMwcYPzClEpw8CiJ8J5YBpTmLS5IzC3OTIdInWJUlBLn/bUOKCE
  AksgozYNrg6WMS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeSeBjOfJzCuBm/4KaDET0GIu
  FwOQxSWJCCmpBiaO5dNF66uldyzz+sy0bdr61U2u158ZVpgs3Zf6wc//XZ8b214BW2tvI0Mf9
  dN+6xhvNjzUuL7zGx9T4cP2bdLnVr09bNDukfb+8Z/Pk17tP/BqbXL5skJOtdt3c/9N2y/erK
  Tc+TG7qDjRdPr+RzeFKyPOaR5efED9d9S/OSnbX4ruXRia3LRpm4Bg0aR3RouvMDM+3rQhL5R
  XK8EpSqs34GPrBbscxvyHzM84T14rVnnPyej5iTnwoF74cs8Hbn8T5UJ916/6rb7pscPxX/Lm
  k9YlCM54GbslbSKL140zsZ1CxuWPvq4/Grcv85KgzQLdDrkPper1DTmmoXGaNoHrQ2X59h3hj
  Sri+flrroUSS3FGoqEWM9CZAMXtRZ+UAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-15.tower-585.messagelabs.com!1681109010!186112!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7567 invoked from network); 10 Apr 2023 06:43:30 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-15.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Apr 2023 06:43:30 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 10B55100323;
        Mon, 10 Apr 2023 07:43:30 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 021941000EE;
        Mon, 10 Apr 2023 07:43:30 +0100 (BST)
Received: from 31d618797ed9.localdomain (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 10 Apr 2023 07:43:26 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 1/3] RDMA/rtrs: Remove duplicate cq_num assignment
Date:   Mon, 10 Apr 2023 06:43:02 +0000
Message-ID: <1681108984-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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

