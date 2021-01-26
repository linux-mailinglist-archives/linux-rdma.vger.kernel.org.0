Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D8303C93
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbhAZMJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:09:22 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56694 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392578AbhAZMJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611662957; x=1643198957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqYnfshhXPXbkMouA2rUJp9xWBVuBcJ7FAZeJ0E/HHU=;
  b=ANpqpUuWJCpGAGERBPaBFMbouoGu92On2t6RMLU8k9gv66YcEXi5WyvA
   prJJq29oEVzthlT5gER+dv302G3ReF0kHL/SaP/A6D8kqztDmOESb89Mp
   Hg0IyRt/okPqLF1+ByVAmWLk46cpCiC07/y6B0G/v33Pcugsh9SQNe2K8
   Y=;
X-IronPort-AV: E=Sophos;i="5.79,375,1602547200"; 
   d="scan'208";a="80169819"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 26 Jan 2021 12:08:29 +0000
Received: from EX13D19EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id E3965A22EF;
        Tue, 26 Jan 2021 12:08:28 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 Jan 2021 12:08:27 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.21) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 12:08:21 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 4/5] RDMA/efa: Remove unused 'select' field from get/set feature command descriptor
Date:   Tue, 26 Jan 2021 14:07:00 +0200
Message-ID: <20210126120702.9807-5-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
References: <20210126120702.9807-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'select' field in the get/set feature admin command is
unimplemented, unused and misleading, remove it.
The command always refers to the current values.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index d383850ee446..9327d5e3ec62 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -563,12 +563,8 @@ struct efa_admin_acq_get_stats_resp {
 };
 
 struct efa_admin_get_set_feature_common_desc {
-	/*
-	 * 1:0 : select - 0x1 - current value; 0x3 - default
-	 *    value
-	 * 7:3 : reserved3 - MBZ
-	 */
-	u8 flags;
+	/* MBZ */
+	u8 reserved0;
 
 	/* as appears in efa_admin_aq_feature_id */
 	u8 feature_id;
@@ -909,9 +905,6 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
 #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
 
-/* get_set_feature_common_desc */
-#define EFA_ADMIN_GET_SET_FEATURE_COMMON_DESC_SELECT_MASK   GENMASK(1, 0)
-
 /* feature_device_attr_desc */
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
-- 
2.30.0

