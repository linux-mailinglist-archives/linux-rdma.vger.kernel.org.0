Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20966BB6B7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCOO4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjCOO4F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:56:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBEB470
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892119; x=1710428119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trMO+CELAllNuQiyU2jNaYYUoY88qD5RjCEK39jqyT0=;
  b=n4HNDSyFs3JGT1kRj4FKmiozctVKEDi/JPglhdd2lfwDTiezZXJo1z6T
   Q0W6HeIqwaJLJgjlcnLugUxTxDBnptHvecJEcLgY0WtVGi2ODgpnoYvCH
   D+SHHTDTTc7VmjdOSeXkmOizFHfu9v37ODL2JpllybzkjramBxLfT3qWN
   UO1zdVHdwiUMXCkGQ2fSt76OUjS2SYteTSmrbq3hZ4FOO6zbs640KYUyh
   V+1T34+RCPBEw2yv/AcrNEJqbVwF/hlTiJneFuEkmhobapqsyDheaOIBL
   MwK3UO2UdbMvGW4IOLqdNEUhty8f8VtpP/mibw3kKgzvy8RSp5GaGtgKs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561717"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743714338"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743714338"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:29 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/4] irdma -next updates
Date:   Wed, 15 Mar 2023 09:53:01 -0500
Message-Id: <20230315145305.955-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds a refactor/improvement to the statistics
infrastructure of irdma. And minor updates to IRQ naming,
PBLE function arguments, and removes a redundant call in
irdma_modify_qp_roce.

Krzysztof Czurylo (1):
  RDMA/irdma: Refactor HW statistics

Michal Swiatkowski (1):
  RDMA/irdma: change name of interrupts

Sindhu Devale (1):
  RDMA/irdma: Refactor PBLE functions

Tatyana Nikolova (1):
  RDMA/irdma: Remove a redundant irdma_arp_table() call

 drivers/infiniband/hw/irdma/ctrl.c      | 324 +++++++++++---------------------
 drivers/infiniband/hw/irdma/defs.h      |   9 +-
 drivers/infiniband/hw/irdma/hw.c        |  13 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c  |  60 +++++-
 drivers/infiniband/hw/irdma/icrdma_hw.c |  51 +++++
 drivers/infiniband/hw/irdma/irdma.h     |   1 +
 drivers/infiniband/hw/irdma/main.h      |   3 +
 drivers/infiniband/hw/irdma/pble.c      |  16 +-
 drivers/infiniband/hw/irdma/pble.h      |   2 +-
 drivers/infiniband/hw/irdma/protos.h    |   8 +-
 drivers/infiniband/hw/irdma/type.h      | 166 ++++++----------
 drivers/infiniband/hw/irdma/utils.c     | 172 ++---------------
 drivers/infiniband/hw/irdma/verbs.c     | 200 ++++++++------------
 13 files changed, 406 insertions(+), 619 deletions(-)

-- 
1.8.3.1

