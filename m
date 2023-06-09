Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE982728E1A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjFICk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 22:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjFICkZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 22:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4C1702
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 19:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CAF665337
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 02:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93F86C433EF;
        Fri,  9 Jun 2023 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686278423;
        bh=TyQXd4uJbQFbQKN9+1sFODOf7JNOc9uiu0T1NDAKb4w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YqHFs28pObv74H7Cxmp+0/lhanNfOVBO2SElGyXAqqsm/W+hSFrVUmsJ5FsQ1CdcI
         tPcvVgh512NuQEW3zleVQ9yoXX+fphSY427kfXKwkr6o0dio4Oowu6cMfi2RO2NYXu
         AmeemMV68egDGbrV9Nwlpd9u0Wz5Bx4p5oZsEdQVV/UeeblHtEGZcVKiHV3jOL7k9C
         d/uIC3JaNSifepb8KXQ+UNAf0cLUC22Cf1TwFLdtJm6cMut8432ZOKhDeTx07weI+R
         x6yCNWalXrQ0tCilzpHWgr1zKlRt0RErXFHPx+D+HgY4CYZVKqcD1QNwpLvqn6ktEZ
         Q83oJBjLnU2sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 705E5E4D015;
        Fri,  9 Jun 2023 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V2 01/14] RDMA/mlx5: Free second uplink ib port
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168627842345.12774.8628736626822754496.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 02:40:23 +0000
References: <20230607210410.88209-2-saeed@kernel.org>
In-Reply-To: <20230607210410.88209-2-saeed@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
        tariqt@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
        shayd@nvidia.com, mbloch@nvidia.com
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

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed,  7 Jun 2023 14:03:57 -0700 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> The cited patch introduce ib port for the slave device uplink in
> case of multiport eswitch. However, this ib port didn't perform
> anything when unloaded.
> Unload the new ib port properly.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/14] RDMA/mlx5: Free second uplink ib port
    https://git.kernel.org/netdev/net-next/c/962825e534a9
  - [net-next,V2,02/14] {net/RDMA}/mlx5: introduce lag_for_each_peer
    https://git.kernel.org/netdev/net-next/c/222dd185833e
  - [net-next,V2,03/14] net/mlx5: LAG, check if all eswitches are paired for shared FDB
    https://git.kernel.org/netdev/net-next/c/4c103aea4bed
  - [net-next,V2,04/14] net/mlx5: LAG, generalize handling of shared FDB
    https://git.kernel.org/netdev/net-next/c/86a12124dc02
  - [net-next,V2,05/14] net/mlx5: LAG, change mlx5_shared_fdb_supported() to static
    https://git.kernel.org/netdev/net-next/c/c83e6ab96ef2
  - [net-next,V2,06/14] net/mlx5: LAG, block multipath LAG in case ldev have more than 2 ports
    https://git.kernel.org/netdev/net-next/c/d61bab396115
  - [net-next,V2,07/14] net/mlx5: LAG, block multiport eswitch LAG in case ldev have more than 2 ports
    https://git.kernel.org/netdev/net-next/c/7718c1c8ac32
  - [net-next,V2,08/14] net/mlx5: Enable 4 ports VF LAG
    https://git.kernel.org/netdev/net-next/c/6ec0b55e72a5
  - [net-next,V2,09/14] net/mlx5e: Expose catastrophic steering error counters
    https://git.kernel.org/netdev/net-next/c/a33682e4e78e
  - [net-next,V2,10/14] net/mlx5e: Remove RX page cache leftovers
    https://git.kernel.org/netdev/net-next/c/f4692ab13a1f
  - [net-next,V2,11/14] net/mlx5e: TC, refactor access to hash key
    https://git.kernel.org/netdev/net-next/c/de1f0a650824
  - [net-next,V2,12/14] net/mlx5: Skip inline mode check after mlx5_eswitch_enable_locked() failure
    https://git.kernel.org/netdev/net-next/c/97bd788efb90
  - [net-next,V2,13/14] mlx5/core: E-Switch, Allocate ECPF vport if it's an eswitch manager
    https://git.kernel.org/netdev/net-next/c/eb8e9fae0a22
  - [net-next,V2,14/14] net/mlx5e: simplify condition after napi budget handling change
    https://git.kernel.org/netdev/net-next/c/803ea346bd3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


