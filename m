Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4985F3AD8A5
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jun 2021 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhFSIj0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 19 Jun 2021 04:39:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8280 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhFSIj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Jun 2021 04:39:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G6TYM4WSPz1BNqG;
        Sat, 19 Jun 2021 16:32:07 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 19 Jun 2021 16:37:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 19 Jun 2021 16:37:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Sat, 19 Jun 2021 16:37:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, hhh ching <chenglang7@gmail.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about
 hr_reg_write()
Thread-Topic: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about
 hr_reg_write()
Thread-Index: AQHXZCmd+gx7WuGX9USxRlbj85Fxsg==
Date:   Sat, 19 Jun 2021 08:37:12 +0000
Message-ID: <2de4153f7b704e398315de98a709183c@huawei.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
 <1624010765-1029-2-git-send-email-liweihang@huawei.com>
 <20210618120159.GC1002214@nvidia.com>
 <CAEc5TmJTfaSqPgk7CWgD1R9Oqddkg7XEJSHJF0A=8EFJtXcYLQ@mail.gmail.com>
 <20210618161038.GH1002214@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/19 0:10, Jason Gunthorpe wrote:
> On Fri, Jun 18, 2021 at 11:22:46PM +0800, hhh ching wrote:
>> Jason Gunthorpe <jgg@nvidia.com> 于2021年6月18日周五 下午8:49写道：
>>>
>>> On Fri, Jun 18, 2021 at 06:05:58PM +0800, Weihang Li wrote:
>>>> Fix complains from sparse about "dubious: x & !y" when calling
>>>> hr_reg_write(ctx, field, !!val) by using "val ? 1 : 0" instead of "!!val".
>>>>
>>>> Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fields")
>>>> Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC")
>>>> Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++-------
>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> index fbc45b9..6452ccc 100644
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> @@ -3013,15 +3013,15 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
>>>>       hr_reg_enable(mpt_entry, MPT_L_INV_EN);
>>>>
>>>>       hr_reg_write(mpt_entry, MPT_BIND_EN,
>>>> -                  !!(mr->access & IB_ACCESS_MW_BIND));
>>>> +                  mr->access & IB_ACCESS_MW_BIND ? 1 : 0);
>>>
>>> Err, I'm still confused where the sparse warning is coming from
>>
>> Hi, Jason, i found some code in sparse/evaluate.c:
>> const unsigned left_not = expr->left->type == EXPR_PREOP &&
>> expr->left->op == '!';
>> const unsigned right_not = expr->right->type == EXPR_PREOP &&
>> expr->right->op == '!';
>> if ((op == '&' || op == '|') && (left_not || right_not))
>>         warning(expr->pos, "dubious: %sx %c %sy",
>>
>> I guess the "dubious" is,  if somebody use "&" or "|",  maybe he want
>> to bitwise operate a number instead of a bool.
> 
> Oh I see, yes, that does many some sense actually
> 
>>> A hr_reg_write_bool() would be cleaner?
> 
> Which makes me further think this is the right direction
> 
> Jason
> 

I see, thanks.

Weihang
