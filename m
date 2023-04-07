Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCA6DB0F3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDGQwv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDGQwv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:52:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF505B92
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWDTiVKCxC2UXwy/wOqfYAivolwFZqQsvPPB8tQUL/1UnizKLU5H18l5xzwN2/yQPJgO3y2xwUXFwtlwIy6e9n64VzJeQmw/rKjW0AsKMOYFjoJ9OP4RZ1ZTAygJZ88JZXqyB6OQ3LxfBq9FKvnZmZLfoO0EWE+OB9sPhSgy5WC1ibWM5s059vvf7LD8ON1n2mwK3Z4xz/wWmwjAp49knaiMmNEGKk1htSoi36x24cYMvsUX6X34OrQniKuDBwXaQvzjg1XhkahNqsIhd3xt8wBdja0MwgORudEJjT7VGlczcukxboltfjoEse8TmAtsL9flybm1bxHrvgwCP06hRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0VuyUTbjuV/ejAK8NY8T4i8+HA6yLNtJR8SbIhpLGo=;
 b=CPFLari7nD6Ib8PopUKtDaO4syv1l0owF6FVRDvDRuKn46Muo6CGho/B23LDzi9mq/euXmFMOR153evqguZxLz4GPl2MRm8MoeLV7BzaYKAniajRD5tp8pHWHFtYQg99rFhXZo3ZuaesUipyoocVhm/dUbEraXraWlDxF1JiT8PfAU++8QV9Py1BEVF1yd/95v9llpf0Ck1K97nOqyHOmpSV78FCDTt7WT3YOpBKoPPabrPiu5DUpdHskcsKQYsFQW0xhIa+ML+jsRLimnrm21rMhLvtzt6WBBcUpz8J2WT5I6e1/G4tPjtA0MF2C/15jKIT70vdyLILYTDJBI5Qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0VuyUTbjuV/ejAK8NY8T4i8+HA6yLNtJR8SbIhpLGo=;
 b=nNtp3r+sfud+42HlL53Pvtx/90I5H4nNzIgnP5ezso2KMKIWf5CwO41Hz7gG+FGU0JExEM6bUttGua8cEEalpmF7XXeGK1QkC8ssUKUrYZCmIyeX2XTXqp3smy7uR1M3N+YovBR1dt7uK/9FPuerDlj2JinJ/gOzjROByAWU+H9Qf5vFioWMWDA3F9K3TlGXj9l+HllM3x9gOz3M0q9ERQmkgUXOYWPSxsRfBG9qW4zP1vISnA/CVZ7wqjHREU4fKtuTxzatLsvZmnEY8irmqX7df+i5BUWrpHlHTE4TzDb/iomxBgI0LmFKiZ6cD650LLoQlCXffbbUNaV2ukVuUg==
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.18; Fri, 7 Apr 2023 16:52:40 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::3b) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.21 via Frontend Transport; Fri, 7 Apr 2023 16:52:40 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337GqdRb3027393;
        Fri, 7 Apr 2023 12:52:39 -0400
Subject: [PATCH for-next 3/5] IB/hfi1: Fix SDMA mmu_rb_node not being evicted
 in LRU order
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:39 -0400
Message-ID: <168088635931.3027109.10423156330761536044.stgit@252.162.96.66.static.eigbox.net>
In-Reply-To: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
References: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|CH0PR01MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d739ff-628a-443c-829a-08db3788800e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMJRM4GM5072B31ycPeF2SwwgAQQ8CDvc5d9LMf2kmlZQgM3nmEHDvGg9FU8AnSg3JIBRu4j6XfSSY5nTxef8XEjHIhGbxBLEPPOBB9zC3XGQj3OGrsDcG6WZ3wXbA8ZCUVik/yOx8gxpKC6zx2cBow/PT7Nw6rfnrmbUJZVtV3JgUzJh5oMlfI8V0V8LQHF3ACNE1tNBT7gQ0KBvNY7eWbJpw+TXIGQ9MEMQGLvr++nNk52dzQ7H2wa5abiBbNsmVNrwZpzQj2xgrn/DTFKUhbPk6gucFWbV+KC9eI/kqjTAy78I5bg81ENYowVCNDQuLHfPR3j3hBt0px/jPeOLK23gQqmvVCW/nSEW8Y/c8/hLIoy1T6YnC94R2xTu89SJFJUCPe+EliQnvJmKD/i7H6tap05Y3k0fmTBoKVOOb3OLW51Dzoc/ggIHLxxBctXqyTb+zFAZJCwKtgCI2ZrmpHn03mWNtxNXvjCvwEpE3+HPQ3d7na9YlnJR30aVSqquiVvy5nDi0DOWwMiLbBjBe6IBHwFHQgeyJRSrPjFH3eve61JY8RZw1oakiPhC9jE5xtkk5un3qk5jYd3/rFoosEJbpucdsyJU6xqmmkq3i4ijiWoZQok7g/kt9T4jzWIPaS/UD4e3hwUl+PJXaZubghKD3Qqyk/vLpfTQSKvfNpezcbW0mIW9c/aTlIJg9i58JSA9B7/3MyrYd9l840lsAEUf+l6hmpbDS4tHzhvzYmQCW42v1BOOtUGjeQ8VigX5LcsR2NdLAVHWnlla0T6vg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39840400004)(136003)(451199021)(36840700001)(46966006)(40480700001)(36860700001)(336012)(83380400001)(426003)(47076005)(7126003)(54906003)(478600001)(7696005)(186003)(26005)(9686003)(103116003)(2906002)(44832011)(5660300002)(81166007)(316002)(4326008)(356005)(41300700001)(70586007)(86362001)(82310400005)(8676002)(8936002)(70206006)(55016003)(9916002)(24686002)(102196002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:40.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d739ff-628a-443c-829a-08db3788800e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7153
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

hfi1_mmu_rb_remove_unless_exact() did not move mmu_rb_node objects in
mmu_rb_handler->lru_list after getting a cache hit on an mmu_rb_node.

As a result, hfi1_mmu_rb_evict() was not guaranteed to evict truly
least-recently used nodes.

This could be a performance issue for an application when that
application:
- Uses some long-lived buffers frequently.
- Uses a large number of buffers once.
- Hits the mmu_rb_handler cache size or pinned-page limits, forcing
  mmu_rb_handler cache entries to be evicted.

In this case, the one-time use buffers cause the long-lived buffer
entries to eventually filter to the end of the LRU list where
hfi1_mmu_rb_evict() will consider evicting a frequently-used long-lived
entry instead of evicting one of the one-time use entries.

Fix this by inserting new mmu_rb_node at the tail of
mmu_rb_handler->lru_list and move mmu_rb_ndoe to the tail of
mmu_rb_handler->lru_list when the mmu_rb_node is a hit in
hfi1_mmu_rb_remove_unless_exact(). Change hfi1_mmu_rb_evict() to evict
from the head of mmu_rb_handler->lru_list instead of the tail.

Fixes: 0636e9ab8355 ("IB/hfi1: Add cache evict LRU list")
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 7333646021bb..af46ff203342 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -130,7 +130,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -181,8 +181,10 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, addr, len);
 	if (node) {
-		if (node->addr == addr && node->len == len)
+		if (node->addr == addr && node->len == len) {
+			list_move_tail(&node->list, &handler->lru_list);
 			goto unlock;
+		}
 		__mmu_int_rb_remove(node, &handler->root);
 		list_del(&node->list); /* remove from LRU list */
 		ret = true;
@@ -206,8 +208,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -219,9 +220,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }


