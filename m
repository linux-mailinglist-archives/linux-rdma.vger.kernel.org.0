Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C177A631
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHMLaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMLaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 07:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEEFE6A
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 04:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF064622F6
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50A6DC433C7;
        Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691926222;
        bh=jbdj++Mx2oPt1m78JJi5wWjRpFgvtCP2dY0aBpjBUEU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=exe2kZhToaSUSIEVsNRdSP95Q7utjmc1ty5Yg9vjZApaylAQBTeKQQraki42xL9Ag
         M7P5Ulx3WtiJEvLdH4Yfx9v2aVDxpXdYzQoiRAjNuMgK4nWxnp2ZOuqjaOARXxA4Ka
         NmFWAE94vkN5oTyCUsiqItTl3lbEMs9T+A/ELY9wtNf5vRUam1OwMELt/p8sGP5HXJ
         peVd3tENRb09hVVi7m5WqO3uQDUIlHYKM/o/6RpS9hvSULUA8uNi0wcqUXxDyS1Ltp
         K6uMyvB2BjKbD//9jdSnvbguJANAa41NfgU5enGGsEqgf/P3aLDgUy1zudF9JFJTqV
         kOUbPmiYtFzKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C75BC3274B;
        Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/rds: Remove unused function declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169192622224.28684.13322550078177356055.git-patchwork-notify@kernel.org>
Date:   Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811095010.8620-1-yuehaibing@huawei.com>
In-Reply-To: <20230811095010.8620-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:50:10 +0800 you wrote:
> Commit 39de8281791c ("RDS: Main header file") declared but never implemented
> rds_trans_init() and rds_trans_exit(), remove it.
> Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
> implementation rds_message_inc_free() but not the declaration.
> 
> Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
> rds_rdma_conn_connect() is never implemented and used.
> rds_tcp_map_seq() is never implemented and used since
> commit 70041088e3b9 ("RDS: Add TCP transport to RDS").
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net/rds: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2b8893b639e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


