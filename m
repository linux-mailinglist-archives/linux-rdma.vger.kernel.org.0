Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEA710B40
	for <lists+linux-rdma@lfdr.de>; Thu, 25 May 2023 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbjEYLkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 May 2023 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjEYLkg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 May 2023 07:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EE1A7;
        Thu, 25 May 2023 04:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6635B64528;
        Thu, 25 May 2023 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8587C433EF;
        Thu, 25 May 2023 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014821;
        bh=3v/jzca5/u4ZdT2KhsBW54pILYScwd01Wld0+qVzkHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EvKRc2TurnOSl3xDZJMlDV7sHXUitzdowhhbVRLhqdcDAHqgdkslYYvt6d1EPLkei
         btiTJ0fK7dXbKtp36nyJA1jUXnuPI/UTYVkzHIKKDt5j01oKAnG2CGPPDfLpiIUrvN
         +7isdJ/17VueY7MT1WjXfadvgdYh0lnqV0xnop3bMrqr2R226SuPUMo7YdnZE2Vsem
         rXnniDHjs90eX6ngf3Hczw8mkxppBnpjxexAEb3qfuv1Dchk//C+1ka7QW1Tg8e6g5
         OCQQCGdCrms72nlupL/Cm+l5LKOrRpitPcnVNFf49QfyI0MBIdl9mzKcoJCp3AtOfO
         Qi+DL2V0GxMzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B1DFC4166F;
        Thu, 25 May 2023 11:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx4: Use bitmap_weight_and()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168501482156.11061.4458413113759538534.git-patchwork-notify@kernel.org>
Date:   Thu, 25 May 2023 11:40:21 +0000
References: <a29c2348a062408bec45cee2601b2417310e5ea7.1684865809.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a29c2348a062408bec45cee2601b2417310e5ea7.1684865809.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 May 2023 20:17:52 +0200 you wrote:
> Use bitmap_weight_and() instead of hand writing it.
> 
> This saves a few LoC and is slightly faster, should it mater.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net/mlx4: Use bitmap_weight_and()
    https://git.kernel.org/netdev/net-next/c/623a71385312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


