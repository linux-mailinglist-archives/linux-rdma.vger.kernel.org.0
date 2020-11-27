Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477102C6245
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 10:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgK0JzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 27 Nov 2020 04:55:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0JzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 04:55:17 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cj92y67pFz4yvx;
        Fri, 27 Nov 2020 17:54:50 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 27 Nov 2020 17:55:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 27 Nov 2020 17:55:11 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 27 Nov 2020 17:55:11 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Thread-Topic: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Thread-Index: AQHWvAyZ1U9I9yddukaFoH2luFPjtw==
Date:   Fri, 27 Nov 2020 09:55:11 +0000
Message-ID: <35582a7f2b924a6980403f2901e7bf31@huawei.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <1605526408-6936-8-git-send-email-liweihang@huawei.com>
 <20201118191051.GL244516@ziepe.ca>
 <7a7ee7427b68488f98ebc18d5b7c4d75@huawei.com>
 <20201126192428.GA547165@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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

On 2020/11/27 3:24, Jason Gunthorpe wrote:
> On Thu, Nov 19, 2020 at 06:15:42AM +0000, liweihang wrote:
>> On 2020/11/19 3:11, Jason Gunthorpe wrote:
>>> On Mon, Nov 16, 2020 at 07:33:28PM +0800, Weihang Li wrote:
>>>> @@ -503,7 +581,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
>>>> +	if (wr->send_flags & IB_SEND_INLINE) {
>>>> +		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
>>>> +		if (ret)
>>>> +			return ret;
>>>
>>> Why are you implementing this in the kernel? No kernel ULP sets this
>>> flag?
>>
>> Sorry, I don't understand. Some kernel users may set IB_SEND_INLINE
>> when using UD, some may not, we just check this flag to decide how
>> to fill the data into UD SQ WQE here.
> 
> I mean if you 'git grep IB_SEND_INLINE' nothing uses it. 
> 
> This is all dead code.
> 
> How did you test it?
> 
> Jason
> 

Hi Jason,

We have tested it with our own tools. After running 'git grep IB_SEND_INLINE',
I found following drivers refer to this flag:

bnxt_re/cxgb4/i40iw/mlx5/ocrdma/qedr/rxe/siw

So I'm still a bit confused. Do you mean that no kernel ULP uses UD inline or
the IB_SEND_INLINE flag? Should current related codes be removed?

I also found a very old discussion about removing this flag, but there was no
futher information:

https://lists.openfabrics.org/pipermail/general/2007-August/039826.html

I will appreciate it if you can give us more detailed suggestions.

Thanks
Weihang
