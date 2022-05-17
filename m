Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B15296C3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiEQBde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiEQBdd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 21:33:33 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6392B403EB;
        Mon, 16 May 2022 18:33:31 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 17 May
 2022 09:33:29 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 17 May
 2022 09:33:28 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA: remove null check after call container_of()
Date:   Tue, 17 May 2022 09:33:28 +0800
Message-ID: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

container_of() will never return NULL, so remove useless code.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/infiniband/sw/rdmavt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 59481ae39505..b2d83b4958fc 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -50,8 +50,6 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
 	struct rvt_dev_info *rdi;
 
 	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
-	if (!rdi)
-		return rdi;
 
 	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
 	if (!rdi->ports)
-- 
2.7.4

