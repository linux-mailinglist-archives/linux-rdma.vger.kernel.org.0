Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D87CB0D4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjJPQ76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjJPQ7k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 12:59:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4894786;
        Mon, 16 Oct 2023 09:20:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3DE6C433CA;
        Mon, 16 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697473227;
        bh=OmDX71W8pnHJvXkCucPAjaUIHG3N468/aXGQVHPVYXQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WuQYN0K2HpIwDAjzQiBVC5JrYoaVVtaLpuWb1pc+cdzeBkr+6x5S/jEu9XDMgt4rY
         oKm+/HfdeAsovwP8ukPV9BWFziId+OCUwR1IlO/AYEn1kIMRPiaxszRwMciqUDl13n
         HYdqJywsspuFeiLzrq82PQRmU/+WADdUUISr090Xg2J78wmFOGih6iA6y1ojqQmWDR
         5nDzZIdcLht1DfVBZ3Phy9MLaFfMP2DkdDGOe822bB3s0dOmy8cbHMNMWd3jcFGrPK
         OZzB8xOyIlTc9GRPcmlWBSaqtWVhQOdoBCt1HO6Xm7ll5CvrQLY7ApSFUWl0L3RTZX
         8ZUoKpv9/JvRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C14C04E32;
        Mon, 16 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2-next 0/2] rdma: Support dumping SRQ resource in
 raw format
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169747322756.5359.10248022521412902967.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 16:20:27 +0000
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
In-Reply-To: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 10 Oct 2023 15:55:24 +0800 you wrote:
> This patchset adds support to dump SRQ resource in raw format with
> rdmatool. The corresponding kernel commit is aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> v2 adds the missing change in res_srq_idx_parse_cb().
> 
> Junxian Huang (1):
>   rdma: Update uapi headers
> 
> [...]

Here is the summary with links:
  - [v2,iproute2-next,1/2] rdma: Update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cd4315de422e
  - [v2,iproute2-next,2/2] rdma: Add support to dump SRQ resource in raw format
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=07bfa4482d49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


