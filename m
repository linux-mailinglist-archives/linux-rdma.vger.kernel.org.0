Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F8765598
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjG0OKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjG0OKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:10:39 -0400
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [IPv6:2001:41d0:1004:224b::65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B03430CF
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:10:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ATSXSDlBE74r32r6jUDgc2lfMNjgsjksjoju2sTEins=;
        b=T5VNyFR9d/CqeULL/YFXsc0eVK+JFADOj4uhVDTe8sNruXmLHUEJ6nml7H1CmYS4JkvPqU
        0d5+IG6hEB1XF83ezL9boqB65qSD4Y+SCu3eRmihroSOWSxV8CX0LCVuYWZPSgYjY3Jgs9
        9E9EbzoU2sK9dNbzPXwitXEpGGcUiro=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/5] Fix potential issues for siw
Date:   Thu, 27 Jul 2023 22:03:44 +0800
Message-Id: <20230727140349.25369-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Several issues appeared if we rmmod siw module after failed to insert
the module (with manual change like below).

--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -577,6 +577,7 @@ static __init int siw_init_module(void)
        if (rv)
                goto out_error;

+       goto out_error;
        rdma_link_register(&siw_link_ops);

Basically, these issues are double free, use before initalization or
null pointer dereference. For more details, pls review the individual
patch.

Thanks,
Guoqing    

Guoqing Jiang (5):
  RDMA/siw: Set siw_cm_wq to NULL after it is destroyed
  RDMA/siw: Ensure siw_destroy_cpulist can be called more than once
  RDMA/siw: Initialize siw_link_ops.list
  RDMA/siw: Set siw_crypto_shash to NULL after it is freed
  RDMA/siw: Don't call wake_up unconditionally in siw_stop_tx_thread

 drivers/infiniband/sw/siw/siw_cm.c    | 4 +++-
 drivers/infiniband/sw/siw/siw_main.c  | 7 ++++++-
 drivers/infiniband/sw/siw/siw_qp_tx.c | 7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.34.1

