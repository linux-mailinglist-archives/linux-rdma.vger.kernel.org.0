Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1853C2280F6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGUNb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:31:27 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57976 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgGUNb1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 09:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595338287; x=1626874287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXBkKvxEbJsQ96m+qS4fije8AJ7HuRS1Zj4zUOqcY00=;
  b=UwRuUQz83hBoz/bndkkzRD29U1yeKmOPTa1KFyMy9jSzSF3fcu1+PMLR
   eiXXvsTRGqi4rlQh8qqRtrm1GKGNSRHxc+tL5oAz9Pk0B72gTqe5xUIP3
   2+iyJtNA1o8FBhONklGL4qiepYBWuL7k5ypVKYD/wnL3eCxBxMCHwu394
   M=;
IronPort-SDR: LYou7jTWIkIy8w2xqHADWo62w4j/kQbYD1c79rCl/Ce4ed/0bG5W7Xn5wnQzfyxtI4vOZIQxev
 ed/PAHYSqE4A==
X-IronPort-AV: E=Sophos;i="5.75,378,1589241600"; 
   d="scan'208";a="61579251"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-60ce1996.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Jul 2020 13:31:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-60ce1996.us-west-2.amazon.com (Postfix) with ESMTPS id 69E90A3430;
        Tue, 21 Jul 2020 13:31:25 +0000 (UTC)
Received: from EX13D22EUB003.ant.amazon.com (10.43.166.142) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D22EUB003.ant.amazon.com (10.43.166.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:23 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.11) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 21 Jul 2020 13:31:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v3 4/4] RDMA/efa: Add EFA 0xefa1 PCI ID
Date:   Tue, 21 Jul 2020 16:30:49 +0300
Message-ID: <20200721133049.74349-5-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721133049.74349-1-galpress@amazon.com>
References: <20200721133049.74349-1-galpress@amazon.com>
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

