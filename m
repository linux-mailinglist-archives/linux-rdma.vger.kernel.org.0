Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E126F2A8C54
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgKFBxA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 5 Nov 2020 20:53:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2426 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFBxA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 20:53:00 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CS3LY3PtBz52BD;
        Fri,  6 Nov 2020 09:52:53 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 6 Nov 2020 09:52:57 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 6 Nov 2020 09:52:57 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 6 Nov 2020 09:52:57 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN for
 bank load balance
Thread-Topic: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Thread-Index: AQHWjceX3aRvAeQKjEuzXmMmmBepcKm6oxQQ
Date:   Fri, 6 Nov 2020 01:52:57 +0000
Message-ID: <115588ae632747f29e977f6abf0a5733@huawei.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
 <20200918142525.GA306144@nvidia.com>
In-Reply-To: <20200918142525.GA306144@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: Friday, September 18, 2020 10:25 PM
> To: liweihang <liweihang@huawei.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected
> QPN/CQN for bank load balance
> 
> On Wed, Sep 09, 2020 at 05:09:23PM +0800, Weihang Li wrote:
> > From: Yangyang Li <liyangyang20@huawei.com>
> >
> > In order to improve performance by balancing the load between
> > different banks of cache, the QPC cache is desigend to choose one of 8
> > banks according to lower 3 bits of QPN, and the CQC cache uses the
> > lower 2 bits to choose one from 4 banks. The hns driver needs to count
> > the number of QP/CQ on each bank and then assigns the QP/CQ being
> > created to the bank with the minimum load first.
> >
> > Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > drivers/infiniband/hw/hns/hns_roce_alloc.c  | 46
> +++++++++++++++++++++++++++++
> >  drivers/infiniband/hw/hns/hns_roce_cq.c     | 38
> +++++++++++++++++++++++-
> >  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +++++
> >  drivers/infiniband/hw/hns/hns_roce_qp.c     | 39
> ++++++++++++++++++++++--
> >  4 files changed, 128 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c
> > b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> > index a522cb2..cbe955c 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> > @@ -36,6 +36,52 @@
> >  #include "hns_roce_device.h"
> >  #include <rdma/ib_umem.h>
> >
> > +static int get_bit(struct hns_roce_bitmap *bitmap, u8 bankid,
> > +		   u8 mod, unsigned long *obj)
> > +{
> > +	unsigned long offset_bak = bitmap->last;
> > +	bool one_circle_flag = false;
> > +
> > +	do {
> > +		*obj = find_next_zero_bit(bitmap->table, bitmap->max,
> > +					  bitmap->last);
> > +		if (*obj >= bitmap->max) {
> > +			*obj = find_first_zero_bit(bitmap->table, bitmap->max);
> > +			one_circle_flag = true;
> > +		}
> > +
> > +		bitmap->last = (*obj + 1);
> > +		if (bitmap->last == bitmap->max) {
> > +			bitmap->last = 0;
> > +			one_circle_flag = true;
> > +		}
> > +
> > +		/* Not found after a round of search */
> > +		if (bitmap->last >= offset_bak && one_circle_flag)
> > +			return -EINVAL;
> > +
> > +	} while (*obj % mod != bankid);
> > +
> > +	return 0;
> > +}
> 
> This looks like an ida, is there a reason it has to be open coded?
> 
> Jason


Hi Jason,

Thanks for your comments and we have a look at the ida interfaces.

There are 8 banks and each of them has a counter which represents how many QPs are using this
bank. We first find the bank with the smallest count, and then try to find a QPN belongs to this bank
according to the bitmap.
The ida will find an unused ID starting from 0, I think it can't meet our needs. If we use ida here,
the code may looks like:

While () {
	id = ida_alloc_range();
	if (isOK(id))
		break;

	ida_free(id);
}

We need to continuously apply for and release IDs that don't meet our requirements in the loop.

Thanks,
Weihang
