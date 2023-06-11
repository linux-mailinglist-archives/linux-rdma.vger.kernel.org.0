Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5472B124
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjFKJVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjFKJVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 05:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C112717
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 02:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3535660C7B
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 09:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E793C433EF;
        Sun, 11 Jun 2023 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686475266;
        bh=HWQM6v78QvxiOtjUc81fQmyFbQzMDjzOzgzZ8K4+BIc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r8Z7eoigiCc/RQykGuTCfR6xdnsYXcHFu8LKj8AkYXt6dxW8Gcr6dUl9EzP7xtyAk
         LYEs5Wo4epFZZHFWs9iccvnZUtXGBNtf3hTH6M23vLn1TbnDKLpV3mYetQ6vPsQxw8
         Lu1XNlbGinmPwcyHnpXEgKbuKkApdaw7CPqtHZL8DttFYtOTl7/seWzqV8sfPIrcj9
         t1qKZCsrCdQ0JHUL/TZ73ziZx43LD2JqWOq2BpJdr2jPD81pnZuRi9msrylOJ32sPK
         vCyQd3hdlkGjKsqGrQ6Wv2uB0F++pfi2RxFUdF+LJ/2dApxlUypefE8Vp/u3hLaypm
         gl3a48qzPqQVw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
Subject: Re: (subset) [PATCH rdma-rc 00/10] Batch of uverbs and mlx5_ib fixes
Message-Id: <168647526239.117684.16706680400025165817.b4-ty@kernel.org>
Date:   Sun, 11 Jun 2023 12:21:02 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 05 Jun 2023 13:33:16 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is my collection of various fixes.
> 
> Thanks
> 
> [...]

Applied, thanks!

[01/10] RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions
        https://git.kernel.org/rdma/rdma/c/ee4d269eccfea6
[02/10] RDMA/mlx5: Create an indirect flow table for steering anchor
        https://git.kernel.org/rdma/rdma/c/e1f4a52ac171dd
[03/10] RDMA/mlx5: Fix Q-counters per vport allocation
        https://git.kernel.org/rdma/rdma/c/c2ea687e5e0e29
[04/10] RDMA/mlx5: Remove vport Q-counters dependency on normal Q-counters
        https://git.kernel.org/rdma/rdma/c/e80ef139488fb4
[05/10] RDMA/mlx5: Fix Q-counters query in LAG mode
        https://git.kernel.org/rdma/rdma/c/2de43f5b5137e0
[07/10] RDMA/cma: Always set static rate to 0 for RoCE
        https://git.kernel.org/rdma/rdma/c/58030c76cce473
[08/10] RDMA/uverbs: Restrict usage of privileged QKEYs
        https://git.kernel.org/rdma/rdma/c/0cadb4db79e1d9
[09/10] IB/uverbs: Fix to consider event queue closing also upon non-blocking mode
        https://git.kernel.org/rdma/rdma/c/62fab312fa1683
[10/10] RDMA/mlx5: Fix affinity assignment
        https://git.kernel.org/rdma/rdma/c/617f5db1a626f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
