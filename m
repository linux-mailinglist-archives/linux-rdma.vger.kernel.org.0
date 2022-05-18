Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2152B04D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 03:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiERB57 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 21:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiERB56 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 21:57:58 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3958954BFF
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 18:57:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VDYaCW9_1652839074;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDYaCW9_1652839074)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 May 2022 09:57:55 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: [PATCH for-next v8 02/12] RDMA/core: Allow calling query_port when netdev isn't attached in iWarp
Date:   Wed, 18 May 2022 09:57:41 +0800
Message-Id: <20220518015751.38156-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220518015751.38156-1-chengyou@linux.alibaba.com>
References: <20220518015751.38156-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This change lets the iWarp device drivers decide the return value of
iw_query_port when attached netdev is NULL. This allows ib_register_device
calling when netdev is NULL.

background info:
https://lore.kernel.org/all/20220118141324.GF8034@ziepe.ca/

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/core/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a..6f5e46e0e5b3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2020,8 +2020,12 @@ static int iw_query_port(struct ib_device *device,
 	memset(port_attr, 0, sizeof(*port_attr));
 
 	netdev = ib_device_get_netdev(device, port_num);
+	/* Some iwarp device may be not binded to a netdev temporarily when
+	 * ib_register_device called. To adapt this scenario, allowing iWarp
+	 * device drivers decide the return value.
+	 */
 	if (!netdev)
-		return -ENODEV;
+		goto query_port;
 
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
@@ -2046,6 +2050,7 @@ static int iw_query_port(struct ib_device *device,
 	}
 
 	dev_put(netdev);
+query_port:
 	return device->ops.query_port(device, port_num, port_attr);
 }
 
-- 
2.27.0

