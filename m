Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7527399EBA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFCKSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 06:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFCKSa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 06:18:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 696EA6139A;
        Thu,  3 Jun 2021 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622715406;
        bh=7HZciQxLsBuDoWMd4Kb6D5lue9+WuT5FUDqHbpuuJFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBn9EBCTr/3wcixKOMWXn/re9l7QnkKOGGYXUU7FMUKCbzdv6J01w7AQa7hlB8tDG
         1+GPwyig2oF++DkVY1lBIYDte4/IP9mhnSf3o0RUYpmd/jscIrozXAOkY+VtvgxvW8
         708BT7bDa6iZZqOYm0UqNQ1tCQHjLivlzV81NT4FxZKcOWrE7vj+xExLp3hxGChQNs
         SWG2V6nXkz3Mn+qLTI+eqUqtNg+dcY0GLdCPRSkZtuht/OrzCWGf3bV4COqT7N95n+
         wLoe7vzrAKNM1ykOKcuREzzqFDIbpnkcrzqgDvsBkYvkDyHwqRkDjokBleLInCkY9i
         ZwQdoM98OQ3kQ==
Date:   Thu, 3 Jun 2021 13:16:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Message-ID: <YLisCgBLu9pD1qSw@unreal>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com>
 <YLib5BhTX6tEMTfe@unreal>
 <D188B984-4B47-4992-80E6-6927ADC3DA26@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D188B984-4B47-4992-80E6-6927ADC3DA26@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 09:29:32AM +0000, Haakon Bugge wrote:
> 
> 
> > On 3 Jun 2021, at 11:07, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Thu, Jun 03, 2021 at 12:20:24PM +0530, Anand Khoje wrote:
> >> ib_query_port() calls device->ops.query_port() to get the port
> >> attributes. The method of querying is device driver specific.
> >> The same function calls device->ops.query_gid() to get the GID and
> >> extract the subnet_prefix (gid_prefix).
> >> 
> >> The GID and subnet_prefix are stored in a cache. But they do not get
> >> read from the cache if the device is an Infiniband device. The
> >> following change takes advantage of the cached subnet_prefix.
> >> Testing with RDBMS has shown a significant improvement in performance
> >> with this change.
> >> 
> >> The function ib_cache_is_initialised() is introduced because
> >> ib_query_port() gets called early in the stage when the cache is not
> >> built while reading port immutable property.
> >> 
> >> In that case, the default GID still gets read from HCA for IB link-
> >> layer devices.
> >> 
> >> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> >> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> >> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> >> ---
> >> drivers/infiniband/core/cache.c  | 7 ++++++-
> >> drivers/infiniband/core/device.c | 9 +++++++++
> >> include/rdma/ib_cache.h          | 6 ++++++
> >> include/rdma/ib_verbs.h          | 6 ++++++
> >> 4 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > Can you please help me to understand how cache is updated?
> > 
> > There are a lot of calls to ib_query_port() and I wonder how callers can
> > get new GID after it was changed in already initialized cache.
> 
> The cache is initialized when it is created, just before the bit IB_PORT_CACHE_INITIALIZED is set in flags.
> 
> After commit d58c23c92548 ("IB/core: Only update PKEY and GID caches on respective events"), the GID portion of the cache is updated when a IB_EVENT_GID_CHANGE event is received.
> 
> Before said commit, it was updated on any event.

This part is clear to me, the missing piece is to understand what will
happen if cache and GID are not in sync because of asynchronous nature of
events.

Thanks

> 
> 
> Thxs, Håkon
> 
