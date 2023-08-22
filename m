Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3935F7837D7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 04:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHVCUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHVCUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 22:20:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5D113;
        Mon, 21 Aug 2023 19:20:32 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVCf01ll9zNnCZ;
        Tue, 22 Aug 2023 10:16:56 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 10:20:29 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <davem@davemloft.net>, <maciej.fijalkowski@intel.com>,
        <michal.simek@amd.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Tue, 22 Aug 2023 10:14:55 +0800
Message-ID: <20230822021455.205101-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>
References: <20230822021455.205101-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/davicom/dm9051.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9051.c b/drivers/net/ethernet/davicom/dm9051.c
index 70728b2e5f18..829ec35d094b 100644
--- a/drivers/net/ethernet/davicom/dm9051.c
+++ b/drivers/net/ethernet/davicom/dm9051.c
@@ -1161,9 +1161,7 @@ static int dm9051_phy_connect(struct board_info *db)
 
 	db->phydev = phy_connect(db->ndev, phy_id, dm9051_handle_link_change,
 				 PHY_INTERFACE_MODE_MII);
-	if (IS_ERR(db->phydev))
-		return PTR_ERR_OR_ZERO(db->phydev);
-	return 0;
+	return PTR_ERR_OR_ZERO(db->phydev);
 }
 
 static int dm9051_probe(struct spi_device *spi)
-- 
2.25.1

