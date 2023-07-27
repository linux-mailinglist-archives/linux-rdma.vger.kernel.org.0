Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AED76455E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 07:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjG0FUZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 01:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjG0FUX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 01:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6C26AE;
        Wed, 26 Jul 2023 22:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 332B561D3D;
        Thu, 27 Jul 2023 05:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DD98C43395;
        Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690435221;
        bh=dqWE7kL20TM0ajSkADbtWBdNsFCoPOpsIVvBxz80qaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZWm4nA0yKSaa/mrbdXqmvI1T+nTKrj0Tihv6EQSoAnwAX9yBjMcv8cOOyr3cqOIWW
         c+syc6ZYWYXbWw642iAhbsMBe3icrPpw6Ujr3Xlh4lKV0sZBCDGjvfUA5f2CH7hKF+
         guVK5pHfaC0Q8+n1FGnKQBvxA01oxTUg9/g0rjtIXzZdxWRFPGU2Pwz4wi9JO09Nlb
         vP0asVVwx3WPmzRtTNJzRlLmp/qu3nlztD67uKCmI2aI9HTsXhWUQ7IKGR5iut33tq
         bBcEZOXV0gd4yEMRKMp+swHfnN1iFUdLw4AIb96K0XTLNN1dHO69ty6mOCNKInv9Ym
         rlpgjhQgajzYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75951C595D0;
        Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043522147.2558.18006094227407431264.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 05:20:21 +0000
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 08:39:47 +0300 you wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Not a bug.  Targetting net-next.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx4: clean up a type issue
    https://git.kernel.org/netdev/net-next/c/bc758ade6145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


