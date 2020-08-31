Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0955257479
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaHqQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 31 Aug 2020 03:46:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgHaHqP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Aug 2020 03:46:15 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 900E8C2E4D9DEC1E9AD8;
        Mon, 31 Aug 2020 15:46:10 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 31 Aug 2020 15:46:10 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 15:46:10 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 15:46:10 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/4] RDMA/hns: Export hardware capability
 flags to userspace
Thread-Topic: [PATCH v2 for-next 1/4] RDMA/hns: Export hardware capability
 flags to userspace
Thread-Index: AQHWfG9NNvwDDSWCPEOkjDn9kDnjiw==
Date:   Mon, 31 Aug 2020 07:46:09 +0000
Message-ID: <22f7007f36f54bb8acec608fc19e1593@huawei.com>
References: <1597929469-22674-1-git-send-email-liweihang@huawei.com>
 <1597929469-22674-2-git-send-email-liweihang@huawei.com>
 <20200827124031.GA4023659@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/8/27 20:40, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2020 at 09:17:46PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> The libhns in userspace for HIP09 will use the hardware's capability to
>> enable some features. So export the hardware capablility flags to userspace
>> by reusing the reserved fields in structure
>> "hns_roce_ib_alloc_ucontext_resp".
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
>>  include/uapi/rdma/hns-abi.h               | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index 5907cfd..98945df 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -313,6 +313,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>>  		return -EAGAIN;
>>  
>>  	resp.qp_tab_size = hr_dev->caps.num_qps;
>> +	resp.cap_flags = (u32)hr_dev->caps.flags;
> 
> This makes all the HNS_ROCE_CAP_FLAG_* values uapi, they need to be
> moved to the uapi header too.
> 
> Or rethink this to only expose what you want to be uapi.
> 
> Jason
> 

Hi Jason,

Thanks for your comments, we will only expose the needed flag to be
uapi.

Considering that this cap_flags field is not necessary for this series,
I will drop #1 and send a new version. And the modification about
cap_flags will be sent later.

Weihang
