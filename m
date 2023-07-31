Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2176A2D4
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGaVbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGaVbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 17:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA61FDE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 14:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410A2612EE
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 21:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938CDC433C7;
        Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839022;
        bh=pQfRh1ZbEZsm3fYKoQE0zU0UksbypnaUuSQAyKqfye8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iIEPwfFNLDElfyRZotMoFkQJN6ZnIjScqDugB3a3FcrYnnHuDvPZ7rKUDq/L3ch7n
         kzY4CwUVf4r0NmoDdAKklcQbX+SVPZXTw0thj5Xkw7wKrNzONd2VQYn6P6ms9BRIF7
         QMQty0AcN7BfSwCBMms3CVShAXYFd3wKUWVNJZjtWS3V6T5fy/qjYFkaF6XXfthAKj
         b1L9z0s7Nw5I/My0SaZO0jjxdoj9ChDb6IfiZPwjokfhqQjSM92/f6p6QLzWCj5aGk
         qAMzDMXyYvVo3G99UVtE/v5DsP012IWVA5DtTa0mHQd46gqGeVw86YHyOHiMyhoB6b
         l0ZYhcsleHPAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F392C595C0;
        Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Fix RDMA VSI removal during queue rebuild
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169083902244.31832.215608833883581269.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        rafalx.rogalski@intel.com, david.m.ertman@intel.com,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com, jgg@nvidia.com,
        leonro@nvidia.com, linux-rdma@vger.kernel.org,
        mateusz.palczewski@intel.com, kamil.maziarz@intel.com,
        bharathi.sreenivas@intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 10:12:43 -0700 you wrote:
> From: Rafal Rogalski <rafalx.rogalski@intel.com>
> 
> During qdisc create/delete, it is necessary to rebuild the queue
> of VSIs. An error occurred because the VSIs created by RDMA were
> still active.
> 
> Added check if RDMA is active. If yes, it disallows qdisc changes
> and writes a message in the system logs.
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix RDMA VSI removal during queue rebuild
    https://git.kernel.org/netdev/net/c/4b31fd4d77ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


