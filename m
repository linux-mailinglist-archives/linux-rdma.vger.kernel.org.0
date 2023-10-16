Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1177CB645
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjJPWMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjJPWMI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 18:12:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D9B7B4;
        Mon, 16 Oct 2023 15:12:06 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id C34B420B74C0; Mon, 16 Oct 2023 15:12:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C34B420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1697494324;
        bh=aobf/RxcZbP6ByTEXUNT39lz8Bz1Q2bXgp7q74BkzHI=;
        h=From:To:Cc:Subject:Date:From;
        b=DMBVdAW16SIV0IEbvC46sDXbo1Do3OOB/QOU8izZgyjIBqgi9CVU0i1xKwW3nkttM
         D94mnsPfX7x8Oi44Ko9ghAysWB4clQJwcJR6qx7OAs7Wu12l0lm31sIpzygw9reeBH
         ESjCJ0nlsG0ZG5mpgR85ezwvcoOgiw6eP8xzepRo=
From:   sharmaajay@linuxonhyperv.com
To:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v7 0/5] RDMA/mana_ib
Date:   Mon, 16 Oct 2023 15:11:57 -0700
Message-Id: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

Change from v5:
Use xarray for qp lookup.

Ajay Sharma (5):
  RDMA/mana_ib: Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib: Register Mana IB  device with Management SW
  RDMA/mana_ib: Create adapter and Add error eq
  RDMA/mana_ib: Query adapter capabilities
  RDMA/mana_ib: Send event to qp

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  78 +++--
 drivers/infiniband/hw/mana/main.c             | 290 +++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h          | 102 +++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  86 +++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 543 insertions(+), 259 deletions(-)

-- 
2.25.1

