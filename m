Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC8061ED72
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKGIvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiKGIvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:51:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7413DC3
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:51:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5515B60F59
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF92C433D6;
        Mon,  7 Nov 2022 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811103;
        bh=NuqbUG7YIUbuVnICeTUeFbLjbylePWzusqyF/6BSHT4=;
        h=From:To:Cc:Subject:Date:From;
        b=OI0DJDPvlTEHEVlTcJl2N6LKVAMsshk6CrgPw/pVjOPhRnki9QL5HOW4INtV2mYR0
         IHifMBxhFq4QLsBiPL+ix2KGxRv2SSKFn7gkRlNhYvjYTDp5iDL6JqldTLyTAScicq
         MT3kNAbJOC0NmNu12xJQeS2prU+cHo4hwSvflKv3zQWykIFdqs9YWB5ys4cQYrih69
         3dOhGntiOK0hjWX0711QQRYEY2v7WANuYSfSZ1ivgSmvZGze8bRn2QdkNdJQ4MPNxe
         y5ryJojxW5XCMg+7cC7OMnmj7HKzpfuOizicfU2Z/1UhZ0aaXciKXB0dXSGEboHQ6b
         Cq6ENonu3x8Lg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 0/4] Various core fixes
Date:   Mon,  7 Nov 2022 10:51:32 +0200
Message-Id: <cover.1667810736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Batch unrelated fixes.

Mark Zhang (3):
  RDMA/restrack: Release MR restrack when delete
  RDMA/core: Make sure "ib_port" is valid when access sysfs node
  RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port

Or Har-Toov (1):
  RDMA/nldev: Use __nlmsg_put instead nlmsg_put

 drivers/infiniband/core/nldev.c    | 110 ++++++++++++++---------------
 drivers/infiniband/core/restrack.c |   2 -
 drivers/infiniband/core/sysfs.c    |  17 +++--
 3 files changed, 64 insertions(+), 65 deletions(-)

-- 
2.38.1

