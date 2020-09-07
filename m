Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCE25F31F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIGGVm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgIGGVj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 02:21:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE1C061574
        for <linux-rdma@vger.kernel.org>; Sun,  6 Sep 2020 23:21:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so14450958wrx.7
        for <linux-rdma@vger.kernel.org>; Sun, 06 Sep 2020 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3oP9jMz8PxukO77MqrP3WJWqCJMX6PQBpHmKrr7RmAE=;
        b=DzschHug1O5sGkzahEgIqom0bzD4Mxup6tApjd3tZ964RDsl0cFi8V11gY5ojNWqBo
         a00/8oZgXMJ8Nl58u36Wy5d7ZnWA+LLcj4MV5ikghczrksAUsy4XvXuVQM40glqne+bu
         SKjxhNr3jsIPzzZH8S431P99a5h5U+beTMHtqBhCKaKx3t+m9BHGGeTkEza9dISyvC6H
         5y0ngzHrpVIOfptEDYdkMPwme7fLgGjOH2RtK/wkjyIrFhEi9LNOfk98QMpPtEFnNanx
         hjObx1XucUFucGd/qi5ivDt6rJ4+0fsUA3JTzTRiBDKCX8WZrXpWtG9jEbWcgylR8A0g
         d8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3oP9jMz8PxukO77MqrP3WJWqCJMX6PQBpHmKrr7RmAE=;
        b=UXn+kpiQRvklf193lIyxf+dPwn33nB/APm/7XWHe/1BXkntXqGcTAGFJfEUE/eYGol
         45OQ+HgUMw1wfrhD50JGaConrSqZQBoC2m7kximJxjPMM+xSQU4aZNFxVQFHER1oSlSC
         HvVihzVDxPZ63sjupZVpNmAyo4jl6aUPKDAwaIaIPXxBjzjaksIed45QXqPVVZ8oLRQd
         J4DlrDo14ReLp6zqAxxqzTPLfcF1JFKnnJYCIPpZqkEfJRFhLoeejHAfGjw7IUYxXpYS
         oyJ2y4w2QSvwP+rC7GXioKzmFYg8Rnb5JGPrihen60vlGFwxLWVdFeG74ubEcnQAGde/
         fj6Q==
X-Gm-Message-State: AOAM5319xNbUemCVQ8NDMbXjPZ6CUfR+QXVjeVgexZ5uxH57UHks3nAA
        zb2kqxSoYVfk38JG5Z6aiqYtpw==
X-Google-Smtp-Source: ABdhPJzZA0heTDu0QOuAMERnnKoZLQvA5RgAZExXcniJI/xYrHiRLz0NOnwTZbamWpE2x2eNZyJORg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr869570wrx.140.1599459697091;
        Sun, 06 Sep 2020 23:21:37 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y5sm15567903wmg.21.2020.09.06.23.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:21:36 -0700 (PDT)
Date:   Mon, 7 Sep 2020 08:21:35 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, kernel-team@fb.com, tariqt@mellanox.com,
        yishaih@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] mlx4: make sure to always set the port type
Message-ID: <20200907062135.GJ2997@nanopsycho.orion>
References: <20200904200621.2407839-1-kuba@kernel.org>
 <20200906072759.GC55261@unreal>
 <20200906093305.5c901cc5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906093305.5c901cc5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sun, Sep 06, 2020 at 06:33:05PM CEST, kuba@kernel.org wrote:
>On Sun, 6 Sep 2020 10:27:59 +0300 Leon Romanovsky wrote:
>> On Fri, Sep 04, 2020 at 01:06:21PM -0700, Jakub Kicinski wrote:
>> > Even tho mlx4_core registers the devlink ports, it's mlx4_en
>> > and mlx4_ib which set their type. In situations where one of
>> > the two is not built yet the machine has ports of given type
>> > we see the devlink warning from devlink_port_type_warn() trigger.
>> >
>> > Having ports of a type not supported by the kernel may seem
>> > surprising, but it does occur in practice - when the unsupported
>> > port is not plugged in to a switch anyway users are more than happy
>> > not to see it (and potentially allocate any resources to it).
>> >
>> > Set the type in mlx4_core if type-specific driver is not built.
>> >
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> > ---
>> >  drivers/net/ethernet/mellanox/mlx4/main.c | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >
>> > diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
>> > index 258c7a96f269..70cf24ba71e4 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx4/main.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
>> > @@ -3031,6 +3031,17 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
>> >  	if (err)
>> >  		return err;
>> >
>> > +	/* Ethernet and IB drivers will normally set the port type,
>> > +	 * but if they are not built set the type now to prevent
>> > +	 * devlink_port_type_warn() from firing.
>> > +	 */
>> > +	if (!IS_ENABLED(CONFIG_MLX4_EN) &&
>> > +	    dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH)
>> > +		devlink_port_type_eth_set(&info->devlink_port, NULL);  
>>                                                                ^^^^^
>> 
>> Won't it crash in devlink_port_type_eth_set()?
>> The first line there dereferences pointer.
>>   7612         const struct net_device_ops *ops = netdev->netdev_ops;
>
>Damn, good catch. It's not supposed to be required. I'll patch devlink.

When you set the port type to ethernet, you should have the net_device
instance. Why wouldn't you?


> 
>> And can we call to devlink_port_type_*_set() without IS_ENABLED() check?
>
>It'll generate two netlink notifications - not the end of the world but
>also doesn't feel super clean.
