Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94859D545
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiHWIrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348228AbiHWIqQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 04:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D76EF11
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 01:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE5861212
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 08:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2292AC433D6;
        Tue, 23 Aug 2022 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661242844;
        bh=w7PCEth/lVVNUfI7i66+NBaTPOavnAp6OXqLhjd3FrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9m3i2u0/HMQytycEJZ2aUGvvwZCUUYNIym0Tdm7YluhWJjTaumqR/1Eu/D2zD975
         YX+EuC48p4NV9/oFKaLp4ZGyFXvXe/ll5wbHJJWDonfmAab2hRmar5ZFBtP21YLph1
         iAd41sMDTj3Tbxi0MV6ZspO2smcGhYZNIS3b6/o5WyEziQBANATFmnyWEepdIbm3cE
         Bk1PgO5YNJO2u3+dmhLEPOHgkPBdj08iXM5RNBkxC8ImzbMHpQZyC70RQteIwKl99l
         5R0+Z2vkQOVgnlIgzOXbw+kV6m+TIK/ZQPoy/u3/7Af4kGA4I3MfZSFwS7x9VzbA/9
         J0jpxT3enapmA==
Date:   Tue, 23 Aug 2022 11:20:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Remove duplicate header inclusion related to ODP
Message-ID: <YwSN2Mbdx/sFk1VA@unreal>
References: <20220823025131.862811-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823025131.862811-1-matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 23, 2022 at 02:51:31AM +0000, Daisuke Matsuda wrote:
> rdma/ib_umem.h and rdma/ib_verbs.h are included by rdma/ib_umem_odp.h.
> This patch removes the redundant entries.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 2 --
>  drivers/infiniband/hw/mlx5/main.c  | 3 +--
>  drivers/infiniband/hw/mlx5/mem.c   | 1 -
>  drivers/infiniband/hw/mlx5/mr.c    | 2 --
>  drivers/infiniband/hw/mlx5/odp.c   | 1 -
>  5 files changed, 1 insertion(+), 8 deletions(-)

I have mixed feelings about this change.

Thanks, applied.
