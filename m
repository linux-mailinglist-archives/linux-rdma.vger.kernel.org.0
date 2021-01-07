Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953DA2ECA8E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbhAGGiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 01:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbhAGGiN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Jan 2021 01:38:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16DB52158C;
        Thu,  7 Jan 2021 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610001452;
        bh=TdqsjKwkdGqmzCggPVn0kvAfKJ2ppLt6TlNNRcNYzIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7cojOkS68jAMIv9yassJSVi/AC+Ra+C5qpRp5yHqiF+NittMUQWKPbKLMN9VSZ4Z
         6yBXQqNgiLq+A40/lVeAfVk/ZhJXSKySrfNgRoHKygll56FPYUWjzHFRqcP3BpC9Hh
         prD1EOhUm0Z5+XzQrTB3RQsH5xogEYtu4i0h3OmLDGE/B3kFN4QtViuVmHeYU/o76I
         LrDhy9Ku/mDBHi9zlZuj+VP8vk2eONhUh3t4HS5UB/odWKh27whBj+TvS5B5SqOtc5
         45sFtNKTXtoIVgN7XXHmdGNgtQrCPXEPkECaxScbxNebMtCd0XTAbzE4uDehK+BZ3h
         JYhHQlsAPlEPg==
Date:   Thu, 7 Jan 2021 08:37:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210107063728.GZ31158@unreal>
References: <20210106122212.498789-1-leon@kernel.org>
 <20210106213316.GA825697@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106213316.GA825697@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 06, 2021 at 05:33:16PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 06, 2021 at 02:22:12PM +0200, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index da2512c30ffd..d6cd72ff213b 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1430,6 +1430,12 @@ static ssize_t ucma_notify(struct ucma_file *file, const char __user *inbuf,
> >  	return ret;
> >  }
> >
> > +static void ucma_flush_wq(struct rdma_cm_id *id)
> > +{
> > +	if (rdma_protocol_roce(id->device, id->port_num))
> > +		cma_flush_wq();
> > +}
>
> The problem here is that rdma_leave_multicast() does not cancel the
> work it created. It is a bug on the iboe side because the normal IB
> side does do the ib_sa_free_multicast() which cancels its callback.
>
> The fix is to add a cancel work to destroy_mc(), not queue flushing

In IB flow, we are storing work pointer so it will be possible to
cancel. This is not the case for the iboe, we simply don't know which
work to cancel.

We can cache that work inside "mc" too.

Thanks

>
> Jason
