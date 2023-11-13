Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F47E9B8E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKML5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjKML5i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:38 -0500
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7243ED75
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HDqZPB0eiiRmTMEY486ZpVhnofu11YZsxXLxypoPhRc=;
        b=BAv0+VX54KtLpVOA9zLM32DlC4CerSzG/eBFE9JlDIN2uCO2T42SHSviTWuDY9cy+DovkA
        jUmb4ltLQuj7bFUStJf1wy7Xu1OQs0ypWAa1bxOfLZ2ty3p2bUYfHTFlOkfEvH6qc79rhl
        qjoiutq8foxaWa38Xjx/Jfj7/8r9Ar4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 00/17] Cleanup for siw
Date:   Mon, 13 Nov 2023 19:57:09 +0800
Message-Id: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V5 changes:
1.  add Acked-by tags.
2.  rebase to latest rdma tree and remove one obsolete patch.

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

Guoqing Jiang (17):
  RDMA/siw: Introduce siw_get_page
  RDMA/siw: Introduce siw_update_skb_rcvd
  RDMA/siw: Use iov.iov_len in kernel_sendmsg
  RDMA/siw: Remove goto lable in siw_mmap
  RDMA/siw: Remove rcu from siw_qp
  RDMA/siw: No need to check term_info.valid before call
    siw_send_terminate
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
 drivers/infiniband/sw/siw/siw_mem.c   |  12 ++-
 drivers/infiniband/sw/siw/siw_qp.c    |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c |  84 ++++++---------
 drivers/infiniband/sw/siw/siw_qp_tx.c |  39 +++----
 drivers/infiniband/sw/siw/siw_verbs.c |  23 ++--
 8 files changed, 134 insertions(+), 202 deletions(-)


base-commit: 057a30168175048be9e9b30f0cafd26f5043eb07
-- 
2.35.3

