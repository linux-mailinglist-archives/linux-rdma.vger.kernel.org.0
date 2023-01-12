Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE966553C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAKHjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 02:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjAKHje (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 02:39:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9A10FC1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 23:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673422773; x=1704958773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SxDi1PymQh8vyDuMa0jgTE9ViFVBYK8GuuIfjRHwS2I=;
  b=M1cgJ/17jW7tsZqo1qSpngnyvVZzY6A29E8x2mwVJnOmceTHyCUVHa50
   oXEXrLb3A7MjtW+PUdbNyEecmFlTWQHro5jha3XoiSjFGB887ILSdEI/V
   qLQ2oy0stnSLbIwykuvaQpfDDdadd0NxQJ6qRHXjd8OS2x5aiZVBgjh5m
   fIlgJIZVjBgeUl9edoa3pHXc9JJaZegPip3lzdwQoS2/5SLyk+pk7BVRE
   5R7IkNSk3iuINps3gw7gY76EyiwhcFtEuTwQS99rWlRAI6KGxYWeDrPuk
   psAMa6B9oyMCBcGxWNge9N3oRg2XjWZEYAFRqG43Vr3MG/U8WjKDhyVHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303050017"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303050017"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659273362"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659273362"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 23:39:31 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv2 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr function
Date:   Wed, 11 Jan 2023 19:06:13 -0500
Message-Id: <20230112000617.1659337-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

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

 drivers/infiniband/hw/irdma/verbs.c | 264 +++++++++++++++++-----------
 1 file changed, 165 insertions(+), 99 deletions(-)

-- 
2.31.1

