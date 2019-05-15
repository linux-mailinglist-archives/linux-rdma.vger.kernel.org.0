Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8D1F0F9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfEOLtc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 07:49:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34515 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfEOLt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 07:49:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id h1so2879045qtp.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IBVsz3o+2n0t1L/2nETYgDIAX1JE+bW+wb3PVLyZLoQ=;
        b=jrcTPpbHlf0E4shErVqIxRmEpaxgSakoF1BSLXvCeogXuWGWquGF9cADlyP62kewDA
         Z37ueTThjgcT9HL6fRlGntUi1wAvaoe2kmC4VE1eF4eQCFsLErsLw1CsGf0zrz79OTSz
         G3gAHTl5YXFpSwOqLEkEyab/e1NuUgHsoRm2urtCw/BFqD9iFL2JDv949m2RaButudlb
         MQ1IWz4mal9mIEHgxj6QRjYJ9ws0ycgu1hdVVuRPPbvBp802NsvMvm8mu9A8Q7rHPrZD
         jnl+byi9m60ajmwx3qeyl87eNb+4PsMZslCe+EOAvl/TvxbRODo13ybu0ZDVrNlAVLv7
         py9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IBVsz3o+2n0t1L/2nETYgDIAX1JE+bW+wb3PVLyZLoQ=;
        b=ueJ4eNLV2Bywwn8jKNXJCTAu5JMFtltKcIhPTFpvRERp0b5kKd0xaVoAhywUZhFq3M
         S1fqAoNFfGH+VMr9OW0COwQnOSW2E4GUex8TQW6C4OHFeVJEjzWJs3ek28Z9Ivpqnnzq
         3AVW9G4wwHGtUYKemiMKMxdHa0KDZzGQH5Bg3sBMwsvRQSucZpqHwFS8lX2xCRVDRe8o
         KAOEs2dE1R/WT2vL+GfWr93EkeYoIAXHxoFDpxzc/zIuc3/V6Ur0gNYQyjxotLfeerr0
         rRzAIlHEAfvZaz+FXbbrixxa40pH+CEkziNEIM1AdVFZnLnfVv2FqIzjJ7Jx/YMHl9JH
         mf0A==
X-Gm-Message-State: APjAAAXymocL2H0DcubfDkbMzQbBKkbjrnkimRMU3R/iDYAAguFN8jUQ
        pNsyOdrlva8oKu7Nt0IiRFB19Q==
X-Google-Smtp-Source: APXvYqwqsRAdisj/324Xnhw7EqX0qHQgn4W6fr2YsK3IF0ZtJWXCTFEq4NmuRFyGy7zeXmoG901n1w==
X-Received: by 2002:a0c:9542:: with SMTP id m2mr17301558qvm.108.1557920968746;
        Wed, 15 May 2019 04:49:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e131sm783104qkb.80.2019.05.15.04.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 04:49:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQsPX-0008Sm-SI; Wed, 15 May 2019 08:49:27 -0300
Date:   Wed, 15 May 2019 08:49:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>, oulijun <oulijun@huawei.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support function clear when
 removing module
Message-ID: <20190515114927.GB30791@ziepe.ca>
References: <20190422122209.GD27901@mtr-leonro.mtl.com>
 <add43d02-b3d5-35d9-a74d-8254c1fb472c@huawei.com>
 <20190423152339.GE27901@mtr-leonro.mtl.com>
 <90a91e1f-91fc-bc4e-067c-7bc788c62ab6@huawei.com>
 <20190426143656.GA2278@ziepe.ca>
 <20190426210520.GA6705@mtr-leonro.mtl.com>
 <99195660-be8d-555f-01fc-efd9e680fdf3@huawei.com>
 <20190502130304.GB18518@ziepe.ca>
 <a23d02b4-5a1f-8b25-2b5c-f14e16acdcc2@huawei.com>
 <bd517597-4feb-c748-b43b-e0f45ced959d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd517597-4feb-c748-b43b-e0f45ced959d@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 05:38:02PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2019/5/9 18:50, Liuyixian (Eason) wrote:
> > 
> > 
> > On 2019/5/2 21:03, Jason Gunthorpe wrote:
> >> On Tue, Apr 30, 2019 at 04:27:41PM +0800, Liuyixian (Eason) wrote:
> >>>
> >>>
> >>> On 2019/4/27 5:05, Leon Romanovsky wrote:
> >>>> On Fri, Apr 26, 2019 at 11:36:56AM -0300, Jason Gunthorpe wrote:
> >>>>> On Fri, Apr 26, 2019 at 06:12:11PM +0800, Liuyixian (Eason) wrote:
> >>>>>
> >>>>>>     However, I have talked with our chip team about function clear
> >>>>>>     functionality. We think it is necessary to inform the chip to
> >>>>>>     perform the outstanding task and some cleanup work and restore
> >>>>>>     hardware resources in time when rmmod ko. Otherwise, it is
> >>>>>>     dangerous to reuse the hardware as it can not guarantee those
> >>>>>>     work can be done well without the notification from our driver.
> >>>>>
> >>>>> If it is dangerous to reuse the hardware then you have to do this
> >>>>> cleanup on device startup, not on device removal.
> >>>>
> >>>> Right, I can think about gazillion ways to brick such HW.
> >>>> The simplest way will be to call SysRq during RDMA traffic
> >>>> and no cleanup function will be called in such case.
> >>>>
> >>>> Thanks
> >>>
> >>> Hi Jason and Leon,
> >>>
> >>> 	As hip08 is a fake pcie device, we could not disassociate and stop the hardware access
> >>> 	through the chain break mechanism as a real pcie device. Alternatively, function clear
> >>> 	is used as a notification to the hardware to stop accessing and ensure to not read or
> >>> 	write DDR later. That is, the role of function clear to hip08 is similar as the chain
> >>> 	break to pcie device.
> >>
> >> What? This hardware is broken and doesn't respond to the bus master
> >> enable bit in the PCI config space??
> >>
> > Hi Jason,
> > 
> > Sorry to reply to you late.
> > 
> > Yes, the bus master enable bit should be set by a pcie device when startup and removal.
> > The hns (nic) module use it as well. However, we couldn't use/operate this bit in hip08
> > as it shares the PF(physical function) with nic. Therefore, we need function clear to
> > notify the hardware to do the cleanup thing and cache write back.
> > 
> > Thanks.
> > 
> 
> Hi Jason and Leon,
> 
> Do you have further more suggestions?

The approach seems completely wrong to me - no other driver is doing
something so sketchy. 

You need to explain why hns is so special

Jason
