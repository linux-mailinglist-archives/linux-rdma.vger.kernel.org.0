Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC79D1F394
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfEOMO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 08:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfEOLEG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 07:04:06 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042142084F;
        Wed, 15 May 2019 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918245;
        bh=wbf1HotXH/BpvJBUzFfLlYKqjMqZS6ybGrQUAD4fs68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhQ1dM02RW5hLO0l8IHJvQ2ocWXLk4rFd5nhRKugbqicxqoM7M8RcVp6pYCW6DZiR
         5DwV775YYuKiIqt1Fob/mcaCChLOHjFkpgq8loeCGnk8OmeLd/xn4uLiTrb80RtXnX
         NFMJeFwwpR2bPvECtjLk9/gYSdQhqrvMlb7lIeZY=
Date:   Wed, 15 May 2019 14:04:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
Message-ID: <20190515110401.GK5225@mtr-leonro.mtl.com>
References: <20190515095013.8141-1-leon@kernel.org>
 <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 12:50:32PM +0200, Bart Van Assche wrote:
> On 5/15/19 11:50 AM, Leon Romanovsky wrote:
> > @@ -4089,11 +4093,15 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
> >
> >  	host->dev.class = &srp_class;
> >  	host->dev.parent = device->dev->dev.parent;
> > -	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
> > -		     port);
> > +	devnum = find_first_zero_bit(dev_map, SRP_MAX_DEVICES);
> > +	if (devnum >= SRP_MAX_DEVICES)
> > +		goto free_host;
> > +	set_bit(devnum, dev_map);
> > +	host->devnum = devnum;
> > +	dev_set_name(&host->dev, "srp%d", devnum);
> >
> >  	if (device_register(&host->dev))
> > -		goto free_host;
> > +		goto free_num;
> >  	if (device_create_file(&host->dev, &dev_attr_add_target))
> >  		goto err_class;
> >  	if (device_create_file(&host->dev, &dev_attr_ibdev))
>
> Hi Leon,
>
> Thank you for having root-caused this issue. However, this patch
> modifies the ABI between kernel and user space and hence breaks at least
> srp_daemon and blktests. Are you aware it is considered completely
> unacceptable in the Linux community to break user space? You may have
> noticed that the SRP sysfs ABI has been documented in
> Documentation/ABI/stable/sysfs-driver-ib_srp.

Are you aware that ib_srp is broken for systems with 2+ adapters?
Any suggestions on what should be done in ib_srp to fix it?

Thanks

>
> Bart.
>
