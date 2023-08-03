Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C676F1B3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 20:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHCSSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHCSRg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 14:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A2C26B6
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 11:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1549761E67
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 18:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1AEC433C8;
        Thu,  3 Aug 2023 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086654;
        bh=eFNBhBaVjqMLEN64GMvfHB1O2ZA4bHNQxw/O6nWVKVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWDLwqkl9cba6rL1dO1czm4V39g6/zrqxlamrZx66fiU3LtcuQEyY3mHSI+Fa9HZI
         p+cXDuhV7XFg/KOdAtKiQKBnubgXAdivLmEOi9Un8Ie0ZQDxAvzy3eCgRzOrDCW1xK
         jlowrkuSXugor8/GLskdVyTDRpTIeqT/7J/MtOTwpMx+ZqYdUXvGxbc0IqVbqM9mgm
         5hlaakfSrINoy+Nh35ewnVCMaxJz64CuhylEV2Z6RKvvusyI3NLHK+TQqxmSykGxAf
         2XWHPB81AZHabBx1JW2591ozC2/lTsfCZt/2tIw1buHZ13YlkjN7LUr3CYhMcbTYD9
         NWrYgrBTOVDzQ==
Date:   Thu, 3 Aug 2023 21:17:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     borisp@nvidia.com, saeedm@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Message-ID: <20230803181730.GG53714@unreal>
References: <20230801123854.375155-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801123854.375155-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 01, 2023 at 08:38:54PM +0800, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so

Ther -> There

> remove the NULL assignment.

assignment -> assignments.

> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
