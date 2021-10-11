Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DC42858A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 05:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhJKDYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 23:24:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:47094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231578AbhJKDYL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Oct 2021 23:24:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226688595"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226688595"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 20:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="479677430"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2021 20:22:09 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leonro@nvidia.com, yanjun.zhu@linux.dev
Subject: [PATCH 0/4] Do some cleanups in irdma driver
Date:   Mon, 11 Oct 2021 07:01:24 -0400
Message-Id: <20211011110128.4057-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Some functions are not used. So these functions are removed.

Zhu Yanjun (4):
  RDMA/irdma: compact the uk.c file
  RDMA/irdma: compact the ctrl.c
  RDMA/irdma: compact the utils.c file
  RDMA/irdma: compact the file uk.c

 drivers/infiniband/hw/irdma/ctrl.c   | 38 -------------------
 drivers/infiniband/hw/irdma/osdep.h  |  1 -
 drivers/infiniband/hw/irdma/protos.h |  2 -
 drivers/infiniband/hw/irdma/type.h   |  2 +-
 drivers/infiniband/hw/irdma/uk.c     | 57 ----------------------------
 drivers/infiniband/hw/irdma/user.h   |  4 +-
 drivers/infiniband/hw/irdma/utils.c  | 45 ----------------------
 7 files changed, 2 insertions(+), 147 deletions(-)

-- 
2.27.0

