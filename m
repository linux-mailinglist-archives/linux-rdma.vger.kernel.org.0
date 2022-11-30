Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7562863D24D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 10:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiK3Joy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 04:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiK3Joq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 04:44:46 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7B1FCD6;
        Wed, 30 Nov 2022 01:44:44 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMZ6y70qNz4xVnf;
        Wed, 30 Nov 2022 17:44:42 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 2AU9iZEi061201;
        Wed, 30 Nov 2022 17:44:35 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 30 Nov 2022 17:44:37 +0800 (CST)
Date:   Wed, 30 Nov 2022 17:44:37 +0800 (CST)
X-Zmail-TransId: 2b04638726050486114f
X-Mailer: Zmail v1.0
Message-ID: <202211301744378304494@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
Cc:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBJQi9oZmkxOiBzd2l0Y2ggdG8gbmV0aWZfbmFwaV9hZGQoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU9iZEi061201
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6387260A.001 by FangMail milter!
X-FangMail-Envelope: 1669801483/4NMZ6y70qNz4xVnf/6387260A.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6387260A.001/4NMZ6y70qNz4xVnf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

There is no need to use netif_napi_add_weight() when the weight argument
is 64. See "net: drop the weight argument from netif_napi_add".

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 3dfa5aff2512..08080ca6cb2d 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -216,7 +216,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
 		 * right now.
 		 */
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &rxq->napi.state);
-		netif_napi_add_weight(dev, &rxq->napi, hfi1_netdev_rx_napi, 64);
+		netif_napi_add(dev, &rxq->napi, hfi1_netdev_rx_napi);	
 		rc = msix_netdev_request_rcd_irq(rxq->rcd);
 		if (rc)
 			goto bail_context_irq_failure;
-- 
2.15.2
