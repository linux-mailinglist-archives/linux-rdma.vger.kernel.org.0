Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE505EB741
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiI0Bz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 21:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiI0Bz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 21:55:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85337B795
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 18:55:24 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc2f34wMdzlXL5;
        Tue, 27 Sep 2022 09:51:07 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:55:11 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 09:55:10 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] IB/hfi1: Use skb_put_data() instead of skb_put/memcpy pair
Date:   Tue, 27 Sep 2022 10:29:19 +0800
Message-ID: <20220927022919.16902-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use skb_put_data() instead of skb_put() and memcpy(), which is shorter
and clear. Drop the tmp variable that is not needed any more.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/infiniband/hw/hfi1/ipoib_rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_rx.c b/drivers/infiniband/hw/hfi1/ipoib_rx.c
index 3afa7545242c..629691a572ef 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_rx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_rx.c
@@ -11,13 +11,10 @@
 
 static void copy_ipoib_buf(struct sk_buff *skb, void *data, int size)
 {
-	void *dst_data;
-
 	skb_checksum_none_assert(skb);
 	skb->protocol = *((__be16 *)data);
 
-	dst_data = skb_put(skb, size);
-	memcpy(dst_data, data, size);
+	skb_put_data(skb, data, size);
 	skb->mac_header = HFI1_IPOIB_PSEUDO_LEN;
 	skb_pull(skb, HFI1_IPOIB_ENCAP_LEN);
 }
-- 
2.17.1

