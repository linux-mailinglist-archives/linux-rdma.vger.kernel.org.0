Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CC73A4A2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjFVPUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 11:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFVPUU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 11:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C5E4B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 08:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B891617E0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 15:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD00C433C8;
        Thu, 22 Jun 2023 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687447218;
        bh=XzXLfJdwDbBzqOeZFXEXwaHRm7C+W+mBk6wcYeIcqPw=;
        h=Subject:From:To:Cc:Date:From;
        b=N9wvSpBgNdTv+zOQExkY9fqe4wvMzLLUi+FCvXK5qhp9tlO/dXiUcuYkq6xLMM5SK
         CbntLX+OHA9M9D2XLCayr+VvEw15FVKDEWfOcrZJ+0lFGTBcQ20x2G0TK7sNZx3iFy
         BH7RFj1xaX8Z5rr8P2Wvnjf0hnypDGIE82Kq9Ksn/jdEV4d3fF1JzKwwtptd2OLotD
         6zhGqEG36oyDP/gmgHwwm86k5oub+3dNm0b6aHL8b0MccOq/yTq8jSmi+4g58zG+3s
         Eke0PflJOvzW1riqnCiwxZ9B43oqN+/tOVsxw7+o5M12GEPRdN5o0dVxDKccuEUVpA
         FjmTqxFba2RbA==
Subject: [PATCH v4 0/4] Handle ARPHRD_NONE devices for siw
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, Tom Talpey <tom@talpey.com>,
        Bernard Metzler <bmt@zurich.ibm.com>, tom@talpey.com,
        linux-rdma@vger.kernel.org, BMT@zurich.ibm.com,
        yanjun.zhu@linux.dev
Date:   Thu, 22 Jun 2023 11:20:17 -0400
Message-ID: <168744710872.136340.12090873711939747309.stgit@manet.1015granger.net>
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


 drivers/infiniband/core/cache.c       | 12 ++++++++++++
 drivers/infiniband/core/cma.c         | 26 +++++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  | 22 ++++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
 5 files changed, 44 insertions(+), 21 deletions(-)

--
Chuck Lever

