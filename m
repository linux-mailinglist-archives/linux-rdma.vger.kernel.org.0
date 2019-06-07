Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6723928A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfFGQxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:53:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39248 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfFGQxY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:53:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so1667434qkd.6
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcMVvau639e6GHs85I191h7HJo9Yo/oJwRFXFLILprM=;
        b=alG8C5wkjMnVzzNvEfBVUH8AJ0KtqFEOIxxOne6D46cbZMesHY8ZvYU/WFMyFnz6tK
         XoyjsaKFN8NAjAX0tgU1lmwGx5gJlhfkHBO1ZoZv/oVN0NsP4nTx2NwoHF9VOZ0mCblT
         5KYayW25Bsmcw9qqYyrcL8/CmvKA/Ka8j5RXeYwYCXNjEyc0pS5dm/EZrsUlfot06wwb
         uSUemNRVK5Nz1/Z48SJ5OJ49mqrHF3pINDoeRDtvshrX4kQCvGPyrmEoaq7aDqm3JjeD
         fC5vRYGOCGgll2iEJZJfFD0TkJGFeWVXO6EaH4ijgV5Q1Jaudit3krqariaj6YjfRuDY
         nc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcMVvau639e6GHs85I191h7HJo9Yo/oJwRFXFLILprM=;
        b=JX+W4IZUADC1IXymF0TJ0M//wrBTW4DzLTob30av/qF6y0T+K8KrM1lF5+qcABiB9N
         +wjjkEtB6S3gxNBsklVGIXrxRlAR8e0TI9EBd8ehRD7q7MNv77m72HUQGUxFs36g+Bk6
         MndlyMAWJBN8qbOAoBHH4DVYsgKpRP9lxzsvfUcF/iXfgucFQBHgP00ImlGTb2AmhqF0
         9yG4P/6Fd18JXWf37pe/6WF0WRxkOVfR8hwdWTBDlwI/nrBfQ4uMb5EzYB2D/6epRd++
         258+g5kJKl71NyoXiW4JVOw0+5X16phmzLllMW7W057wRemesMaxkY+BA+mgHDMbde6F
         bfYw==
X-Gm-Message-State: APjAAAUyQMqts/qv3EaikMZwwlq7MRECOSmep5UbhkSnq+Lu8QKEXdwR
        SKeKKN9lr+Kn4eNFZGwSKRyiWA==
X-Google-Smtp-Source: APXvYqy7/A8l3mMVud9aKtVAhJGn+4Ikn26e4nlP1hSpQPZkx1Ym1/di6bdxk4YFUXDCtQLcU5JGcg==
X-Received: by 2002:a37:4e17:: with SMTP id c23mr35974131qkb.34.1559926403477;
        Fri, 07 Jun 2019 09:53:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l2sm1194723qtp.14.2019.06.07.09.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:53:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZI7G-0005pz-FH; Fri, 07 Jun 2019 13:53:22 -0300
Date:   Fri, 7 Jun 2019 13:53:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] RDMA/ipoib: implement ethtool .get_link() callback
Message-ID: <20190607165322.GA22304@ziepe.ca>
References: <20190529135545.25371-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529135545.25371-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 04:55:45PM +0300, Kamal Heib wrote:
> Add support for reporting link state for ipoib net devices.
> 
> $ ip l set dev mlx4_ib0 up
> $ ethtool mlx4_ib0 | grep Link
> 	Link detected: yes
> $ ip l set dev mlx4_ib0 down
> $ ethtool mlx4_ib0 | grep Link
> 	Link detected: no
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
