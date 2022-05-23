Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAC5310EB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiEWMSj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiEWMSj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 08:18:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E63EF35
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 05:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689A6B8109E
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 12:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94780C385AA;
        Mon, 23 May 2022 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653308315;
        bh=WdMJzDS49GL13gJdJ9VlHOyzAHb0e/bbAm8AfZxXNK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYIJNxvf4Fy+Ior3d3G1HwjiiIkC6pyiDpN9FKUYOVb01gcAm7Y+6p/XPmgXFQerl
         l0FE6O88wcqnwd59EApjnBVw0Aqnoctr8phRT2pgN8Q3rbyKuxJ6og1kqcH5H8/BWa
         UBXtPqTcdph2aKFHrLfAy/PnXWd0wRIN8qrGhiVjxFbpQzFWj/2XJXTLMrq5h1qYBh
         BdBhV5JBlNVnxZfY5XWcfBnKbc8kXPPQJqwwUIH+Itn4nAYHf58tT/Y+yxi6L3R4vA
         KnV6p0GoLFViMjQhFo6rv5OoJZavnJfqWUsXTJ9uongiEzfkJ+5iQ4hvem6pKmlWsL
         bvnF889QGFWYg==
Date:   Mon, 23 May 2022 15:18:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     matanb@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx4_core: Support more than 64 VFs
Message-ID: <Yot7loyr9xVwMHZR@unreal>
References: <YmLMmEOcUrTRjqvh@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmLMmEOcUrTRjqvh@kili>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 22, 2022 at 06:41:12PM +0300, Dan Carpenter wrote:
> Hello Matan Barak,
> 
> The patch de966c592802: "net/mlx4_core: Support more than 64 VFs"
> from Nov 13, 2014, leads to the following Smatch static checker
> warning:
> 
> 	drivers/net/ethernet/mellanox/mlx4/main.c:3455 mlx4_load_one()
> 	warn: missing error code 'err'
> 
> drivers/net/ethernet/mellanox/mlx4/main.c
>     3438         if (mlx4_is_master(dev)) {
>     3439                 /* when we hit the goto slave_start below, dev_cap already initialized */
>     3440                 if (!dev_cap) {
>     3441                         dev_cap = kzalloc(sizeof(*dev_cap), GFP_KERNEL);
>     3442 
>     3443                         if (!dev_cap) {
>     3444                                 err = -ENOMEM;
>     3445                                 goto err_fw;
>     3446                         }
>     3447 
>     3448                         err = mlx4_QUERY_DEV_CAP(dev, dev_cap);
>     3449                         if (err) {
>     3450                                 mlx4_err(dev, "QUERY_DEV_CAP command failed, aborting.\n");
>     3451                                 goto err_fw;
>     3452                         }
>     3453 
>     3454                         if (mlx4_check_dev_cap(dev, dev_cap, nvfs))
> --> 3455                                 goto err_fw;
>                                          ^^^^^^^^^^^^
> Should this have an error code?

I don't think so. Failure here means that more than 64 VFs were
requested for unsupported device. In such case, we will perform same
flow as for failure in SR-IOV a couple of lines below - graceful exit.

It is hard to say if it is correct behaviour, but I won't change
anything for such old driver.

Thanks
