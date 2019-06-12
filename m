Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6461442C16
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440151AbfFLQWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 12:22:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37651 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440150AbfFLQWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 12:22:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so10722451qkl.4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d4yTfItnSljOgURU5EVlt3t03b0mj+M1X08QipOacs4=;
        b=bDaMJjvTitqo/pn6BAmxUvk7oAGRVJVbuv9Q7gMXuDHM0A0AzcgSoM0x3f/KUlvQNP
         fjZhcGrVnY+Kyq6rxUM4KZGx6egd9IUIUwFO1WiPXowmUO76RBxxhlFqa+2VupaLVshR
         hB+TbfU6iKUgEtGMNTgiA/IwtigUemvuGkDt3rcc18eP8xlhgLxGUoq5NhswTjjs+92L
         qyavYVgUoshaYRv0cnvjoT4EwcK2Z4wyBRk0pT31d4MPH3kjD8HQgR8u804jZK+/zvuD
         Cdacj5N5hDojs7gCKW+yuRBQcKCmX0yQyWcSXM1Kvqgy8exiwbdpLkm9kTo1yxF2y7G3
         +ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d4yTfItnSljOgURU5EVlt3t03b0mj+M1X08QipOacs4=;
        b=FP2fzI+S3MvT5SdXLK5gcSwyMdLytSqWN9jy3B1AIpqj2a4ZN+pYbEe4IXOuNRQ3mq
         liZKD8XJm8WA0DcclSEQZCRotVn0PL9xn7wVj9tMkBsLHy5pSTwrkwpvR2S11ckpQpAb
         r7PGnL+CiakxLXLv34ybsuECSKznjzrir+GjqEw5Jaz1p5bPzIOJCFI1cSKaZVbERMJX
         PVbLcmJIPhspS98yQMpoPs4F4+DhnPu6M8H3w1+PY9Tr5U6xM76UM1ILVy6bjGUbacyS
         JzVGAV3ODSG6JslDoRkFvg4yC1Tw8D0nHdwHJuAGKGKslWF9N2jZOIrWVkh49Ag1Eeon
         o+tA==
X-Gm-Message-State: APjAAAWMJjNfbgfaiAcs5XUCAo801iqlDFpHaU2qP7/EQl9TkPiSYYWy
        r56UtfBHWoowJthU6pJHzGCNyw==
X-Google-Smtp-Source: APXvYqxLU8GlSLGkn5d4sG+Letn0miVoAJVTpqTC7dIdLgAquBeYv50dvhSHdyJZdnji8a/R6e+a4w==
X-Received: by 2002:a37:a9c3:: with SMTP id s186mr15613530qke.190.1560356557615;
        Wed, 12 Jun 2019 09:22:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m5sm77998qke.25.2019.06.12.09.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:22:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb61E-0004PW-LW; Wed, 12 Jun 2019 13:22:36 -0300
Date:   Wed, 12 Jun 2019 13:22:36 -0300
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
Message-ID: <20190612162236.GL3876@ziepe.ca>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
 <20190612115226.GC3876@ziepe.ca>
 <443656b7965a4b319e83eb6b9557676e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <443656b7965a4b319e83eb6b9557676e@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 03:12:24PM +0000, Salil Mehta wrote:
> > From: linux-rdma-owner@vger.kernel.org
> > [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
> > Sent: Wednesday, June 12, 2019 12:52 PM
> > To: John Garry <john.garry@huawei.com>
> > Cc: Leon Romanovsky <leon@kernel.org>; wangxi (M) <wangxi11@huawei.com>;
> > linux-rdma@vger.kernel.org; dledford@redhat.com; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
> > multihop addressing
> > 
> > On Wed, Jun 12, 2019 at 09:51:59AM +0100, John Garry wrote:
> > > On 11/06/2019 06:56, Leon Romanovsky wrote:
> > > > On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
> > > > >
> > > > >
> > > > > 在 2019/6/10 21:27, Jason Gunthorpe 写道:
> > > > > > On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> > > > > >
> > > > > > > > Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> > > > > > > > hns. Please send a patch to remove all of them and respin this.
> > > > > > > >
> > > > > > > There are 2 modules in our ib driver, one is hns_roce.ko, another
> > > > > > > is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> > > > > > > this function defined in hns_roce.ko, and invoked in
> > > > > > > hns_roce_hw_v2.ko.
> 
> [...]
> 
> > > In addition to this, v1 hw is a platform device driver and depends on HNS,
> > > while v2 hw is for a PCI device and depends on PCI && HNS3. Attempts to
> > > combine into a single ko would introduce messy dependencies and ifdefs.
> > 
> > I suspect it would not be any different from how it is today. Do
> > everything the same, just have one module not three. module_init/etc
> > already take care of conditional compilation of the entire .c file via
> > Makefile
> 
> Okay. I see your point. 
> 
> As I understand, the code within v1 and v2 will almost never be required on
> the same system since they belong to different types of hardware (platform/PCI).
> Dependency between V1, V2 and common code is something like below

platform and PCI can co-exist in the kernel, there is no reason to
worry about them co-existing in the same driver other than loaded code
size, which doesn't seem like a big deal here.

About the only thing that might give me pause is that v2 depends on a
different ethernet module than v1.. But that depends alot on size too,
there is no harm to load a useless ethernet module if it is not large.

Jason
