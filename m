Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F9A7BA47B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjJEQGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbjJEQEm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 12:04:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E65C69C;
        Thu,  5 Oct 2023 07:50:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 950B1C116D3;
        Thu,  5 Oct 2023 10:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696500025;
        bh=EEdWp/Ry3IlTSHH5W4iQK0g3V2xPwp6PsEmr0L7SbPA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wh24q8085oThfBu4okUkjzAOz2rCv38txL0DojMdjiSx3+4w9BDu3PuKT+AOVHJDR
         LPagfyMwuaX/L50KJTR5EJ5gzB/f66qPC6qUQO3DjuWgWOiJbmWPq6rjUQoI6WXW/R
         LsU85lT1mcB6H9OMj3P3oXO8LMl31elssfFP0uD6yIdlZiGvbvcXtGxkX8swnukc1v
         2EG17HvqBq/biFVKnotqLBHAJdKhVJ0aCdo4LDuMAno7nWgxRB8ol7s+j3M992rrhQ
         ncD2XclK7nSeMhSW91rIQoCEs/0RX9t+rxzE/cbFwJ28sjOC3Y8cA5cWp1l9V6ka1i
         X+1mB7AYYfHvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 778F6E632D8;
        Thu,  5 Oct 2023 10:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2, 0/3] net: mana: Fix some TX processing bugs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169650002548.27211.13692825610419255584.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 10:00:25 +0000
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Sep 2023 13:42:24 -0700 you wrote:
> Fix TX processing bugs on error handling, tso_bytes calculation,
> and sge0 size.
> 
> Haiyang Zhang (3):
>   net: mana: Fix TX CQE error handling
>   net: mana: Fix the tso_bytes calculation
>   net: mana: Fix oversized sge0 for GSO packets
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: mana: Fix TX CQE error handling
    https://git.kernel.org/netdev/net/c/b2b000069a4c
  - [net,v2,2/3] net: mana: Fix the tso_bytes calculation
    https://git.kernel.org/netdev/net/c/7a54de926574
  - [net,v2,3/3] net: mana: Fix oversized sge0 for GSO packets
    https://git.kernel.org/netdev/net/c/a43e8e9ffa0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


