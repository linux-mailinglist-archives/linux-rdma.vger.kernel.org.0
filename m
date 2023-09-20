Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95B7A74D5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjITHug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjITHue (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 03:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596012B;
        Wed, 20 Sep 2023 00:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0697AC433C8;
        Wed, 20 Sep 2023 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695196223;
        bh=qgnXu1TyYhloTi8YxIU3S0Uj/ogkTienBEk6w7AwPsA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a469RoIF/TseFpgEKVifl0CRz3yEPY4vn2YwIGI9Tf2LwaXVNfLY95PHBZXcUuD4C
         wlRjk4Fb5SpLEAmSorm5DX8AhtGpAw+uA17JeTc8KjK2AFnsIAuf6b8j6xvSpOsHHb
         iU7oaHrT8itoWuPPw9C9qKpuZpoJyuOb0C17bkZa8haJQ/V/NyJ7Re/R9oADlPbXAR
         qU+wpEkrdOLKK2dtZU9/CM/wZ7HtzOLpfLJohSQ6rVmRBVqjdhcB/29YQnlXfHK6zq
         Dt+rQ50n9rwL2hwAU6WspRIU1LFbI7EaYOQT3O5Ieu1wnsbaD+qBMMbU8JF2Pajava
         SF4vXzzlcOfJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1DE1C41671;
        Wed, 20 Sep 2023 07:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: rds: Fix possible NULL-pointer dereference
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169519622292.27747.2696089097178293135.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 07:50:22 +0000
References: <20230918135623.630654-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20230918135623.630654-1-artem.chernyshev@red-soft.ru>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Sep 2023 16:56:23 +0300 you wrote:
> In rds_rdma_cm_event_handler_cmn() check, if conn pointer exists
> before dereferencing it as rdma_set_service_type() argument
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: fd261ce6a30e ("rds: rdma: update rdma transport for tos")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> 
> [...]

Here is the summary with links:
  - net: rds: Fix possible NULL-pointer dereference
    https://git.kernel.org/netdev/net/c/f1d95df0f310

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


