Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947675EBA25
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiI0FyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiI0FyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:11 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2190897D71;
        Mon, 26 Sep 2022 22:54:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="90729131"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="90729131"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:09 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5650DD624B;
        Tue, 27 Sep 2022 14:54:08 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 741BAD35AE;
        Tue, 27 Sep 2022 14:54:07 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C61F11403D7;
        Tue, 27 Sep 2022 14:54:06 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 10/11] RDMA/cm: Make QP FLUSHABLE
Date:   Tue, 27 Sep 2022 13:53:36 +0800
Message-Id: <20220927055337.22630-11-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--0.921700-10.000000
X-TMASE-MatchedRID: M35ia3mjZ7StVKSQoU2TwQrcxrzwsv5u1QQ6Jx/fflbAuQ0xDMaXkH4q
        tYI9sRE/KqrQ7lLcMnwur3Fjd+eQSljaDEobnfK28Jb881FGn9l9LQinZ4QefCP/VFuTOXUT3n8
        eBZjGmUzkwjHXXC/4I8ZW5ai5WKlyM99BYxnKS3kxb1ulXaH/32kieamUbtsrqDqferhvzIc0pn
        liIFcQucsjLiUIBI2RcrCcbDx2V+24kpwBjmmShjxoObZSQIcAEWW0bEJOTAVAdUD6vW8Z1mZAM
        QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It enables flushable access flag for qp

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

