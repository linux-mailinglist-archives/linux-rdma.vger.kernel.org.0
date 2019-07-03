Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26785ED62
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCUTO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 16:19:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37995 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfGCUTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 16:19:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so5530969qtl.5
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypzSTQQT0lNz7uIqG/1HvCt5tyzVjgeVAQ5Oisj1J8I=;
        b=MOrc5nCSh0drlXFnHZ5UBQe5lGMtPRf/iI5G/8CW2H6dRc1o875rgZieBkS4kyLYGL
         ciNXvTk/CeJbJpBv+LG6pbHNC2rgnnHmOnARgW3PIux++OzDTj0UE21n6PduASg5OHrR
         gaRMHnijNJNNoOuXO6oadoJs/RuPBRroEQRklyugph7C7DtsA317YjV86suHbZeXQgkq
         WnkWIC7frYKfxfpn+IDXLVyd7nHm9QGu5peJhXD1gW4jQ4QKuH1pLZ8mi13fhtMigBbM
         5TCGWjPLKP1TuJXLCWBeCACOIhB9ezEfw50275EPmKdi+mGlegbejmiZvNti0ZW9k224
         Tlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypzSTQQT0lNz7uIqG/1HvCt5tyzVjgeVAQ5Oisj1J8I=;
        b=VZongXuapzeYJTWQkPkuVvJJA410yWhhRMXkF1RWZKLoc3vX61dauKPTiBxQtLoAzk
         DVx1/a1dYGIgQe5Zv/CAH9+5pXNP4NibVN+FUyFSFTNu3ANoY5Twe/yWqcTK67XMImxx
         ZWwjyY1RlNww5uWcLnH/zBAFgEu5bPhgEOEtDEJHw4LA6uzD78T/zyudYLUAj3sK6Lbo
         LsxO8KfpY1AQtBaEgbR0GXBBfUu2WN35d2hAtfEiWMDHueLJZD3N+1Qj3J+KU7f4VuGY
         LLZ5n7xksf3KUL30dTeys/ln7rqP8KXM5dvrN3SqZl3cl+quUINTxfa9FtGGTSfM6oxb
         Rvdg==
X-Gm-Message-State: APjAAAXJ7aKmXjGXEcdn1rs+ziTwz9Fl0bgAIlIK+4hmx0yZP0PVpnJY
        rS50zLYyveK7OIj8v9b/f8Z9bg==
X-Google-Smtp-Source: APXvYqzAxTzXMt4gop2IFYiOfZvHHPJblaLDQQcNetdDEM3g+MP9poxFmqADobUlULTciEl+0TkSvw==
X-Received: by 2002:a0c:adef:: with SMTP id x44mr34075412qvc.153.1562185153508;
        Wed, 03 Jul 2019 13:19:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u126sm1412485qkf.132.2019.07.03.13.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 13:19:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hilii-0007HE-EX; Wed, 03 Jul 2019 17:19:12 -0300
Date:   Wed, 3 Jul 2019 17:19:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 00/13] DEVX asynchronous events
Message-ID: <20190703201912.GB27910@ziepe.ca>
References: <20190630162334.22135-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630162334.22135-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 07:23:21PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v1 -> v2:
>  * Added Saeed's ack to net patches
>  * Patch #2:
>   * Fix to gather user asynchronous events on top of kernel events.
>  * Patch #7:
>   * Fix obj_id to be 32 bits.
>  * Patch #8:
>   * Inline async_event_queue applicable fields into devx_async_event_file.
>   * Move to use bitfields in few places rather than flags.
>   * Shorten name of UAPI attribute.
>  * Patch #10:
>   * Use explicitly 'struct file *' instead of void *
>   * Store struct devx_async_event_file * instead of uobj * on the subscription.
>   * Drop 'is_obj_related' and use list_empty instead.
>   * Drop the temp arrays as part of the subscription API and move to simpler logic.
>   * Revise devx_cleanup_subscription() to be success oriented without
>     the is_close flag.
>   * Leave key level 1 in the tree upon bad flow to prevent a race with IRQ flow.
>   * Fix some styling notes.
>  * Patch #11:
>   * Use rcu read lock also for the un-affiliated event flow.
>   * Improve locking scheme as part of read events.
>   * Return -EIO as soon as destroyed occurred.
>   * Use a better errno as part read event failure when the buffer size
>     was too small.
>   * Upon hot unplug call wake_up_interruptible() unconditionally.
>   * Use eqe->data for affiliated events header.
>   * Fix some styling notes.
>  * Patch #12:
>   * Use rcu read lock also for the first XA layer.
>  * Patch #13:
>   * A new patch to clean up mdev usage from devx code, it can be accessed
>     from ib_dev now.
>  v0 -> v1:
>  * Fix the unbind / hot unplug flows to work properly.
>  * Fix Ref count handling on the eventfd mode in some flow.
>  * Rebased to latest rdma-next
> 
> Thanks
> 
> >From Yishai:
> 
> This series enables RDMA applications that use the DEVX interface to
> subscribe and read device asynchronous events.
> 
> The solution is designed to allow extension of events in the future
> without need to perform any changes in the driver code.
> 
> To enable that few changes had been done in mlx5_core, it includes:
>  * Reading device event capabilities that are user related
>    (affiliated and un-affiliated) and set the matching mask upon
>    creating the matching EQ.
>  * Enable DEVX/mlx5_ib to register for ANY event instead of the option to
>    get some hard-coded ones.
>  * Enable DEVX/mlx5_ib to get the device raw data for CQ completion events.
>  * Enhance mlx5_core_create/destroy CQ to enable DEVX using them so that CQ
>    events will be reported as well.
> 
> In mlx5_ib layer the below changes were done:
>  * A new DEVX API was introduced to allocate an event channel by using
>    the uverbs FD object type.
>  * Implement the FD channel operations to enable read/poo/close over it.
>  * A new DEVX API was introduced to subscribe for specific events over an
>    event channel.
>  * Manage an internal data structure  over XA(s) to subscribe/dispatch events
>    over the different event channels.
>  * Use from DEVX the mlx5_core APIs to create/destroy a CQ to be able to
>    get its relevant events.

Applied to for-next, thanks

Jason
