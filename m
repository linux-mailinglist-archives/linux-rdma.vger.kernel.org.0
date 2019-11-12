Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F7F8B8F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLJSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 04:18:01 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30066 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLJSB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 04:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573550280; x=1605086280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+Mk8klq4ofaz7JCyqRqJk8FHFXq5xJJYoe/FM5DDDM=;
  b=ZUndGMm6BNVffe81lx1C8JoC5J2Ka5vboFcxUrUB4FNtwHEpUXPgqdBa
   Ag/9EHsQi/WBUecZWTWo7Vgjx3u/tb3EvTtmh8xlhgQhaR6iLSB6sgGeU
   3VDzK6cumQ9ndxTi5uLo5h3vVAmLv3jcDcU7scqz3vKF9aIjTvWSkEUwL
   E=;
IronPort-SDR: NLt9u8h7QZLxlP6CNBJlQMOJpq4p25xNQas6bi1jBCau0TSKZ4MS3E01XsiKapsoI7/VCYF7Ik
 QyKudvCMLGEQ==
X-IronPort-AV: E=Sophos;i="5.68,295,1569283200"; 
   d="scan'208";a="6699946"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Nov 2019 09:17:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 9B8581A12A4;
        Tue, 12 Nov 2019 09:17:55 +0000 (UTC)
Received: from EX13D19EUB004.ant.amazon.com (10.43.166.61) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB004.ant.amazon.com (10.43.166.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 12 Nov 2019 09:17:50 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 2/3] RDMA/efa: Support remote read access in MR registration
Date:   Tue, 12 Nov 2019 11:17:36 +0200
Message-ID: <20191112091737.40204-3-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112091737.40204-1-galpress@amazon.com>
References: <20191112091737.40204-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daniel Kranzdorf <dkkranzd@amazon.com>

Enable remote read access for memory regions in order to support RDMA
operations.

Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 12 +++++++++---
 drivers/infiniband/hw/efa/efa_com_cmd.c         |  3 +--
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  7 +------
 drivers/infiniband/hw/efa/efa_verbs.c           |  5 +++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 2be0469d545f..7fa9d532db61 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -362,9 +362,13 @@ struct efa_admin_reg_mr_cmd {
 
 	/*
 	 * permissions
-	 * 0 : local_write_enable - Write permissions: value
-	 *    of 1 needed for RQ buffers and for RDMA write
-	 * 7:1 : reserved1 - remote access flags, etc
+	 * 0 : local_write_enable - Local write permissions:
+	 *    must be set for RQ buffers and buffers posted for
+	 *    RDMA Read requests
+	 * 1 : reserved1 - MBZ
+	 * 2 : remote_read_enable - Remote read permissions:
+	 *    must be set to enable RDMA read from the region
+	 * 7:3 : reserved2 - MBZ
 	 */
 	u8 permissions;
 
@@ -780,6 +784,8 @@ struct efa_admin_mmio_req_read_less_resp {
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_SHIFT     7
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
 #define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
+#define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_SHIFT       2
+#define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_MASK        BIT(2)
 
 /* create_cq_cmd */
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_SHIFT 5
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 4713c2756ad3..520c9d920f9e 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -230,8 +230,7 @@ int efa_com_register_mr(struct efa_com_dev *edev,
 	mr_cmd.flags |= params->page_shift &
 		EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK;
 	mr_cmd.iova = params->iova;
-	mr_cmd.permissions |= params->permissions &
-			      EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK;
+	mr_cmd.permissions = params->permissions;
 
 	if (params->inline_pbl) {
 		memcpy(mr_cmd.pbl.inline_pbl_array,
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 6134d13ecc6f..d119186c41d0 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -178,12 +178,7 @@ struct efa_com_reg_mr_params {
 	 * address mapping
 	 */
 	u8 page_shift;
-	/*
-	 * permissions
-	 * 0: local_write_enable - Write permissions: value of 1 needed
-	 * for RQ buffers and for RDMA write:1: reserved1 - remote
-	 * access flags, etc
-	 */
+	/* see permissions field of struct efa_admin_reg_mr_cmd */
 	u8 permissions;
 	u8 inline_pbl;
 	u8 indirect;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 0d09b365be48..e5008de89ef0 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -70,7 +70,8 @@ static const char *const efa_stats_names[] = {
 #define EFA_CHUNK_USED_SIZE \
 	((EFA_PTRS_PER_CHUNK * EFA_CHUNK_PAYLOAD_PTR_SIZE) + EFA_CHUNK_PTR_SIZE)
 
-#define EFA_SUPPORTED_ACCESS_FLAGS IB_ACCESS_LOCAL_WRITE
+#define EFA_SUPPORTED_ACCESS_FLAGS \
+	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ)
 
 struct pbl_chunk {
 	dma_addr_t dma_addr;
@@ -1382,7 +1383,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	params.pd = to_epd(ibpd)->pdn;
 	params.iova = virt_addr;
 	params.mr_length_in_bytes = length;
-	params.permissions = access_flags & 0x1;
+	params.permissions = access_flags;
 
 	pg_sz = ib_umem_find_best_pgsz(mr->umem,
 				       dev->dev_attr.page_size_cap,
-- 
2.23.0

