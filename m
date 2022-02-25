Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085BD4C4AD0
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 17:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiBYQdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 11:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243027AbiBYQdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 11:33:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDFDF3D
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645806784; x=1677342784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zvv8hI1QPt634uBhyJmRrQrFj148ipt4fy4vewJCOM=;
  b=VID+7Vcp9aYiCgU7TvfM3RaRD1LrlAz+4z7DaTwmH1sG713eBxCYlmZE
   f217SjddhZpP6yK4scg/m5jGKkdyN390DAh8bcam6YOrE+XLpqSzdPxAc
   9Zc2oke08Y7d3ILklik+xyNd3PV88iPLPSX8VaX6pHwKBf9Xs793eP/wY
   Kd8wvw9JhHRB/6M+BYk8WgqEiWagwNYyYnrgd+7UkBYlEhxzl0a7Hswtj
   /p0YcgNyk0N9c6oWfc8hnEyB9kuGY0wwo/h8M6sIcLOzRGGJXMLfgGdEh
   G2sOHpHJi8OBG3duoazQo7CEYLR5C5PMkJcsqxhmUS7lQZBhZHeuKwX+M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315744245"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315744245"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:01 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549321860"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.32.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:00 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc v1 0/3] irdma driver updates
Date:   Fri, 25 Feb 2022 10:32:08 -0600
Message-Id: <20220225163211.127-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains a set of irdma bug fixes for 5.17 cycle.

v0-->v1: Use rdma_vlan_dev_real_dev in Patch #1

Mustafa Ismail (3):
  RDMA/irdma: Fix netdev notifications for vlan's
  RDMA/irdma: Fix Passthrough mode in VM
  RDMA/irdma: Remove incorrect masking of PD

 drivers/infiniband/hw/irdma/hw.c       |  2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c |  1 +
 drivers/infiniband/hw/irdma/main.c     |  1 +
 drivers/infiniband/hw/irdma/main.h     |  1 +
 drivers/infiniband/hw/irdma/utils.c    | 48 +++++++++++++++++++++-------------
 drivers/infiniband/hw/irdma/verbs.c    |  4 +--
 6 files changed, 36 insertions(+), 21 deletions(-)

-- 
1.8.3.1

