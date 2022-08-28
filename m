Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3B5A3D00
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH1Jo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1Jo0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 05:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7224F26
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 02:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71856B80917
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 09:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2186C433D6;
        Sun, 28 Aug 2022 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661679863;
        bh=4JlMtjoa97Bc0v+Y2nDqTOutr1sO3SFkyyoAdIhWGPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIbrbuUhM3KbQYjAHM/oZViSmvoY7TECgC6kY67zHhu3SuPP6Kt8bQwUvMQ4S+MuK
         DrNmRQKjOHby3wC3yofutcjzR8Zo7Vio4OGvJ0zi57AbRpiNZrR6clBxe5zl91z48F
         NY4r8kDv8E3vZTwW8VBfaeCX74kuFHXaH84VW413GYBXpQlWo68AE5uzHELbf3lGnt
         ImILQHkxOps9us4rzYEcTeV8vqV7no9e0uyk6L0qJ7fe+ZfvheQLSE5Gjb61Xi4ItM
         d9p/+Yu5HOpx5AegAcG7CPColvvPC+P4tUpwqfMMZbNuXIpAmNevMlRRyIqutI5R8P
         fACpbfaQsBOUQ==
Date:   Sun, 28 Aug 2022 12:44:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix drain SQ hang with no completion
Message-ID: <Yws48tBf3aIv5Neo@unreal>
References: <20220824154358.117-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824154358.117-1-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 24, 2022 at 10:43:59AM -0500, Shiraz Saleem wrote:
> SW generated completions for outstanding WRs posted on SQ
> after QP is in error target the wrong CQ. This causes the
> ib_drain_sq to hang with no completion.
> 
> Fix this to generate completions on the right CQ.
> 
> [  863.969340] INFO: task kworker/u52:2:671 blocked for more than 122 seconds.
> [  863.979224]       Not tainted 5.14.0-130.el9.x86_64 #1
> [  863.986588] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  863.996997] task:kworker/u52:2   state:D stack:    0 pid:  671 ppid:     2 flags:0x00004000
> [  864.007272] Workqueue: xprtiod xprt_autoclose [sunrpc]
> [  864.014056] Call Trace:
> [  864.017575]  __schedule+0x206/0x580
> [  864.022296]  schedule+0x43/0xa0
> [  864.026736]  schedule_timeout+0x115/0x150
> [  864.032185]  __wait_for_common+0x93/0x1d0
> [  864.037717]  ? usleep_range_state+0x90/0x90
> [  864.043368]  __ib_drain_sq+0xf6/0x170 [ib_core]
> [  864.049371]  ? __rdma_block_iter_next+0x80/0x80 [ib_core]
> [  864.056240]  ib_drain_sq+0x66/0x70 [ib_core]
> [  864.062003]  rpcrdma_xprt_disconnect+0x82/0x3b0 [rpcrdma]
> [  864.069365]  ? xprt_prepare_transmit+0x5d/0xc0 [sunrpc]
> [  864.076386]  xprt_rdma_close+0xe/0x30 [rpcrdma]
> [  864.082593]  xprt_autoclose+0x52/0x100 [sunrpc]
> [  864.088718]  process_one_work+0x1e8/0x3c0
> [  864.094170]  worker_thread+0x50/0x3b0
> [  864.099109]  ? rescuer_thread+0x370/0x370
> [  864.104473]  kthread+0x149/0x170
> [  864.109022]  ? set_kthread_struct+0x40/0x40
> [  864.114713]  ret_from_fork+0x22/0x30
> 
> Fixes: 81091d7696ae ("RDMA/irdma: Add SW mechanism to generate completions on error")
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
