Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C057D99B5
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjJ0N1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbjJ0N1G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:27:06 -0400
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78B18A
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:27:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698413220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vkB16tL73c1SRKEI0xNgl33zFH9DDspJK1ASa8PmyH8=;
        b=GCHHnhPlZ/IxfJ7LuArfgrNOVem0qbtjT2kqKQtZgOWOMVSlErfbwDr2UJv5puJiZf5buj
        3mggSI8mC9ftS5RK1VeLy2/Cv/MDRPXMen2Ts+JiE/mzkcKm2lx0gBHt3BnuFCRDqhqiX/
        K250FyBmfpHLplEBRudPHDPdjAP7xdA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V4 00/18] Cleanup for siw
Date:   Fri, 27 Oct 2023 21:26:26 +0800
Message-Id: <20231027132644.29347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V4 changes:
1. add Acked-by tags.
2. update patch 3 and patch 12 per Bernard's review.
3. update patch header in patch 18.

V3 changes:
1. add Acked-by tags.
2. drop 2 patches and address other comments.

Appreciate for Bernard's review!

V2 changes:
1. address W=1 warning in patch 12 and 19 per the report from lkp.
2. add one more patch (20th).

Hi,

This series aim to cleanup siw code, please review and comment!

Thanks,
Guoqing

Guoqing Jiang (18):
  RDMA/siw: Introduce siw_get_page
  RDMA/siw: Introduce siw_update_skb_rcvd
  RDMA/siw: Use iov.iov_len in kernel_sendmsg
  RDMA/siw: Remove goto lable in siw_mmap
  RDMA/siw: Remove rcu from siw_qp
  RDMA/siw: No need to check term_info.valid before call
    siw_send_terminate
  RDMA/siw: Also goto out_sem_up if pin_user_pages returns 0
  RDMA/siw: Factor out siw_rx_data helper
  RDMA/siw: Introduce SIW_STAG_MAX_INDEX
  RDMA/siw: Add one parameter to siw_destroy_cpulist
  RDMA/siw: Introduce siw_cep_set_free_and_put
  RDMA/siw: Introduce siw_free_cm_id
  RDMA/siw: Cleanup siw_accept
  RDMA/siw: Remove siw_sk_save_upcalls
  RDMA/siw: Fix typo
  RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
  RDMA/siw: Introduce siw_destroy_cep_sock
  RDMA/siw: Update comments for siw_qp_sq_process

 drivers/infiniband/sw/siw/siw.h       |   1 -
 drivers/infiniband/sw/siw/siw_cm.c    | 145 +++++++++++---------------
 drivers/infiniband/sw/siw/siw_main.c  |  30 +++---
 drivers/infiniband/sw/siw/siw_mem.c   |  14 +--
 drivers/infiniband/sw/siw/siw_qp.c    |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c |  84 ++++++---------
 drivers/infiniband/sw/siw/siw_qp_tx.c |  39 +++----
 drivers/infiniband/sw/siw/siw_verbs.c |  23 ++--
 8 files changed, 135 insertions(+), 203 deletions(-)


base-commit: 7a1c2abf9a2be7d969b25e8d65567933335ca88e
-- 
2.35.3

