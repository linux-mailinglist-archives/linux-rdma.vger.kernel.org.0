Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770B3886CB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 07:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbhESFlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 01:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344991AbhESFif (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 01:38:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D50611BF;
        Wed, 19 May 2021 05:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621402636;
        bh=/wserOAM71RxcqsBZBi62Nr8Kzx6ii8wtkOB0XiIVZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5fo9t0CXUmUiJ6RYESAXULd7nEiQ5eLOxPvVFYOnZeal59HtjtSXMIEengDMh1L0
         Nq1JKywIDrrYO5kRl4RrrZLJY+OdvHcp7rI+cKHaRwwIyjoYzmCeX/GOGoVehQRDYO
         MQhABZi6ArVh1BtKOF4tTmrhFZx7pI3wyv4EeD9GLa8UnsFvajMiutnTs1VDYJuS5x
         ma/1YAqxjIFbVcmJEZcIw2uiVVvnXIThS8hp66AfXXTeKOgeLcwEw+WAyPVjvwSIt4
         /YqeZ2jznzZFkMklLfK08aZvLE0uOmdPr40Z8Muro4h5qto8qFoRT9aNTyxlzGecc2
         /rz5elMajzQTA==
Date:   Wed, 19 May 2021 08:37:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Avihai Horon <avihaih@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix a NULL vs IS_ERR() bug
Message-ID: <YKSkCDcGMdttmeCH@unreal>
References: <YJ6Got+U7lz+3n9a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6Got+U7lz+3n9a@mwanda>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 05:18:10PM +0300, Dan Carpenter wrote:
> The uapi_get_object() function returns error pointers, it never returns
> NULL.
> 
> Fixes: 149d3845f4a5 ("RDMA/uverbs: Add a method to introspect handles in a context")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
