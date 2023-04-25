Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB016ED97F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 03:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjDYBEm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDYBEl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 21:04:41 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A65AF1C;
        Mon, 24 Apr 2023 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682384663; i=@fujitsu.com;
        bh=O0kcifYVmFdHHYe5snDPuVQyH9cIgfpR9XX11fi5kg0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Rze6ebYeALFG9TUcby0W6ULkEIr4nHyRqKYwc9ftk2R2Eg2tTKIbov60gm6t/uQuX
         9oWU3jNapo+UGrczav8gYbxbs26sXgAv2MmbWkpxGRkefzzKrDK+9Qx7Ca1gzc2ybg
         wXcxb1B5XmtnDetXGWQFDuT0LbZ8ivW1shPvCfrz7b3HLp6AxPiD2QW0JLQkegv9S4
         zaB/SquLdFR1bgb00H2AdCFQ2GVPpvO98F4c61+RvaBQH4tq6awGHV3RUHl7rFw6un
         VyE6wpri8tyuWQ7EffJOqLQRV2BXSCymgcVf79bkADr8IB7zF8Cf4Gop7Zsub6BHkz
         mu7SrCUt3bbVQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42Kxs+HYrCuq7p5
  icPqPlcWNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNaPl/Vfmggc8FVcWfGZuYGzj7GLk4hAS2Mgosev8N
  WYIZymTRNOay1DOQUaJG6s3sXUxcnKwCWhI3Gu5yQhiiwgESSxd85oJpIhZoJVR4kjTJGaQhL
  CAn8SHV7fAGlgEVCXu3H8CZHNw8Ao4SmzblQgSlhBQkJjy8D1YOaeAk8Smt51g5UJAJVM232A
  BsXkFBCVOznwCZjMLSEgcfPGCGaJXSeLi1zusEHalROuHXywQtprE1XObmCcwCs5C0j4LSfsC
  RqZVjGbFqUVlqUW6ZnpJRZnpGSW5iZk5eolVuol6qaW6eflFJRm6hnqJ5cV6qcXFesWVuck5K
  Xp5qSWbGIHxkVKcbLeD8cvOv3qHGCU5mJREebnC3FKE+JLyUyozEosz4otKc1KLDzFqcHAIzD
  g3dzqTFEtefl6qkgRvrLJ7ipBgUWp6akVaZg4whmFKJTh4lER4lyoBpXmLCxJzizPTIVKnGBW
  lxHllVYESAiCJjNI8uDZY2rjEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZiXQQFoCk9mXgnc
  9FdAi5mAFu/idgFZXJKIkJJqYMpqmbGrMH/tw4WXZtdZl59S5ZhyWbv0fJJS0cqt/d4ydttEQ
  7My/Sa/m3kj5oBN5cMDPvNmCQXzMSxJFhdq8shf5x95Sqb0fPtlVmPep7p/1MPYK20DBW7f1h
  O2cFmm9cfZ6mDpxUmlnAsFoyUWLUq9kam5TvCAajx3QIXcrEXvdb9HJk+68ctvxcZTO18LvrJ
  gYgngDdTQzDi/U0NImXXC91f338VP37Buvr7c7/cW8vOO3/IpKWA3u/WU+fg2c5f1+1n8YpaL
  M39o3/qqeIP5hl2rtIJXCWsuuJFq+Ud21e+Ndb85NKrtvyU3OB8Pnm76afqkNQGdbI6CLqteL
  rzUxb/h+7uvkbvWRu0oiFViKc5INNRiLipOBACNVWSulgMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-4.tower-745.messagelabs.com!1682384661!376981!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22786 invoked from network); 25 Apr 2023 01:04:21 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-4.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 01:04:21 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 6226815B;
        Tue, 25 Apr 2023 02:04:21 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 5629D142;
        Tue, 25 Apr 2023 02:04:21 +0100 (BST)
Received: from 0819309620d6.localdomain (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 02:04:17 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <guoqing.jiang@linux.dev>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v3 1/3] RDMA/rtrs: remove duplicate cq_num assignment
Date:   Tue, 25 Apr 2023 01:02:41 +0000
Message-ID: <1682384563-2-2-git-send-email-lizhijian@fujitsu.com>
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

