Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD962B14D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 03:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKPCbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 21:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKPCbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 21:31:12 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B829353
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 18:31:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VUvaC6P_1668565868;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VUvaC6P_1668565868)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 10:31:09 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 0/3] RDMA/erdma: Support flushing all WRs after QP state changed to ERROR
Date:   Wed, 16 Nov 2022 10:31:04 +0800
Message-Id: <20221116023107.82835-1-chengyou@linux.alibaba.com>
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

This series introduces the support of flushing all WRs posted to hardware
after QP state changed to ERROR.

Old Firmware may not flush the newly posted WRs after QP state chagned to
ERROR, because it's a little difficult for firmware to get the realtime
PI (producer index) of QPs, especially for the RQs.

Previously we want to avoid this issue by implementing custom
drain_{sq/rq} [1], but this has falw, as Tom and Jason pointed out, which
we also meet in some scenarios, for example, NoF fatal recovery.

So, we introduce a new mechanism to fix this. When registering the ibdev,
we create a workqueue for reflushing (we name it "reflush", because
hardware is already start flushing for the QPs at that time, and it's used
for hardware to flush newly posted WRs). Once QP needs to flush WRs, or
new WRs posted after flushing, we post a delay work to the workqueue or
modify the delay time if is already posted. In the work, driver notifies
the lastest PIs to firmware by CMDQ, so that firmware can flush all the
newly posted WRs. This applies to kernel QP first.

- #1 adds a workqueue for WRs reflushing.
- #2 adds a reflushing work for each QP.
- #4 notifies the lastest PIs to firmware for reflushing.

[1] https://lore.kernel.org/all/20220824094251.23190-3-chengyou@linux.alibaba.com/t/

Thanks,
Cheng Xu

Cheng Xu (3):
  RDMA/erdma: Add a workqueue for WRs reflushing
  RDMA/erdma: Implement the lifecycle of reflushing work for each QP
  RDMA/erdma: Notify the latest PI to FW for reflushing when necessary

 drivers/infiniband/hw/erdma/erdma.h       |  1 +
 drivers/infiniband/hw/erdma/erdma_hw.h    |  8 ++++++
 drivers/infiniband/hw/erdma/erdma_main.c  | 14 +++++++++--
 drivers/infiniband/hw/erdma/erdma_qp.c    | 30 ++++++++++++++++-------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 18 ++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  7 ++++++
 6 files changed, 67 insertions(+), 11 deletions(-)

-- 
2.27.0

