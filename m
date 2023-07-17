Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA5756739
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGQPMK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQPMJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 11:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EAE9C
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 08:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFF5610E8
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 15:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C56C433C7;
        Mon, 17 Jul 2023 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689606727;
        bh=cdfHGwqW0HN0/TUKr6gl0EZSaGcbXnMKtOgVLl1jxjI=;
        h=Subject:From:To:Cc:Date:From;
        b=sJfshzb3CglCW/Y8Uvg4u9jSCx5t8xUl5B5FW7Rl/rPSq9BsPdJqPNXhgpaFJFWaD
         9fZDTL2IOmm58gtA2XGrmSoL/Ce2V9Wr+rFNjU3SgNOBpNS/u8Znm4puFCU/6TsSoK
         D5ZObX/tUZWc3EkaPmxE3H/sEsaSuiOCBKP2GsyaxVaALpvOhO6mKC5SyEsJ6rU6fv
         PBRLbqDXKKbeT8JnmFSUDQhv8rCGUMWFwtnW3daQuvum/Deh1UDwFWe8LUbLo89coC
         +a8XPfXjpCzFZlxvIRw7sV+ZsgxWxKQp1W5shpNTpmnMFPvJpRKbzginfPfdH9LdNk
         ZPvfF1s7//lMw==
Subject: [PATCH v6 0/4] Handle ARPHRD_NONE devices for siw
From:   Chuck Lever <cel@kernel.org>
To:     leon@kernel.org, jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, Tom Talpey <tom@talpey.com>,
        Bernard Metzler <bmt@zurich.ibm.com>, BMT@zurich.ibm.com,
        tom@talpey.com, linux-rdma@vger.kernel.org
Date:   Mon, 17 Jul 2023 11:12:05 -0400
Message-ID: <168960662017.3007.17697555924773191374.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here's a series that implements support for siw on tunnel devices,
based on suggestions from Jason Gunthorpe and Tom Talpey.


Changes since v5:
- Refine comment in cma_validate_port()

Changes since v4:
- Address review comments from Tom Talpey

Changes since v3:
- Clean up RCU dereference in cma_validate_port()

Changes since v2:
- Split into multiple patches
- Pre-initialize gid_attr::ndev for iWARP devices

---

Chuck Lever (4):
      RDMA/siw: Fabricate a GID on tun and loopback devices
      RDMA/core: Set gid_attr.ndev for iWARP devices
      RDMA/cma: Deduplicate error flow in cma_validate_port()
      RDMA/cma: Avoid GID lookups on iWARP devices


 drivers/infiniband/core/cache.c       | 11 +++++++++
 drivers/infiniband/core/cma.c         | 32 ++++++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  | 22 +++++++-----------
 drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
 5 files changed, 49 insertions(+), 21 deletions(-)

--
Chuck Lever

