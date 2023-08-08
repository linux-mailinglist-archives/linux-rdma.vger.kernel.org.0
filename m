Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF177484E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjHHTam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjHHTaY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB76D4D2;
        Tue,  8 Aug 2023 11:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF6962A9F;
        Tue,  8 Aug 2023 18:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5060AC433C8;
        Tue,  8 Aug 2023 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521012;
        bh=PBYX39Fh8kduYlpxb9l5KBWuvLpTVHnXDflwjsgv2Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nsmvkq8XV3XKmYFkrWGH4a9Fw05B4XLDV+OC5sl7sgFnj17ii4PY/xxARuwGsAY5T
         G6ORlMw3jiM8pF9s8znkjsb7JH1Hi9xo1LEo8PGR7M0iOviGrpof2h+cz9FylvKQRF
         pmysa8t5S+SDf/1KpdOS7tvmkOpR9Sz6MAiCuLW5aFAgFyHebFKKjXxbme8Y0jfPBf
         ueWSWtdFOiSqseHbFA5es/7OzGXG7ZNMbh+yGOQmK/WkhLYP+Cyy7ZJR11bjKK4wNQ
         FG3W0qME87QR0J4R9/8YjjMfKYdj8EM9moXVAYzJPYJa9/SNsecrDYpJRIYdp0SYqN
         QwBImWMwnjh3g==
Date:   Tue, 8 Aug 2023 21:56:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/10] mlx4: Move the bond work to the core
 driver
Message-ID: <20230808185644.GJ94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-6-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-6-petr.pavlu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:22PM +0200, Petr Pavlu wrote:
> Function mlx4_en_queue_bond_work() is used in mlx4_en to start a bond
> reconfiguration. It gathers data about a new port map setting, takes
> a reference on the netdev that triggered the change and queues a work
> object on mlx4_en_priv.mdev.workqueue to perform the operation. The
> scheduled work is mlx4_en_bond_work() which calls
> mlx4_bond()/mlx4_unbond() and consequently mlx4_do_bond().
> 
> At the same time, function mlx4_change_port_types() in mlx4_core might
> be invoked to change the port type configuration. As part of its logic,
> it re-registers the whole device by calling mlx4_unregister_device(),
> followed by mlx4_register_device().
> 
> The two operations can result in concurrent access to the data about
> currently active interfaces on the device.
> 
> Functions mlx4_register_device() and mlx4_unregister_device() lock the
> intf_mutex to gain exclusive access to this data. The current
> implementation of mlx4_do_bond() doesn't do that which could result in
> an unexpected behavior. An updated version of mlx4_do_bond() for use
> with an auxiliary bus goes and locks the intf_mutex when accessing a new
> auxiliary device array.
> 
> However, doing so can then result in the following deadlock:
> * A two-port mlx4 device is configured as an Ethernet bond.
> * One of the ports is changed from eth to ib, for instance, by writing
>   into a mlx4_port<x> sysfs attribute file.
> * mlx4_change_port_types() is called to update port types. It invokes
>   mlx4_unregister_device() to unregister the device which locks the
>   intf_mutex and starts removing all associated interfaces.
> * Function mlx4_en_remove() gets invoked and starts destroying its first
>   netdev. This triggers mlx4_en_netdev_event() which recognizes that the
>   configured bond is broken. It runs mlx4_en_queue_bond_work() which
>   takes a reference on the netdev. Removing the netdev now cannot
>   proceed until the work is completed.
> * Work function mlx4_en_bond_work() gets scheduled. It calls
>   mlx4_unbond() -> mlx4_do_bond(). The latter function tries to lock the
>   intf_mutex but that is not possible because it is held already by
>   mlx4_unregister_device().
> 
> This particular case could be possibly solved by unregistering the
> mlx4_en_netdev_event() notifier in mlx4_en_remove() earlier, but it
> seems better to decouple mlx4_en more and break this reference order.
> 
> Avoid then this scenario by recognizing that the bond reconfiguration
> operates only on a mlx4_dev. The logic to queue and execute the bond
> work can be moved into the mlx4_core driver. Only a reference on the
> respective mlx4_dev object is needed to be taken during the work's
> lifetime. This removes a call from mlx4_en that can directly result in
> needing to lock the intf_mutex, it remains a privilege of the core
> driver.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  .../net/ethernet/mellanox/mlx4/en_netdev.c    | 62 +-----------------
>  drivers/net/ethernet/mellanox/mlx4/main.c     | 65 +++++++++++++++++--
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  5 ++
>  include/linux/mlx4/device.h                   | 13 ++++
>  include/linux/mlx4/driver.h                   | 19 ------
>  5 files changed, 77 insertions(+), 87 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
