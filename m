Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526F0AEBCB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfIJNnc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 09:43:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:51177 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNnc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 09:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568123012; x=1599659012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTDuCr4NjgqoRi6zevo3wZMRZ0iYINS5nrcNJ/wq1Ds=;
  b=ZK1lIGEXA9yRySahMOrxwsehA54LOdWH/tweqyg4c4Cn4+DSl03PJGSF
   XxyKz5i3v6pUMAOMWhy2xHp/7Sq607NaKjhDRUU8Ldkgg81CLKIt6RJti
   UeERavTHx88ouwJDTgA9Hrmum1ckOjefpwdzqQH0UF6Cn0h1KPMCkn/C4
   8=;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="414510105"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Sep 2019 13:43:29 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 5046EA1C0A;
        Tue, 10 Sep 2019 13:43:28 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:27 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:26 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.79.108) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Sep 2019 13:43:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 3/4] RDMA/efa: Support remote read access in MR registration
Date:   Tue, 10 Sep 2019 14:43:00 +0100
Message-ID: <20190910134301.4194-4-galpress@amazon.com>
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
index fe79351334f3..0011e2c1c8a6 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -82,7 +82,8 @@ static const char *const efa_stats_names[] = {
 #define EFA_CHUNK_USED_SIZE \
 	((EFA_PTRS_PER_CHUNK * EFA_CHUNK_PAYLOAD_PTR_SIZE) + EFA_CHUNK_PTR_SIZE)
 
-#define EFA_SUPPORTED_ACCESS_FLAGS IB_ACCESS_LOCAL_WRITE
+#define EFA_SUPPORTED_ACCESS_FLAGS \
+	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ)
 
 struct pbl_chunk {
 	dma_addr_t dma_addr;
@@ -1434,7 +1435,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	params.pd = to_epd(ibpd)->pdn;
 	params.iova = virt_addr;
 	params.mr_length_in_bytes = length;
-	params.permissions = access_flags & 0x1;
+	params.permissions = access_flags;
 
 	pg_sz = ib_umem_find_best_pgsz(mr->umem,
 				       dev->dev_attr.page_size_cap,
-- 
2.23.0

