Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA06443DE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiLFNDC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiLFNCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:24 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED891DE97;
        Tue,  6 Dec 2022 05:02:21 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="77665422"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="77665422"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DEF47D6473;
        Tue,  6 Dec 2022 22:02:19 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 13E90D948A;
        Tue,  6 Dec 2022 22:02:19 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2CF32340E90;
        Tue,  6 Dec 2022 22:02:17 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 10/10] RDMA/rxe: Enable RDMA FLUSH capability for rxe device
Date:   Tue,  6 Dec 2022 21:02:01 +0800
Message-Id: <20221206130201.30986-11-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10-6.925300-10.000000
X-TMASE-MatchedRID: MqppGi75AUU2TliLLcf2acIkzTqL3E/WnQkHrAHoKqay65WOujyvG78F
        Hrw7frluf146W0iUu2tDc4lSgrowpa8zfGxMvR+8qdwbW9Wx9tB9LQinZ4QefCP/VFuTOXUT3n8
        eBZjGmUzkwjHXXC/4I7I7zVffJqTz/Nej2diPFEYkx2mVPK6ijBvXaPMnVH1UBp2GjUpoSSzjMQ
        1F5tN3gGJN/XOAeBaSxElywQImzRoVIaSRP79Cgv7aLgy40S4H
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now we are ready to enable RDMA FLUSH capability for RXE.
It can support Global Visibility and Persistence placement types.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index bbc88cd71d95..a754fc902e3d 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -51,6 +51,8 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_MEM_WINDOW
+					| IB_DEVICE_FLUSH_GLOBAL
+					| IB_DEVICE_FLUSH_PERSISTENT
 #ifdef CONFIG_64BIT
 					| IB_DEVICE_MEM_WINDOW_TYPE_2B
 					| IB_DEVICE_ATOMIC_WRITE,
-- 
2.31.1

