Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAB761DBE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjGYPzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGYPzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563C18F
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300515; x=1721836515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MrOq5kHsrV2D32CQnsi44biowqdzzBgWSyMX2CT3UI8=;
  b=NaNilbRlP9U+J3X1KrZspRAEhRSfRedJYuqof9Np5yibM0XegTdhnn0A
   87NPFwbkABWR87z1CmLumWJvkOLYvLLN6hB7k7PQrLOPeoz/N1qSj5zwH
   7iGSF0S5I8HYYdlYfboa2XVAtbTKaeCivzT8Lph3FTybvROiHIQmQFs9t
   d8i4NSW8hY6qEW/vLCwdwzG7OgTqPshF5koO9XMCg7MQM63aYse24If+x
   I30TeN1EVreEBMyt4vpQ20IECPhXFO0WGT1L918F89wWjP1WPdw8fJPoo
   sEgvVXTYx33RliDLJowRdGZEDwnMtqnqd05aWs1TKAWog8UCIOwt56EAA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574671"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574671"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743797"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743797"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:14 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/4] irdma: Misc cleanup
Date:   Tue, 25 Jul 2023 10:55:01 -0500
Message-Id: <20230725155505.1069-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains miscellaneous clean up patches and
update to how CQ lookup is done during AE events.

Krzysztof Czurylo (1):
  RDMA/irdma: Add table based lookup for CQ pointer during an event

Mustafa Ismail (1):
  RDMA/irdma: Cleanup and rename irdma_netdev_vlan_ipv6()

Sindhu Devale (2):
  RDMA/irdma: Drop a local in irdma_sc_get_next_aeqe
  RDMA/irdma: Refactor error handling in create CQP

 drivers/infiniband/hw/irdma/cm.c    | 23 ++++++--------
 drivers/infiniband/hw/irdma/ctrl.c  |  5 +--
 drivers/infiniband/hw/irdma/hw.c    | 62 ++++++++++++++++++++++++-------------
 drivers/infiniband/hw/irdma/main.h  |  6 +++-
 drivers/infiniband/hw/irdma/utils.c | 25 +++++++++++++++
 drivers/infiniband/hw/irdma/verbs.c |  9 +++++-
 drivers/infiniband/hw/irdma/verbs.h |  2 ++
 7 files changed, 91 insertions(+), 41 deletions(-)

-- 
1.8.3.1

