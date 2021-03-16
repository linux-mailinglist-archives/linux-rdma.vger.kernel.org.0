Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1511C33D4C8
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhCPNYw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 09:24:52 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:49488 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhCPNYl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 09:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615901082; x=1647437082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8RqfYJVx3TxOGYL92bBqZD2JSDvaRMR8WOcio3v45M=;
  b=r48T2k3Hz/B3tqebF84Hgzt6GUoHMo+IQ2ykTbKZcybEFSR8PQrJ9Z5O
   OMTLSyRW5gLy4//+EmWVmJvjXOvUg71jhslBmBuooS5fNYF3TAvehf5ks
   uXytV7IfXF4nbrCxru2Hny/iG6kHG5opAfEwd5MuwC9it4f7QFGSBRDr/
   U=;
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="97771888"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Mar 2021 13:24:34 +0000
Received: from EX13D19EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 79C1FA21E4;
        Tue, 16 Mar 2021 13:24:33 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 13:24:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.106.83.17) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 16 Mar 2021 13:24:29 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
Date:   Tue, 16 Mar 2021 15:24:16 +0200
Message-ID: <20210316132416.83578-1-galpress@amazon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The strlcpy function doesn't limit the source length, use the preferred
strscpy function instead.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 0f578734bddb..a8da96ef2be8 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -209,10 +209,10 @@ static void efa_set_host_info(struct efa_dev *dev)
 	if (!hinf)
 		return;
 
-	strlcpy(hinf->os_dist_str, utsname()->release,
+	strscpy(hinf->os_dist_str, utsname()->release,
 		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
 	hinf->os_type = EFA_ADMIN_OS_LINUX;
-	strlcpy(hinf->kernel_ver_str, utsname()->version,
+	strscpy(hinf->kernel_ver_str, utsname()->version,
 		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
 	hinf->kernel_ver = LINUX_VERSION_CODE;
 	EFA_SET(&hinf->driver_ver, EFA_ADMIN_HOST_INFO_DRIVER_MAJOR, 0);
-- 
2.31.0

