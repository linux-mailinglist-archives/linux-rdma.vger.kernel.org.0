Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD93C7311CA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbjFOIKX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbjFOIKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 04:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3141A1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 01:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D134D63149
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 08:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36909C433C8;
        Thu, 15 Jun 2023 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686816620;
        bh=dxjkm3m8O2MPTIeb0JTZ6ABjDl4Re4A0C0kPAOSbxGo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TDyAuschd+98vEaQDCdAtehhRpIOdLeqvZOiyUmxEg/knjIjchCtfZ9WTwbigQwGj
         2jnU1D/OPI3FV+MHKlf/L1eJvTLHezdQQQxnBJGFTCu0VTEQsIfsXVA+EXMhb+xK1b
         ES0Ojv1Q0RqlKr9GS533PG1m3IOPyTikUbFXLi03mrpck4+PiNq45zHUCAz7SMwU+x
         4GzjqOpX13CWBhEfizQYSVmdmb7EOi2FzoDFw5OEezCISexscoZcabYVcYIOyVOo85
         fnNoSdrgkpEvPuIRDZRlkl9UsczzKsWcLdrmvMf1G1YymfuyaPrO2VQ/5nCKBNX9bq
         ReifaFZNv3ERw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1216DC395C7;
        Thu, 15 Jun 2023 08:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tls: make the offload check helper take skb not
 socket
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168681662007.2859.16638410006829594250.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 08:10:20 +0000
References: <20230613205006.1995873-1-kuba@kernel.org>
In-Reply-To: <20230613205006.1995873-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
        rajur@chelsio.com, ayush.sawal@chelsio.com, dmichail@fungible.com,
        borisp@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        simon.horman@corigine.com, john.fastabend@gmail.com,
        anirudh.venkataramanan@intel.com, maxtram95@gmail.com,
        tariqt@nvidia.com, gal@nvidia.com, raeds@nvidia.com,
        liorna@nvidia.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, na.wang@corigine.com,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Jun 2023 13:50:06 -0700 you wrote:
> All callers of tls_is_sk_tx_device_offloaded() currently do
> an equivalent of:
> 
>  if (skb->sk && tls_is_skb_tx_device_offloaded(skb->sk))
> 
> Have the helper accept skb and do the skb->sk check locally.
> Two drivers have local static inlines with similar wrappers
> already.
> 
> [...]

Here is the summary with links:
  - [net-next] net: tls: make the offload check helper take skb not socket
    https://git.kernel.org/netdev/net-next/c/ed3c9a2fcab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


