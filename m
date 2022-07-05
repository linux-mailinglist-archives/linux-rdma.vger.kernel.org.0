Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9C567A79
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiGEXCP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiGEXCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED8183A3
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E4E61BCD
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 23:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83314C341C7;
        Tue,  5 Jul 2022 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657062132;
        bh=PlhYC2lsawRbPf6UrTdJDCkDTAitBQpm/hb/SSkZuKA=;
        h=From:To:Cc:Subject:Date:From;
        b=oxoAhbxgPWCrJhosgreB20iR11CY6SupIBR3DBd+P8TB5Jq4x2I2g+5QJwi22fl5a
         b2e/6267aXxVya08hRpWkXdrcknmcqNmjv+JcCyKo7LQHqjsxvEP7YrUWF4AazI5ED
         RN4nG9ue4R9XfL+IvCDH9pDkKk1uWNpSKpiTemloe0sXAm8z7/cNW7dTvZ8jn6kzT9
         2CXpri/JjIhgb1EBNgJyXT8LYwEQwXqIgfYmeA5hgRLxsY1fKY7INfe4ZZ3ZPErD1s
         z64TjRJIoryxTyTnAFL/xnmSCXtKihdvk3kdGO5ruEYWcvYSVck6Mxjd56P/qa7vMq
         V3o9P+tarVLjQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH rdma-next 0/3] rdma: move to the new NAPI helpers
Date:   Tue,  5 Jul 2022 16:02:05 -0700
Message-Id: <20220705230208.924408-1-kuba@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm dropping the wight argument from netif_napi_add()
because most callers just want the default. This is
prep taking care of the few callers in RDMA.

Jakub Kicinski (3):
  IB/hfi1: switch to netif_napi_add_tx()
  IB/hfi1: switch to netif_napi_add_weight()
  ipoib: switch to netif_napi_add_weight()

 drivers/infiniband/hw/hfi1/ipoib_tx.c     | 4 +---
 drivers/infiniband/hw/hfi1/netdev_rx.c    | 2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 ++++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.36.1

