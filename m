Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45FA2B2ADC
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Nov 2020 03:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKNCnJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 13 Nov 2020 21:43:09 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2062 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKNCnJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 21:43:09 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CY04M3CC3zVmVg;
        Sat, 14 Nov 2020 10:42:43 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 14 Nov 2020 10:43:04 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 14 Nov 2020 10:43:03 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 14 Nov 2020 10:43:04 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 7/8] RDMA/hns: Add UD support for HIP09
Thread-Topic: [PATCH for-next 7/8] RDMA/hns: Add UD support for HIP09
Thread-Index: AQHWrrGZOhShmijq8kylfddGm9m/Uw==
Date:   Sat, 14 Nov 2020 02:43:04 +0000
Message-ID: <b48bd67d080a453b941b4f7f69966876@huawei.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
 <1604057975-23388-8-git-send-email-liweihang@huawei.com>
 <20201112183532.GA964096@nvidia.com>
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

On 2020/11/13 2:35, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 07:39:34PM +0800, Weihang Li wrote:
>> HIP09 supports service type of Unreliable Datagram, add necessary process
>> to enable this feature.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 2 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 8 +++++---
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 ++-
>>  3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 9a032d0..23f8fe7 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -222,7 +222,9 @@ enum {
>>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
>> +	HNS_ROCE_CAP_FLAG_UD			= BIT(11),
> 
> Why add this flag if nothing reads it?

Hi Jason,

I checked it to set IB_USER_VERBS_CMD_CREATE_AH and IB_USER_VERBS_CMD_DESTROY_AH
in uverbs_cmd_mask which is not needed recently, I forgot to remove it in this
patch :) Will drop it.

> 
>>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
>> +
>>  };
> 
> Extra space

OK, will remove it.

> 
> 
> If I recall properly earlier chips did not have a GID table so could
> not support UD because they could not secure the AH, or something like
> that.
> 
> So, I would expect to see that only the new devices support UD, but
> I can't quite see that in this patch??

You are right. I made a mistake, I thought it's enough to add judgment of hardware
version in rdma-core to prevent the HIP08's user from using UD in userspace and I
realize it's meaningless just now...

I think I can add a check about the hardware version when creating a user's UD QP.

Thanks again for the reminder.

Weihang

> 
> Jason
> 

