Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3079642A74
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408722AbfFLPMl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 12 Jun 2019 11:12:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6539 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408717AbfFLPMl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 11:12:41 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 25156102972EC90A3A0B;
        Wed, 12 Jun 2019 23:12:29 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Jun 2019 23:12:28 +0800
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 12 Jun 2019 23:12:26 +0800
Received: from lhreml702-chm.china.huawei.com ([10.201.68.197]) by
 lhreml702-chm.china.huawei.com ([10.201.68.197]) with mapi id 15.01.1713.004;
 Wed, 12 Jun 2019 16:12:24 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Garry <john.garry@huawei.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Thread-Topic: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Thread-Index: AQHVHVDZZTzLZeXBDkqmbcycKUyIGqaQ9yOAgAPd6ACAANzgAIAAN2UAgAHDe4CAADJrAIAAPXFA
Date:   Wed, 12 Jun 2019 15:12:24 +0000
Message-ID: <443656b7965a4b319e83eb6b9557676e@huawei.com>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
 <20190612115226.GC3876@ziepe.ca>
In-Reply-To: <20190612115226.GC3876@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.41]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org
> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
> Sent: Wednesday, June 12, 2019 12:52 PM
> To: John Garry <john.garry@huawei.com>
> Cc: Leon Romanovsky <leon@kernel.org>; wangxi (M) <wangxi11@huawei.com>;
> linux-rdma@vger.kernel.org; dledford@redhat.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
> multihop addressing
> 
> On Wed, Jun 12, 2019 at 09:51:59AM +0100, John Garry wrote:
> > On 11/06/2019 06:56, Leon Romanovsky wrote:
> > > On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
> > > >
> > > >
> > > > 在 2019/6/10 21:27, Jason Gunthorpe 写道:
> > > > > On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> > > > >
> > > > > > > Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> > > > > > > hns. Please send a patch to remove all of them and respin this.
> > > > > > >
> > > > > > There are 2 modules in our ib driver, one is hns_roce.ko, another
> > > > > > is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> > > > > > this function defined in hns_roce.ko, and invoked in
> > > > > > hns_roce_hw_v2.ko.

[...]

> > In addition to this, v1 hw is a platform device driver and depends on HNS,
> > while v2 hw is for a PCI device and depends on PCI && HNS3. Attempts to
> > combine into a single ko would introduce messy dependencies and ifdefs.
> 
> I suspect it would not be any different from how it is today. Do
> everything the same, just have one module not three. module_init/etc
> already take care of conditional compilation of the entire .c file via
> Makefile

Okay. I see your point. 

As I understand, the code within v1 and v2 will almost never be required on
the same system since they belong to different types of hardware (platform/PCI).
Dependency between V1, V2 and common code is something like below

         [V1]    [V2]
          |         |
          |_______|
               |
         hns_roce_xxx

Therefore, we could always make V1+[hns_roce_xxx] OR V2+[hns_roce_xxx] as
single module .ko at compile time by making them optional in Makefile.

Salil.



