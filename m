Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3649741C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiAWSDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52234 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiAWSDo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF38B80DE2;
        Sun, 23 Jan 2022 18:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743DC340E2;
        Sun, 23 Jan 2022 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961021;
        bh=FjT8fPV0AryG+akmLSuf5eEiyxAc6uhvVjAWBgYkfY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TORKCQSYVPlSq+QMdW5XIvNx9c3cO/OTNRlkBk09dBBcKKJhqnIztS/hV4n/v22w4
         2FAHCvIX5wlwlpG1TKndQ4Ltse6/72HQd4A7ElCxJ4ckRSKRmtQIshhFz8YnJ59MC3
         MMT7oMYFHPcaw3EmbpBvKKViicwM22xwVvgpiWSyK5hPaKCQejT3j6b2LC5Yaic/fH
         dBESvqWO8ZFZ+VhvrLQO0uDbtg+dPt66CyrSpTkCe7ML++0uJNtIahmAFAdG7PcFsH
         n5sAnwapUzMR0oIh2LKer86Q2J7pVuZFQHTrqKDBPgnonOdNkYCzzoN+nLTLy9WFOu
         wvdNcDC8O9cWA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 09/11] RDMA/ipoib: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:58 +0200
Message-Id: <a5acab89181b55fd640369b3829cc49e0320302f.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following files.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 1 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 5b05cf3837da..ea16ba5d8da6 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -32,7 +32,6 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>      /* For ARPHRD_xxx */
-#include <linux/module.h>
 #include <net/rtnetlink.h>
 #include "ipoib.h"
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 0322dc75396f..4bd161e86f8d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <linux/sched/signal.h>
 
 #include <linux/init.h>
-- 
2.34.1

