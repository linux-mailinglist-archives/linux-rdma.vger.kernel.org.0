Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0003774AD0
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 22:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjHHUgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHHUfq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 16:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DD1715;
        Tue,  8 Aug 2023 11:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA1B62A8E;
        Tue,  8 Aug 2023 18:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9C6C433C9;
        Tue,  8 Aug 2023 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520967;
        bh=X7+ZlYY0FSROiWpD/bKqog6jgK40bS0uWHHjKh6wWlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDG9QJkLhPbqqQfBzt3N7r2dsveLSfJMqJQfcq0fGicrdcP6y78WcyFNVY21Ax8h2
         xFWsWEeiADuI5XUFS3VMfpTD8uKILykVo32nUMolFaKIW2gRP1f/D/pgT4KQ3WAaq5
         f5epbNJZuODx4njaDNqmunIVfXtw+XWFGFh6yi9Aj9DA962USo9mS/DDPeUIWLIAuF
         K2B1YZwIHghG31iZS5eaGN2fifNyuh1XCAlL1DexxeTRTdM5hsw8n60uC0lrkn5QC/
         Le3r2umH3AE1Hbyct6+Oth8getUwyIa9G9uIyc8PvVPq/FN216Ju1RnHtDN5B57Ju2
         HPBmj5nge99iA==
Date:   Tue, 8 Aug 2023 21:56:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/10] mlx4: Get rid of the
 mlx4_interface.activate callback
Message-ID: <20230808185601.GI94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-5-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-5-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:21PM +0200, Petr Pavlu wrote:
> The mlx4_interface.activate callback was introduced in commit
> 79857cd31fe7 ("net/mlx4: Postpone the registration of net_device"). It
> dealt with a situation when a netdev notifier received a NETDEV_REGISTER
> event for a new net_device created by mlx4_en but the same device was
> not yet visible to mlx4_get_protocol_dev(). The callback can be removed
> now that mlx4_get_protocol_dev() is gone.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 37 +++++++++-----------
>  drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 --
>  include/linux/mlx4/driver.h                  |  1 -
>  3 files changed, 16 insertions(+), 24 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
