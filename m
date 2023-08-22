Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2767842F3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjHVOEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjHVOEm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EFC10C6;
        Tue, 22 Aug 2023 07:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A8E6572D;
        Tue, 22 Aug 2023 14:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5863CC433CB;
        Tue, 22 Aug 2023 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713046;
        bh=ZIT11GIJSJZYc0Nk4zmM2lN1LnR6J6up+poTrlxkwEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAbSmcSAtB0IL2oIl2XBLF8PyEKDDiTf0zaaA6Ga32HyeZ0w4yhSkB0CYf5znMN0I
         Xaja+9MY/z0jGyoJhVUgvmiNk59A4rq4qMPSSm0aAePihuhTprydi//vQvy1/NMZF3
         KJwmVHXpsNik1D3NHQ0ua5wFNY0LcSyDzW0nOkRtPEVzvIT6aXqAh/FxU1NHnyYUlI
         F1HLLTIXoBfJo3wUGCqTgjWhevl4sjq1kcu+N6NH4zVFlSP4dfhq1AXLjsN/EFxtEn
         vOCK21l9S20rph4xnbd2tXoJOOcOCDfjtR230CZ63Sd67lApLo7DW+Mp+j+rmdQw8+
         pb4cMcAsNYj6g==
Date:   Tue, 22 Aug 2023 17:04:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/11] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Message-ID: <20230822140403.GF6029@unreal>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
 <20230821131225.11290-5-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821131225.11290-5-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 21, 2023 at 03:12:18PM +0200, Petr Pavlu wrote:
> Use a notifier to implement mlx4_dispatch_event() in preparation to
> switch mlx4_en and mlx4_ib to be an auxiliary device.
> 
> A problem is that if the mlx4_interface.event callback was replaced with
> something as mlx4_adrv.event then the implementation of
> mlx4_dispatch_event() would need to acquire a lock on a given device
> before executing this callback. That is necessary because otherwise
> there is no guarantee that the associated driver cannot get unbound when
> the callback is running. However, taking this lock is not possible
> because mlx4_dispatch_event() can be invoked from the hardirq context.
> Using an atomic notifier allows the driver to accurately record when it
> wants to receive these events and solves this problem.
> 
> A handler registration is done by both mlx4_en and mlx4_ib at the end of
> their mlx4_interface.add callback. This matches the current situation
> when mlx4_add_device() would enable events for a given device
> immediately after this callback, by adding the device on the
> mlx4_priv.list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 40 +++++++++++++-------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h         |  2 +
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 26 +++++++++----
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 24 ++++++++----
>  drivers/net/ethernet/mellanox/mlx4/main.c    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  2 +
>  include/linux/mlx4/driver.h                  |  8 +++-
>  8 files changed, 75 insertions(+), 31 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
