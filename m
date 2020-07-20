Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1F7225995
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGTICB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 04:02:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18716 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTICB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 04:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595232121; x=1626768121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXBkKvxEbJsQ96m+qS4fije8AJ7HuRS1Zj4zUOqcY00=;
  b=RCoklrLgYFR2+91beeiWBzNlJx6iIndPs1+D4XJI4Rp6UMy1x9ZhNAeK
   Ix0gvX/9Zvs4u7E26Cy23sCDs74aSlYu/pVSgNwzDa/wap3dfERxLA4Ig
   yKafP8Fp90UbetueY6R/jsgSRi7Gdo64zm8FaT4vZBJG0M/AzscW/FB9X
   w=;
IronPort-SDR: 7d7ygNPQ5+PmELQpRbbgJj55hXnWRGlJ/zome3lQ+dV1Zme92nXWSrYBtAoefNFqFkQQMaTJVj
 6KdJ7VqDZ9nA==
X-IronPort-AV: E=Sophos;i="5.75,374,1589241600"; 
   d="scan'208";a="61016680"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Jul 2020 08:01:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 26844A0803;
        Mon, 20 Jul 2020 08:01:58 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D22EUA003.ant.amazon.com (10.43.165.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:56 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.12) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Jul 2020 08:01:52 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v2 4/4] RDMA/efa: Add EFA 0xefa1 PCI ID
Date:   Mon, 20 Jul 2020 11:01:13 +0300
Message-ID: <20200720080113.13055-5-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720080113.13055-1-galpress@amazon.com>
References: <20200720080113.13055-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for 0xefa1 devices.

Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 82145574c928..92d701146320 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -12,10 +12,12 @@
 
 #include "efa.h"
 
-#define PCI_DEV_ID_EFA_VF 0xefa0
+#define PCI_DEV_ID_EFA0_VF 0xefa0
+#define PCI_DEV_ID_EFA1_VF 0xefa1
 
 static const struct pci_device_id efa_pci_tbl[] = {
-	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA_VF) },
+	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA0_VF) },
+	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA1_VF) },
 	{ }
 };
 
-- 
2.27.0

