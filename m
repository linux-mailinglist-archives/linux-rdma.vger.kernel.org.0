Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D754CAEBC8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfIJNnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 09:43:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4418 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568123003; x=1599659003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLtfeU4ImV7XDlhwuegfp96peNKe36QbTQrf1JDhwGw=;
  b=nebXwybSAEKPPIFMmzVzGY5K13md+hr+/Gn+8OWfn1t3VrQ2lipG0zDq
   OFcZyqY1q14S35zqaBOx6RjxueEmnE9HgF14PfW41Vt9j6aCseE0yzwB6
   HA8TfIc3kg5yl6b13/PmQw415kwAhLYKup8UbWFTa76aDmsquV1ZhJvB4
   I=;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="701811947"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 13:43:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id DD797A1C62;
        Tue, 10 Sep 2019 13:43:20 +0000 (UTC)
Received: from EX13D22EUA001.ant.amazon.com (10.43.165.37) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D22EUA001.ant.amazon.com (10.43.165.37) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.79.108) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Sep 2019 13:43:15 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-next 1/4] RDMA/efa: Fix incorrect error print
Date:   Tue, 10 Sep 2019 14:42:58 +0100
Message-ID: <20190910134301.4194-2-galpress@amazon.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910134301.4194-1-galpress@amazon.com>
References: <20190910134301.4194-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error print should indicate that it failed to get the queue
attributes, not network attributes.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 501dce89f275..c079f1332082 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -481,7 +481,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 				  EFA_ADMIN_QUEUE_ATTR);
 	if (err) {
 		ibdev_err_ratelimited(edev->efa_dev,
-				      "Failed to get network attributes %d\n",
+				      "Failed to get queue attributes %d\n",
 				      err);
 		return err;
 	}
-- 
2.23.0

