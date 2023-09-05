Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB9792511
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjIEQBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354221AbjIEKKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 06:10:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E2C2;
        Tue,  5 Sep 2023 03:10:27 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg1Nk0Lh7z67Gnx;
        Tue,  5 Sep 2023 18:05:58 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 11:10:24 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <gregkh@linuxfoundation.org>,
        <benjamin.tissoires@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] RDMA/uverbs: Fix typo of sizeof argument
Date:   Tue, 5 Sep 2023 18:10:21 +0800
Message-ID: <20230905101021.1722796-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since size of 'hdr' pointer and '*hdr' structure is equal on 64-bit
machines issue probably didn't cause any wrong behavior. But anyway,
fixing of typo is required.

Fixes: da0f60df7bd5 ("RDMA/uverbs: Prohibit write() calls with too small buffers")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/infiniband/core/uverbs_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7c9c79c13941..508d6712e14d 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -535,7 +535,7 @@ static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
 	if (hdr->in_words * 4 != count)
 		return -EINVAL;
 
-	if (count < method_elm->req_size + sizeof(hdr)) {
+	if (count < method_elm->req_size + sizeof(*hdr)) {
 		/*
 		 * rdma-core v18 and v19 have a bug where they send DESTROY_CQ
 		 * with a 16 byte write instead of 24. Old kernels didn't
-- 
2.34.1

