Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC61B4D4F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDVT0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVT0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 15:26:49 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45AC03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 12:26:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q31so1516585qvf.11
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HlkJ7DCMRW5DM0Cr5A//hH5XtvheICAxstvQ6UI2sz0=;
        b=l2HAlcJqHWneHN7oLMLzLEvygAVPcJP1+sbx1OZz6tmEcynOSCDAgW4hOEb/pJ5UCj
         ut4ETMBw+lkV4oxp2L6Dyrlchz9p1dojaPhrI6oqQDu0s3Uzgp2N1CfXdig461Xc/i5H
         gBU9xWKHKtk0KtrshHfFh8/VJYfiLm0iEqC3zmgvVzcXqX/+gPOdcnjPIhObbgCSvUQG
         hqpU0YzD+hIjiDs5yxmdXh+/s/NvdcuBBIV5kiNysuCxm4feLtA0ebLVuacnoJTogXnX
         /dF5uX1jRFff5jp/LJRFjoh9yi0scwLhlRjcFNmtk1tPqqLC41P0xByhOJKgGJlAURuu
         P6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HlkJ7DCMRW5DM0Cr5A//hH5XtvheICAxstvQ6UI2sz0=;
        b=LkAi3VwXzIkRlBUF5RA/FupTgewoQRL7B8h4Jg32lU1zMvxRX7T8ftOf4c6gphGUJt
         TAlxjv96LWQS6MEm3RaSF+0ZIa3XgKpOS4XoreX+r+G+V+PbFjkTDJ/oeQ7a7Cv+l5n0
         c7StnElkp2DjxEjE0cRC2tJ6Og/CvFG9asLwMlTrLKESSLoP76p+pgxiC2wamvj8dAh+
         Tg50UjzLJrEUoURZvls0U7R0nM/GQtbXyRySazpw5t9RSMw3Y1ZS/Ove4m7vYLWyt+YL
         UYkihpfHIPNCIV6OE4zqu3dz+i7N8HhX8HNtWJymfGdPD6F42HY/yMtDsIuZj6et0pTc
         Djaw==
X-Gm-Message-State: AGi0PuaZdETJmd61utpiYDAZv4tnSz5q8gaMZyc0EAp+5pSK+UUxuT/e
        m6I65y2XhR1aPJdeRRBVVgQkDZY+bP7KgQ==
X-Google-Smtp-Source: APiQypIYJDpuDR+lnGc+ksLKS43xUeBVGtTLzuiwzhd0kQZuu8xw6XFnarph+QCZAZ+pehF+CBQnhA==
X-Received: by 2002:a0c:e9cc:: with SMTP id q12mr567945qvo.128.1587583608758;
        Wed, 22 Apr 2020 12:26:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d188sm69311qkg.59.2020.04.22.12.26.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 12:26:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRL1D-0003Bs-RN; Wed, 22 Apr 2020 16:26:47 -0300
Date:   Wed, 22 Apr 2020 16:26:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add support for drop action in DV
 steering
Message-ID: <20200422192647.GA12235@ziepe.ca>
References: <20200413135328.934419-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413135328.934419-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:53:28PM +0300, Leon Romanovsky wrote:
> From: Daria Velikovsky <daria@mellanox.com>
> 
> When drop action is used the matching packet will stop
> processing in steering and will be dropped. This functionality
> will allow users to drop matching packets.
> 
> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/flow.c        | 37 +++++++++++++++---------
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
>  2 files changed, 24 insertions(+), 14 deletions(-)

Where is the rdma-core part of this?

Jason
