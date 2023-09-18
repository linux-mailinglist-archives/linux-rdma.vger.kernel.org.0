Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC27A3F65
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 04:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjIRCGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Sep 2023 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbjIRCGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Sep 2023 22:06:13 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A02D2;
        Sun, 17 Sep 2023 19:06:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="111348746"
X-IronPort-AV: E=Sophos;i="6.02,155,1688396400"; 
   d="scan'208";a="111348746"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 11:06:05 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 64AC8CA1E4;
        Mon, 18 Sep 2023 11:06:03 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 95424D4F54;
        Mon, 18 Sep 2023 11:06:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CED4F22CAEB;
        Mon, 18 Sep 2023 11:06:01 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Li Zhijian <lizhijian@fujitsu.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after rxe_register_device
Date:   Mon, 18 Sep 2023 10:05:43 +0800
Message-Id: <20230918020543.473472-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230918020543.473472-1-lizhijian@fujitsu.com>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27882.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27882.004
X-TMASE-Result: 10--4.606400-10.000000
X-TMASE-MatchedRID: 5HHZS01SLJyIYY2hRSylnMQ4mpKyfkqZ0MQw+++ihy/qFRQsrMdGBLbS
        c9DZ5nsJJCq8bCHd+Z97L4dx4z+0QP9HU1IxzaoJSs47mbT7SAQh9mNF8ZPJ2J4Q+L3BXIWucwh
        qloOj04orzzBwyc2R+IchfYk7/A4ytluGG+j/1f5O5y1KmK5bJRSLgSFq3TnjoxCLfriDzzhzFn
        5q/FBFPCOK0EQG/QrRgDLqnrRlXrbIDt27MLDp0t0H8LFZNFG76sBnwpOylLMhBBd/FrDsocwGS
        yUEon0hzHEipDRCGLyw+YgszRtgJ7OFAN+Hpfzj3XakdTPL36NuxVmNfPwGLxTn0HtNsIvHOHGK
        aIvEvTMhyadlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

After this change, the message becomes:
"rxe_eth0: rxe_set_mtu: Set mtu to 4096"

Fixes: 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a086d588e159..8a43c0c4f8d8 100644
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

