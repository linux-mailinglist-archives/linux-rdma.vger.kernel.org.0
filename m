Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80D7BD435
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjJIHXf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIHXe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:23:34 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F3B9
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:23:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+lheCq8ZM2QEF1ECu825TM2cRZFC6Ta1+9zqncEZZ8E=;
        b=CNnd3THvkkoP/fRYshLGbsRYusGqgV/XUr4z92yaCRdtCpFiLJ/JtSnVKrhApxJw20kdpS
        HA4SAfdd3SHVjvqLZ23jGgaN6ehWyI8xTOjsxbk2rimU1XNHz5PgByjAp0bAYtJOOJIW5p
        kQDmPel7W41GAl85GFC296d0eGHqJS4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 00/19] Cleanup for siw
Date:   Mon,  9 Oct 2023 15:17:42 +0800
Message-Id: <20231009071801.10210-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series aim to cleanup siw code, please review and comment!

Thanks,
Guoqing

Guoqing Jiang (19):
  RDMA/siw: Introduce siw_get_page
  RDMA/siw: Introduce siw_srx_update_skb
  RDMA/siw: Use iov.iov_len in kernel_sendmsg
  RDMA/siw: Remove goto lable in siw_mmap
  RDMA/siw: Remove rcu from siw_qp
  RDMA/siw: No need to check term_info.valid before call
    siw_send_terminate
  RDMA/siw: Also goto out_sem_up if pin_user_pages returns 0
  RDMA/siw: Factor out siw_generic_rx helper
  RDMA/siw: Introduce SIW_STAG_MAX_INDEX
  RDMA/siw: Add one parameter to siw_destroy_cpulist
  RDMA/siw: Introduce siw_cep_set_free_and_put
  RDMA/siw: Introduce siw_free_cm_id
  RDMA/siw: Simplify siw_qp_id2obj
  RDMA/siw: Simplify siw_mem_id2obj
  RDMA/siw: Cleanup siw_accept
  RDMA/siw: Remove siw_sk_assign_cm_upcalls
  RDMA/siw: Fix typo
  RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
  RDMA/siw: Introduce siw_destroy_cep_sock

 drivers/infiniband/sw/siw/siw.h       |   9 +-
 drivers/infiniband/sw/siw/siw_cm.c    | 154 +++++++++++---------------
 drivers/infiniband/sw/siw/siw_main.c  |  30 +++--
 drivers/infiniband/sw/siw/siw_mem.c   |  22 ++--
 drivers/infiniband/sw/siw/siw_qp.c    |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c |  84 ++++++--------
 drivers/infiniband/sw/siw/siw_qp_tx.c |  34 +++---
 drivers/infiniband/sw/siw/siw_verbs.c |  23 +---
 8 files changed, 142 insertions(+), 216 deletions(-)

-- 
2.35.3

