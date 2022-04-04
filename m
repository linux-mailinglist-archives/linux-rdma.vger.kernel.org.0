Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC04F117E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbiDDJAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiDDJAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 05:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD83BA4D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 01:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12210B80171
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 08:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B93BC340EE;
        Mon,  4 Apr 2022 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649062690;
        bh=FgmmpQgfNIHeWT8pmFeLPHUp6kBbozdw5d6gdSg/6Ag=;
        h=From:To:Cc:Subject:Date:From;
        b=QBj9fPVYtFNwMHtV2ZIuwZcpFy6nMnmBhp8Pc4oemhZDdvkAVLZFzzq00p8/CZQch
         JlJG8ChKvShOkxzn784BDgpOkl0LGkceO0Gh5rJAVuKazfcR73I3/XBffJrf0r45Fr
         bcTs6Ia875r7bVSOsUEXeAhpohf8UeI2h/rcrixBbEi0afasZGkqElTXDl4i8pPB9n
         6mApprB45fTJEGgi1xHkH9m2dm/+0/Cbm5SabUXEIUz88j8n16YSESrS8ZJdpTHUM+
         QaVkNzhguxUcVcazug1GHboraTNe+gPR/ppd4M3LT4cAA69A+mRmuh8x1261tzMtyU
         U0BiaiuI5G1sQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v1 0/3] Fixes for v5.17
Date:   Mon,  4 Apr 2022 11:58:02 +0300
Message-Id: <cover.1649062436.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Fixed rebase error in patch #1
v0: https://lore.kernel.org/all/cover.1648366974.git.leonro@nvidia.com

Aharon Landau (2):
  RDMA/mlx5: Don't remove cache MRs when a delay is needed
  RDMA/mlx5: Add a missing update of cache->last_add

Mark Zhang (1):
  IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

 drivers/infiniband/core/cm.c    | 3 +--
 drivers/infiniband/hw/mlx5/mr.c | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.35.1

