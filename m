Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A543445065
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFMX7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 19:59:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33686 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfFMX7M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 19:59:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so541979qtr.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hlTFiQXTs+d8dESj95hIBXbQK+koFpP+seS/TyGfJ1s=;
        b=fYfcDajzM49cMzKV5FkTACz0Uu9pMyEPJVQyKAeL4cHRuE1sDXC798291Ls0zzNYHQ
         45sMZx7DUlaMMdmebL0c61cKTAW45E+uB39gP0k4E7h9AtpCzP1DnVZFUaNM9iSZEp/4
         vJyZVvbeuA13HQCJ4OlCKf2MFsozknSAR7Ob/GpfBl8EpL5FdqHyxknu3I3C3imubyB2
         OVKLJsfLQ4G7Ni5tJ4cZEfVn78B7tssgALmj3e+M1ho/BlOlvb/4TaDa2lj8ROUCYVl8
         ZTvIOtcOTivFGEyz8CdPxNkqQsIpnnfbCthBBST2iGqPFTBXwEyOOnaYsNqSZxS7NXNW
         DLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hlTFiQXTs+d8dESj95hIBXbQK+koFpP+seS/TyGfJ1s=;
        b=ACJxU44ZHM8jEFt/NjwniWQaQjIqvC1HGIrcyOTDbxqCrMqnI5rwncVcVkvGIn/px/
         1qmat9xg2qqLufx0uF4Y6UcyGdAiAxTrQ/6YIqKb8VowgDUaab48NkiXb+DwkOptXY2p
         deTWoD/XwXrc8GNgpp1Zz/MumIT4RSyhg4HeSPK3IpSIz6KDvX9yVulBZInu4fbqabnn
         zh+f7WaPdBdnfz9gt+cC4kB79xoV9y5bfgmoybIpWLct6wlfsvZ/7kGL5gWVnXPcpwDP
         t9wMIY2Rh1UcPD0SEzOt8Rhv9UU3jjuhHccYdw2MdYYs/rQP2FzgKQp7znBQRPITbK8z
         ruhA==
X-Gm-Message-State: APjAAAVv/82M4XQhpd0bBDB5xKO7yUn0kByP3ENZdXJoWYkMLTeAknGY
        GTHn5Xm4X2nZhrTBzW/Q1504uw==
X-Google-Smtp-Source: APXvYqxwfTBgwVRoL/++FVS2vhVufwjaTORL+4skkZ5QwJHwxy9A7s+7uBrMj5MbglLYrkcODKIFwQ==
X-Received: by 2002:a0c:acb5:: with SMTP id m50mr5714013qvc.82.1560470351750;
        Thu, 13 Jun 2019 16:59:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m27sm873480qtc.16.2019.06.13.16.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:59:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZcc-0001oE-Tx; Thu, 13 Jun 2019 20:59:10 -0300
Date:   Thu, 13 Jun 2019 20:59:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190613235910.GN22901@ziepe.ca>
References: <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
 <20190612115226.GC3876@ziepe.ca>
 <443656b7965a4b319e83eb6b9557676e@huawei.com>
 <20190612162236.GL3876@ziepe.ca>
 <80d4fcee49624b5cba2fcda77f03e74a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80d4fcee49624b5cba2fcda77f03e74a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 10:14:18AM +0000, Salil Mehta wrote:
> > From: linux-rdma-owner@vger.kernel.org
> > [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
> > Sent: Wednesday, June 12, 2019 5:23 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > 
> > On Wed, Jun 12, 2019 at 03:12:24PM +0000, Salil Mehta wrote:
> > > > From: linux-rdma-owner@vger.kernel.org
> > > > [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
> > > > Sent: Wednesday, June 12, 2019 12:52 PM
> > > > To: John Garry <john.garry@huawei.com>
> > > > Cc: Leon Romanovsky <leon@kernel.org>; wangxi (M) <wangxi11@huawei.com>;
> > > > linux-rdma@vger.kernel.org; dledford@redhat.com; Linuxarm
> > > > <linuxarm@huawei.com>
> > > > Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
> > > > multihop addressing
> > > >
> > > > On Wed, Jun 12, 2019 at 09:51:59AM +0100, John Garry wrote:
> > > > > On 11/06/2019 06:56, Leon Romanovsky wrote:
> > > > > > On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
> > > > > > >
> > > > > > >
> > > > > > > 在 2019/6/10 21:27, Jason Gunthorpe 写道:
> > > > > > > > On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> > > > > > > >
> > > > > > > > > > Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> > > > > > > > > > hns. Please send a patch to remove all of them and respin this.
> > > > > > > > > >
> > > > > > > > > There are 2 modules in our ib driver, one is hns_roce.ko, another
> > > > > > > > > is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> > > > > > > > > this function defined in hns_roce.ko, and invoked in
> > > > > > > > > hns_roce_hw_v2.ko.
> > >
> > > [...]
> > >
> > > > > In addition to this, v1 hw is a platform device driver and depends on HNS,
> > > > > while v2 hw is for a PCI device and depends on PCI && HNS3. Attempts to
> > > > > combine into a single ko would introduce messy dependencies and ifdefs.
> > > >
> > > > I suspect it would not be any different from how it is today. Do
> > > > everything the same, just have one module not three. module_init/etc
> > > > already take care of conditional compilation of the entire .c file via
> > > > Makefile
> > >
> > > Okay. I see your point.
> > >
> > > As I understand, the code within v1 and v2 will almost never be required on
> > > the same system since they belong to different types of hardware (platform/PCI).
> > > Dependency between V1, V2 and common code is something like below
> > 
> > platform and PCI can co-exist in the kernel, there is no reason to
> > worry about them co-existing in the same driver other than loaded code
> > size, which doesn't seem like a big deal here.
> 
> 
> Ok. I take your point. If we have an options then we would rather prefer to
> reduce the size as well other than converting it to a single .ko.

Generally modules should be reasonable, in this case the hns RDMA
driver looks to be around maybe 100k, which is not really big enough to
be worth splitting IMHO.
> 
> > About the only thing that might give me pause is that v2 depends on a
> > different ethernet module than v1.. But that depends alot on size too,
> > there is no harm to load a useless ethernet module if it is not large.
> 
> Yes, you are right. That is another concern. It would be very messy
> to load HNS & HNS3 Ethernet driver together when we know they will not
> be used and have big differences in their hardware. Also, HNS3 Ethernet
> driver is big in size.
> 
> As such,
>            V1 RoCE ---> HNS Ethernet Driver
>            V2 RoCE ---> HNS3 Ethernet Driver

This is a reasonable explanation

Jason
