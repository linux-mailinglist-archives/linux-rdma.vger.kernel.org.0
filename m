Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A284C1951B9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 08:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgC0HJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 27 Mar 2020 03:09:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbgC0HJR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Mar 2020 03:09:17 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 1074582CB4490420B5C4;
        Fri, 27 Mar 2020 15:09:10 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 27 Mar 2020 15:09:09 +0800
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.252]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Fri, 27 Mar 2020 15:09:02 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 04/10] RDMA/hns: Optimize
 hns_roce_alloc_vf_resource()
Thread-Topic: [PATCH v2 for-next 04/10] RDMA/hns: Optimize
 hns_roce_alloc_vf_resource()
Thread-Index: AQHV/meJCyHjaGwIp0CEti43/V/n0A==
Date:   Fri, 27 Mar 2020 07:09:02 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022B650A@DGGEML502-MBS.china.huawei.com>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
 <1584674622-52773-5-git-send-email-liweihang@huawei.com>
 <20200326195135.GA27277@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/27 3:51, Jason Gunthorpe wrote:
> On Fri, Mar 20, 2020 at 11:23:36AM +0800, Weihang Li wrote:
> 
>> @@ -2028,6 +2002,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>>  	if (ret)
>>  		set_default_caps(hr_dev);
>>  
>> +	ret = hns_roce_alloc_vf_resource(hr_dev);
>> +	if (ret) {
>> +		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
>> +			ret);
>> +		return ret;
>> +	}
> 
> It is unfortunate these have to remain as dev_err()
> 
> I've thought about setting the name during ib_alloc_dev, which would
> avoid this, what do you think?
> 
> Jason
> 

Hi Jason,

Thanks for your comments. I agree with you and make a simple test by just
moving assign_name() into _ib_alloc_device(), and ibdev_*() works fine
anywhere in hns. But I'm not sure if there are any side effects.

I noticed that the code about name assignment is implemented by you, could
you please explain why put assign_name() in ib_register_device() rather than
ib_alloc_device()?

Thanks
Weihang



