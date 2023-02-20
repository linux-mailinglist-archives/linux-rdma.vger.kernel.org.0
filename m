Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9B69C874
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Feb 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBTKUY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTKUY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 05:20:24 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1C35B6
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 02:20:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vc4QBNS_1676888416;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vc4QBNS_1676888416)
          by smtp.aliyun-inc.com;
          Mon, 20 Feb 2023 18:20:17 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/2] RDMA/erdma: Add non-4K page size support
Date:   Mon, 20 Feb 2023 18:20:13 +0800
Message-Id: <20230220102015.43047-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series introduces non-4K page size support. For some aarch64
distributions, the default page size is 64K, not 4K. Current erdma can
not work correctly for these systems. There are two reasons: one is that
the kernel driver passes the kernel's page size to HW, but HW always
treats 4096 as the basic page size. The second reason is that the user
space provider uses 4096 to map the doorbell space which is right for
4096 page size only.

So, we fix these issues in this patchset:
- #1 fixes the issue that put wrong value in CMD to HW if PAGE_SIZE is
  not 4096.
- #2 returns the necessary information for userspace to call mmap. This
  commit requires changes in userspace provider. PR is [1].

Thanks,
Cheng Xu

[1] https://github.com/linux-rdma/rdma-core/pull/1313

Cheng Xu (2):
  RDMA/erdma: Use fixed hardware page size
  RDMA/erdma: Support larger page size with doorbell allocation

 drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 57 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  5 +-
 include/uapi/rdma/erdma-abi.h             |  5 +-
 4 files changed, 36 insertions(+), 35 deletions(-)

-- 
2.27.0

