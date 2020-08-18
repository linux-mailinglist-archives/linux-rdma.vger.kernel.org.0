Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8232248395
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRLJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 07:09:03 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:44158 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHRLJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 07:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597748942; x=1629284942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNByvqJv9tkvzuG1/LZFFo2mbFcPqdrN7d/xN9wE5Os=;
  b=GyknzsfhccWDBtoBSZT5DQcuLqSdk8CBy4lYO0HBRl4og0MVucUs7g3c
   VvY+ka7peRNT5KLKWZ2wnTqBYJ72E61rK0QTJVkNz90wsdWyB8k4141nr
   yE9DTnR0kv08ODBar8MRT0oR4nAgM9MBZSQvrveisV446amziz99sSfkI
   I=;
X-IronPort-AV: E=Sophos;i="5.76,327,1592870400"; 
   d="scan'208";a="48538280"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Aug 2020 11:08:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id A676BA0456;
        Tue, 18 Aug 2020 11:08:57 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 11:08:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 11:08:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.29) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 18 Aug 2020 11:08:53 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Remove redundant udata check from alloc ucontext response
Date:   Tue, 18 Aug 2020 14:08:35 +0300
Message-ID: <20200818110835.54299-1-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The alloc ucontext flow is always called with a valid udata, there's no
need to test whether it's NULL.

While at it, the 'udata->outlen' check is removed as well as we copy the
minimum between the size of the response and outlen, so in case of zero
outlen, zero bytes will be copied.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index fda175836fb6..b53acd238d36 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1568,12 +1568,10 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
 	resp.min_sq_wr = dev->dev_attr.min_sq_depth;
 
-	if (udata && udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err)
-			goto err_dealloc_uar;
-	}
+	err = ib_copy_to_udata(udata, &resp,
+			       min(sizeof(resp), udata->outlen));
+	if (err)
+		goto err_dealloc_uar;
 
 	return 0;
 
-- 
2.28.0

