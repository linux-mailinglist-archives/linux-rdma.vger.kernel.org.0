Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75F106696
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKVGk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 01:40:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfKVGk5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 01:40:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97D993C022C9085C666F;
        Fri, 22 Nov 2019 14:40:55 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 14:40:49 +0800
Subject: Re: [PATCH rdma-core 2/7] libhns: Optimize bind_mw for fixing null
 pointer access
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
 <1574299169-31457-3-git-send-email-liweihang@hisilicon.com>
 <678F3D1BB717D949B966B68EAEB446ED300CC8B9@dggemm526-mbx.china.huawei.com>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <2564c679-8df9-6fec-487f-b3d614dca5a4@hisilicon.com>
Date:   Fri, 22 Nov 2019 14:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED300CC8B9@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/22 11:02, Zengtao (B) wrote:
>> -----Original Message-----
>> From: linux-rdma-owner@vger.kernel.org
>> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Weihang Li
>> Sent: Thursday, November 21, 2019 9:19 AM
>> To: jgg@ziepe.ca; leon@kernel.org
>> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Linuxarm
>> Subject: [PATCH rdma-core 2/7] libhns: Optimize bind_mw for fixing null
>> pointer access
>>
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> The argument checking flow in hns_roce_u_bind_mw() will leads to access
>> on
>> a null address when the mr is not initialized in mw_bind.
>>
>> Fixes: 47eff6e8624d ("libhns: Adjust the order of parameter checking")
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>> ---
>>  providers/hns/hns_roce_u_verbs.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/providers/hns/hns_roce_u_verbs.c
>> b/providers/hns/hns_roce_u_verbs.c
>> index bd5060d..0acfd9a 100644
>> --- a/providers/hns/hns_roce_u_verbs.c
>> +++ b/providers/hns/hns_roce_u_verbs.c
>> @@ -186,7 +186,10 @@ int hns_roce_u_bind_mw(struct ibv_qp *qp,
>> struct ibv_mw *mw,
>>  	if (!bind_info->mr && bind_info->length)
>>  		return EINVAL;
>>
>> -	if ((mw->pd != qp->pd) || (mw->pd != bind_info->mr->pd))
>> +	if (mw->pd != qp->pd)
>> +		return EINVAL;
>> +
>> +	if (bind_info->mr && (mw->pd != bind_info->mr->pd))
>>  		return EINVAL;
>>
> Errno should also be set properly in this function, please refer to:
> http://man7.org/linux/man-pages/man3/ibv_bind_mw.3.html
> 

Hi Zengtao,

Do you mean that all these conditions should return errno different
with each other?

IMHO, EINVAL is OK here, because all these returns is caused by "Invalid
Argument"

Thank you
Weihang


>>  	if (mw->type != IBV_MW_TYPE_1)
>> --
>> 2.8.1
> 
> 
> .
> 

