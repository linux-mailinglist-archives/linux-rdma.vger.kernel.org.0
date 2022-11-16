Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650EF62B4F8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiKPIUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiKPIUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:30 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111D2640;
        Wed, 16 Nov 2022 00:20:28 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="96201651"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="96201651"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:26 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 662D9E081B;
        Wed, 16 Nov 2022 17:20:25 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A4989D5C3C;
        Wed, 16 Nov 2022 17:20:24 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 87D3F2340D52;
        Wed, 16 Nov 2022 17:20:23 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Date:   Wed, 16 Nov 2022 16:19:50 +0800
Message-Id: <20221116081951.32750-10-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--0.921700-10.000000
X-TMASE-MatchedRID: 92xvE4Eud/+tVKSQoU2TwQrcxrzwsv5u1QQ6Jx/fflbAuQ0xDMaXkH4q
        tYI9sRE/KqrQ7lLcMnwur3Fjd+eQSljaDEobnfK28Jb881FGn9l9LQinZ4QefOYQ3zcXToXr+gt
        Hj7OwNO2OhzOa6g8KrXinYhvRB8kptqxdGensUT2Zj5MKbfT31F3WT1KhjSLChjHlUHUMYUVBrQ
        obDMfLt/4VhULZJHaF9y9INlBams5YIoo0pwKZmBXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
        0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It enables flushable access flag for qp

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: new patch, inspired by Bob
---
 drivers/infiniband/core/cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1f9938a2c475..58837aac980b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4096,7 +4096,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
 		if (cm_id_priv->responder_resources)
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
-						    IB_ACCESS_REMOTE_ATOMIC;
+						    IB_ACCESS_REMOTE_ATOMIC |
+						    IB_ACCESS_FLUSHABLE;
 		qp_attr->pkey_index = cm_id_priv->av.pkey_index;
 		if (cm_id_priv->av.port)
 			qp_attr->port_num = cm_id_priv->av.port->port_num;
-- 
2.31.1

