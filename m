Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F071EEFD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFAQap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjFAQan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 12:30:43 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B8D1
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685637043; x=1717173043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WzxbMtvaoeBZacTn0Okr5QdGjMb4QaxZAvuY/Vp4fI8=;
  b=ioxpKY4qbE8QmXPe2AGzZJpJoDGwFqCaRRCCpZml9U7eM/ZkwNKMtXaj
   B9XaRwd5qkDU1q7SVcnevohxnix8Osz1X89M/ND3O0pLszk/gXzIoVd93
   j21yPALzi6YtnLnfxNDO+N2CJ2ADyTCLKj5jBDr6Iflyl7SuwgOz+i1fZ
   s=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="338079193"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 16:30:39 +0000
Received: from EX19D002EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 0E6DE45BF0;
        Thu,  1 Jun 2023 16:30:36 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D002EUC002.ant.amazon.com (10.252.51.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 16:30:35 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.135.200) with Microsoft
 SMTP Server id 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 16:30:35
 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH v2] MAINTAINERS: Update maintainer of Amazon EFA driver
Date:   Thu, 1 Jun 2023 16:30:34 +0000
Message-ID: <20230601163034.13269-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change EFA driver maintainer from Gal Pressman to myself.
Add Gal as reviewer.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..805307f7e13b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -956,8 +956,9 @@ F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
 F:	drivers/net/ethernet/amazon/
 
 AMAZON RDMA EFA DRIVER
-M:	Gal Pressman <galpress@amazon.com>
+M:	Michael Margolin <mrgolin@amazon.com>
 R:	Yossi Leybovich <sleybo@amazon.com>
+R:	Gal Pressman <gal.pressman@linux.dev>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-rdma/list/
-- 
2.39.2

