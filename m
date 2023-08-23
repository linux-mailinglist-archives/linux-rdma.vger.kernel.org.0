Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C90784E8E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 04:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjHWCNS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHWCNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 22:13:18 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F3CEF;
        Tue, 22 Aug 2023 19:13:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="116846128"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="116846128"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:13:13 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A453AD29E6;
        Wed, 23 Aug 2023 11:13:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D64C4D8B7F;
        Wed, 23 Aug 2023 11:13:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 10EFF6B817;
        Wed, 23 Aug 2023 11:13:10 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Date:   Wed, 23 Aug 2023 10:13:05 +0800
Message-Id: <20230823021306.170901-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27830.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27830.003
X-TMASE-Result: 10-0.490300-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vntAplHZmS+xk7nLUqYrlslFIuBIWrdOePfUZT83lbkEMi+
        UJljoDHwzhvnvWgCKR4AjeDwXx2MYgzyMxeMEX6wFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
        zmuoPCq3iLksbXZuk3eG5Gam1ger6AgqwE4H+UHVKRyGul7qFUsNg6qN/5IWoubnZTxMUT3oiDU
        jqX2A6fCmjniQnoHNlwGQhKv4yiPQVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
        gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A newline help flushing message out.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..cb2c0d54aae1 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
 
-	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
+	rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
-- 
2.29.2

