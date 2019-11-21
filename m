Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD710542C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKUOPi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 09:15:38 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26551 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKUOPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 09:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574345736; x=1605881736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gfQaUF8lzpKLuCIm9g8moQiKmL3qx9GwtlgsG5651n8=;
  b=hU+KhwPWWn8oFQLjYLqofiNFixwwdbggeESCva9pSLtaro5/aZLWW12v
   m1Z4SxQNSeyzAIiQ/jZUD49C6rqj5dLDtTk32UPYxUaFKpsa0QjVq1qEj
   OSHt5VM7X0Lejge6Rx79dM7L6IlF5jY4mQ9iouMvLMVII9mHLIr2Vn2aU
   I=;
IronPort-SDR: Be8IPlcJWLVAgEaVTWOKYIqYfkio8m3O4691SyilV03EbIbxYfN8r9GB8YYj4JQbJx1fRZbZvV
 vJJ7wxvL/jlg==
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="9057613"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Nov 2019 14:15:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id BF532C40CD;
        Thu, 21 Nov 2019 14:15:21 +0000 (UTC)
Received: from EX13D13EUB002.ant.amazon.com (10.43.166.205) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:21 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:20 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.146) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 14:15:18 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 2/3] RDMA/efa: Support remote read access in MR registration
Date:   Thu, 21 Nov 2019 16:15:08 +0200
Message-ID: <20191121141509.59297-3-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121141509.59297-1-galpress@amazon.com>
References: <20191121141509.59297-1-galpress@amazon.com>
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
index e1f1c1495da1..9701f8e52c71 100644
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
2.24.0

