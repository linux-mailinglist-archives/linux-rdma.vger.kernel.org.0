Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22366B5D5
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 04:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjAPDGz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 22:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjAPDGy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 22:06:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B3C4485
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 19:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673838413; x=1705374413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxkHoonsIYy+LN/zUeF6hDoI51gsi21Swk0mDJrCPwQ=;
  b=QgDJu1TloQFjbTIAAKr0+7X7poMDBvnQtXPuauOxc+Nfbhe4xpDvO+it
   OFyX8v7gT6RUOFm0sGedehEOqdcJUFMdRJIJk9WZCOqwAbCFSTOcf6ll0
   n3QvfkA6vZF55wLXE+vEyVC0rZbOWYOx38Wjrcrgs9qiQu172um75ohEm
   IJTtPGSClo2ZtXzNEy82ctcZZJXTPSnhdRqbPiO6/luJqTnT/HVmJXHyu
   mjsqBbqqolhdEl0MvyWDEXZ98iE81ZXQkRcft9BEqkWRX1HaVhU9KD0f4
   /f04G7fdPrv3h3WG4l+D3mjUQOSjNTzDT1YNATZ+bHdC4eZ1GrFAghBOe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386720774"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="386720774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="660831290"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="660831290"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2023 19:06:50 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>
Subject: [PATCHv3 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr function
Date:   Mon, 16 Jan 2023 14:34:58 -0500
Message-Id: <20230116193502.66540-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V2->V3: 1) Use netdev reverse Christmas tree rule;
	2) Return 0 instead of err;
	3) Remove unnecessary brackets;
	4) Add an error label in error handler;
	5) Initialize the structured variables;
 
V1->V2: Thanks Saleem, Shiraz. 
        1) Remove the unnecessary variable initializations;
        2) Get iwdev by to_iwdev;
	3) Use the label free_pble to handle errors;
	4) Validate the page size before rdma_umem_for_each_dma_block

Split the shared source codes into several new functions for future use.
No bug fix and new feature in this commit series.

The new functions are as below:

irdma_reg_user_mr_type_mem
irdma_alloc_iwmr
irdma_free_iwmr
irdma_reg_user_mr_type_qp
irdma_reg_user_mr_type_cq

These functions will be used in the dmabuf feature.

Zhu Yanjun (4):
  RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
  RDMA/irdma: Split mr alloc and free into new functions
  RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
  RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq

 drivers/infiniband/hw/irdma/verbs.c | 270 +++++++++++++++++-----------
 1 file changed, 168 insertions(+), 102 deletions(-)

-- 
2.27.0

