Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E08774E6B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 00:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHHWkY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjHHWkY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 18:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77DFE;
        Tue,  8 Aug 2023 15:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E5362DD9;
        Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47D6AC433CB;
        Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691534422;
        bh=mJG5rpnaod2qIsDUv4+1eWd5VxYuF2zZBjEDf6ZWRbw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EdOiOQeay6hxzk8+2LdvXnESSsYM3tpL224doupU/hg1gYF03WYrrBOWSt2yPf/sl
         q8UIoLMroC2aQ4uKbO3sfRd9UmiFBVvYuUQNm7fr6yll2yE0rNPO6WV0uPTIAxChby
         DjmvswUZ7IbxuRNRbPRYxA3se1gEIt/Drl6wQvTXDCvAcZdIgnbly9+EuT6ZN+UYZZ
         wlunJORpuy9/YXRbbxqzKO6hHFToh2zwYNrDPK/5tHEon8ONkOnyZkhkNiXAYkw7gT
         5Lr1K6trXmud9GjNe1ggyYUhw2QhkXSWzaYGPeCx+Ab9IAl+mvxDhxp/eb2iBgjNUU
         lsFGAIdNzR71g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C1A9E270C1;
        Tue,  8 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rtnetlink: remove redundant checks for nlattr
 IFLA_BRIDGE_MODE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153442210.29360.11186424124562731879.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 22:40:22 +0000
References: <20230807091347.3804523-1-linma@zju.edu.cn>
In-Reply-To: <20230807091347.3804523-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        simon.horman@corigine.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, huanhuan.wang@corigine.com,
        tglx@linutronix.de, na.wang@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 17:13:47 +0800 you wrote:
> The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
> which is the only caller for ndo_bridge_setlink handlers defined in
> low-level driver codes. Hence, this patch cleanups the redundant checks in
> each ndo_bridge_setlink handler function.
> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtnetlink: remove redundant checks for nlattr IFLA_BRIDGE_MODE
    https://git.kernel.org/netdev/net-next/c/f1d152eb66a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


