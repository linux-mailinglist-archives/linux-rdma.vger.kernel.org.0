Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A375AAC39
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiIBKTf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiIBKTc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 06:19:32 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475BBB07D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 03:19:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662113969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OkdqCQiOJ0Y0OZgStXTO3y5izYlAozN/ExBZffybCbM=;
        b=ekgmHmvcXJ+zBaSJkump0enUjwfinLUpzCSead1wTLsOGg+Vu68uYfOX+AT4CK19TNHmLu
        KhBtbvPQz9RJ5XYwjCu463P+GIJwNuJmrKV44+twdP1/diNW/89wlXBc62YvH+EKSybo1m
        MZ2DKUR4HbXqTcFJtxEIsK8I3VYh2AI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] misc changes for rtrs
Date:   Fri,  2 Sep 2022 18:19:19 +0800
Message-Id: <20220902101922.26273-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Pls review the three patches.

Thanks,
Guoqing

Guoqing Jiang (3):
  RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
  RDMA/rtrs-clt: Break the loop once one path is connected
  RDMA/rtrs-clt: Kill xchg_paths

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++-------------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
 2 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.31.1

