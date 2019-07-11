Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39876596C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfGKOyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 10:54:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45100 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKOyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 10:54:06 -0400
Received: by mail-vs1-f66.google.com with SMTP id h28so4353929vsl.12
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSRL99BIaLodkBG8Ur8XBaGK7O8DpdxuI0IXmHEfTNw=;
        b=lMbDPIbb0vvyUGWQdnCiasoDr4Yy47wih84OLLO3r9IgeHn7AFQirkDsZ+9bZv6a+X
         DJEbz83leO6ygDTze7wSrzwTG8b303QISowRG65eVyF3T+qaRAD97sq//wM3/4jpKRQH
         aHJYj7vqQUIQ92pFm8jlret5UmI8TNCWExeMqDLj6SM+yz0lJDsUEPy9ql4ZK/mymEY2
         C/lYAWQe9OeEl1jh9NtOjpnr3J0/mSWN6rpdBR3WGPbPaKQT6CJT6hAvOFDJdQziH1wH
         6od1oUQ52AMEnuaTZLM6eWhyh/Sw+Mb1IzzbgWpP9Ng+oJkpeLSGW9ubE23lLgR2MP0k
         dY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSRL99BIaLodkBG8Ur8XBaGK7O8DpdxuI0IXmHEfTNw=;
        b=p0dik+Ft/g3wDAC68kNdKzRF9t4lNXRcgGReZejySw97HyB75gp0scqM4QYPKNOEFe
         xhsSle8j4H5RpL7HOXiKapeVs0Ufu/td7xmZT2ACKnEnK/jMEPmAKlUMSpG/vuRrg/IV
         YK8gKqlbuq9QEtUanJrnYv1vB0WeRL7VwtFszQcy+uolC0RccpHTpmvEqEC8mAM+P4KB
         /mMiO2e+8rOGIizgTVqZz3d46ONEMB9OzEbxCjcpgaIHP+9dLw3+9OlR/Rh0JNsqQsgr
         eg+8OPMdu3CqdRJDM+22IHRUTaKHtQx/8TJgdBXdlM5q+VkVLc/F0NGNJBgIWpWPyVTN
         tbbQ==
X-Gm-Message-State: APjAAAUeL+CmUkTqCGzTbz7p3X+NX6DFS1FnSkYQ0+DtWiitzJTUZArQ
        6WjpsuHLg0oGxpT3fj9HtngnGQ==
X-Google-Smtp-Source: APXvYqzGv5XLpzcelYU2tuSxvoVuhMY+giJViUABBr/Bp/cZiVAevwOuDoKjZcXPaQJW1DVRDkKdnA==
X-Received: by 2002:a67:f492:: with SMTP id o18mr4970890vsn.62.1562856845452;
        Thu, 11 Jul 2019 07:54:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l20sm2290597vkl.2.2019.07.11.07.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:54:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlaSS-00068i-61; Thu, 11 Jul 2019 11:54:04 -0300
Date:   Thu, 11 Jul 2019 11:54:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qian Cai <cai@lca.pw>
Cc:     leonro@mellanox.com, saeedm@mellanox.com, talgi@mellanox.com,
        yaminf@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/core: fix -Wunused-const-variable warnings
Message-ID: <20190711145404.GA23576@ziepe.ca>
References: <1562853356-11595-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562853356-11595-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 09:55:56AM -0400, Qian Cai wrote:
> The linux-next commit "linux/dim: Implement RDMA adaptive moderation
> (DIM)" [1] introduced a few compilation warnings.
> 
> In file included from ./include/rdma/ib_verbs.h:64,
>                  from ./include/linux/mlx5/device.h:37,
>                  from ./include/linux/mlx5/driver.h:51,
>                  from drivers/net/ethernet/mellanox/mlx5/core/uar.c:36:
> ./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
> used [-Wunused-const-variable=]
>  rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
>  ^~~~~~~~~~~~~
> In file included from ./include/rdma/ib_verbs.h:64,
>                  from ./include/linux/mlx5/device.h:37,
>                  from ./include/linux/mlx5/driver.h:51,
>                  from
> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c:37:
> ./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
> used [-Wunused-const-variable=]
>  rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
>  ^~~~~~~~~~~~~
> 
> Since only ib_cq_rdma_dim_work() in drivers/infiniband/core/cq.c uses
> it, just move the definition over there.
> 
> [1] https://patchwork.kernel.org/patch/11031455/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/infiniband/core/cq.c | 13 +++++++++++++
>  include/linux/dim.h          | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
