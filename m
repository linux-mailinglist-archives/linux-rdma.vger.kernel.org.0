Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719C5628F0D
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 02:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiKOBRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 20:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKOBRJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 20:17:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97813EB4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475028; x=1700011028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h6Dsf3NbnnvYVrHbPKgQzVqv5SxckdbwFZcVNbDNvkA=;
  b=AdEqiPH/j9N8td+qfV19SyjHfMlQ/Yr+7e1d57DAoJLHo7nKAMNkuHHq
   IjxiXAPF/JXFfx40RL0xpZ/x16kZmHhnCWO/lS3D3XwPh6su0pjaFHp55
   yaURa3flk+Zub4PLgD7Dg3+b5Hf5AnNCXrwWrybCvJdmmWWWVU1rHOjRJ
   Qk3ceRBquWT/mPHLRFntXYPDAqHPiuQVOUh9aJP8KXb7rhvG4TI4ALoGZ
   qd+rYGsJeSeTNoF1FgqdCFcWzk6kN6B+73Mk+ls6CLC9dTZG0jKI3sz+F
   5eO+pbYKOQUuieAvEVkjHOD12qbZrgpry4gW7Y92xw1kZgRZIH1ytPfbi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309755403"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309755403"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727755011"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727755011"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:07 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 0/3] irdma for-next updates 11-1-2022
Date:   Mon, 14 Nov 2022 19:16:58 -0600
Message-Id: <20221115011701.1379-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds inline support when multiple SGE's are used
as well fixes for WC RQ completion opcodes and to not use level 2
PBLEs for virtual CQs.

v0-->v1:
-Fix 0-day warnings in Patch #2

v1->v2:
-Run the patches via clang and clear out 80 col and incorrect indentation hits
-Move static inline functions in Patch #2 to a header
-Use a local variable for the sge_list.length to avoid modifying the passed in parameter
in irdma_copy_inline_data & irdma_copy_inline_data_gen_1


Mustafa Ismail (3):
  RDMA/irdma: Fix inline for multiple SGE's
  RDMA/irdma: Fix RQ completion opcode
  RDMA/irdma: Do not request 2-level PBLEs for CQ alloc

 drivers/infiniband/hw/irdma/uk.c    | 170 +++++++++++++++++++++++-------------
 drivers/infiniband/hw/irdma/user.h  |  20 +----
 drivers/infiniband/hw/irdma/utils.c |   2 +
 drivers/infiniband/hw/irdma/verbs.c | 109 +++++++----------------
 drivers/infiniband/hw/irdma/verbs.h |  53 +++++++++++
 5 files changed, 195 insertions(+), 159 deletions(-)

-- 
1.8.3.1

