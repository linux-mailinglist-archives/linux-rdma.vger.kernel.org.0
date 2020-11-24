Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C062E2C34C0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 00:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgKXXmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 18:42:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:40242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgKXXmv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 18:42:51 -0500
IronPort-SDR: 8MaTh9uaofeFsV5ePfr371CuIUpirwaSA++aULvaK3aiwUwUnqYweOHdW3is6BmlYlkqiQomKX
 9z6Q1Aomn7Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159801394"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="159801394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:42:50 -0800
IronPort-SDR: 0PIIeCjzOCWH/4S1od92JVcippr6fdkVq/tAUip30BWJC5ZJtLkjfiFUlKO4iywZdX47ZoV2su
 gnMAJCunWU8Q==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="478695668"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.134.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:42:49 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, stable@kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 0/2] Fix an mmap exploit and remove push in i40iw
Date:   Tue, 24 Nov 2020 17:42:22 -0600
Message-Id: <20201124234224.1654-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

i40iw_mmap is vulnerable to an mmap exploit due to its
manipulation on vma->vm_pgoff done for the push feature,
and its subsequent use in remap_pfn_range without validation.

Patch #1 fixes the mmap exploit in i40iw_mmap and can be backported
to stable if acceptable.

Patch #2 removes the push feature from the driver

Shiraz Saleem (2):
  RDMA/i40iw: Address an mmap handler exploit in i40iw
  RDMA/i40iw: Remove push code from i40iw

 drivers/infiniband/hw/i40iw/i40iw.h        |    1 -
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |   52 +------------
 drivers/infiniband/hw/i40iw/i40iw_d.h      |   35 +++-----
 drivers/infiniband/hw/i40iw/i40iw_main.c   |    5 -
 drivers/infiniband/hw/i40iw/i40iw_status.h |    1 -
 drivers/infiniband/hw/i40iw/i40iw_type.h   |   18 ----
 drivers/infiniband/hw/i40iw/i40iw_uk.c     |   41 +--------
 drivers/infiniband/hw/i40iw/i40iw_user.h   |    8 --
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  |  123 ++--------------------------
 9 files changed, 25 insertions(+), 259 deletions(-)

