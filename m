Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84212761DC7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjGYPzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGYPzr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1E2113
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300536; x=1721836536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oaeQrS0qV0Zna/2jxSX1tC9GkE5ZQ3ekZusN2sfbdbQ=;
  b=VhViwaiXVDaKU46/Cl7tue0tjQKcdTjSR68+aWQpqruSuyL04TuIzjhv
   npIhu3YkV6KY6apYiNrSjVfHfuvRh7kmW5xXoRU2okWYXKQaM08u6lVog
   L5gZd3y24xRX1UN7qoXQbhOUcRcr5cDf3Z7qpDt9MhTnnErqpOzYE7T+V
   fRsmGtkJKZbSvL6pwrgE3m9OvNoy/JBaA6TFB7lIdoKjOGx2ugkkLFt1V
   BgtNt7IPEbS8DQPHCqB1Gnu/+dBRm20N7iCDwyBxWFYcPHmMVjdPbdDpF
   vNR71nV/N9CeGOJ9DXhF7+FfDmSoOyvPjNhWM44iQ6d8Sn8hEmlOL0HDW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574792"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574792"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743869"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743869"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:35 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/2] RDMA/irdma: Use coherent user/kernel queue size
Date:   Tue, 25 Jul 2023 10:55:23 -0500
Message-Id: <20230725155525.1081-1-shiraz.saleem@intel.com>
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

This series extends ABI to allow user QPs max send/recv WR to be
retrievable in driver and pass generation specific min WQ size to
user-space.

Sindhu Devale (2):
  RDMA/irdma: Allow accurate reporting on QP max send/recv WR
  RDMA/irdma: Use HW specific minimum WQ size

 drivers/infiniband/hw/irdma/i40iw_hw.c  |   1 +
 drivers/infiniband/hw/irdma/i40iw_hw.h  |   2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c |   1 +
 drivers/infiniband/hw/irdma/icrdma_hw.h |   1 +
 drivers/infiniband/hw/irdma/irdma.h     |   1 +
 drivers/infiniband/hw/irdma/uk.c        | 101 ++++++++++++++----
 drivers/infiniband/hw/irdma/user.h      |  11 ++
 drivers/infiniband/hw/irdma/verbs.c     | 184 +++++++++++++++++++-------------
 drivers/infiniband/hw/irdma/verbs.h     |   3 +-
 include/uapi/rdma/irdma-abi.h           |   9 ++
 10 files changed, 222 insertions(+), 92 deletions(-)

-- 
1.8.3.1

