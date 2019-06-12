Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD51424C7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfFLLw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 07:52:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35792 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfFLLw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 07:52:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id l128so9918666qke.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 04:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rVxt7efS5AHvg2mhczjfYrOT90Z76QMKXU0uqSLTbMw=;
        b=AHlb/p0SGFX0Ka4jmDBv675+ey5oFkC6ZL/1vJHoI8bFH9NcOgFxUXEXStscdOIb+M
         SChyjmMunyOIPRnNQLtBcsbBqbu7hV7WmM/cLo12zyFH21C7BD6hmz1WaQaXTlWMY2i7
         /47HSx2FzibYAAZCGwIFquxzwiGKHY6WnD5zHI6eYnq593futmWdi2qHBbXuj7XLwoIl
         QsnAy2dASxwoWOVPqVCCgxLgRKLVpyoGQJ5AF5iKnIiE59i06huICzq+YyecWNZvBseC
         7gnJnGjFS4x1v5ppecyDhYpRyn3WKuWDgPBb5IwKzlGQ0opYtyDuja75EfQVqHJrnISY
         wTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rVxt7efS5AHvg2mhczjfYrOT90Z76QMKXU0uqSLTbMw=;
        b=Vb0z+ZiiXwhFzaudtfmQeidqtdOjqN0l+2ZrVEgvm5R7KTPbMkcmcvhKWLGJ63/kUX
         gmbIQlyRBhldhSsQ9EM2h/46aHXpLRnv7deiDE4Enk3FImW3OZs8FB66QOW1uxrlseNm
         eCD5pWmigMAAfbLyExyubjSgJZp12GRYkfX/XpWcmW5iZ9amJnOvfBZ87eBKOWMSre4G
         XEjIA6IYy6v+tmMzVKimaiXtvC6o/5IaXORPmKa7JSqetMCqCUeCu3VclXCRFROUWdbk
         ETpK+C1F2EvFCTr8T9oJq03rMqreMw3qCSIBSeJkZZN2jAlvXWCpqtkvJ/nFhXh2eALE
         FnTA==
X-Gm-Message-State: APjAAAXUVLEMRwv8pnYJqBQWTf+CzG0uLyPq8LY17Lg9CQ0O9f4r6yUX
        wjtE3v+V6bE7mjKIxxgcmhptgw==
X-Google-Smtp-Source: APXvYqy6QrnzD7t5MmpVCk2mjN3zevxiabcamvR4ddH534+vgkzyeRWYihmg21qVRrSOVdAVORD7tQ==
X-Received: by 2002:a37:9c16:: with SMTP id f22mr65654797qke.261.1560340347444;
        Wed, 12 Jun 2019 04:52:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a139sm7932517qkb.48.2019.06.12.04.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:52:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb1nm-0002Lj-KI; Wed, 12 Jun 2019 08:52:26 -0300
Date:   Wed, 12 Jun 2019 08:52:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Garry <john.garry@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>, wangxi <wangxi11@huawei.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190612115226.GC3876@ziepe.ca>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 09:51:59AM +0100, John Garry wrote:
> On 11/06/2019 06:56, Leon Romanovsky wrote:
> > On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
> > > 
> > > 
> > > 在 2019/6/10 21:27, Jason Gunthorpe 写道:
> > > > On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> > > > 
> > > > > > Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> > > > > > hns. Please send a patch to remove all of them and respin this.
> > > > > > 
> > > > > There are 2 modules in our ib driver, one is hns_roce.ko, another
> > > > > is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> > > > > this function defined in hns_roce.ko, and invoked in
> > > > > hns_roce_hw_v2.ko.
> > > > 
> > > > seems unnecessarily complicated
> > > > 
> > > > Jason
> > > > .
> > > > 
> > > Hi,Jason,
> > > 
> > > The hns ib driver was originally designed for the hip06. When designing the
> > > driver for the new hardware hip08, in order to maximize the reuse of the
> > > existing hip06 code, the common part of the code is separated into the
> > > hns_roce.ko, and the hardware difference code is defined into hns_roce_hw_v1.ko
> > > for hip06 and hns_roce_hw_v2.ko for hip08.
> > > 
> > > The mtr code is designed as a public part in this patchset, so it is defined
> > > in hns_roce.ko. It can be used for hi16xx series hardware with mixed mutihop
> > > addressing feature. Currently, hip08 supports this feature, so it is be called
> > > in hns_roce_hw_v2.ko.
> > 
> > Combine v1 and v2 into one driver (.ko) and change initialization to
> > call v1 or v2 accordingly. The rest is handled by ib_device_ops
> > structure.
> > 
> 
> Is there a rule which says that a driver cannot export symbols? Module
> stacking is useful for more complex drivers, in that a hw-specific
> implementation may plug into common driver. This helps code reuse.

Generally we do not like to see leaf drivers be so complicated that
they need to export symbols. A multi-module driver is generally an
over engineered thing to do, few drivers would be so big for that to
make any sense.

> In addition to this, v1 hw is a platform device driver and depends on HNS,
> while v2 hw is for a PCI device and depends on PCI && HNS3. Attempts to
> combine into a single ko would introduce messy dependencies and ifdefs.

I suspect it would not be any different from how it is today. Do
everything the same, just have one module not three. module_init/etc
already take care of conditional compilation of the entire .c file via
Makefile

Jason
