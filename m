Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A5F8BAA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 10:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLJ0V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 04:26:21 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62856 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKLJ0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 04:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573550780; x=1605086780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c5ue4zW/Jg9vutnQiDXwWVYJSnDh7bMHm7lWiQw0hLA=;
  b=QFqimPRps7YTwixqowwtoOiTGTRPkyL3otBUWk+cRdmTjyUI4jm4cgUv
   ntsIB2La9Enpagcl1BEcWxoNjoc5cYHepJydW4BusxH9UWCatFYx4/6gJ
   TeyFz+kaU5GdUk9aYeYXR3Gelo4xYtPDkV2+LiqOf0fkzPovo3Z63BL/r
   g=;
IronPort-SDR: coD7J2hQVvurLsU6lKNViPtH7h+7hWd/33dLrM7YOgteDyhxRzs2D8xzevI0ViEc0Xvrb8oRiu
 ju92vq/KCr7Q==
X-IronPort-AV: E=Sophos;i="5.68,295,1569283200"; 
   d="scan'208";a="6371055"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Nov 2019 09:26:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 83359A20BA;
        Tue, 12 Nov 2019 09:26:18 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:26:17 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D22EUA003.ant.amazon.com (10.43.165.210) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:26:16 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 12 Nov 2019 09:26:13 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Clear the admin command buffer prior to its submission
Date:   Tue, 12 Nov 2019 11:26:08 +0200
Message-ID: <20191112092608.46964-1-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We cannot rely on the entry memcpy as we only copy the actual size of
the command, the rest of the bytes must be memset to zero.

Fixes: 0420e542569b ("RDMA/efa: Implement functions that submit and complete admin commands")
Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 3c412bc5b94f..0778f4f7dccd 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -317,6 +317,7 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 						       struct efa_admin_acq_entry *comp,
 						       size_t comp_size_in_bytes)
 {
+	struct efa_admin_aq_entry *aqe;
 	struct efa_comp_ctx *comp_ctx;
 	u16 queue_size_mask;
 	u16 cmd_id;
@@ -350,7 +351,9 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 
 	reinit_completion(&comp_ctx->wait_event);
 
-	memcpy(&aq->sq.entries[pi], cmd, cmd_size_in_bytes);
+	aqe = &aq->sq.entries[pi];
+	memset(aqe, 0, sizeof(*aqe));
+	memcpy(aqe, cmd, cmd_size_in_bytes);
 
 	aq->sq.pc++;
 	atomic64_inc(&aq->stats.submitted_cmd);
-- 
2.23.0

