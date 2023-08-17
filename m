Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118977F43E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbjHQKWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjHQKV6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 06:21:58 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64742D50
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 03:21:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VpzlsK6_1692267713;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VpzlsK6_1692267713)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 18:21:54 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/3] RDMA/erdma: Add hierachical MTT support
Date:   Thu, 17 Aug 2023 18:21:48 +0800
Message-Id: <20230817102151.75964-1-chengyou@linux.alibaba.com>
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

Currently, erdma only supports 0-level or 1-level MTT, which limits the
maximum length of MR. It fails to meet the requirements in some scenarios.
Therefore, we implement hierachical MTT to support 2-level and 3-level
MTT, so that users can register MRs large to 64G to erdma devices.

- #1 ~ #2 make some preparations, such as renaming certain variables and
  refactoring the storage structure of MTT.
- #3 implements the hierachical MTT.

Cheng Xu (3):
  RDMA/erdma: Renaming variable names and field names of struct
    erdma_mem
  RDMA/erdma: Refactor the storage structure of MTT entries
  RDMA/erdma: Implement hierachical MTT

 drivers/infiniband/hw/erdma/erdma_hw.h    |  18 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    |   2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 430 ++++++++++++++++------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  36 +-
 4 files changed, 357 insertions(+), 129 deletions(-)

-- 
2.31.1

