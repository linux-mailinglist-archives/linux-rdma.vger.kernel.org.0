Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7236740EAB6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhIPTOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 15:14:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:63939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhIPTOP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 15:14:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="220757296"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="220757296"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 12:12:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545830755"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.81.178])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 12:12:35 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Shiraz <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 0/4] irdma fixes
Date:   Thu, 16 Sep 2021 14:12:18 -0500
Message-Id: <20210916191222.824-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shiraz <shiraz.saleem@intel.com>

This series contains a small set of irdma bug fixes for 5.15 cycle.

Sindhu Devale (4):
  RDMA/irdma: Skip CQP ring during a reset
  RDMA/irdma: Validate number of CQ entries on create CQ
  RDMA/irdma: Report correct WC error when transport retry counter is
    exceeded
  RDMA/irdma: Report correct WC error when there are MW bind errors

 drivers/infiniband/hw/irdma/cm.c       |  4 ++--
 drivers/infiniband/hw/irdma/hw.c       | 14 +++++++++++---
 drivers/infiniband/hw/irdma/i40iw_if.c |  2 +-
 drivers/infiniband/hw/irdma/main.h     |  1 -
 drivers/infiniband/hw/irdma/user.h     |  2 ++
 drivers/infiniband/hw/irdma/utils.c    |  2 +-
 drivers/infiniband/hw/irdma/verbs.c    |  9 ++++++---
 7 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.27.0

