Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21D6FF0B2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjEKLvR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEKLvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 07:51:15 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232138A47
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1683805873; x=1715341873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rjBOooN5o4H43NMQtcL8q8kkJ3R/anmgGygBdo2R4cw=;
  b=rNAmveMO1Rdn6jK1YeESpmTv2fpljElBAD5FldbIjcdCkAgQ7A1Inbu9
   C5CF3tDKN5UTUI+Nlf4JviXh9dftyWQF1sbO7gcgLG1PUOyhE/u2rhG17
   mXEoYEBB7g9hCFn7y0DEKCCLNeQfsbpWEDKVwfjvKAmqeDGAwT9wHBhYW
   g=;
X-IronPort-AV: E=Sophos;i="5.99,266,1677542400"; 
   d="scan'208";a="213072604"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 11:51:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 51240A778B;
        Thu, 11 May 2023 11:51:06 +0000 (UTC)
Received: from EX19D004UWB004.ant.amazon.com (10.13.138.108) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 11:51:05 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D004UWB004.ant.amazon.com (10.13.138.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 11:51:05 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Thu, 11 May 2023 11:51:03
 +0000
From:   <ynachum@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
        <bbarrett@amazon.com>, Yonatan Nachum <ynachum@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Fix unsupported page sizes in device
Date:   Thu, 11 May 2023 11:51:03 +0000
Message-ID: <20230511115103.13876-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yonatan Nachum <ynachum@amazon.com>

Device uses 4KB size blocks for user pages indirect list while the
driver creates those blocks with the size of PAGE_SIZE of the kernel. On
kernels with PAGE_SIZE different than 4KB (ARM RHEL), this leads to a
failure on register MR with indirect list because of the miss
communication between driver and device.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8eca6c14d0cf..2a195c4b0f17 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1403,7 +1403,7 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  */
 static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZE);
+	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
-- 
2.39.2

