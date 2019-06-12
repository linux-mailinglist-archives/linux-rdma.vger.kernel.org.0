Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7A41DB8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbfFLH25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 03:28:57 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64018 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389710AbfFLH25 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 03:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560324536; x=1591860536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CR0DqlhbCF/5aaAWCQyLhms86t7ulAXnhxRMMOrGVE=;
  b=eV4+KJncKCMks74BIsD9azBfGBFPQziP1zDvWTkBmPIXOHfLn5WvYT8E
   FhyN+hdi+hINmWHbVTd3kgyrZQMBV/JCmSw2Ayk1N9to3AuLLceEWl/Cl
   6G6hxeeBtxHQN/KFGCMnXet5XPBPkAHmhRW0IhCZ40/Usel91T9WySruW
   w=;
X-IronPort-AV: E=Sophos;i="5.62,363,1554768000"; 
   d="scan'208";a="804941592"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Jun 2019 07:28:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id EEB17A2413;
        Wed, 12 Jun 2019 07:28:53 +0000 (UTC)
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:53 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 07:28:49 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc 1/2] RDMA/efa: Fix success return value in case of error
Date:   Wed, 12 Jun 2019 10:28:41 +0300
Message-ID: <20190612072842.99285-2-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612072842.99285-1-galpress@amazon.com>
References: <20190612072842.99285-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Existing code would mistakenly return success in case of error instead
of a proper return value.

Fixes: e9c6c5373088 ("RDMA/efa: Add common command handlers")
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 14227725521c..c0016648804c 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -139,9 +139,11 @@ int efa_com_destroy_qp(struct efa_com_dev *edev,
 			       sizeof(qp_cmd),
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev, "Failed to destroy qp-%u [%d]\n",
 			  qp_cmd.qp_handle, err);
+		return err;
+	}
 
 	return 0;
 }
@@ -199,9 +201,11 @@ int efa_com_destroy_cq(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&destroy_resp,
 			       sizeof(destroy_resp));
 
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev, "Failed to destroy CQ-%u [%d]\n",
 			  params->cq_idx, err);
+		return err;
+	}
 
 	return 0;
 }
@@ -273,10 +277,12 @@ int efa_com_dereg_mr(struct efa_com_dev *edev,
 			       sizeof(mr_cmd),
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev,
 			  "Failed to de-register mr(lkey-%u) [%d]\n",
 			  mr_cmd.l_key, err);
+		return err;
+	}
 
 	return 0;
 }
@@ -327,9 +333,11 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 			       sizeof(ah_cmd),
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev, "Failed to destroy ah-%d pd-%d [%d]\n",
 			  ah_cmd.ah, ah_cmd.pd, err);
+		return err;
+	}
 
 	return 0;
 }
@@ -387,10 +395,12 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 			       get_resp,
 			       sizeof(*get_resp));
 
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev,
 			  "Failed to submit get_feature command %d [%d]\n",
 			  feature_id, err);
+		return err;
+	}
 
 	return 0;
 }
@@ -534,10 +544,12 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)set_resp,
 			       sizeof(*set_resp));
 
-	if (err)
+	if (err) {
 		ibdev_err(edev->efa_dev,
 			  "Failed to submit set_feature command %d error: %d\n",
 			  feature_id, err);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.22.0

