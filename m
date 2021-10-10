Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910AE427C36
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhJIRDt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 13:03:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:65332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhJIRDt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 9 Oct 2021 13:03:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="224084132"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="224084132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 10:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="440257516"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2021 10:01:46 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH 0/4] Do some cleanups
Date:   Sat,  9 Oct 2021 20:41:06 -0400
Message-Id: <20211010004110.3842-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Some functions are not used. So these functions are removed.

Zhu Yanjun (4):
  RDMA/irdma: compat the uk.c file
  RDMA/irdma: compat the ctrl.c
  RDMA/irdma: compat the utils.c file
  RDMA/irdma: compat the file

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

