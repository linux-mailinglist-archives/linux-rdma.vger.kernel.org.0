Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84473010B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbjFNOAl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbjFNOAg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 10:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292591FEB
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 07:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A4E63F79
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 14:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0137C433C9;
        Wed, 14 Jun 2023 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751235;
        bh=7p02cS1LLFFF7aMk1kwT7IdV5SzXxqI7eEArpWdDdZM=;
        h=Subject:From:To:Cc:Date:From;
        b=kU1WXwxelk3bt2ALtMMT3PnHETaok8FOyBwd1MmHvN3b7v1qxWms3+FgX37/HCuCf
         3iqj/FCHc1xB87h99SEmRbC04POMMRuG7SiBr4m8jUpqDZTFqAfHVakc5ypFfyrEkQ
         e+6s8q260lJMJwsPOhdlSZI7aHOH+YS5c7oqLK2n9ScnUPisqIr34FR6V2oN7KZkRu
         QtFw4uTtgEJpOR42b/i1Bx1oz2aGWoAroRtaR6O709xomtIxfqSMOPBBbRdTHnhrr2
         V2NVZhf6LpMAeZPJY5apbCmrWCOfhW4vlo/jfUZnhfdIhlAN3XvrdoZud7N2SjcrvO
         Qc50tKPIB+jPg==
Subject: [PATCH v3 0/4] Handle ARPHRD_NONE devices for siw
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org, tom@talpey.com, BMT@zurich.ibm.com
Date:   Wed, 14 Jun 2023 10:00:33 -0400
Message-ID: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here's a series that implements support for siw on tunnel devices,
based on suggestions from Jason Gunthorpe and Tom Talpey.

This series does not address a similar issue with rxe because RoCE
GID resolution behaves differently than it does for iWARP devices.
An independent solution is likely to be required for rxe.

Changes since v2:
- Split into multiple patches
- Pre-initialize gid_attr::ndev for iWARP devices

---

Chuck Lever (4):
      RDMA/siw: Fabricate a GID on tun and loopback devices
      RDMA/core: Set gid_attr.ndev for iWARP devices
      RDMA/cma: Deduplicate error flow in cma_validate_port()
      RDMA/cma: Avoid GID lookups on iWARP devices


 drivers/infiniband/core/cache.c       | 12 ++++++++++++
 drivers/infiniband/core/cma.c         | 24 +++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  | 22 ++++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
 5 files changed, 42 insertions(+), 21 deletions(-)

--
Chuck Lever

