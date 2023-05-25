Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE76710925
	for <lists+linux-rdma@lfdr.de>; Thu, 25 May 2023 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjEYJo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 May 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbjEYJo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 May 2023 05:44:57 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA8A9
        for <linux-rdma@vger.kernel.org>; Thu, 25 May 2023 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685007898; x=1716543898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dVRill0ltZ01ymFt19AlVkKRLG4nUCF3MRAO5Y/RSQo=;
  b=K7+MhY7ULBOOmMH3qobV7p1LBpA12J1MTsAvIV3j9pTwtploQwYx93oO
   w7YpIdCDn2siYtdAd4loeD+HK9ri4QgawAawGRhXuKR+qcEDDok/3s/1+
   cISwviYYyLeZTI2a5wz4ZdYvr92GO5wR8vHsrObUDswj7PcSiXEnfEbXP
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,190,1681171200"; 
   d="scan'208";a="216533887"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 09:44:54 +0000
Received: from EX19D013EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 4DE9380FC5;
        Thu, 25 May 2023 09:44:52 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D013EUA003.ant.amazon.com (10.252.50.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 09:44:45 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.135.200) with Microsoft
 SMTP Server id 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:44:44
 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>
Subject: [PATCH] MAINTAINERS: Update maintainer of Amazon EFA driver
Date:   Thu, 25 May 2023 09:44:44 +0000
Message-ID: <20230525094444.12570-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change EFA driver maintainer from Gal Pressman to myself.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..24a0640ded06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -956,7 +956,7 @@ F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
 F:	drivers/net/ethernet/amazon/
 
 AMAZON RDMA EFA DRIVER
-M:	Gal Pressman <galpress@amazon.com>
+M:	Michael Margolin <mrgolin@amazon.com>
 R:	Yossi Leybovich <sleybo@amazon.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-- 
2.39.2

