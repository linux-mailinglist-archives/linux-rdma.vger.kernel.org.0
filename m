Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9B2299E1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGVOOX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:14:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50656 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGVOOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595427262; x=1626963262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXBkKvxEbJsQ96m+qS4fije8AJ7HuRS1Zj4zUOqcY00=;
  b=uQJqpCM72oXyaRk4twlZS9egNaVPsC/kR0swRTi7mqiPBmYhEwHbxsTx
   /M1roTYgK7uYY+GTz9t9/i9y6ZQK910FKq0stUqX240Am5ufwd75CTJ+J
   rUo0eSVa7L5se06tQ4FHJ9PpXKGGBVO1GxtcWkGhywgUEaz2K1HE3kVep
   I=;
IronPort-SDR: BVui8p+ofrfE+OJdVYVtU+yobgnyiwIMGWLuM/6LroQpSHh948kp0PY2Qty+2xJhx2guPi9aFp
 y4QTfB3k3SyA==
X-IronPort-AV: E=Sophos;i="5.75,383,1589241600"; 
   d="scan'208";a="53748704"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Jul 2020 14:07:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id E4C0DA2A91;
        Wed, 22 Jul 2020 14:03:42 +0000 (UTC)
Received: from EX13D19EUB002.ant.amazon.com (10.43.166.78) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:41 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.83.32) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 22 Jul 2020 14:03:37 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v4 4/4] RDMA/efa: Add EFA 0xefa1 PCI ID
Date:   Wed, 22 Jul 2020 17:03:12 +0300
Message-ID: <20200722140312.3651-5-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722140312.3651-1-galpress@amazon.com>
References: <20200722140312.3651-1-galpress@amazon.com>
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

