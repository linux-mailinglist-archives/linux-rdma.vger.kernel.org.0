Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69091787860
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjHXTK7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHXTK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 15:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04191BCE
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 12:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E78B56402D
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AABFC433C7;
        Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692904226;
        bh=rwPVKvMFwPTglukeawxDljxe8sv9U6Q7h79nRwOMo1M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q/zO44aJJmsdI7Jxknl3sMa+xBwG+QF2a6diNd8mBC1gohcA4VZlb4FPwWlO+7QoL
         /elPWXPoRebKddrua8YE2wbFvG4dH6lnP2EBdLaxLkoPNUoFxQw8hlYG2kR1KTxQAC
         xaouAWJz1xv3JrwRKQpJqo+ejzg9ixFyrwo3p6+9npc6s4W9xsadIA3FP0kuqCHCsh
         uXfc9BliJhB7uVYQwhis3a23WPbldBlPhPW9KJRAkTHZ877D2MBTGcfGbE5lbRuUxH
         djR5bIx9buCkSvpnteeRPMfTzEISXUqNgf/GbdGD79KfvQ5pLv/6jkKVO9K/a8ZCh5
         MxUlx7i7miqmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 197DEC395C5;
        Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL v1] Please pull mlx5 MACsec RoCEv2 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169290422609.11645.14718872759290823619.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 19:10:26 +0000
References: <20230821073833.59042-1-leon@kernel.org>
In-Reply-To: <20230821073833.59042-1-leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        markzhang@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com,
        phaddad@nvidia.com, raeds@nvidia.com, saeedm@nvidia.com,
        horms@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 10:38:25 +0300 you wrote:
> Changelog:
> v1:
>  * Removed NULL check in first macsec patch as it is not needed.
>  * Added more information about potential merge conflict.
> v0: https://lore.kernel.org/netdev/20230813064703.574082-1-leon@kernel.org/
> ----------------------------------------------------------------
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,v1] Please pull mlx5 MACsec RoCEv2 support
    https://git.kernel.org/netdev/net-next/c/3c5066c6b0a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


