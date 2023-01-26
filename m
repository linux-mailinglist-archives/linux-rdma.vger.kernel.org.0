Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85867D4AD
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAZSww (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 13:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAZSwv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 13:52:51 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2D76AC;
        Thu, 26 Jan 2023 10:52:48 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 26 Jan
 2023 21:52:39 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 26 Jan
 2023 21:52:39 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Mustafa Ismail <mustafa.ismail@intel.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] RDMA/irdma: Fix potential NULL-ptr-dereference
Date:   Thu, 26 Jan 2023 10:52:30 -0800
Message-ID: <20230126185230.62464-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

in_dev_get() can return NULL which will cause a failure once idev is
dereferenced in in_dev_for_each_ifa_rtnl(). This patch adds a
check for NULL value in idev beforehand.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

 drivers/infiniband/hw/irdma/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 7b086fe63a24..195aa9ea18b6 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1722,6 +1722,9 @@ static int irdma_add_mqh_4(struct irdma_device *iwdev,
 			continue;
 
 		idev = in_dev_get(ip_dev);
+		if (!idev)
+			continue;
+
 		in_dev_for_each_ifa_rtnl(ifa, idev) {
 			ibdev_dbg(&iwdev->ibdev,
 				  "CM: Allocating child CM Listener forIP=%pI4, vlan_id=%d, MAC=%pM\n",
