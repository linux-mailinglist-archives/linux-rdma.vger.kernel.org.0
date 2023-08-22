Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC67842DC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjHVOEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjHVOEI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580810CB;
        Tue, 22 Aug 2023 07:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F23A65782;
        Tue, 22 Aug 2023 14:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEA5C433C7;
        Tue, 22 Aug 2023 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713026;
        bh=q1ziU6ksqbqdW+Vln/eJ89jqwt4BR5N7Hb8vGAmczfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaVbmaiRy9iNjh4HF2fsg5yyZVsAIzAeHkMWJWIoMXTOtqBZHgKjipqLtlXn2XIrA
         RHTqs+cStj24daWzDIh3Yeo9V4VXfVHfILbCZA9awXlq7g/4Q/NzYir0mkX5KQ6X29
         kEX0WoecEIU6dO97ER1ZxnpZuhq5es5hKmykp2B7v0u+ejJa4HlcUjJb2WjqEkXHZB
         XN8zX693c7kfCuIWV3ngFHlJPK2lH/XsGPGLwq66aIAQYe3Gv8kudKf0hoesSZOW6W
         VPoAXnpHVXQ/PxLOqnMwkAz6kw3Q2rDfDU9atZtP4TQdX8Tp3pBLGdeq5fScy9h2KA
         Qsw78RWzs0tBg==
Date:   Tue, 22 Aug 2023 17:03:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/11] mlx4: Use 'void *' as the event param
 of mlx4_dispatch_event()
Message-ID: <20230822140342.GE6029@unreal>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
 <20230821131225.11290-4-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821131225.11290-4-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 21, 2023 at 03:12:17PM +0200, Petr Pavlu wrote:
> Function mlx4_dispatch_event() takes an 'unsigned long' as its event
> parameter. The actual value is none (MLX4_DEV_EVENT_CATASTROPHIC_ERROR),
> a pointer to mlx4_eqe (MLX4_DEV_EVENT_PORT_MGMT_CHANGE), or a 32-bit
> integer (remaining events).
> 
> In preparation to switch mlx4_en and mlx4_ib to be an auxiliary device,
> the mlx4_interface.event callback is replaced with a notifier and
> function mlx4_dispatch_event() gets updated to invoke
> atomic_notifier_call_chain(). This requires forwarding the input 'param'
> value from the former function to the latter. A problem is that the
> notifier call takes 'void *' as its 'param' value, compared to
> 'unsigned long' used by mlx4_dispatch_event(). Re-passing the value
> would need either punning it to 'void *' or passing down the address of
> the input 'param'. Both approaches create a number of unnecessary casts.
> 
> Change instead the input 'param' of mlx4_dispatch_event() from
> 'unsigned long' to 'void *'. A mlx4_eqe pointer can be passed directly,
> callers using an int value are adjusted to pass its address.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 14 ++++++++++----
>  drivers/net/ethernet/mellanox/mlx4/catas.c   |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/cmd.c     |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 17 +++++++++++++++--
>  drivers/net/ethernet/mellanox/mlx4/eq.c      | 15 ++++++++-------
>  drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +-
>  include/linux/mlx4/driver.h                  |  2 +-
>  8 files changed, 39 insertions(+), 19 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
