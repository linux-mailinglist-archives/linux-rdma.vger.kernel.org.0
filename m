Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010F3661CA7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 04:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjAID1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 22:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjAID1N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 22:27:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F3559D
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673234833; x=1704770833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qUk+J/1s34Xjv5zUQg7Q8q/vesZqx7QMBsioiap1oBY=;
  b=iTNnTthVGXgYFrYvlj6aKnS3S4+7kwXsj0RQHoBaSpMiuatKzRAs7Z4t
   B+6ZMOIq25ULtrtud9Kh0E1i+5eRhhE5Fw3JUeSe4G72qcVkJEfJZ7Nvv
   fCBYbiBLij8q2AtDS0X6b3qMD2a5W8DgDBHDZjS7NH7nrpV7xrdmoYUoZ
   vaIQAnD55vPa6+Ve7IefWQ2jaRb2S4TF4WqIoJqoAW7f9sZ+/es8xjmcM
   S7i7VWy5qOCF4UKBrvxLWCZqhMXHk6lROXcIujHXvMkXE8plqB0YENdHy
   +AilsX3YbfIbS7wyDVysZo1cBohGFRESg/tex/V1tpX3KnufQr/PnTV5B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321487910"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321487910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 19:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649882041"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649882041"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 19:27:09 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr function
Date:   Mon,  9 Jan 2023 14:53:58 -0500
Message-Id: <20230109195402.1339737-1-yanjun.zhu@intel.com>
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

From: Zhu Yanjun <yanjun.zhu@linux.dev>

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

 drivers/infiniband/hw/irdma/verbs.c | 260 +++++++++++++++++-----------
 1 file changed, 160 insertions(+), 100 deletions(-)

-- 
2.31.1

