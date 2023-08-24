Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9C786562
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 04:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjHXCar (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 22:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbjHXCa2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 22:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929410FA
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 19:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E42A64EAC
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08A02C433C7;
        Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692844224;
        bh=Mf+4HSNHW/8gsTF1eN2rjY4M1HRlYwTnQWlDdie2JGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V/62bohpS8lwCRaM3fFoUrGfq15QHvYc7sn0l2AYKaRub1hZ9hbOTA+TwRaG4cZ63
         JzXVFvRjObYLkDweIWe61EE2kNAKafRI1jkZ2VHH3z/QpKF6QbV6n6KTNo1ySLCCY9
         ESrDZOBgawp03E+IZwClUhlHNCljeXFeuIdOUsAbh/uYFDRY5sln6FbyDcNDBnuaTa
         e1WLyjedHeZqAIvqOP7Ah+iZF207keYQtveYogppJTSHiWmeq00TJ7C7MYAZCQ65uN
         lPPAiXSn/ittrdnNjgXpD46Ea9Ybsz9I3kpYOBanEtmi4Lp9sF5E2Y/Un9dzIjrYBn
         ezJrlcS1fpOsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1F15C395C5;
        Thu, 24 Aug 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify
 code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169284422392.2546.14098414271711051915.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 02:30:23 +0000
References: <20230822021455.205101-1-liaoyu15@huawei.com>
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        saeedm@nvidia.com, leon@kernel.org, liwei391@huawei.com,
        davem@davemloft.net, maciej.fijalkowski@intel.com,
        michal.simek@amd.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 10:14:54 +0800 you wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
    (no matching commit)
  - [net-next,2/2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
    https://git.kernel.org/netdev/net-next/c/664c84c26d7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


