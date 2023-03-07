Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93146ADBEF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCGKan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 05:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCGKaT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 05:30:19 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC834DBD9
        for <linux-rdma@vger.kernel.org>; Tue,  7 Mar 2023 02:29:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VdL2Wcm_1678184966;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VdL2Wcm_1678184966)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 18:29:26 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 0/2] RDMA/erdma: Add non-4K page size support
Date:   Tue,  7 Mar 2023 18:29:22 +0800
Message-Id: <20230307102924.70577-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
treats 4K as the basic page size. Another reason is that the user
space provider always uses 4K to map the doorbell space which is not
right if page size is not 4K.

So, we fix these issues in this patchset:
- #1 fixes the issue that put wrong value in CMD to HW if PAGE_SIZE is
  not 4096.
- #2 returns the necessary information for userspace to call mmap. This
  commit requires changes in userspace provider. PR is [1].

v2 -> v1:
- Add fixes line in the first patch.
- Update commit description of the two patches.

Thanks,
Cheng Xu

[1] https://github.com/linux-rdma/rdma-core/pull/1313

Cheng Xu (2):
  RDMA/erdma: Use fixed hardware page size
  RDMA/erdma: Support non-4K page size in doorbell allocation

 drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 57 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  5 +-
 include/uapi/rdma/erdma-abi.h             |  5 +-
 4 files changed, 36 insertions(+), 35 deletions(-)

-- 
2.31.1

