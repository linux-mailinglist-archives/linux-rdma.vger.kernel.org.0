Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0EE0CAF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfJVTkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:40:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37827 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJVTkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:40:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id g50so14452640qtb.4
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KEsITeSETtQ4t2A+VMw2dUY0D5+ZH1nhFWKO0QZaA0=;
        b=jYaEeibKuM2W1en3ZXInpeIlVqCkqN6YyttRdjmUAWui3CiFiigEqPYRGOyc/koM0j
         fDNRMh2ZmMhPXYmxEnTCq7p42BJgh0SuN5aCwvDQdYlS5IlialZVkT0oqKjKM/+5Fy5Z
         9DOSbl/vqcqNbjPymlQUhaUieBatC7K2LhKTDLYcikU3tWvXo07t0sNQzmn6l6JRklwu
         BoOh8ZkwDlIxmaoNz4eewZqLbPV783HMnEQezZaAz3FKed4H1lZhXViuJcaFfjVSHs9H
         A0vwAWyOXaJFYu8CeNsCg4hfQ73WWZAPzKF2nkGboPBhGA3LhEJXHCszYXpMm/Es1e+e
         CFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KEsITeSETtQ4t2A+VMw2dUY0D5+ZH1nhFWKO0QZaA0=;
        b=P7le5RyTErx19K8qj2EI50qBaYusf8WZ8zIwWXf6DizfVQmcmVRGciYrJG00sWJGNz
         imYubH4NchmuxfVxcgwIr2AGkc+XRAXJab6aEbdlQqnp/pqFnm1+lO+ycmLcx8ky6Xny
         4/lsW0NFWMjqC8oBJGESQqlVYcsA3xEQT+rXaTvL/0q3KOT37hcpgKCW1cirnAQzTiQc
         4So8br+R6Pw6mDus6TYhu0olTa/Pqb0dz0mOJSGGtVov/ZsGcJ7L9EvuaQb/XYdl2QUk
         zn3KGvqNrBVWCFLEDF/hFd69ruEh6vd/uxt6gRNTdkJfF37I6+lpC9+eMIyCZyKwg9Vk
         JlNA==
X-Gm-Message-State: APjAAAUa5CWcKasGw+OimMLhdVg0d0X4ia7mVwao/7D2AQ42BUXgzzgk
        NDvleBzCMs2YNKgwYfb71OkZLg==
X-Google-Smtp-Source: APXvYqwDsicah6KABrxxrBJ607/v7cdHX9/98XDNLVP4Er9KjLmS6UapfZS27Ec1lcrdDwcSLeLvNA==
X-Received: by 2002:ac8:7617:: with SMTP id t23mr5184918qtq.88.1571773246658;
        Tue, 22 Oct 2019 12:40:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g8sm14407789qta.67.2019.10.22.12.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:40:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iN01N-0003GN-Q1; Tue, 22 Oct 2019 16:40:45 -0300
Date:   Tue, 22 Oct 2019 16:40:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH rdma-next 1/2] IB/mlx5: Align usage of QP1 create flags
 with rest of mlx5 defines
Message-ID: <20191022194045.GA12479@ziepe.ca>
References: <20191020064400.8344-1-leon@kernel.org>
 <20191020064400.8344-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020064400.8344-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:43:59AM +0300, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@mellanox.com>
> 
> There is little value in keeping separate function for one flag, provide
> it directly like any other mlx5 define.
> 
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/gsi.c     | 2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 7 +------
>  drivers/infiniband/hw/mlx5/qp.c      | 8 ++++----
>  3 files changed, 6 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
