Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC412FE2C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 22:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgACVHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 16:07:42 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36795 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgACVHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 16:07:42 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so815831qvl.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 13:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=REWVEVD25DJ/LlOolIh87ZE8P72JX3v1tKzboY0yctU=;
        b=bAFjRnOQH+OzKugfuXEnLpLqszEIEseHb3X10RWB04zGK8n84D+T+USlbK/QAXCHw5
         utpMzBMWZu3Tm9HWmVUEeWUVVOWfCTSaUvnzXyc9Sz9gNRjXKzLq3n5yQSnE19f0vMZX
         mOmQYAWoN/F650b+bOWTmqBJ9obgEkPFdOxYiV8F3oHQuwg7f8YhuSofv+g7l8Hk2VIz
         PJKMoeyTtORIn9A//dCNJ0VLxw6sCfDqsXrcnKNegrZfROvx4GLWyC+15AKSXaXFsLkN
         Oaw50Y31uNhEdZ58axfkyPbNjKYrb+K6G4FWiQkKXxGA53sdSnPK/ydxTMlA6DkoDdAU
         LXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=REWVEVD25DJ/LlOolIh87ZE8P72JX3v1tKzboY0yctU=;
        b=S0t9FJg8VS+fEnazIn2jfEHG88F9oCy2mXLlTjfBw+Vojeo4Kgw6DyI59K7wyt0x1W
         JmnLfL65cj7QAn+CUVs5R+H5VvUazblggLzJKw9ymfoS4HJhILRcT2zJ/Ekh8B6e+T88
         ikPQt5lCIUpa8IwMM0E33ByZ6psPt3JbW6WRLppQVuLvd4Xn9DnBXXWir/3PnyV4RwcN
         GlCRltwQPr+Ge9Jhw+Et2c0y0YZ8F5Uxzlbpns7E6CgMQJzdu5b5Lo6FUv5ekaw+kvwH
         Ppcf74AeCxgatRScpoOQZGp01seL7GfWyZgxRwy9gAD9hFeWQjIuH29x9Z6QaHTotI0k
         HMFw==
X-Gm-Message-State: APjAAAXdCGqWjgWkZu4oEZKLCaeVxKf2aSYFyZKVN+L9qyUHPM0ff6OI
        nJAr3T8GygAoaiH8EbyObAgd2w==
X-Google-Smtp-Source: APXvYqybQULEEyZSeNms6Z+1WVyW5pFdhDiO49U78QuIgrgQON+8Ygfl9zfr8fvnbM1ite/ULiIkvA==
X-Received: by 2002:ad4:4f94:: with SMTP id em20mr66900975qvb.95.1578085661675;
        Fri, 03 Jan 2020 13:07:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g62sm16969095qkd.25.2020.01.03.13.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 13:07:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inUAW-0003vN-JO; Fri, 03 Jan 2020 17:07:40 -0400
Date:   Fri, 3 Jan 2020 17:07:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc v1 0/3] ODP Fixes
Message-ID: <20200103210740.GA14957@ziepe.ca>
References: <20191222124649.52300-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222124649.52300-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 22, 2019 at 02:46:46PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v0 -> v1: https://lore.kernel.org/linux-rdma/20191219134646.413164-1-leon@kernel.org
>  * Added description of fix to patch #1
>  * Added Jason's ROB tag to patch #2
>  * Dropped changes in page fault handler in patch #3
> 
> Please find below three patches that fix ODP flow.

Applied to for-next, not rc
 
> Artemy Kovalyov (1):
>   IB/mlx5: Unify ODP MR code paths to allow extra flexibility

This is the only one that really fixes a bug, and it is too big for
rc5 at this point.
 
> Yishai Hadas (2):
>   IB/core: Fix ODP get user pages flow
>   IB/core: Fix ODP with IB_ACCESS_HUGETLB handling

While these are needed fixes they are not bugs...

Thanks,
Jason
