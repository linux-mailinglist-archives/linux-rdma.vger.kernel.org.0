Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E145EB3D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCSKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 14:10:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38488 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGCSKU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 14:10:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so3550303qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RVaAbHe3jIHHPXVwl0yWYqnPw6T3W9Ts0wd+fEp1YEw=;
        b=Ry0/E/PzNSOgiJppJcUHhl/TRJBs6Y78NbaggNKhJdu0WhHwnZcXYGSKQ1+Ik0lEYS
         of8dqG70fovhW6yTLC4kM9eP7s7oSOd8oKBYv/oqpfq8hR8vSmtIk4U20m+h/QFNo5Uj
         k/lOoCC4KZIw7eD6QxM6NDRFlpu3a05AjTu1xfdyGA6tNNOLa4KiWkYYNyLCX0mS77xz
         ktFmXRDHsTeWP6rhphYCOsYunjY++2xiArpJ63TfuHo7zZd76LRVHUZkEMWvhD6GYD/o
         Wz4wkcGHbiVjgAnptFsZWJ1VYa77xEuKQNzqarGsX8lmvL4+9n3sA/KRGnXy3HK7cdH1
         7GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RVaAbHe3jIHHPXVwl0yWYqnPw6T3W9Ts0wd+fEp1YEw=;
        b=afzNJTDVjVaFBevXeBfcX2n1x8b88ibHVF/ac9XYLrn1eLVE4U2QxQLcCfEliWmg3F
         eoqGSpGJz7xku7zuNN/HURcLM6xEuW1lT/XriFkxoqpEa/uv9HtkVAEQDwZIWUNGfrNo
         ZZyBzSCBaYnKBSz6Agw5RVuJaP6wF/89DGuFxxawBr12mPilOyLLOFuift8RYHtxMkz0
         uAf9nGJNl0FoRoPjDUvcwGHYaHYhmAezpuOY+dYwu+5eHoU0R64ZJzl4V05wdFoPqcN8
         yqSSkEDtRHYcq3A8hi2ETTxcGMUhj6B6rVXHE/EzxCMWLRajNvjCcoIzV1hC6iaJpBxi
         G/og==
X-Gm-Message-State: APjAAAUqGpFLdQ+MjYeHvrQt7czynqkhN4h1ueComhN4b5iXFwALy2rm
        Y8br8XpXwsLMpkkwR11AXZ3hoeJw220zMA==
X-Google-Smtp-Source: APXvYqz+yB+8LbQ8fjiXsggtURbP20MT3g3/m4rHzvlrhIF9pwaf7N3yyi6Ugv+30FPE2Qg2lauPwg==
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr30901978qke.362.1562177419737;
        Wed, 03 Jul 2019 11:10:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j66sm1309667qkf.86.2019.07.03.11.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:10:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijhy-0000Eo-U8; Wed, 03 Jul 2019 15:10:18 -0300
Date:   Wed, 3 Jul 2019 15:10:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Fixed reporting counters on 2nd port
 for Dual port RoCE
Message-ID: <20190703181018.GA890@ziepe.ca>
References: <20190630075252.9833-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630075252.9833-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 10:52:52AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Currently during dual port IB device registration in below code flow,
> 
> ib_register_device()
>   ib_device_register_sysfs()
>     ib_setup_port_attrs()
>       add_port()
>         get_counter_table()
>           get_perf_mad()
>             process_mad()
>               mlx5_ib_process_mad()
> 
> mlx5_ib_process_mad() fails on 2nd port when both the ports are not
> fully setup at the device level (because 2nd port is unaffiliated).
> 
> As a result, get_perf_mad() registers different PMA counter group for
> 1st and 2nd port, namely pma_counter_ext and pma_counter. However both
> ports have the same capability and counter offsets.
> 
> Due to this when counters are read by the user via sysfs in below code
> flow, counters are queried from wrong location from the device mainly
> from PPCNT instead of VPORT counters.
> 
> show_pma_counter()
>   get_perf_mad()
>     process_mad()
>       mlx5_ib_process_mad()
>         process_pma_cmd()
> 
> This shows all zero counters for 2nd port.
> 
> To overcome this, process_pma_cmd() is invoked, and when unaffiliated port is not
> yet setup during device registration phase, make the query on the first port.
> while at it, only process_pma_cmd() needs to work on the native port
> number and underlying mdev, so shift the get, put calls to where its needed
> inside process_pma_cmd().
> 
> Fixes: 212f2a87b74f ("IB/mlx5: Route MADs for dual port RoCE")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mad.c | 60 +++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 24 deletions(-)

Applied to for-next, thanks

Jason
