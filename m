Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4874626D33
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiKMBIl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMBIj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:39 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742CBF10
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:38 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3CJFWjYt61jecG+fnK/iUkyykWjvWumkbqRC+UNbwlw=;
        b=qN3phKeG4Jf5RrkawGpKapDNzGvLvPzi3kParOnCl+MgIHA467L5mJzIb4AGgUqCnJ9DjU
        owj3/nFaXG2shRHRSZcSoX3YLzp4+KU2XTT8pJZ6jWZD7NPr2jYzxeRA103eFaHF2aq6bB
        YGd1CM/D/ObigS9cQBlsS7fKYaGCZiE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 00/12] Misc changes for rtrs
Date:   Sun, 13 Nov 2022 09:08:11 +0800
Message-Id: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Here are some changes for rtrs, please review them.

Thanks,
Guoqing

Guoqing Jiang (12):
  RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
  RDMA/rtrs-srv: Refactor rtrs_srv_rdma_cm_handler
  RDMA/rtrs-srv: Only close srv_path if it is just allocated
  RDMA/rtrs-srv: refactor the handling of failure case in map_cont_bufs
  RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
  RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
  RDMA/rtrs-srv: Remove outdated comments from create_con
  RDMA/rtrs: Kill recon_cnt from several structs
  RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
  RDMA/rtrs-srv: Remove paths_num
  RDMA/rtrs-srv: fix several issues in rtrs_srv_destroy_path_files
  RDMA/rtrs-srv: Remove kobject_del from
    rtrs_srv_destroy_once_sysfs_root_folders

 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   6 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  13 ++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 110 ++++++-------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   2 -
 drivers/infiniband/ulp/rtrs/rtrs.c           |  22 +---
 6 files changed, 47 insertions(+), 118 deletions(-)

-- 
2.31.1

