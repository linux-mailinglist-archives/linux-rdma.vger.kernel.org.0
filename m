Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC44D1AA4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbiCHOfq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiCHOfq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:35:46 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DD4B86F;
        Tue,  8 Mar 2022 06:34:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646750087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=07h5pxLtI1/yoJHBgDBSyWxgSOTaSGKINDti+18p9R4=;
        b=TAajbzMgENxIzEZryT/PgNkOdxCqCDybP/Fos4sYNa51onaMgNLeIxt046vIj4/v0NymX/
        jq7CxPVFGHc4rv/FnO24LH93rCH6UeOVL1hYveUyg5YIdKo0RB1K/1i690xOde9A7nRH/d
        9Y3I63SJAqiF8JH884xjV7XT88rRyTs=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next 0/9] RDMA: get rid of create_user_ah
Date:   Tue,  8 Mar 2022 22:34:28 +0800
Message-Id: <20220308143428.3401170-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The two members create_user_ah and create_ah in struct ib_device_ops
are very similar. we can use create_ah for all case. so get rid of
create_user_ah.

Yajun Deng (9):
  RDMA/core: get rid of create_user_ah
  RDMA/bnxt_re: get rid of create_user_ah
  RDMA/efa: get rid of create_user_ah
  RDMA/hns:  get rid of create_user_ah
  RDMA/irdma: get rid of create_user_ah
  RDMA/mlx5: get rid of create_user_ah
  RDMA/ocrdma: get rid of create_user_ah
  RDMA/rdmavt: get rid of create_user_ah
  RDMA/rxe: get rid of create_user_ah

 drivers/infiniband/core/device.c           | 1 -
 drivers/infiniband/core/uverbs_cmd.c       | 2 +-
 drivers/infiniband/core/verbs.c            | 7 ++-----
 drivers/infiniband/hw/bnxt_re/main.c       | 1 -
 drivers/infiniband/hw/efa/efa_main.c       | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c      | 5 +++++
 drivers/infiniband/hw/hns/hns_roce_main.c  | 1 -
 drivers/infiniband/hw/irdma/verbs.c        | 1 -
 drivers/infiniband/hw/mlx5/main.c          | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_main.c | 1 -
 drivers/infiniband/sw/rdmavt/vt.c          | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c      | 1 -
 include/rdma/ib_verbs.h                    | 2 --
 13 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.25.1

