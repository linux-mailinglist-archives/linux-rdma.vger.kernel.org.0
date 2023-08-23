Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86503784E90
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjHWCN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 22:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjHWCN0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 22:13:26 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A8E4E;
        Tue, 22 Aug 2023 19:13:22 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="108546362"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="108546362"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:13:19 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9480DC68E5;
        Wed, 23 Aug 2023 11:13:15 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BAD24D20AF;
        Wed, 23 Aug 2023 11:13:14 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E39766B817;
        Wed, 23 Aug 2023 11:13:13 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Call rxe_set_mtu after rxe_register_device
Date:   Wed, 23 Aug 2023 10:13:06 +0800
Message-Id: <20230823021306.170901-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230823021306.170901-1-lizhijian@fujitsu.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27830.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27830.003
X-TMASE-Result: 10--4.000400-10.000000
X-TMASE-MatchedRID: 5PeO86FyjNKIYY2hRSylnMQ4mpKyfkqZ0MQw+++ihy/qFRQsrMdGBLbS
        c9DZ5nsJJCq8bCHd+Z97L4dx4z+0QP9HU1IxzaoJSs47mbT7SAQh9mNF8ZPJ2J4Q+L3BXIWucwh
        qloOj04py+ROQfAr1jeaffHI8kAmiHY/bzRmIaZGqFx2c/3V5cf3l3BKhUmN/myiLZetSf8nyb6
        HMFK1qe11j5mhaIsibJ0RPnyOnrZICgmfua/fPXtuW3D6HtXwtBOtTmZPZgcKgolbk5R0jWqi4O
        rUcQoc5QkbGFj8igiyBx2s7JQ1vW2HbVJe6RBtpX2C5l3vFPxjAYLx7rnbR8rDQ8m3TqgloelpC
        XnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_set_mtu() will call rxe_info_dev() to print message, and
rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.

Previously since dev_name() is not set, when a new rxe link is being
added, 'null' will be used as the dev_name like:

"(null): rxe_set_mtu: Set mtu to 1024"

Move rxe_register_device() earlier to assign the correct dev_name
so that it can be read by rxe_set_mtu() later.

And it's safe to do such change since mtu will not be used during the
rxe_register_device()

After this change, message becomes:
"rxe_eth0: rxe_set_mtu: Set mtu to 4096"

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index cb2c0d54aae1..d29efce6e5ca 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -169,10 +169,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
  */
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 {
+	int ret;
+
 	rxe_init(rxe);
+	ret = rxe_register_device(rxe, ibdev_name);
 	rxe_set_mtu(rxe, mtu);
 
-	return rxe_register_device(rxe, ibdev_name);
+	return ret;
 }
 
 static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
-- 
2.29.2

