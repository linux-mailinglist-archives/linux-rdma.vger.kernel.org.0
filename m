Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7A7C61E7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 02:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbjJLAkc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 20:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJLAkb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 20:40:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FC9E;
        Wed, 11 Oct 2023 17:40:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83BDBC433CD;
        Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697071229;
        bh=wGHJyiALp3GFYTvWaoHxyso+f2Vuj4QGs+ejJHlDf/k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VE5CUTDPsvYyqkldEDqOEXMVmFtYsTPZSIVSOrPhdqUiu+qC0gTSFu6e4mo37ejhQ
         /nJHSRLR/5Uq37Vk7V8G+nOXlNvk8vH6E7h/jFJuVqHPRQONGS0TzuyWGyPhojUAH7
         Y4urAQ4NY7DQHqZIv7DL90hwQTF8/SrBLn8tcK2EKIaO4+tESHK8SoJsiMlOStfslk
         O/7RUIjozO0FXUzHR0diff2R+Z5LRSigjR9sS4lydG4rj6L1lOXawWzS/iyDrc3/8u
         ubZ2+bqVueHFdmEqJE9Vi1b+9kyKU6EIaNcULLSEz66GZICCGoNPjSU3dE+Xj/HwlZ
         8gXY0TDIzUzzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A538E21ED9;
        Thu, 12 Oct 2023 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v3 1/5] netdev: replace simple
 napi_schedule_prep/__napi_schedule to napi_schedule
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707122936.23011.6924255297609142862.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:40:29 +0000
References: <20231009133754.9834-1-ansuelsmth@gmail.com>
In-Reply-To: <20231009133754.9834-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, chris.snook@gmail.com,
        rajur@chelsio.com, jeroendb@google.com, pkaligineedi@google.com,
        shailend@google.com, dougmill@linux.ibm.com, nnac123@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        haren@linux.ibm.com, ricklind@linux.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, tariqt@nvidia.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, khalasa@piap.pl, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, gregory.greenman@intel.com,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, ruc_gongyuanjun@163.com,
        elder@linaro.org, bhupesh.sharma@linaro.org, horms@kernel.org,
        robh@kernel.org, bcf@google.com, junfeng.guo@intel.com,
        gustavoars@kernel.org, ziweixiao@google.com, rushilg@google.com,
        tglx@linutronix.de, u.kleine-koenig@pengutronix.de,
        krzysztof.kozlowski@linaro.org, YKarpov@ispras.ru, andrew@lunn.ch,
        zhengzengkai@huawei.com, set_pte_at@outlook.com,
        pagadala.yesu.anjaneyulu@intel.com, benjamin.berg@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Oct 2023 15:37:50 +0200 you wrote:
> Replace drivers that still use napi_schedule_prep/__napi_schedule
> with napi_schedule helper as it does the same exact check and call.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> Changes v3:
> - Add Reviewed-by tag
> Changes v2:
> - Add missing semicolon
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] netdev: replace simple napi_schedule_prep/__napi_schedule to napi_schedule
    https://git.kernel.org/netdev/net-next/c/ef724517b596
  - [net-next,v3,2/5] netdev: make napi_schedule return bool on NAPI successful schedule
    https://git.kernel.org/netdev/net-next/c/0a779003213b
  - [net-next,v3,3/5] netdev: replace napi_reschedule with napi_schedule
    https://git.kernel.org/netdev/net-next/c/73382e919f3d
  - [net-next,v3,4/5] net: tc35815: rework network interface interrupt logic
    https://git.kernel.org/netdev/net-next/c/be176234d0a8
  - [net-next,v3,5/5] netdev: use napi_schedule bool instead of napi_schedule_prep/__napi_schedule
    https://git.kernel.org/netdev/net-next/c/d1fea38f01ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


