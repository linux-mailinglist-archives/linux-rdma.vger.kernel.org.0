Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494261E88E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 03:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKGCSx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 21:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKGCSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 21:18:52 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E0BC0A
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 18:18:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VU4j49M_1667787528;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VU4j49M_1667787528)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 10:18:49 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 0/3] RDMA/erdma: Add atomic operations support
Date:   Mon,  7 Nov 2022 10:18:42 +0800
Message-Id: <20221107021845.44598-1-chengyou@linux.alibaba.com>
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

This series introcuces atomic operations support for erdma driver:
- #1 extends access rights field in FRMR and REG MR commands to support
  IB_ACCESS_REMOTE_ATOMIC.
- #2 gets atomic capacity from hardware, and reports the cap to core.
- #3 implements the IO-path of atomic WR processing.

v2:
- Fix static analyzer check errors.

Thanks,
Cheng Xu

Cheng Xu (3):
  RDMA/erdma: Extend access right field of FRMR and REG MR to support
    atomic
  RDMA/erdma: Report atomic capacity when hardware supports atomic
    feature
  RDMA/erdma: Implement atomic operations support

 drivers/infiniband/hw/erdma/erdma.h       |  1 +
 drivers/infiniband/hw/erdma/erdma_cq.c    |  2 ++
 drivers/infiniband/hw/erdma/erdma_hw.h    | 29 +++++++++++----
 drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
 drivers/infiniband/hw/erdma/erdma_qp.c    | 43 +++++++++++++++++++----
 drivers/infiniband/hw/erdma/erdma_verbs.c |  7 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++---
 7 files changed, 74 insertions(+), 21 deletions(-)

-- 
2.27.0

