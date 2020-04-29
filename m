Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E165C1BE503
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2RUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2RUT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 13:20:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98844C03C1AE
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:20:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so2819131qke.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mpmSHkWxwgm/LhAcYo3SLWkH0ACT29klkaOxaqVeapg=;
        b=BaftpZqbKcU3LSUdl2EAMo8xhJ6wB1ilnYyQomJV8QvAIrZ6woGMlhjQPBa4Pkuhj5
         yx7FNiCccDVVyzMRl8IqarWuhPX/ynoe1ZQgHXorS18x/9Y/YqYHvmfRr91+CmRPZ9bD
         0uR4D+wPBYCr9Jz0cnUfo0M+MM6/EXe2WkCSMjsa9Eo4IjWhTO0Kx5sqUgYdXLd1sRb0
         jKdux+HfHqUdTRaXE5YzDuen1XJUNoKrmanc5lasHpkwas3+EqXjMn25UDw6A2P3HpD0
         YIJVfNcsicp+J7iJVtSqwS7wnAHpLSDgI+kmQUaY7NIu4bs0pNz9yn4jQG8Ggw/9byYN
         vNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mpmSHkWxwgm/LhAcYo3SLWkH0ACT29klkaOxaqVeapg=;
        b=PVPNxTuFmef7U7XBlJRKOPfSQUOeEIxlVC4NxDboYnov7+GFjqyqkznTUibYKHkKa+
         /DKAKICjx8PiCYc54qBh3sU3ZblnC9mCXdNssUiEuLYnNEj44wl4i07Lz4TjedVZkkKd
         9pkyi/RUx/tbM5FqgFgXxupySZjBtuVWiCc199F5ZBsvMTzwXfMKvvYhAjLiOY/sVlws
         rL48lNmN1G5EnTE4lD+QBlT4VbWOv0F1NZdduLo60eBeQJc8cnD4hf8jAjpleM5JPaN+
         7KrQITibGQ6qmNYLSb8zE2qTpVXtzmjvgPTKfUEwomu7Y4hlVWkHNLzGTzefGUXiA/Nx
         X4Ag==
X-Gm-Message-State: AGi0PubDRVkCF7vpHfc4HKHTQwdcNeU8bq7DMdoICqVIgZ6HpDPraXwM
        uCHX7mJ/YzDen66gncKfLUA8ig==
X-Google-Smtp-Source: APiQypLF04153S2p8VjAH6Hqezdn+VH4SbYIpT5qP9grOE7J2dD8zbHdFDcq4lHoEALrjdD8Yc830w==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr32525444qkg.262.1588180818856;
        Wed, 29 Apr 2020 10:20:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x22sm10456093qtr.57.2020.04.29.10.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 10:20:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTqNe-0000P8-1Y; Wed, 29 Apr 2020 14:20:18 -0300
Date:   Wed, 29 Apr 2020 14:20:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v13 19/25] block/rnbd: server: private header with server
 structs and functions
Message-ID: <20200429172018.GG26002@ziepe.ca>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-20-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141020.655-20-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 04:10:14PM +0200, Danil Kipnis wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> This header describes main structs and functions used by rnbd-server
> module, namely structs for managing sessions from different clients
> and mapped (opened) devices.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>  drivers/block/rnbd/rnbd-srv.h | 79 +++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 drivers/block/rnbd/rnbd-srv.h
> 
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> new file mode 100644
> index 000000000000..89218024325d
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * RDMA Network Block Driver
> + *
> + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> + */
> +#ifndef RNBD_SRV_H
> +#define RNBD_SRV_H
> +
> +#include <linux/types.h>
> +#include <linux/idr.h>
> +#include <linux/kref.h>
> +
> +#include "rtrs.h"
> +#include "rnbd-proto.h"
> +#include "rnbd-log.h"
> +
> +struct rnbd_srv_session {
> +	/* Entry inside global sess_list */
> +	struct list_head        list;
> +	struct rtrs_srv		*rtrs;
> +	char			sessname[NAME_MAX];
> +	int			queue_depth;
> +	struct bio_set		sess_bio_set;
> +
> +	spinlock_t              index_lock ____cacheline_aligned;
> +	struct idr              index_idr;

No new users of idr, use xarray.

Also no users of radix tree if there are any in here..

Jason
