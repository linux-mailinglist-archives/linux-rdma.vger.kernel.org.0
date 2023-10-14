Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC117C91C5
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Oct 2023 02:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjJNAa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 20:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNAa2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 20:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C78FC9;
        Fri, 13 Oct 2023 17:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11923C433C9;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=Sc9W8OXHyJj8/6hKSufokis8j739xxmwqoZ1WCdjwMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J8KXxVtrPaVulk18GB8r/MCiIiuCxJAfaHYW6cHQOBFBElp38dTD2UAx4Y+zbRY+y
         4QDfBmQHKU//BRjsrUKwnE8WlaaWnZuJUS0iN71yCZiaDRKsuJSTS5fAcs5FDVOD0a
         /3OiS1E4hJwfrCe29FFLGT2NCjf+H8yBr3o4iZ+1o3PPnTOnil99sYUy4C0NUv01mX
         M77Ev0rfyf/MWlZFf/Sg4cTVZuNYMDBT5ROJtvHUdCwhOv8kQ5XsgCQIlKEgxBccPu
         Ecrs0JgTWn7Ow/8iaectUD7ALrZJ/u9dnwt5RlkiJ7zkABYTreN7bW7j7G4HoOZSZ5
         dOWnTKZxpKvcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E337FE1F66B;
        Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342692.24435.15302817559300342474.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 21:04:37 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dst` to be NUL-terminated based on its use with format
> strings:
> |       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
> 
> [...]

Here is the summary with links:
  - net/mlx4_core: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/88fca39b660b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


