Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE0162ADA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRQl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 11:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQl2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 11:41:28 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F23021D56;
        Tue, 18 Feb 2020 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582044088;
        bh=dD5KRg2uLdDE3+hMdalgNdDA0xhlDBXqzKR2/8ImprI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz55yuz9WDKOFO181jLC9yfs45zXzmH2ii41PAz04D4upVxBWTT4gFlyzJKp1LGrF
         VMmX81iAzPCQJ0ILqdgNULZD9qbUqEFY8qJ/LKq6WMpAiLqUTPDGgSSLRz2n7hdbpC
         2DnLSMAM28+UhcOFd7hYzsoEDEXUw15/DXr7IFVg=
Date:   Tue, 18 Feb 2020 18:41:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Erez Alfasi <ereza@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mohamad Heib <mohamadh@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/core: Fix a bitwise vs logical OR typo
Message-ID: <20200218164124.GA14557@unreal>
References: <20200218055801.cosg4fylgfxhk67s@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218055801.cosg4fylgfxhk67s@kili.mountain>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 08:58:01AM +0300, Dan Carpenter wrote:
> This was supposed to be a bitwise | instead of a logical ||.
>
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,

There is an extra patch for that.
https://lore.kernel.org/lkml/20200217204318.13609-1-natechancellor@gmail.com

Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
