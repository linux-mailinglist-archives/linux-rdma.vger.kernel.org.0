Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549059FEB9
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiHXPr0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiHXPrA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 11:47:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B61837C
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661355916; x=1692891916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RRMrp97+0Mb+rWzQFlkX31yk5nt08k8WtdDEBJlkBG8=;
  b=Z9Vm85pa79aiVy/oCZbVnyCWJCr33kHYEjai8xueuf++sdSmaEaUSioy
   e0jQln44Gxl9MweM/3fJYoGRMl8Fttge5Rklwiam+SePQOPXufOm+BLUN
   +lsjIwfVtyvwkrJ1spzgbgxKKp+EtVjYF50msS0lxIrIeV+xYyho4ixE6
   SjAn1dE0vuiCzEEsrlWrnSBh8McDCefwi32NKYQqoGxlMR0L8SyuYyVB+
   50abogkPZ0PHX10eFrVVwwlWBx8cWwaKigoO0QKxN6BfRaXEp3YM7L75e
   GuiBacRCr1LNO8jjY5uRPm8m4CasNIGQdt0PEW/frLDK1ktaJcowi1jvp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295282465"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295282465"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 08:44:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670555875"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 08:44:27 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/irdma: Fix drain SQ hang with no completion
Date:   Wed, 24 Aug 2022 10:43:59 -0500
Message-Id: <20220824154358.117-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SW generated completions for outstanding WRs posted on SQ
after QP is in error target the wrong CQ. This causes the
ib_drain_sq to hang with no completion.

Fix this to generate completions on the right CQ.

[  863.969340] INFO: task kworker/u52:2:671 blocked for more than 122 seconds.
[  863.979224]       Not tainted 5.14.0-130.el9.x86_64 #1
[  863.986588] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  863.996997] task:kworker/u52:2   state:D stack:    0 pid:  671 ppid:     2 flags:0x00004000
[  864.007272] Workqueue: xprtiod xprt_autoclose [sunrpc]
[  864.014056] Call Trace:
[  864.017575]  __schedule+0x206/0x580
[  864.022296]  schedule+0x43/0xa0
[  864.026736]  schedule_timeout+0x115/0x150
[  864.032185]  __wait_for_common+0x93/0x1d0
[  864.037717]  ? usleep_range_state+0x90/0x90
[  864.043368]  __ib_drain_sq+0xf6/0x170 [ib_core]
[  864.049371]  ? __rdma_block_iter_next+0x80/0x80 [ib_core]
[  864.056240]  ib_drain_sq+0x66/0x70 [ib_core]
[  864.062003]  rpcrdma_xprt_disconnect+0x82/0x3b0 [rpcrdma]
[  864.069365]  ? xprt_prepare_transmit+0x5d/0xc0 [sunrpc]
[  864.076386]  xprt_rdma_close+0xe/0x30 [rpcrdma]
[  864.082593]  xprt_autoclose+0x52/0x100 [sunrpc]
[  864.088718]  process_one_work+0x1e8/0x3c0
[  864.094170]  worker_thread+0x50/0x3b0
[  864.099109]  ? rescuer_thread+0x370/0x370
[  864.104473]  kthread+0x149/0x170
[  864.109022]  ? set_kthread_struct+0x40/0x40
[  864.114713]  ret_from_fork+0x22/0x30

Fixes: 81091d7696ae ("RDMA/irdma: Add SW mechanism to generate completions on error")
Reported-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index fdf4cc8..c8b9235 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2598,7 +2598,7 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 		spin_unlock_irqrestore(&iwqp->lock, flags2);
 		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
 		if (compl_generated)
-			irdma_comp_handler(iwqp->iwrcq);
+			irdma_comp_handler(iwqp->iwscq);
 	} else {
 		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
 		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
-- 
1.8.3.1

