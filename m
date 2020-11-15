Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26B72B3376
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKOKeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 05:34:24 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62368 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKOKeX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Nov 2020 05:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605436463; x=1636972463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxaDaPsXBR9qf14cqwV8R21pbxt52oi1FGMcMWzG6DY=;
  b=eGmhaKNO/cgowv+8qNqLgj9//mXo0NQY2gmCxR01oWRAItngQTmSeBKU
   X1BrQ4RznUAMoZiiL7+mhfHRIP/x6ze1zkpU7E6O5cM7YJzzqgMPgPa4O
   uGimURkwsZozlFl+zrMbgxVTt3jfgUINSCcYr7ITj3YXHmDIhU9OBBvk1
   I=;
X-IronPort-AV: E=Sophos;i="5.77,480,1596499200"; 
   d="scan'208";a="95396639"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Nov 2020 10:34:20 +0000
Received: from EX13D13EUB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 26913A203D;
        Sun, 15 Nov 2020 10:34:18 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 15 Nov 2020 10:34:17 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.17) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 15 Nov 2020 10:34:14 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Remove .create_ah callback assignment
Date:   Sun, 15 Nov 2020 12:34:03 +0200
Message-ID: <20201115103404.48829-3-galpress@amazon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103404.48829-1-galpress@amazon.com>
References: <20201115103404.48829-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The AH creation flow is now split to two callbacks, based on
uverbs/kverbs. EFA only supports uverbs so the .create_ah assignment can
be removed.

Fixes: 676a80adba01 ("RDMA: Remove AH from uverbs_cmd_mask")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 2b3da85fb43c..cb2f2c647ee5 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -245,7 +245,6 @@ static const struct ib_device_ops efa_dev_ops = {
 	.alloc_hw_stats = efa_alloc_hw_stats,
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
-	.create_ah = efa_create_ah,
 	.create_cq = efa_create_cq,
 	.create_qp = efa_create_qp,
 	.create_user_ah = efa_create_ah,
-- 
2.29.2

