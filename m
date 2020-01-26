Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2014989B
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 04:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAZDnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 22:43:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbgAZDnL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 22:43:11 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D63A14F71DFAEED73DB5;
        Sun, 26 Jan 2020 11:43:07 +0800 (CST)
Received: from [127.0.0.1] (10.45.216.243) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sun, 26 Jan 2020
 11:42:58 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
 <20200116195118.GG10759@ziepe.ca>
 <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
 <20200123225447.GA15167@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <e601dd32-14a2-d201-1253-71638f143b06@huawei.com>
Date:   Sun, 26 Jan 2020 11:42:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123225447.GA15167@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.216.243]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/24 6:54, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2020 at 04:54:55PM +0800, Weihang Li wrote:
>>
>>
>> On 2020/1/17 3:51, Jason Gunthorpe wrote:
>>>>> What happens to your userspace if it runs on an old kernel and tries
>>>>> to use extended atomic?
>>>>>
>>>>> Jason
>>>>>
>>>> Hi Jason,
>>>>
>>>> If the hns userspace runs with old kernel, the hardware will report a asynchronous
>>>> event for the extended atomic operation and modify the qp to error state because
>>>> the enable bit in this qp's context hasn't been set.
>>>>
>>>> The driver will print like this:
>>>>
>>>> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
>>>> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!
>>> Ideally the provider will not set
>>> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
>>> support..
>>>
>>> I've applied this patch, but I feel like you may need a followup to
>>> fix the capability reporting?
>>>
>>> Jason
>>
>> Hi Jason,
>>
>> Thank for your suggestions.
>>
>> But I'm confuse about the relationship between "PCI ATOMIC" in this macro
>> and atomic operations in RDMA.
>>
>> I found the related series on patchwork:
>> https://patchwork.kernel.org/cover/10782873/
> 
> I may have got the wrong capability bit here, I'm not sure where the
> capability bits for extended atomics are actually
> 
> Jason

Hi Jason,

Thank you anyway. There seems no capability bit for extended atomic
currently. We will try to add one.

Weihang

> 

