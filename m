Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314A7236F5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjFFFu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjFFFuS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:18 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D801BD
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkV2uOR_1686030607;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VkV2uOR_1686030607)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:50:08 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/4] RDMA/erdma: Add a new doorbell allocation mechanism
Date:   Tue,  6 Jun 2023 13:50:01 +0800
Message-Id: <20230606055005.80729-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series adds a new doorbell allocation mechanism to meet the
the isolation requirement for userspace applications. Two main change
points in this patch set: One is that we extend the bar space for doorbell
allocation, and the other one is that we associate QPs/CQs with the
allocated doorbells for authorization. We also keep the original doorbell
mechanism for compatibility, but only used under CAP_SYS_RAWIO to prevent
non-privileged access, which suggested by Jason before.

- #1 configures the current PAGE_SIZE to hardware, so that hardware can
  organize the mmio space properly.
- #2~#3 implement the new doorbell allocation mechanism.
- #4 refactors the doorbell allocation part to make code more simpler and
  cleaner.

Thanks,
Cheng Xu

Cheng Xu (4):
  RDMA/erdma: Configure PAGE_SIZE to hardware
  RDMA/erdma: Allocate doorbell resources from hardware
  RDMA/erdma: Associate QPs/CQs with doorbells for authorization
  RDMA/erdma: Refactor the original doorbell allocation mechanism

 drivers/infiniband/hw/erdma/erdma.h       |  16 +-
 drivers/infiniband/hw/erdma/erdma_hw.h    |  64 ++++++--
 drivers/infiniband/hw/erdma/erdma_main.c  |  53 +++----
 drivers/infiniband/hw/erdma/erdma_verbs.c | 178 +++++++++++++---------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  13 +-
 5 files changed, 183 insertions(+), 141 deletions(-)

-- 
2.31.1

