Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4ED6443EA
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiLFNDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiLFNCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:24 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F7D2E3;
        Tue,  6 Dec 2022 05:02:21 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="78294263"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="78294263"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 25E80DD994;
        Tue,  6 Dec 2022 22:02:19 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 58D0EBF5E2;
        Tue,  6 Dec 2022 22:02:18 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 489A52340E31;
        Tue,  6 Dec 2022 22:02:17 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 09/10] RDMA/cm: Make QP FLUSHABLE for supported device
Date:   Tue,  6 Dec 2022 21:02:00 +0800
Message-Id: <20221206130201.30986-10-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10-3.491200-10.000000
X-TMASE-MatchedRID: XQoK3HqFntCNpmmKKDMxRBFbgtHjUWLym0H2L3kjQgqOVdQAiMmbZ7QS
        /KxKInUSGlIk2Jn88ims3cxFKjrJJg8rYO92b9NmTuctSpiuWyUUi4Ehat05499RlPzeVuQQupO
        isvffcFAeHbRWTn6MWgRwIKYSevfuJ1KOwNqVG3GhLSC6hXpJl3O1oaQ51CuNmyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1tSUt10mlRwOgEuuQp1ojSopZ99nU19O1dAvIodzvTTS4XTI5zHRVOjRsj
        qNLiyWSoijzbmPsL2EGPFNcHWllqqT0oCFWLSFCGIoA/ljtOSEVxRB/din+uJ07T8ZSLiAVvR84
        /OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Similar to RDMA and Atomic qp attributes enabled by default in CM, enable
FLUSH attribute for supported device. That makes applications that are
built with rdma_create_ep, rdma_accept APIs have FLUSH qp attribute
natively so that user is able to request FLUSH operation simpler.

Note that, a FLUSH operation requires FLUSH are supported by both
device(HCA) and memory region(MR) and QP at the same time, so it's safe
to enable FLUSH qp attribute by default here.

FLUSH attribute can be disable by modify_qp() interface.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V7: enable flush for supported device only # Jason
V5: new patch, inspired by Bob
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/core/cm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1f9938a2c475..603c0aecc361 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4094,9 +4094,18 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 		*qp_attr_mask = IB_QP_STATE | IB_QP_ACCESS_FLAGS |
 				IB_QP_PKEY_INDEX | IB_QP_PORT;
 		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
-		if (cm_id_priv->responder_resources)
+		if (cm_id_priv->responder_resources) {
+			struct ib_device *ib_dev = cm_id_priv->id.device;
+			u64 support_flush = ib_dev->attrs.device_cap_flags &
+			  (IB_DEVICE_FLUSH_GLOBAL | IB_DEVICE_FLUSH_PERSISTENT);
+			u32 flushable = support_flush ?
+					(IB_ACCESS_FLUSH_GLOBAL |
+					 IB_ACCESS_FLUSH_PERSISTENT) : 0;
+
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
-						    IB_ACCESS_REMOTE_ATOMIC;
+						    IB_ACCESS_REMOTE_ATOMIC |
+						    flushable;
+		}
 		qp_attr->pkey_index = cm_id_priv->av.pkey_index;
 		if (cm_id_priv->av.port)
 			qp_attr->port_num = cm_id_priv->av.port->port_num;
-- 
2.31.1

