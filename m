Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25323C6EE2
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhGMKvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 06:51:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:16175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMKvm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 06:51:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189823680"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="189823680"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="459532928"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2021 03:48:48 -0700
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, yanjun.zhu@intel.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 0/3] RDMA/irdma: do some cleanups 
Date:   Tue, 13 Jul 2021 23:11:27 -0400
Message-Id: <20210714031130.1511109-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Since the functions irdma_sc_repost_aeq_entries, irdma_set_hw_rsrc and
irdma_setup_virt_qp always return 0, remove the returned value check
and change the returned type to void.

Zhu Yanjun (3):
  RDMA/irdma: change the returned type of irdma_sc_repost_aeq_entries to
    void
  RDMA/irdma: change the returned type of irdma_set_hw_rsrc to void
  RDMA/irdma: change returned type of irdma_setup_virt_qp to void

 drivers/infiniband/hw/irdma/ctrl.c  |  4 +---
 drivers/infiniband/hw/irdma/hw.c    | 11 ++---------
 drivers/infiniband/hw/irdma/type.h  |  3 +--
 drivers/infiniband/hw/irdma/verbs.c |  6 ++----
 4 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.27.0

