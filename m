Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B3303C98
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392421AbhAZMJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:09:39 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60464 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392596AbhAZMJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611662962; x=1643198962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pqs46+Al2GjlLS1/yjkliOEa5s1UWhZGr+OvYYZgCks=;
  b=YAgV3j9UkOxEmchrKvt6/y31VHQDN6/s6u0lc07v2pVeqDOM1GGKxBkm
   w7/J75lv2q4qt2lh25alOBk0LkScnLIlstyZTehfyrGb89mx7LpbsLVEO
   FVOleamd5l9Y1Ybx9MT7tNAuPJOcgNBRI5thjbqccPHbcvfB5O1gxx5/f
   k=;
X-IronPort-AV: E=Sophos;i="5.79,375,1602547200"; 
   d="scan'208";a="77442493"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 26 Jan 2021 12:08:40 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id D8AAF14164D;
        Tue, 26 Jan 2021 12:08:39 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 Jan 2021 12:08:38 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.21) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 12:08:36 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 5/5] RDMA/efa: Remove unused syndrome enum values
Date:   Tue, 26 Jan 2021 14:07:01 +0200
Message-ID: <20210126120702.9807-6-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
References: <20210126120702.9807-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The notification syndrome enum values are unused, remove them.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 9327d5e3ec62..fa38b34eddb8 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -819,12 +819,6 @@ enum efa_admin_aenq_group {
 	EFA_ADMIN_AENQ_GROUPS_NUM                   = 5,
 };
 
-enum efa_admin_aenq_notification_syndrom {
-	EFA_ADMIN_SUSPEND                           = 0,
-	EFA_ADMIN_RESUME                            = 1,
-	EFA_ADMIN_UPDATE_HINTS                      = 2,
-};
-
 struct efa_admin_mmio_req_read_less_resp {
 	u16 req_id;
 
-- 
2.30.0

