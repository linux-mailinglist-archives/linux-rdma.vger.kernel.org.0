Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3734CFA2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhC2MCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 08:02:22 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16851 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC2MB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 08:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617019318; x=1648555318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JQd5HR4/QxY99wD8KdnyC34GLKTuEPtKQ5rKqmMpUvE=;
  b=eORMBJMiLqDxAjQCCy2ygxBHa1rB8V8gxtM0ODdtT88OGMDrug78Jy01
   /BdIzOQi7KXtcxYY2zaoIVRtTVvRrYEZdVhin7vNNNwMoLlNQNieLio8F
   XEqoc9GgDt/BUe5DkaJvAdrUdEWkj4OYJh2gvFvO6gNDtGA+rj7x9o2Hq
   E=;
X-IronPort-AV: E=Sophos;i="5.81,287,1610409600"; 
   d="scan'208";a="97243051"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 29 Mar 2021 12:01:51 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id EA825A1CB6;
        Mon, 29 Mar 2021 12:01:49 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 29 Mar 2021 12:01:48 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.67.47) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 29 Mar 2021 12:01:46 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Use strscpy instead of strlcpy
Date:   Mon, 29 Mar 2021 15:01:28 +0300
Message-ID: <20210329120131.18793-1-galpress@amazon.com>
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
v1->v2: https://lore.kernel.org/linux-rdma/20210316132416.83578-1-galpress@amazon.com/
* Remove the min() in the length argument (Jason)
---
 drivers/infiniband/hw/efa/efa_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 0f578734bddb..816cfd65b7ac 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -209,11 +209,11 @@ static void efa_set_host_info(struct efa_dev *dev)
 	if (!hinf)
 		return;
 
-	strlcpy(hinf->os_dist_str, utsname()->release,
-		min(sizeof(hinf->os_dist_str), sizeof(utsname()->release)));
+	strscpy(hinf->os_dist_str, utsname()->release,
+		sizeof(hinf->os_dist_str));
 	hinf->os_type = EFA_ADMIN_OS_LINUX;
-	strlcpy(hinf->kernel_ver_str, utsname()->version,
-		min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
+	strscpy(hinf->kernel_ver_str, utsname()->version,
+		sizeof(hinf->kernel_ver_str));
 	hinf->kernel_ver = LINUX_VERSION_CODE;
 	EFA_SET(&hinf->driver_ver, EFA_ADMIN_HOST_INFO_DRIVER_MAJOR, 0);
 	EFA_SET(&hinf->driver_ver, EFA_ADMIN_HOST_INFO_DRIVER_MINOR, 0);

base-commit: 783cf673b05ebf290317f583ee7eb6967ed9c964
-- 
2.31.0

