Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B245FCDE
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDSZb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 14:25:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35857 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGDSZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 14:25:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so6160844qkl.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YuCOkGPYR1HuQrUxCKSH74a/Mt7z+cyNTqFhu7I94d0=;
        b=MGjKZCml3QvmD1Gk4S2Yu3oIgL2O5AFqNnbr5Ebq5B6sE/FquldNOiuHhtW2OVZukb
         5JpL9oF+lZ1/M/VEvBhCU2MDWNpYugliwwZe/KiHa7U4/snNTv9p+RSuoxOjpM5/Qae9
         5q7RSJs1gtiRulaajuQVXqJVZ8WTv9jHmdimBJENndYbIdFqVUNrJyVn36xyS+w4VHBX
         IpRsRaLN2P6+wMVDmh6ja2a8leMsnjQYof/aZOHiNCFD90XDYXSKj90T4VKmSaSRhE7m
         DKZlVLVzZRQ2J5YvDFHe/ftIe5Rh7SIPIc0GhpdQteTBRtgfjpO+5w2xRLdB4DTnxQxH
         /gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuCOkGPYR1HuQrUxCKSH74a/Mt7z+cyNTqFhu7I94d0=;
        b=hxt/SHvYwEcZ0Idr0GH77RqL8GI7jglG1LKOO6F7wFzVetyBT1ULYe7lYiudQq7Pvt
         MPmO8wzn8aNi8CRb2edqE9xpDKsHgBpfDuF3hWB5YMMa7dgWeMLMguLwJRRWycDfaoiJ
         0t1FHlvtxCZwW7riS7ACpidLHu63svTcxtmSu7iYCG/PP7U8LTNaFqEUFfXbFKX+gN8s
         ZoWyRxzQl6iEvV74NMgXtkRQtJjq7c0Atyy1fgOaXTOVfuOJQrcIJydFYujr8o1bKQcT
         0kszbMhkZNaFAXY0e6iluH95pJUPGpbxQ6sqCAToPVlDWdjO3HQBgO4H2nnH7l7S5tZn
         IVxg==
X-Gm-Message-State: APjAAAXr4hA4Jq2pME3czd8cIkBhV9vTScBqosIzaPp1nZIoCX0zYoDX
        tiq5Rzvv2x0jvA0VRbioeffaIQ==
X-Google-Smtp-Source: APXvYqwi8WRWSeK1x2LMsLxOajUHHqL3EyDz1r+scxW3uQcNld4xIuAHr6B6FAtXNwM6mHhmahKiPA==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr36291262qke.171.1562264729970;
        Thu, 04 Jul 2019 11:25:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o21sm2476711qtq.16.2019.07.04.11.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 11:25:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj6QD-0005f7-6H; Thu, 04 Jul 2019 15:25:29 -0300
Date:   Thu, 4 Jul 2019 15:25:29 -0300
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
Message-ID: <20190704182529.GA20631@ziepe.ca>
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

Well, I can made the needed edits, can you apply the the first patch
to the shared branch?

Thanks,
Jason
