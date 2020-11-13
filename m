Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4982B2B1832
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKMJZH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 13 Nov 2020 04:25:07 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgKMJZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 04:25:06 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CXY2r49FVz54Bs;
        Fri, 13 Nov 2020 17:24:52 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 13 Nov 2020 17:25:03 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 13 Nov 2020 17:25:02 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 13 Nov 2020 17:25:02 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Refactor the hns_roce_buf allocation
 flow
Thread-Topic: [PATCH for-next] RDMA/hns: Refactor the hns_roce_buf allocation
 flow
Thread-Index: AQHWrd7fVaLfqklmx06l2cOBR56mfg==
Date:   Fri, 13 Nov 2020 09:25:02 +0000
Message-ID: <f4d6bc7da0c7483c89d5a2480f7eebd3@huawei.com>
References: <1603967462-18124-1-git-send-email-liweihang@huawei.com>
 <20201112160106.GA894521@nvidia.com>
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

On 2020/11/13 0:01, Jason Gunthorpe wrote:
> On Thu, Oct 29, 2020 at 06:31:02PM +0800, Weihang Li wrote:
>>  	/* The minimum shift of the page accessed by hw is HNS_HW_PAGE_SHIFT */
>> -	buf->page_shift = max_t(int, HNS_HW_PAGE_SHIFT, page_shift);
>> +	WARN_ON(page_shift < HNS_HW_PAGE_SHIFT);
> 
> Stuff like this should be written as
> 
>   if (WARN_ON(page_shift < HNS_HW_PAGE_SHIFT))
>     return ERR_PTR(-EINVAL);
> 
> Rather than wrongly continuing on

Thank you, I will correct it.

> 
>> @@ -780,19 +769,16 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>>  		ret = 0;
>>  	} else {
>>  		mtr->umem = NULL;
>> -		mtr->kmem = kzalloc(sizeof(*mtr->kmem), GFP_KERNEL);
>> -		if (!mtr->kmem) {
>> -			ibdev_err(ibdev, "Failed to alloc kmem\n");
>> +		mtr->kmem =
>> +			hns_roce_buf_alloc(hr_dev, total_size,
>> +					   buf_attr->page_shift,
>> +					   is_direct ? HNS_ROCE_BUF_DIRECT : 0);
>> +		if (IS_ERR_OR_NULL(mtr->kmem)) {
> 
> Please do not use IS_ERR_OR_NULL
> 
> Routines should not return NULL and an error pointer, one or the other
> - or NULL needs to have special meaning and is not an error.
> 
>> +			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
>> +				  PTR_ERR(mtr->kmem));
>>  			return -ENOMEM;
> 
> Here you should return PTR_ERR((mtr->kmem)
> 

OK, I will change it to:

	if (IS_ERR(mtr->kmem)) {
		ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
			  PTR_ERR(mtr->kmem));
		return PTR_ERR(mtr->kmem);
	}


> In other places in this driver too, please check all the
> IS_ERR_OR_NULL's

Thanks for your reminder, I found some callers of IS_ERR_OR_NULL() in our
driver. I will check all of them and send another patch to fix them if
needed.

Weihang

> 
> Jason
> 

