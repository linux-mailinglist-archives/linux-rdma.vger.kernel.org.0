Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FB621970
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiKHQcm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 11:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiKHQcj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 11:32:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D358013
        for <linux-rdma@vger.kernel.org>; Tue,  8 Nov 2022 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667925159; x=1699461159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ON/U7GK88sLR60XGTF4ZEQZXZjrtUCfJ8daLMyGnizU=;
  b=E+U6RbUzUh2ePL/PFUUqmTiuqrAZhQnGn3DYCr5CN/dOXIC/RCHsGIsp
   xIMemuRAyWROKOxaM7mtVmaq7rGVm4d+7riD2mMnpLEDPDq3yzDWMS9cx
   3kITGorbPAaSxoDcbnpw/RJDXSls+thOnMdFK5DFqnBR78IvNHTj8VQ8/
   Dz9B+YpdeCWDhSkA703uQgDJxd10h1sP1gAi6KeATp/69YMTFMwrTF8wS
   Aqg+q+cKy3ZTXS+/qhM874IMH/zXa9gS4Ds5F/SfEooNMVne408QOfH/Q
   x34WalqBOhmoHxaDp+bavidCHnSL7eb2JvBH3COvBx22KYRKBtDz/S1B6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="308362500"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="308362500"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:32:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881573182"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="881573182"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.193])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:30:51 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v1 for-next 0/3] irdma for-next updates 11-1-2022
Date:   Tue,  8 Nov 2022 10:29:55 -0600
Message-Id: <20221108162958.1227-1-shiraz.saleem@intel.com>
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

Mustafa Ismail (3):
  RDMA/irdma: Fix inline for multiple SGE's
  RDMA/irdma: Fix RQ completion opcode
  RDMA/irdma: Do not request 2-level PBLEs for CQ alloc

v0-->v1:
-Fix 0-day warnings in Patch #2
-Fix a bug to get correct op type from the CQE

Mustafa Ismail (3):
  RDMA/irdma: Fix inline for multiple SGE's
  RDMA/irdma: Fix RQ completion opcode
  RDMA/irdma: Do not request 2-level PBLEs for CQ alloc

 drivers/infiniband/hw/irdma/uk.c    | 167 ++++++++++++++++++++++--------------
 drivers/infiniband/hw/irdma/user.h  |  19 +---
 drivers/infiniband/hw/irdma/utils.c |   2 +
 drivers/infiniband/hw/irdma/verbs.c | 160 +++++++++++++++++-----------------
 4 files changed, 188 insertions(+), 160 deletions(-)

-- 
1.8.3.1

