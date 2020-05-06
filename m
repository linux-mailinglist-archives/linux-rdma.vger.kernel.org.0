Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716EF1C7D97
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 00:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgEFWtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgEFWtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 18:49:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527AC061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 15:49:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o10so3128748qtr.6
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sltz2GFQ3je5M+cB4+v2C8CSzhZCj02rrIcrAXAiRL8=;
        b=afOkihqJRcsgdleT8rt2IQfYVlOyU4hRUlzwZpHkV0q7Z5sTvo8kNfY6w9a1d3qQxa
         qAyd7aUZJ0cuuI8M3J3u67hVVZWWw645Watg8JBuDyFxSCfYPvSYq4LwDNGAtFQizVHa
         IhIIPwnAQcwvx+TCOQpRq0PPitktSiZBuLdfK2gd/ULYRa9pw11supwqoGAmZNRygVaK
         gusgI1bPQACJ7fJSOa/+uXvoIH1sCsiHqRPL/LrIjHXd/pIve+e2zJqokNnl7IH9QeNn
         PTi5EzKo2sPoXTPbgEdAQA1dvuFoEQcszicYGq9h9jFR2InTdDkMjPgtBhm+/sEmDy/P
         sfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sltz2GFQ3je5M+cB4+v2C8CSzhZCj02rrIcrAXAiRL8=;
        b=lWotj6dIW8m0RwsDnOTvOo1SH+4izD15aBjk9ooEMNsfwWmHpagnCUtAzlQxCNsLvq
         AsF/ir2tW6pHBYmPSfOAc0ID3g1Gxe5w+dmLwYMq3qX8TF0r7q91ypu7SWIeGFPIzrT0
         c4hg4lFd3d8mt9hIA6Il98ZaHzk0TYLgB94HOjbQYTlz8gr4o5GPi2a42M9vFKy9xh8j
         hmAGRxPpN+6T+9xleA746/QRJgurLSs/dN02rp6fb0bfAwNdZZ9303Rsw9MdqxA19YL+
         1LUCcYHyc4eeQZWrxl/tzUzW51xZDALbhkWDSnhoKTwS/teRVE6wmWwdf3bcaKnK+fCL
         XpkQ==
X-Gm-Message-State: AGi0PubCAVkTOI9YOio6/6MjamwZlSlhY3Ggrzm9LurF/L6BAjF0KaYB
        9qxo9KrSWY6bnAgkQ1aM+Aqo0Q==
X-Google-Smtp-Source: APiQypKBbE/Cd5m2clvjHcs/Gq3dPyjFgqJpefq0ndey6ZIIN6CXKzjOo9KLSrZq9RrvMc9ZPSKfRA==
X-Received: by 2002:ac8:66d8:: with SMTP id m24mr10994979qtp.175.1588805355030;
        Wed, 06 May 2020 15:49:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x124sm2803770qkd.32.2020.05.06.15.49.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 15:49:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWSqn-00027n-SW; Wed, 06 May 2020 19:49:13 -0300
Date:   Wed, 6 May 2020 19:49:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Limit to raw Ethernet QPs for raw ETH
 profile
Message-ID: <20200506224913.GA8082@ziepe.ca>
References: <20200506071602.7177-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506071602.7177-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 10:16:00AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is a fix to restrict opening any other QP types except RAW_PACKET
> if we are using raw ETH profile.
> 
> Thanks
> 
> Mark Bloch (2):
>   RDMA/mlx5: Assign profile before calling stages
>   RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabled
> 
>  drivers/infiniband/hw/mlx5/ib_rep.h |  2 +-
>  drivers/infiniband/hw/mlx5/main.c   |  3 ++-
>  drivers/infiniband/hw/mlx5/qp.c     | 12 +++++++++---
>  3 files changed, 12 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
