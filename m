Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB3609B0
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbfGEPuT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 11:50:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46875 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGEPuS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 11:50:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so9377591qtn.13
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jul 2019 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=un/QMDgD7xRIOUszwS2wGlz52tslEmbgVJUy/OVF8os=;
        b=lFlwULSPUbKrvW+iNcCcGnarrV9/iZivr9wvTC5jRF8sye15li8rovk4EI+B5fvE+m
         hHdQEihBW4yOrOtdwQ2MyCA1DLY1Fk65Frx4r/LXn+fyYT8cu/QxSYF97Z45c/NZ12QK
         X0RzaAh/Z947F8XK1hD0hpATMQ4gz2O9m+4Ui3HoB9A5FuRcwnuHSlWSKrFkk1sVlaNl
         Bup/3WXWZaYKW8rgSaAH785jRNXZaCwKZ1wAbCoQoZVsxOev28nd+9/gxqgm3h/4QLTr
         4xZ2SsM3Xa9HwGO2uAOdDYlCmtnZZJpbZf5tlvtXNNsjS/lfF6dOsY12g3sjkQmHUr4r
         kvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=un/QMDgD7xRIOUszwS2wGlz52tslEmbgVJUy/OVF8os=;
        b=uj2O+oInoZgVipX2GAATByzjnEo810Llbnywjqz8S1RSVG7gwaV8RaTAjzPfZ1STv/
         l5BRxCQqn4RZrVbYwGJnnPykivMD9VHjDZQxfuiZFl+Mi452RE2AEck6rkPeFJDHUKcq
         U2+Yerj8jg8BC2uXqRyvm3uYQlFWTDqOrE7zA+ckPBqnKwP9iyTLzLyrm0jmBL8E2OeP
         AzJGJ2VQw3ozIZVH4U8BhCEntTSxpZychumOgNXPvyWdudDCM1pegGcu5BrPq6Y4XFMM
         6FNl7iI9OleeoXFOoNTPUvcrTXqPrICkxq80YdCqoVpyMKxa1LhDHbNMzah8QAtJXK/o
         lIUg==
X-Gm-Message-State: APjAAAVN7Du0Wx+DOrM142E0WgrNwlvYKtMaU/KD0Kd0a94oR4p0vdQm
        nMg9F1R4SoxIskH2rwWSKNV4mg==
X-Google-Smtp-Source: APXvYqzCHlx84qPO9Fcty4PLwQ299M+9+HbG7YB5mC4W2Jwi/Ecm1FWK2FDHnEkXJtDx3bfebkp86w==
X-Received: by 2002:ac8:450e:: with SMTP id q14mr477512qtn.132.1562341817828;
        Fri, 05 Jul 2019 08:50:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q56sm4224593qtq.64.2019.07.05.08.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 08:50:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjQTY-0006jc-Vo; Fri, 05 Jul 2019 12:50:16 -0300
Date:   Fri, 5 Jul 2019 12:50:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v5 00/17] Statistics counter support
Message-ID: <20190705155016.GA25864@ziepe.ca>
References: <20190702100246.17382-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702100246.17382-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 01:02:29PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v4 -> v5:
>  * Patch #6 and #14 - consolidated many counter release functions,
>    removed mutex lock protection from dealloc_counter() call
>    and simplified kref_put/kref_get operations.
>  * Added Saeed's ACK tags.
>  v3 -> v4:
>  * Add counter_dealloc() callback function
>  * Moved to kref implementation
>  * Fixed lock during spinlock
>  v2 -> v3:
>  * We didn't change use of atomics over kref for management of unbind
>    counter from QP. The reason to it that bind and unbind are non-symmetric
>    in regards of put and get, so we need to count differently memory
>    release flows of HW objects (restrack) and SW bind operations.
>  * Everything else was addressed.
>  v1 -> v2:
>  * Rebased to latest rdma-next
>  v0 -> v1:
>  * Changed wording of counter comment
>  * Removed unneeded assignments
>  * Added extra patch to present global counters
> 
> 
> Hi,
> 
> This series from Mark provides dynamic statistics infrastructure.
> He uses netlink interface to configure and retrieve those counters.
> 
> This infrastructure allows to users monitor various objects by binding
> to them counters. As the beginning, we used QP object as target for
> those counters, but future patches will include ODP MR information too.
> 
> Two binding modes are supported:
>  - Auto: This allows a user to build automatic set of objects to a counter
>    according to common criteria. For example in a per-type scheme, where in
>    one process all QPs with same QP type are bound automatically to a single
>    counter.
>  - Manual: This allows a user to manually bind objects on a counter.
> 
> Those two modes are mutual-exclusive with separation between processes,
> objects created by different processes cannot be bound to a same counter.
> 
> For objects which don't support counter binding, we will return
> pre-allocated counters.
> 
> $ rdma statistic qp set link mlx5_2/1 auto type on
> $ rdma statistic qp set link mlx5_2/1 auto off
> $ rdma statistic qp bind link mlx5_2/1 lqpn 178
> $ rdma statistic qp unbind link mlx5_2/1 cntn 4 lqpn 178
> $ rdma statistic show
> $ rdma statistic qp mode
> 
> Thanks
> 
> 
> Mark Zhang (17):
>   net/mlx5: Add rts2rts_qp_counters_set_id field in hca cap
>   RDMA/restrack: Introduce statistic counter
>   RDMA/restrack: Add an API to attach a task to a resource
>   RDMA/restrack: Make is_visible_in_pid_ns() as an API
>   RDMA/counter: Add set/clear per-port auto mode support
>   RDMA/counter: Add "auto" configuration mode support
>   IB/mlx5: Support set qp counter
>   IB/mlx5: Add counter set id as a parameter for
>     mlx5_ib_query_q_counters()
>   IB/mlx5: Support statistic q counter configuration
>   RDMA/nldev: Allow counter auto mode configration through RDMA netlink
>   RDMA/netlink: Implement counter dumpit calback
>   IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support
>   RDMA/core: Get sum value of all counters when perform a sysfs stat
>     read
>   RDMA/counter: Allow manual mode configuration support
>   RDMA/nldev: Allow counter manual mode configration through RDMA
>     netlink
>   RDMA/nldev: Allow get counter mode through RDMA netlink
>   RDMA/nldev: Allow get default counter statistics through RDMA netlink

Okay, applied to for-next

Thanks,
Jason
