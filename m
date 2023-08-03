Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30676EAE3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjHCNoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbjHCNnZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 09:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4CF5257
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 06:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF38061DA7
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EB20C433C8;
        Thu,  3 Aug 2023 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070021;
        bh=Ag34fpOs/ZDN8OnIF2XhhMhBUdy+7vBk5TXYmXAFKUk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ab0voQdVrt9tWWx/PplP1mNbUQVh4BH54VWsLFyJpENE2P4djMIVVKA4ih3+t0Qob
         NG2IyY5suZH8gdWCQiRTmhbIFr7IlU6pWJHGUgWrp9E5ba5GcBZlbLtODGwO9VuVlp
         j/GzI2aUvYT7Dfv3YndR7h0gHv7zjRj5HvfDMaFWHDWS7K6SluVrkb7zmRKPPv9Z3u
         eXMk6YIm14uYDUCL4xhK7hDwHlATzCDMCwbf3n2zeLTXqbOJZn+Rm67UtWwuXFrW1r
         oG2ZSBhm5dOWjmmt58laaxJVDAM2dwrstGBs/asLVLq+tC+GBK6YhJLallVFKi4qBr
         SZsmFLv0FKI2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB740C41620;
        Thu,  3 Aug 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx4: Remove many unnecessary NULL values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169107002095.31149.2986339328309539867.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 13:40:20 +0000
References: <20230802040026.2588675-1-ruanjinjie@huawei.com>
In-Reply-To: <20230802040026.2588675-1-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 12:00:26 +0800 you wrote:
> The NULL initialization of the pointers assigned by kzalloc() first is
> not necessary, because if the kzalloc() failed, the pointers will be
> assigned NULL, otherwise it works as usual. so remove it.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - add the wrong removed NULL hunk code in mlx4_init_hca().
> - update the commit message.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx4: Remove many unnecessary NULL values
    https://git.kernel.org/netdev/net-next/c/3986892646de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


