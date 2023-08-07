Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72D17726DD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjHGOBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjHGOBe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 10:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2F2D69;
        Mon,  7 Aug 2023 06:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4260761CBC;
        Mon,  7 Aug 2023 13:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EDC433CC;
        Mon,  7 Aug 2023 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691416718;
        bh=ldo/PfwX1/YEJAZBSBXdjfdco2obKz6ExqpCyGI1fKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwcjSfUcWBuI5yDy5LmbY+EIciLl56lQYS52ul5UgTv4C5Jptkmhiz9Ig2IYczl9R
         8BfGC6kitScsZ2gEfKbYTA8vruAwZFdqjbu1xwmCjXeZIulzGrwpdLDHL3blOy0N1l
         pyg2zgG0Rdoqf1QOnN0yFAa/IQHN3in4uMv+ixNxiN8D8D9MdBSbaQQt/5xL5nhCls
         S1JHGCdb8mYAjRXz2gkuwCdvyxxTF+Ke+lAvt3tL8zVxl7tk5xtsApFXOsrOtlf5dG
         kVNiZOzJ82XQ4ipLR1qAkIwhiIsmF20z+gaNK7707B/FMghpau8Os+uxeqW1bmPMjj
         2dKSRAQjVMr/A==
Date:   Mon, 7 Aug 2023 15:58:33 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Message-ID: <ZND4iQMbv5LWNaZA@vergenet.net>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-4-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-4-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:20PM +0200, Petr Pavlu wrote:

...

> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c

...

> @@ -326,6 +333,11 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
>  	mutex_init(&mdev->state_lock);
>  	mdev->device_up = true;
>  
> +	/* register mlx4 core notifier */
> +	mdev->mlx_nb.notifier_call = mlx4_en_event;
> +	err = mlx4_register_event_notifier(dev, &mdev->mlx_nb);

Hi Petr.

This fails to build because err isn't declared in this context.

> +	WARN(err, "failed to register mlx4 event notifier (%d)", err);
> +
>  	return mdev;
>  
>  err_mr:

...
