Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00262B4FC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiKPIUo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiKPIUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:32 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42AE384;
        Wed, 16 Nov 2022 00:20:30 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="96201654"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="96201654"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:26 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D5F6D3EA3;
        Wed, 16 Nov 2022 17:20:26 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7ADC0D968B;
        Wed, 16 Nov 2022 17:20:25 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5343123401D1;
        Wed, 16 Nov 2022 17:20:24 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 10/10] RDMA/rxe: Enable RDMA FLUSH capability for rxe device
Date:   Wed, 16 Nov 2022 16:19:51 +0800
Message-Id: <20221116081951.32750-11-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10-3.982300-10.000000
X-TMASE-MatchedRID: MqppGi75AUU2TliLLcf2acIkzTqL3E/WnQkHrAHoKqay65WOujyvG78F
        Hrw7frluf146W0iUu2tDc4lSgrowpa8zfGxMvR+8v0DcGXX8NxVULRRq00o2mZsoi2XrUn/Js98
        n9dYnJNNQSFbL1bvQASdET58jp62Smtxr6dqHjEeaIrdTCsya8Ag4a62DyyQ2iHJY3Cht6aDqtZ
        MQZaqcwAPQKwJze8HK4UQ+mtTZfIHAppnEk6Iv603AgkyJsFhGwGC8e6520fKw0PJt06oJaHpaQ
        l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
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
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 86c7a8bf3cbb..c7a82823a041 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -51,7 +51,9 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_MEM_WINDOW
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_FLUSH_GLOBAL
+					| IB_DEVICE_FLUSH_PERSISTENT,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.31.1

