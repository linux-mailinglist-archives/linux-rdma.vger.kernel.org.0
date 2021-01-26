Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01966303C92
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbhAZMJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:09:05 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:5074 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392140AbhAZMJC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611662942; x=1643198942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPXkek76se4PprdnwSNIo0lenTE7T4QFmNoaNTvNtuA=;
  b=h1qJCyNIaCKs6Dqvrten20++tZ8WD9QknIBDwfBKv6uYSq5ThKvk8dok
   R7u0+ump/qj96mnDB4QIX1wy66f+5gJ6wLR2tgFkhjNtM2nKcL9CGzibW
   /PV9V6Oz4wiUEd0ATUmzInFQDdcWkUdBjKrbH3Wy2NC6vepi7QiRiy8bX
   s=;
X-IronPort-AV: E=Sophos;i="5.79,375,1602547200"; 
   d="scan'208";a="77680453"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Jan 2021 12:08:14 +0000
Received: from EX13D13EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 942C0120E94;
        Tue, 26 Jan 2021 12:08:13 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUB003.ant.amazon.com (10.43.166.55) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 Jan 2021 12:08:12 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.21) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 12:08:09 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 3/5] RDMA/efa: Remove unnecessary indentation in defs comments
Date:   Tue, 26 Jan 2021 14:06:59 +0200
Message-ID: <20210126120702.9807-4-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
References: <20210126120702.9807-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The indentation in the subsequent comment lines is unnecessary, remove
it.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 8 ++++----
 drivers/infiniband/hw/efa/efa_admin_defs.h      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index b199e4ac6cf9..d383850ee446 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_CMDS_H_
@@ -161,8 +161,8 @@ struct efa_admin_create_qp_resp {
 	u32 qp_handle;
 
 	/*
-	 * QP number in the given EFA virtual device. Least-significant bits
-	 *    (as needed according to max_qp) carry unique QP ID
+	 * QP number in the given EFA virtual device. Least-significant bits (as
+	 * needed according to max_qp) carry unique QP ID
 	 */
 	u16 qp_num;
 
@@ -465,7 +465,7 @@ struct efa_admin_create_cq_cmd {
 
 	/*
 	 * number of sub cqs - must be equal to sub_cqs_per_cq of queue
-	 *    attributes.
+	 * attributes.
 	 */
 	u16 num_sub_cqs;
 
diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
index 29d53ed63b3e..78ff9389ae25 100644
--- a/drivers/infiniband/hw/efa/efa_admin_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_H_
@@ -82,7 +82,7 @@ struct efa_admin_acq_common_desc {
 
 	/*
 	 * indicates to the driver which AQ entry has been consumed by the
-	 *    device and could be reused
+	 * device and could be reused
 	 */
 	u16 sq_head_indx;
 };
-- 
2.30.0

