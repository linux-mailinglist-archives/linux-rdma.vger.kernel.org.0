Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D14BA41D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiBQPTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQPTP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:19:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B191A3754
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645111141; x=1676647141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/MOdkbKnH79sZEEudGsnfttmz4bP+XhNDZ6Qf4KYTFM=;
  b=mFENT6u6XWhwVfPrOpKK8ug7dMpGMmvaxG7C2lQOar4lnzdPKFA4i1KY
   GvJuQqcxrYUDMB6UcK7E34zVVolM1HjKNvvsiUvHy4wDrDJsqaswccl2k
   TndZW/Wmmbq2aO90Sn/Q1d5avOHQhMbeY4m/wgGrNe8nMimqe0WRltRDG
   zJmQI8raFARqNGQYZZ9ZU/UeiurVGmiKU4UFpcegYuAwtdD8jAe+7UPyi
   q2VBjKoDmXOABrrLh6x5O25aa4M4mhGOmhJBYiAw+B2K2UWAGUQyc9yVc
   nk5QB7s6S+E9IUc+W1lNIr1IriBMU4YLb68Uzw50Nr4Hj0xiOpzXj9D8v
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238299007"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238299007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:19:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545657246"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.39.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:18:59 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/3] Remove enum irdma_status_code
Date:   Thu, 17 Feb 2022 09:18:48 -0600
Message-Id: <20220217151851.1518-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series replaces the use of custom irdma status codes with linux
error codes.

Shiraz Saleem (3):
  irdma: Remove enum irdma_status_code
  irdma: Propagate error codes
  irdma: Remove excess error variables

 drivers/infiniband/hw/irdma/cm.c       |  44 ++-
 drivers/infiniband/hw/irdma/ctrl.c     | 553 +++++++++++++++------------------
 drivers/infiniband/hw/irdma/defs.h     |   8 +-
 drivers/infiniband/hw/irdma/hmc.c      | 105 +++----
 drivers/infiniband/hw/irdma/hmc.h      |  53 ++--
 drivers/infiniband/hw/irdma/hw.c       | 190 ++++++-----
 drivers/infiniband/hw/irdma/i40iw_hw.c |   1 -
 drivers/infiniband/hw/irdma/main.c     |  16 +-
 drivers/infiniband/hw/irdma/main.h     |  42 +--
 drivers/infiniband/hw/irdma/osdep.h    |  40 ++-
 drivers/infiniband/hw/irdma/pble.c     |  77 ++---
 drivers/infiniband/hw/irdma/pble.h     |  25 +-
 drivers/infiniband/hw/irdma/protos.h   |  90 +++---
 drivers/infiniband/hw/irdma/puda.c     | 132 ++++----
 drivers/infiniband/hw/irdma/puda.h     |  43 +--
 drivers/infiniband/hw/irdma/status.h   |  71 -----
 drivers/infiniband/hw/irdma/type.h     | 109 +++----
 drivers/infiniband/hw/irdma/uda.c      |  35 +--
 drivers/infiniband/hw/irdma/uda.h      |  46 ++-
 drivers/infiniband/hw/irdma/uk.c       | 122 ++++----
 drivers/infiniband/hw/irdma/user.h     |  62 ++--
 drivers/infiniband/hw/irdma/utils.c    | 199 ++++++------
 drivers/infiniband/hw/irdma/verbs.c    | 140 +++------
 drivers/infiniband/hw/irdma/ws.c       |  19 +-
 drivers/infiniband/hw/irdma/ws.h       |   2 +-
 25 files changed, 961 insertions(+), 1263 deletions(-)
 delete mode 100644 drivers/infiniband/hw/irdma/status.h

-- 
1.8.3.1

