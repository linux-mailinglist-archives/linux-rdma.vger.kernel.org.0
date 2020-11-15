Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1642B3377
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKOKeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 05:34:22 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62368 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKOKeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Nov 2020 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605436462; x=1636972462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Juo6ItyeTAxkCctMId9ekgkRx8+tiVSLStAB/WitKEI=;
  b=aqFUXsyLG6AromWUfzsbsR5C0a6BdsswUec9pRrGKokn7oaRHLPummfR
   hvzc+O90k18q84GcU9wXkdQT81wGVXoMY54WriSR4o5w169qI7kJ1lN/w
   uiPc5WbgH8ZxC5cUHUOVIClP3/2M2aEtzYaCJ3NSE9sVDUmXuLaqOUCHG
   E=;
X-IronPort-AV: E=Sophos;i="5.77,480,1596499200"; 
   d="scan'208";a="95396621"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Nov 2020 10:34:16 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id BAEEC242D64;
        Sun, 15 Nov 2020 10:34:14 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 15 Nov 2020 10:34:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.17) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 15 Nov 2020 10:34:10 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/core: Check .create_ah is not NULL only in case it's needed
Date:   Sun, 15 Nov 2020 12:34:02 +0200
Message-ID: <20201115103404.48829-2-galpress@amazon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103404.48829-1-galpress@amazon.com>
References: <20201115103404.48829-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Drivers now expose two callbacks for address handle creation, one for
uverbs and one for kverbs. The function pointer NULL check in
_rdma_create_ah() should only happen if !udata.

A NULL check for .create_user_ah is not needed as it is validated by the
uverbs uapi definitions.

Fixes: 676a80adba01 ("RDMA: Remove AH from uverbs_cmd_mask")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index ab1e6048685e..33778f8674a1 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -516,7 +516,7 @@ static struct ib_ah *_rdma_create_ah(struct ib_pd *pd,
 
 	might_sleep_if(flags & RDMA_CREATE_AH_SLEEPABLE);
 
-	if (!device->ops.create_ah)
+	if (!udata && !device->ops.create_ah)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	ah = rdma_zalloc_drv_obj_gfp(
-- 
2.29.2

