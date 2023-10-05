Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E97B9944
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 02:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJEAac (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbjJEAac (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 20:30:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2098D7
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 17:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BF2C433C9;
        Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696465828;
        bh=1TriRVhzmRAnwBtw4BTSYXYMCl4ZxHt/kPTjqM0ght8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=igf4HDIUBsEa/7o+MytU4wHIbMHOuDc29n1/ioq+MrFvvVWd3YTuYMBQHrHEPA+NN
         glzjlcXFGJiVsx6JJL6SymGoN568RYWzpx+lQC2Qzrwd5MV2zkjfV/XW4oiqShWWLQ
         L1oy6lvnFWRpZKyXRhddgp/UHWv8s8WIB2Wk7E6Xk2BoKJplaE1t4b0YSqUDoJRsMw
         tVcUDA5QbhU/ZTBBF3ul0gIgj5OfPMgkThgyJ5bxLgd/p6RPXWM8utTsrTZe9M3RJ9
         qukYinl4P0yBDZhpbpCKZ1Rt+JdWITUXF6plovtg5p/NLBAmIaWoXYrgOSr32WNOa/
         jHckA2n840FHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 431F3E632D6;
        Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Fix a couple recent instances of
 -Wincompatible-function-pointer-types-strict from ->mode_get()
 implementations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169646582827.1612.12032165586969190674.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 00:30:28 +0000
References: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
In-Reply-To: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vadfed@fb.com, arkadiusz.kubalewski@intel.com,
        jiri@resnulli.us, netdev@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, richardcochran@gmail.com,
        jonathan.lemon@gmail.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Oct 2023 13:55:19 -0700 you wrote:
> Hi all,
> 
> This series fixes a couple of instances of
> -Wincompatible-function-pointer-types-strict that were introduced by a
> recent series that added a new type of ops, struct dpll_device_ops,
> along with implementations of the callback ->mode_get() that had a
> mismatched mode type.
> 
> [...]

Here is the summary with links:
  - [1/2] ptp: Fix type of mode parameter in ptp_ocp_dpll_mode_get()
    https://git.kernel.org/netdev/net-next/c/26cc115d590c
  - [2/2] mlx5: Fix type of mode parameter in mlx5_dpll_device_mode_get()
    https://git.kernel.org/netdev/net-next/c/f4ecb3d44a11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


