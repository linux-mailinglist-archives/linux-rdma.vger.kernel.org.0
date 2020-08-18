Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2382D2480C8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHRIir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 04:38:47 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:61542 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHRIip (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 04:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597739925; x=1629275925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ePD5zyYoPayfSFLIbdK4wW57JpT+Xr5FtXiAiJVBKLE=;
  b=ZUJfpKCCxVa6VsaqkzNXoShwJm4ShPRP4KQIchURHtFI92y1wwVVt1H+
   YcFPkGIH+mtAnwAF12ZCWS38FqHqw+Q3RSkCwx0JI1DytwMMCbgMpLdmi
   aaWfLHqrr60AnQ+sj+3MkKoKzwRfS+7u8WKA7eaTHhT0aAMfLQiAKxHK0
   Q=;
X-IronPort-AV: E=Sophos;i="5.76,326,1592870400"; 
   d="scan'208";a="48412117"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 18 Aug 2020 08:38:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 4E0FBA1199;
        Tue, 18 Aug 2020 08:38:43 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 08:38:42 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 08:38:41 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.29) by
 mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 18 Aug 2020 08:38:39 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/core: Add a debug print when a driver is marked as non-kverbs provider
Date:   Tue, 18 Aug 2020 11:38:31 +0300
Message-ID: <20200818083831.92212-1-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a debug print which is emitted when a certain driver is marked as
non-kverbs provider. This allows for easier understanding of why kverbs
functionality isn't working in such cases.

In addition, print the name of the first mandatory verb that is missing.
This brings back use for the unused name field.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d293b826acbc..dc5896040df9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -293,6 +293,10 @@ static void ib_device_check_mandatory(struct ib_device *device)
 	for (i = 0; i < ARRAY_SIZE(mandatory_table); ++i) {
 		if (!*(void **) ((void *) &device->ops +
 				 mandatory_table[i].offset)) {
+			ibdev_dbg(
+				device,
+				"Marking as non-kverbs provider due to missing mandatory verb %s",
+				mandatory_table[i].name);
 			device->kverbs_provider = false;
 			break;
 		}
-- 
2.28.0

