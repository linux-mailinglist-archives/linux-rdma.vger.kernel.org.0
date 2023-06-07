Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347FE7265C2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFGQWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFGQWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 12:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D31BE2
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 09:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B3E2636F7
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 16:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249DFC433EF;
        Wed,  7 Jun 2023 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686154931;
        bh=vNPiho7XHTYNtPtq/iit+9m1GXCFcv8ns7OTAfoEQ/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECACco6BWRAB8Du0B4Usut7osCn7uhmFZXtKmaFrK8GJGLBu3r1qdpyH4IujpQBOn
         1EG0l+EMA1u3T2N1+QJOX3YBEgbFnqv/LEsMv08Rb7nTcyHCTX3BrLXEa2fLhJj8t0
         TA5Mmq0La8fAdeaF1LSwSQ7RLTeN7aJ449xFebTq/PI6h7sbgy8B9cfxPzCwcDrZK/
         Bleu+RUo61PnLZW014SSGgb+DQDUhrZC8P/QIRt7QhoHqS6xzJHr3g1cgYRnGL8dij
         pfNyiT2Ct8HUTsKQD1V3u8W1ASmXhW2r29WVyVftmDOQX2aZfscJXdAO8+RzsV34Aa
         4E7fM9VL+mgpQ==
Date:   Wed, 7 Jun 2023 09:22:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next 13/15] net/mlx5: Skip inline mode check after
 mlx5_eswitch_enable_locked() failure
Message-ID: <20230607092210.62ace50f@kernel.org>
In-Reply-To: <ZICmQcFEJkDn71Xq@nanopsycho>
References: <20230606071219.483255-1-saeed@kernel.org>
        <20230606071219.483255-14-saeed@kernel.org>
        <20230606220117.0696be3e@kernel.org>
        <ZICmQcFEJkDn71Xq@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 7 Jun 2023 17:46:09 +0200 Jiri Pirko wrote:
> >The combination of net-next and Fixes is always odd.
> >Why? 
> >Either it's important enough to be a fix or its not important 
> >and can go to net-next...
> 
> As Jason wrote, this is a fix, but not -net worthy. I believe that
> "Fixes" tag should be there regardless of the target tree,
> it makes things easier to follow.

No it doesn't. Both as a maintainer and a person doing backports for 
a production kernel I'm telling you that it doesn't. Fishing a
gazillion patches with random Fixes tags during the merge window,
2 months after they had been merged is *not* helping anyone.
And as it usually happens fixes people consider "not important enough"
are also usually trivial so very low risk of regression.

Maybe it makes it easier for you to stack patches but that's secondary..
-- 
pw-bot: cr
