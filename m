Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1257B5A51
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJBSkf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjJBSke (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 14:40:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D033B0;
        Mon,  2 Oct 2023 11:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C9CC433C9;
        Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696272030;
        bh=6KsLZI9g7UhiN89nAcewKJ5x/HxWt4mFru++XEczoDg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kl1bxsepo+ybIiREqjgx6wx0ShnxoUpHhOb8jw0rJC74J5TAO1gXryRFhSr8JahB/
         /U1aL71EW62ZKhgkUaTwq9dYMPVnXluHHp8RfWlW/Fnl9xoRLQo05UmgxLgYOHDSnY
         3HaLBufuykE0Ga8nAS2DRgiVfBkDp9jrO99Of5B2PPzAw8vdWyaWr9hPGW/q2rGQbz
         2zEGRxCOI8Wa53iD7jmbL0foJ3xzr489GnEki+zvjJQnvfGcx8xlSfUq4yB20KHE6r
         jcnLoUwUjTGvxMf1j53okC4H8YotaXjn6zPVplQyypMYcNxtstzlnfG07Fx9eGxmVM
         UmYqlnBxHMSsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85DCAE632CE;
        Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169627203054.11990.6492371681347182041.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 18:40:30 +0000
References: <20230922172449.work.906-kees@kernel.org>
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kuba@kernel.org, jhs@mojatatu.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
        martin.lau@kernel.org, gustavoars@kernel.org, ast@kernel.org,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, sharmaajay@microsoft.com, elder@kernel.org,
        pshelar@ovn.org, zhangshaokun@hisilicon.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        dev@openvswitch.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Fri, 22 Sep 2023 10:28:42 -0700 you wrote:
> Hi,
> 
> This is the batch 1 of patches touching netdev for preparing for
> the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> [...]

Here is the summary with links:
  - [01/14] ipv4: Annotate struct fib_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/5b98fd5dc1e3
  - [02/14] ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
    https://git.kernel.org/netdev/net-next/c/210d4e9c732f
  - [03/14] ipv6: Annotate struct ip6_sf_socklist with __counted_by
    https://git.kernel.org/netdev/net-next/c/5d22b6528073
  - [04/14] net: hns: Annotate struct ppe_common_cb with __counted_by
    https://git.kernel.org/netdev/net-next/c/5b829c8460ae
  - [05/14] net: enetc: Annotate struct enetc_int_vector with __counted_by
    https://git.kernel.org/netdev/net-next/c/dd8e215ea9a8
  - [06/14] net: hisilicon: Annotate struct rcb_common_cb with __counted_by
    https://git.kernel.org/netdev/net-next/c/2290999d278e
  - [07/14] net: mana: Annotate struct mana_rxq with __counted_by
    https://git.kernel.org/netdev/net-next/c/a3d7a1209bbb
  - [08/14] net: ipa: Annotate struct ipa_power with __counted_by
    https://git.kernel.org/netdev/net-next/c/20551ee45d7d
  - [09/14] net: mana: Annotate struct hwc_dma_buf with __counted_by
    https://git.kernel.org/netdev/net-next/c/59656519763d
  - [10/14] net: openvswitch: Annotate struct dp_meter_instance with __counted_by
    https://git.kernel.org/netdev/net-next/c/e7b34822fa4d
  - [11/14] net: enetc: Annotate struct enetc_psfp_gate with __counted_by
    https://git.kernel.org/netdev/net-next/c/93bc6ab6b19d
  - [12/14] net: openvswitch: Annotate struct dp_meter with __counted_by
    https://git.kernel.org/netdev/net-next/c/16ae53d80c00
  - [13/14] net: tulip: Annotate struct mediatable with __counted_by
    https://git.kernel.org/netdev/net-next/c/0d01cfe5aaaf
  - [14/14] net: sched: Annotate struct tc_pedit with __counted_by
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


