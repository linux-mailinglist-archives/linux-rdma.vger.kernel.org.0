Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFB768FF5
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGaIVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGaIVT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 04:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC05E7A;
        Mon, 31 Jul 2023 01:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF30160F99;
        Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E9D4C433AD;
        Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690791623;
        bh=iFw1eTT0uqbhzj8JDGSr0fgbWXoLNoGg8HGa6Krj/BE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pdzuiheNxcAIUt7dl4VvftR6KVgfb4WfHYzXw7S4BW3HMeL0KMuaUJegDV4ye1i2q
         xt+IXuw4p4K/OydDVMCVezK9Voc5opQc2n1uQHW+pCcF2S8wyiKFcuPa64UxEPUtvQ
         G1Iwdhc79AaODYjflPpqOtbjQJnp2U4Fo+ECkhcQA/WYz7nibFltasYOX6TfOGyiQm
         DkftOEw0qo8qS7YQ1KRXR6FKZrHxTFzDS6vQd6ySIF1lkhclBxDg0VactJ9YcERA3Q
         lruw6F4hQjhGdeD4QZ4puijNgB6y1lT949oNG2pypUD5bnAAqPINZFgkA0SmN19lHN
         qOipMmAtNgTCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B4A1E96AC0;
        Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: flow_dissector: Use 64bits for used_keys
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169079162310.10005.11385616493848955483.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 08:20:23 +0000
References: <20230728232215.2071351-1-rkannoth@marvell.com>
In-Reply-To: <20230728232215.2071351-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
        michael.chan@broadcom.com, rajur@chelsio.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        taras.chornyi@plvision.eu, saeedm@nvidia.com, leon@kernel.org,
        idosch@nvidia.com, petrm@nvidia.com, horatiu.vultur@microchip.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, simon.horman@corigine.com,
        aelior@marvell.com, manishc@marvell.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de,
        muhammad.husaini.zulkifli@intel.com, coreteam@netfilter.org,
        ioana.ciornei@nxp.com, wojciech.drewek@intel.com,
        gerhard@engleder-embedded.com, oss-drivers@corigine.com,
        shenjian15@huawei.com, wentao.jia@corigine.com,
        linux-net-drivers@amd.com, huangguangbin2@huawei.com,
        hui.zhou@corigine.com, linux-rdma@vger.kernel.org,
        louis.peens@corigine.com, zdoychev@maxlinear.com,
        intel-wired-lan@lists.osuosl.org, wenjuan.geng@corigine.com,
        grygorii.strashko@ti.com, kurt@linutronix.de,
        UNGLinuxDriver@microchip.com, netfilter-devel@vger.kernel.org,
        lanhao@huawei.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shmulik.ladkani@gmail.com,
        d-tatianin@yandex-team.ru,
        linux-stm32@st-md-mailman.stormreply.com, jdamato@fastly.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 29 Jul 2023 04:52:15 +0530 you wrote:
> As 32bits of dissector->used_keys are exhausted,
> increase the size to 64bits.
> 
> This is base change for ESP/AH flow dissector patch.
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: flow_dissector: Use 64bits for used_keys
    https://git.kernel.org/netdev/net-next/c/2b3082c6ef3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


