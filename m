Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59405774836
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjHHT2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjHHT2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28656348A;
        Tue,  8 Aug 2023 11:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788DD61FB0;
        Tue,  8 Aug 2023 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D04C433C8;
        Tue,  8 Aug 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520930;
        bh=R5Fhz0qGwQOWhsrhVGmrP+MpvVx3YvZ5RnnE5y8itYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrPxPnSJ8FhjfTtvt4i6zc4G7BFK8yYVK78FiTtMyo+3Y8AN7n3QoscAGfH5vvq1D
         63VGMnXkZbK5ohAA/keDcPBYAZizWj3RE7966xb69rLMjtDvGYn4Sjzau5q7uEh6hh
         8KGsKS0zlgtriyi8wCxP2/ui4F40JDwUGjXH+ctVohzNR+F3wxZQ1HqfUp4gvswg89
         muZUQVwK749RzBnSI0KJQjgCHXQ/L6rlNsWKBC9aK1rulcCHWqO3aHEpoazlfcCSlq
         lIcYgTMHOqGJ1dMU1EnGGzCRr/WB1HJ4dSnm3c686oLJEVdrXEg4vlGHYvizBVOAz/
         oc5YkikwYKTjw==
Date:   Tue, 8 Aug 2023 21:55:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/10] mlx4: Get rid of the
 mlx4_interface.get_dev callback
Message-ID: <20230808185517.GG94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-2-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:18PM +0200, Petr Pavlu wrote:
> Simplify the mlx4 driver interface by removing mlx4_get_protocol_dev()
> and the associated mlx4_interface.get_dev callbacks. This is done in
> preparation to use an auxiliary bus to model the mlx4 driver structure.
> 
> The change is motivated by the following situation:
> * The mlx4_en interface is being initialized by mlx4_en_add() and
>   mlx4_en_activate().
> * The latter activate function calls mlx4_en_init_netdev() ->
>   register_netdev() to register a new net_device.
> * A netdev event NETDEV_REGISTER is raised for the device.
> * The netdev notififier mlx4_ib_netdev_event() is called and it invokes
>   mlx4_ib_scan_netdevs() -> mlx4_get_protocol_dev() ->
>   mlx4_en_get_netdev() [via mlx4_interface.get_dev].
> 
> This chain creates a problem when mlx4_en gets switched to be an
> auxiliary driver. It contains two device calls which would both need to
> take a respective device lock.
> 
> Avoid this situation by updating mlx4_ib_scan_netdevs() to no longer
> call mlx4_get_protocol_dev() but instead to utilize the information
> passed in net_device.parent and net_device.dev_port. This data is
> sufficient to determine that an updated port is one that the mlx4_ib
> driver should take care of and to keep mlx4_ib_dev.iboe.netdevs up to
> date.
> 
> Following that, update mlx4_ib_get_netdev() to also not call
> mlx4_get_protocol_dev() and instead scan all current netdevs to find
> find a matching one. Note that mlx4_ib_get_netdev() is called early from
> ib_register_device() and cannot use data tracked in
> mlx4_ib_dev.iboe.netdevs which is not at that point yet set.
> 
> Finally, remove function mlx4_get_protocol_dev() and the
> mlx4_interface.get_dev callbacks (only mlx4_en_get_netdev()) as they
> became unused.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 89 ++++++++++----------
>  drivers/net/ethernet/mellanox/mlx4/en_main.c |  8 --
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 21 -----
>  include/linux/mlx4/driver.h                  |  3 -
>  4 files changed, 43 insertions(+), 78 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
