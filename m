Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395B5B3422
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiIIJin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiIIJi1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:38:27 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A997EDE
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 02:38:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VP8mhPn_1662716303;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VP8mhPn_1662716303)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:38:24 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/4] RDMA/erdma: cleanups and updates 9-9-2022
Date:   Fri,  9 Sep 2022 17:38:18 +0800
Message-Id: <20220909093822.33868-1-chengyou@linux.alibaba.com>
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

This series has new updates for erdma driver:
- #1~#3 aim at making code more clean, including eliminating unnecessary
  castings, removing redundant include headers, and hiding hardware
  internal opcodes.
- #4 introcuces dynamic mtu support.

Thanks,
Cheng Xu

Cheng Xu (4):
  RDMA/erdma: Eliminate unnecessary casting for erdma_post_cmd_wait
  RDMA/erdma: Remove redundant includes
  RDMA/erdma: Make hardware internal opcodes invisible to driver
  RDMA/erdma: Support dynamic mtu

 drivers/infiniband/hw/erdma/erdma.h       |  4 ++-
 drivers/infiniband/hw/erdma/erdma_cm.c    |  8 ------
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  8 +-----
 drivers/infiniband/hw/erdma/erdma_cq.c    |  4 ---
 drivers/infiniband/hw/erdma/erdma_eq.c    | 13 ++-------
 drivers/infiniband/hw/erdma/erdma_hw.h    | 14 ++++++---
 drivers/infiniband/hw/erdma/erdma_main.c  | 17 +++++------
 drivers/infiniband/hw/erdma/erdma_qp.c    | 15 ++--------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 35 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  9 +-----
 10 files changed, 43 insertions(+), 84 deletions(-)

-- 
2.27.0

