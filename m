Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1963DD0F2
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHBHHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBHHJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 03:07:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B36360E76;
        Mon,  2 Aug 2021 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627888021;
        bh=7Ud3mMQ1iPybmMwFK498Pqj//129yBo9SXkDdUPfebI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qsn+nrAwTvDc8Gx29XitY6FdmiYqwoctCq5RZjAgK6MW9Ra58byqIwMt6PHnp6M3M
         ZyCu2lTgiJB9RmHdT4B/I6ReZAakySDAZnFv/x7VntHbXS8bnLOiS1S8LkLfzi4C7d
         2LLrBLCQlBk55ejsH7f8tabbYglDyIwWGlYtsxe683/y/ap7b/0u9ZyZB6IYnKbFo0
         OiDaeK/LHyljl9uvwCXUfSH0+qcRJ4Rpm1omTwpAjOirkUxcTKGmOU2gsT1e5PWQkb
         3tl5DmBOnmOsujP8VCQYf5jLoVjr9sTYBoQOGNcgxcTVvgQ8E674NoxU4J+n1ve3E9
         I8PbxuCrVVoXQ==
Date:   Mon, 2 Aug 2021 10:06:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 05/10] RDMA/rtrs: Fix warning when use poll mode
Message-ID: <YQeZkTIOHdqK6noK@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-6-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-6-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:27PM +0200, Jack Wang wrote:
> when test with poll mode, it will fail and lead to warning below:
> echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
> device_path=/dev/nullb2 nr_poll_queues=-1" |
> sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device
> 
> rnbd_client L597: Mapping device /dev/nullb2 on session bla,
> (access_mode: rw, nr_poll_queues: 8)
> WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]
> 
> The problem is in case of poll queue, we need to still call
> ib_alloc_cq/ib_free_cq, we can't use cq_poll api for poll queue.

It will be great to see an explanation here.

Thanks
