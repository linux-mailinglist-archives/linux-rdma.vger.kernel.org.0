Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEE25784
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEUSYR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:24:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45938 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfEUSYR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:24:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so21625506qtc.12
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ubkjZUPBzi+OncEAvIsxg1HMFXUVvLxISRwntjYLkIQ=;
        b=khpnaGhFPDwM4dzWvlaFG6meTP4aNgOhtb0lH+GlSRV+4w2AHbLrnrR0Ej6qY4zcQv
         1tGlE5Jt/2NK2OJVCsOvBbXZTetqj4bT5OJKWZ2TYDwYt8VU8uw/SZSYYj5ZmLQU1weg
         jHlrF72xJdlngWh8wvgpapdHxhpvLCeJqE3leu0fjRl08Y4G9WP0T2fS6VWuPR/mbEC0
         2jZ/h8B35sJF9QhRePCLFMtpQJ2p2FEOO0i6jYmszmJXLQCP5M/U+8X+PY0hcq4OR15E
         Hs5v57GjrfSyDJIL5odv5lXhJRycHTjC56yoPC+oKHa2QfklNsugP0Xb/2uylPEztghr
         Q1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ubkjZUPBzi+OncEAvIsxg1HMFXUVvLxISRwntjYLkIQ=;
        b=rvv0IRbui29FBvaoQdSNvQ9q9/pwxRtNjCzYCych9CY0J+BUr6Ls1XYxUpohce8jX5
         OVt+ir1kBLDDjuqXvHrtMCtdEf3/A15S1UvboANEcY/oT/Xt5T7Bqdb9OFSkGkHY2fpg
         hpJkz7jr9xA0WgwA3tyc8wN1UgJfFIgjAWPEs/2zEMIix9ear0Rhtxfxsh6wIDUtoXqJ
         0zHAe1Yhunny+7LMHmKbvy9ctxjaJ5Bjv6viCzQi1ukHBtehqc8GPD5Irt4o6lTvsVUM
         V7BG9wCzAIajrsl54MvsRsLnndm0JTD8lo8BxbcActka+lH8E3P9yzIflXaSjUKeCkWt
         Rt/w==
X-Gm-Message-State: APjAAAVMCwtvGzThhR8Bvi/dRZ/PpGQdHhQJYLyc1te+uiFuIvkwhJ9y
        75f3Hz7H1fjuPZHJgdS+lQATPA==
X-Google-Smtp-Source: APXvYqyJUaUF2WUblvTxBwvhNI+tWoNdR37WnPgSJciFvF9+pmavelAMispLas3VNUGGUhzrmY3QjQ==
X-Received: by 2002:a0c:ad1c:: with SMTP id u28mr23734747qvc.87.1558463056759;
        Tue, 21 May 2019 11:24:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id z29sm10914399qkg.19.2019.05.21.11.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:24:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Qt-00030S-V0; Tue, 21 May 2019 15:24:15 -0300
Date:   Tue, 21 May 2019 15:24:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/umem: Move page_shift from ib_umem to
 ib_odp_umem
Message-ID: <20190521182415.GA11517@ziepe.ca>
References: <20190520060525.7832-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060525.7832-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 09:05:25AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This value has always been set to PAGE_SHIFT in the core code, the only
> thing that does differently was the ODP path. Move the value into the ODP
> struct and still use it for ODP, but change all the non-ODP things to just
> use PAGE_SHIFT/PAGE_SIZE/PAGE_MASK directly.
> 
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog v0->v1:
>  * Fixed wrong page shift in umem ODP.
> ---
>  drivers/infiniband/core/umem.c           |  3 +-
>  drivers/infiniband/core/umem_odp.c       | 79 +++++++++++-------------
>  drivers/infiniband/hw/hns/hns_roce_cq.c  |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c | 10 ++-
>  drivers/infiniband/hw/mlx4/mr.c          |  8 +--
>  drivers/infiniband/hw/mlx4/srq.c         |  2 +-
>  drivers/infiniband/hw/mlx5/mem.c         | 20 +++---
>  drivers/infiniband/hw/mlx5/mr.c          |  5 +-
>  drivers/infiniband/hw/mlx5/odp.c         | 23 +++----
>  drivers/infiniband/hw/nes/nes_verbs.c    |  9 +--
>  include/rdma/ib_umem.h                   | 19 ++----
>  include/rdma/ib_umem_odp.h               | 20 ++++++
>  12 files changed, 99 insertions(+), 102 deletions(-)

Applied to for-next

Jason
