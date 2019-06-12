Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE06A41B42
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 06:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfFLEim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 00:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbfFLEim (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 00:38:42 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D1D2086A;
        Wed, 12 Jun 2019 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560314321;
        bh=IgA33fK12x2ky4CgJPs2odqBSRrlD6GTXsEQbs85g9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjsiNamchirmc8+kfz+jhLzasVGmhSG7uNSRmC/N0b+E47hD3OdFx7PIofEVXvHn1
         MSr97WzOvxh7Q2NOb7xKt7fQ6gGs4yp7/9HtfGLlPFHOZsD4SXgAVOauXQ6Z6xYBHb
         npaQcuNQc3pISbb927I709fklwyO6K0ucjI9in3I=
Date:   Wed, 12 Jun 2019 07:38:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 13/17] RDMA/core: Get sum value of all
 counters when perform a sysfs stat read
Message-ID: <20190612043837.GL6369@mtr-leonro.mtl.com>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-14-leon@kernel.org>
 <20190611180446.GA20174@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611180446.GA20174@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 03:04:46PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 01:53:41PM +0300, Leon Romanovsky wrote:
> > @@ -302,6 +318,46 @@ int rdma_counter_query_stats(struct rdma_counter *counter)
> >  	return ret;
> >  }
> >
> > +static u64 get_running_counters_hwstat_sum(struct ib_device *dev,
> > +					   u8 port, u32 index)
> > +{
> > +	struct rdma_restrack_entry *res;
> > +	struct rdma_restrack_root *rt;
> > +	struct rdma_counter *counter;
> > +	unsigned long id = 0;
> > +	u64 sum = 0;
> > +
> > +	rt = &dev->res[RDMA_RESTRACK_COUNTER];
> > +	xa_lock(&rt->xa);
> > +	xa_for_each(&rt->xa, id, res) {
> > +		counter = container_of(res, struct rdma_counter, res);
> > +		if ((counter->device != dev) || (counter->port != port) ||
> > +		    rdma_counter_query_stats(counter))
> > +			continue;
>
> rdma_counter_query_stats has:
>
> int rdma_counter_query_stats(struct rdma_counter *counter)
> +{
> +	struct ib_device *dev = counter->device;
> +	int ret;
> +
> +	if (!dev->ops.counter_update_stats)
> +		return -EINVAL;
> +
> +	mutex_lock(&counter->lock);
> +	ret = dev->ops.counter_update_stats(counter);
> +	mutex_unlock(&counter->lock);
>
> so again, this can't work and would blow up with lockdep if it was
> ever tested. xa_lock is a spinlock, you can't nest mutex's inside
> spinlocks.
>
> Check all the xa_lock for this. No idea why you are not catching this
> during testing. Maybe some might_sleeps() are needed.

I will check it, but on my system LOCKDEP is enabled, /proc/lockdep
exists and full of information, so it is working.

Thanks

>
> Jason
