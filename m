Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D862AAE60
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgKHXti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Nov 2020 18:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHXti (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Nov 2020 18:49:38 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C1AC0613CF
        for <linux-rdma@vger.kernel.org>; Sun,  8 Nov 2020 15:49:38 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id t191so5322396qka.4
        for <linux-rdma@vger.kernel.org>; Sun, 08 Nov 2020 15:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0aOsrrL8BP44PxWcbJZc+zN6xq6IJqg9SSX6gkyFr8=;
        b=htj+yfMwpYKe6rjzENK8rBZeDinKvFPC8i6iHAX7sXzxi2vD8hTBvZy+bcV7fJIABY
         A6eR/8ey/bwLiU2ATutgLnMMWVfIXhIFWFR5Qv1uWjNAkZgOaBbvZfVHev5Xi6ng80MS
         zEIxmFRTi/RNAqbe/RYuRjPNrsGDQJU/UqAcJ9xTY9AghziMJAZEg1SJ5OlAWnVI8sUt
         FKlYY4FUUehxP8+ictFeVcjIiFZB0vN4lBgPQ8pX9T4pblMwcsTYRn6TN8HeF++7jk9T
         2VcuFL/+ym2Ga7xDq/p14YxcYezmU0IJUrzLxectb/569WEZ2JrU9PTb3I5Nl0gidRN5
         eSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0aOsrrL8BP44PxWcbJZc+zN6xq6IJqg9SSX6gkyFr8=;
        b=HAEeXlDqrbX2jwEkTgtW9wMkN3HFInfQ7u+cyhh0um3gk288PDXZADb9+j+BRZoZBB
         v6WPmh1cPP0pklz7vagHAlKrGzmzDSGLS5+3Jzs/Tb4WHhZGh/AquV80kFl5/tx59BEo
         5TSohl8BI2YLH0YoKH8c2ngO5VfyV/CoNpkWev/vE4ufpKq/0ZZDcW57TtCXy/H1ev3+
         j4gGRMtfsC5lwE+4Z9E1QmzOvHgrD6oBSIzrSLj5sA5TTpB14DDllCwedQi7TpPBYtOj
         GpikuR6WOWg6Bu9dEtmcIdLwqUvsliCk+i73Ul3eQqk0Zw1wGVrF93/AboNnYvOtGTen
         mxww==
X-Gm-Message-State: AOAM531WyWJbX2EyMI1/Bodq2MB5S/IdRLmcxiN6f54XlHC+Eal8yy/H
        Yz9lbixv2+SvrNdVK6tmvPTwPQ==
X-Google-Smtp-Source: ABdhPJztltnfDtFmKSDCtLlyisP/O4Fa/VAEr87+IX2LSC33owLQ3LcSV2wKAPDQs8mA9E1U9rP8YA==
X-Received: by 2002:a37:9f82:: with SMTP id i124mr170816qke.493.1604879377183;
        Sun, 08 Nov 2020 15:49:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d184sm5227736qkf.136.2020.11.08.15.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 15:49:36 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kbuRD-001jvu-Ey; Sun, 08 Nov 2020 19:49:35 -0400
Date:   Sun, 8 Nov 2020 19:49:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201108234935.GC244516@ziepe.ca>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca>
 <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 08, 2020 at 03:03:45PM +0200, Gal Pressman wrote:
> On 05/11/2020 22:00, Jason Gunthorpe wrote:
> > On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
> >> On 03/11/2020 16:22, Jason Gunthorpe wrote:
> >>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
> >>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
> >>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
> >>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
> >>>>>>> Add the ability to query the device's bdf through rdma tool netlink
> >>>>>>> command (in addition to the sysfs infra).
> >>>>>>>
> >>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
> >>>>>>
> >>>>>> Why? What is the use case?
> >>>>>
> >>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
> >>>>
> >>>> When taking system topology into consideration you need some way to pair the
> >>>> ibdev and bdf, especially when working with multiple devices.
> >>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
> >>>
> >>> You are supposed to use sysfs
> >>>
> >>> /sys/class/infiniband/ibp0s9/device
> >>>
> >>> Should always be the physical device
> >>>
> >>>> Why rdma tool? Because it's more intuitive than sysfs.
> >>>
> >>> But we generally don't put this information into netlink BDF is just
> >>> the start, you need all the other topology information to make sense
> >>> of it, and all that is in sysfs only already
> >>
> >> As the commit message says, it's in addition to the device sysfs.
> >>
> >> Many (if not most) of the existing rdma netlink commands are duplicates of some
> >> sysfs entries, but show it in a more "modern" way.
> >> I'm not convinced that bdf should be treated differently.
> > 
> > Why did you call it BDF anyhow? it has nothing to do with PCI BDF
> > other than it happens to be the PDF for PCI devices. Netdev called
> > this bus_info
> 
> Are there non pci devices in the subsystem?

Yes, HNS uses non-pci devices

> I can rename to a more fitting name, will change to bus_info unless
> someone has a better idea.

The thing is, is is still useless. You have to consult sysfs to
understand what bus it is scoped on to do anything further with
it. Can't just assume it is PCI.

Jason
