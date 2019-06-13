Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADF43EAB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFMPwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:52:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:57748 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbfFMJKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560417041; x=1591953041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eay/JlCoNDOS+5zq4DrCJel0ANfIHraEdQufCxzBppo=;
  b=Qhoh+hpE8wsIsEMyrsxyrTcpmCYQA4ZdbVXt/GYyQSg9COSqVKa7hOFE
   z+i9dL55+Beh8Egd84uUQXxwxQmHYICeCX7hPZClv7EXse1B8Rg6RDjmQ
   GU+/r+c/KPj6hvDWWpqYMMUezmdAwWtDrmJtGB5pq3S0nYRnovaWTPygY
   M=;
X-IronPort-AV: E=Sophos;i="5.62,369,1554768000"; 
   d="scan'208";a="805185818"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 13 Jun 2019 09:10:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id A4C3FA2490;
        Thu, 13 Jun 2019 09:10:39 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:39 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:38 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.75.47) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 09:10:34 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 2/3] RDMA/efa: Be consistent with success flow return value
Date:   Thu, 13 Jun 2019 12:10:13 +0300
Message-ID: <20190613091014.93483-3-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613091014.93483-1-galpress@amazon.com>
References: <20190613091014.93483-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The EFA driver is written with success oriented flows in mind, meaning
that functions should mostly end with a return 0 statement.
Error flows return their error value on their own instead of assuming
that the function will return the error at the end.

This commit fixes a bunch of functions that were not aligned with this
behavior.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
 drivers/infiniband/hw/efa/efa_main.c    | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c   | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 91e7f2195802..d2464c8390bb 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -56,7 +56,7 @@ int efa_com_create_qp(struct efa_com_dev *edev,
 	res->send_sub_cq_idx = cmd_completion.send_sub_cq_idx;
 	res->recv_sub_cq_idx = cmd_completion.recv_sub_cq_idx;
 
-	return err;
+	return 0;
 }
 
 int efa_com_modify_qp(struct efa_com_dev *edev,
@@ -178,7 +178,7 @@ int efa_com_create_cq(struct efa_com_dev *edev,
 	result->cq_idx = cmd_completion.cq_idx;
 	result->actual_depth = params->cq_depth;
 
-	return err;
+	return 0;
 }
 
 int efa_com_destroy_cq(struct efa_com_dev *edev,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index db974caf1eb1..44152ed1ee86 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -100,7 +100,7 @@ static int efa_request_mgmnt_irq(struct efa_dev *dev)
 		nr_cpumask_bits, &irq->affinity_hint_mask, irq->vector);
 	irq_set_affinity_hint(irq->vector, &irq->affinity_hint_mask);
 
-	return err;
+	return 0;
 }
 
 static void efa_setup_mgmnt_irq(struct efa_dev *dev)
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 09afb5fbb49f..5ebd84fe7e92 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1619,13 +1619,15 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		err = -EINVAL;
 	}
 
-	if (err)
+	if (err) {
 		ibdev_dbg(
 			&dev->ibdev,
 			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
 			entry->address, length, entry->mmap_flag, err);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 int efa_mmap(struct ib_ucontext *ibucontext,
-- 
2.22.0

