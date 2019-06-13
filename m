Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C25C43E96
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbfFMPvu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:51:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:15569 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbfFMJKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 05:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560417045; x=1591953045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwhgGsWpMq4SS5ph2e3BiN1gfGk9zfaKimfqFbODx/I=;
  b=IwTzJJ3cj2gzVtXvlEEwgYatB0lO1rSgy3Zjs3CfgubRcxboFxh9qTyu
   gUe2LxhHIG2lJmMIN6Qq9VXcYVpPk1nrT1HU4zo7HagaKQojxy1Vb2Ojm
   5bs5b8pxNbaLF8yeqS1SujaG7fyavhvC1026vLFk5yiuL2iKqr+e0HTf7
   4=;
X-IronPort-AV: E=Sophos;i="5.62,369,1554768000"; 
   d="scan'208";a="400545327"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 13 Jun 2019 09:10:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (Postfix) with ESMTPS id 8933FA1CCB;
        Thu, 13 Jun 2019 09:10:43 +0000 (UTC)
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:43 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13EUA004.ant.amazon.com (10.43.165.22) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:41 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.75.47) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 09:10:38 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Firas Jahjah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 3/3] RDMA/efa: Print address on AH creation failure
Date:   Thu, 13 Jun 2019 12:10:14 +0300
Message-ID: <20190613091014.93483-4-galpress@amazon.com>
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

From: Firas Jahjah <firasj@amazon.com>

For debugging purposes, print destination address if failed to create AH.

Signed-off-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index d2464c8390bb..fad5c2ee7bb1 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -300,7 +300,8 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to create ah [%d]\n", err);
+		ibdev_err(edev->efa_dev, "Failed to create ah for %pI6 [%d]\n",
+			  ah_cmd.dest_addr, err);
 		return err;
 	}
 
-- 
2.22.0

