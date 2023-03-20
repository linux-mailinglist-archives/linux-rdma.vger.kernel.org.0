Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09C6C0C72
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCTIrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 04:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCTIrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 04:47:01 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79B11C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 01:46:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeEvyvh_1679302016;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeEvyvh_1679302016)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 16:46:56 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc 0/4] RDMA/erdma: erdma fixes 3-20-2023
Date:   Mon, 20 Mar 2023 16:46:48 +0800
Message-Id: <20230320084652.16807-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Though there is an ongoing patch waiting Jason to take a look, this
series with small changes may be accepted with less discussion. So I
submit them first.

This series has some fixes for erdma driver:
- #1 fixes some typos.
- #2 updates the default EQ depth and max_send_wr for SQ.
- #3 inlines 4 mtt entries for FRMR to achieve the HW limitation.
- #4 defers probing flow if netdevice does not exist temporarily.

Thanks,
Cheng Xu

Cheng Xu (4):
  RDMA/erdma: Fix some typos
  RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192
  RDMA/erdma: Inline mtt entries into WQE if supported
  RDMA/erdma: Defer probing if netdevice can not be found

 drivers/infiniband/hw/erdma/erdma_cq.c    | 2 +-
 drivers/infiniband/hw/erdma/erdma_hw.h    | 4 ++--
 drivers/infiniband/hw/erdma/erdma_main.c  | 2 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 4 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.h | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.31.1

