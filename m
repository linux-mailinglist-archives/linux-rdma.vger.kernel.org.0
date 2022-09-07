Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9685AFA05
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIGClz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGCly (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:41:54 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C16878238;
        Tue,  6 Sep 2022 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662518511; i=@fujitsu.com;
        bh=e1IOWRGj50D0jLr/vNU6CG1Vjm8zy1XGVKAs8sV+qTU=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ja6OYWDhb1bIGAHoAXnbvxX96SG0QxvWVUj3SvChLPLrEKGOWKoUYH1G/FAsQGT3A
         7BQVRHdKCfxUGGNzDnxKY7px284pABROFQ+dOCp/iaNRNWOmH79+24i/kgX1pE5AGR
         QXBpZMLeLwG6nimzNTNd0UP2zmpxf6azg1fyyOG/Jul3Kc5UtbU+nNuFUa+Q2We5wD
         3iKA+IesqJ6vgjJhInN5Yr35xYKD6GXckh/D4Q6iwMVIZA3NUJVZn+GTt4Fr+dGnFR
         jFiTeIBk7zaVRsOYOI0vy0muVEO8o4UwZ86CfJ5BkFQ+M/s++6urLMK6RT0wueaEJu
         /V65jDVUPO42A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORpPuORSL
  Z4NRCY4uZM04wWkz5tZTZ4vKuOWwWzw71slicP9bP7sDqsXPWXXaPTas62Tw+b5Lz2Pr5NksA
  SxRrZl5SfkUCa8aKXadYCk7xV7y59YqxgXEnTxcjF4eQwEZGifn757NDOEuYJA4cnc/axcgJ5
  OxnlFgzRQTEZhPQkLjXcpMRxBYRiJH4d+wXmM0s4Cax6c1sdhBbWMBVonHZP7BeFgEViY9LXj
  OB2LwCjhIHD95jBrElBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL14AxTmAapQkZnbHQ5RXSDROP8Q
  EYatJXD23iXkCI/8sJN2zkHQvYGRaxWiVVJSZnlGSm5iZo2toYKBraGiqa6xraGmpl1ilm6iX
  Wqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGNYpxczHdzBO6fupd4hRkoNJSZRX9YZ4s
  hBfUn5KZUZicUZ8UWlOavEhRhkODiUJXj4GiWQhwaLU9NSKtMwcYIzBpCU4eJREINK8xQWJuc
  WZ6RCpU4yKUuK8uxmBEgIgiYzSPLg2WFxfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM6wA
  yhSczrwRu+iugxUxAi7cGioMsLklESEk1MO28o/bnlU7rsd7jDz/u2/kpUUqxd6LwpPwVHBbl
  f30eJpqYFInZV97zuLo1YvPlE3HFyxyX9G6a9prnSaOzNNOX3Utmy/E4FcdHt2dzGD56t2CRy
  6L+e3H8waGyf8Qv2PsobpGaH7XvxPclxXynBDs4Dabyn545d/Otq/FvuhrKnBMXvVPWE3Fjij
  6j0iC5/ti3j0KcGmeUM1vf1cx7fCOetaHLRJZ16SOd2ZdevVs6N1hvqohOTfn1kDfcbx6fY45
  KXXPFO11LrPD1tY82rM6zC0W0K1qqFZdGhqVpaHamfouTizeSVNs5/ff9uf9XtE91/OZ65sbq
  YwuztWS6DiXos2S84uzZZ3L14zWmeCWW4oxEQy3mouJEAKZk4LJmAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-14.tower-587.messagelabs.com!1662518510!442743!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17575 invoked from network); 7 Sep 2022 02:41:50 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-14.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Sep 2022 02:41:50 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 6B4D31AD;
        Wed,  7 Sep 2022 03:41:50 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 5FF5C1AC;
        Wed,  7 Sep 2022 03:41:50 +0100 (BST)
Received: from 21b4d06c27e6.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 7 Sep 2022 03:41:47 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 1/2] RDMA/rxe: use %u to print u32 variables
Date:   Wed, 7 Sep 2022 02:48:20 +0000
Message-ID: <1662518901-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
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

struct ib_qp_cap {
        u32     max_send_wr;
        u32     max_recv_wr;
        u32     max_send_sge;
        u32     max_recv_sge;
        u32     max_inline_data;
...

To avoid getting a negative value from dmesg:
[410580.579965] rdma_rxe: invalid send sge = 65535 > 32
[410580.583818] rdma_rxe: invalid send wr = -1 > 1048576
[410582.771323] rdma_rxe: invalid recv sge = 65535 > 32
[410582.775310] rdma_rxe: invalid recv wr = -1 > 1048576

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1dcbeacb3122..ad7f06f4beb0 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,33 +19,33 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		pr_warn("invalid send wr = %d > %d\n",
+		pr_warn("invalid send wr = %u > %d\n",
 			cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		pr_warn("invalid send sge = %d > %d\n",
+		pr_warn("invalid send sge = %u > %d\n",
 			cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			pr_warn("invalid recv wr = %d > %d\n",
+			pr_warn("invalid recv wr = %u > %d\n",
 				cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			pr_warn("invalid recv sge = %d > %d\n",
+			pr_warn("invalid recv sge = %u > %d\n",
 				cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		pr_warn("invalid max inline data = %d > %d\n",
+		pr_warn("invalid max inline data = %u > %d\n",
 			cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
-- 
1.8.3.1

