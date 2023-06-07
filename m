Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62CF72532A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 07:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjFGFBg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 01:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjFGFBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 01:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651E19BB
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 22:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5199163A82
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 05:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F76C433D2;
        Wed,  7 Jun 2023 05:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686114078;
        bh=/nRpo4IO/mdSB+hXTWDtar3XcKvXlt/aPbvEsR8/1Ic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EQC2A/R+AQG6dCxOT4Bp9nAPwjnrFqlmXrrwvaIsFHolGH4lTYV16vA0wprp/J4vI
         VVd0OZI0lQNWnyLn9v16y0ZtsXTTSgfjdmJiJn1Ya5Lj7H46A2yMPfdj9ZDfPd4sZZ
         +B0p2L8fyKc7DSCqW5j2oJp+S3cdeUfm7OPVhClJnJGJDOD6EQzYF+phXO6GRvqA0a
         OVKG2kJlEilbRhd/XIViw/N7TDGduCmo91a6mPCnN9a5Rvjohr9B4A7BfWsgzK/ONH
         oVV9U4p3ZBt+Dhrwe0G4wWkkqWCfBItqgIhHutauzeUfaoxpbeNDGhMYucd4pVZXDr
         gjiTWvSnGP6gQ==
Date:   Tue, 6 Jun 2023 22:01:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next 13/15] net/mlx5: Skip inline mode check after
 mlx5_eswitch_enable_locked() failure
Message-ID: <20230606220117.0696be3e@kernel.org>
In-Reply-To: <20230606071219.483255-14-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
        <20230606071219.483255-14-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue,  6 Jun 2023 00:12:17 -0700 Saeed Mahameed wrote:
> Fixes: bffaa916588e ("net/mlx5: E-Switch, Add control for inline mode")
> Fixes: 8c98ee77d911 ("net/mlx5e: E-Switch, Add extack messages to devlink callbacks")

The combination of net-next and Fixes is always odd.
Why? 
Either it's important enough to be a fix or its not important 
and can go to net-next...
