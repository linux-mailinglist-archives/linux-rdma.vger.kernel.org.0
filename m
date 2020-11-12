Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E82B03B6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 12:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgKLLUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 12 Nov 2020 06:20:23 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4094 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKLLUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 06:20:15 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CWzfF46gPzXlrk;
        Thu, 12 Nov 2020 19:20:05 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 12 Nov 2020 19:20:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 12 Nov 2020 19:20:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Thu, 12 Nov 2020 19:20:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN for
 bank load balance
Thread-Topic: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Thread-Index: AQHWjceX3aRvAeQKjEuzXmMmmBepcA==
Date:   Thu, 12 Nov 2020 11:20:12 +0000
Message-ID: <4199dbabf478450fa4e2e6aec6b7b776@huawei.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
 <20200918142525.GA306144@nvidia.com>
 <115588ae632747f29e977f6abf0a5733@huawei.com>
 <20201106133707.GV2620339@nvidia.com>
 <c33b1adfea354db5b7332e8d23bd8880@huawei.com>
 <20201110174615.GQ2620339@nvidia.com>
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

On 2020/11/11 1:46, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2020 at 09:19:39AM +0000, liweihang wrote:
>> On 2020/11/6 21:37, Jason Gunthorpe wrote:
>>> On Fri, Nov 06, 2020 at 01:52:57AM +0000, liweihang wrote:
>>>
>>>> There are 8 banks and each of them has a counter which represents
>>>> how many QPs are using this bank. We first find the bank with the
>>>> smallest count, and then try to find a QPN belongs to this bank
>>>> according to the bitmap.  The ida will find an unused ID starting
>>>> from 0, I think it can't meet our needs. If we use ida here, the
>>>> code may looks like:
>>>
>>> I don't understand, why wouldn't the ida give you a free QPN in a bank
>>> directly?
>>>
>>> Jason
>>>
>>
>> Hi Jason,
>>
>> Here is the QPN that belongs to each bank:
>>
>> QPN on bank0：0, 8, 16, 24 ... <lower three bits is 0>
>> QPN on bank1: 1, 9, 17, 25 ... <lower three bits is 1>
>> QPN on bank2: 2, 10, 18, 26 ... <lower three bits is 2>
>> ...
>> QPN on bank6: 6, 14, 22, 30 ... <lower three bits is 6>
>> QPN on bank7: 7, 15, 23, 31 ... <lower three bits is 7>
>>
>> If bank 6 is the one with the lowest load, then we need to find a
>> valid QPN belongs to bank6, that means, the lower 3 bits of QPN is
>> 6 and it hasn't been used.
>> We can't find out a way to use ida in this situation because the
>> QPNs of each bank are discontinuous.
> 
> Each bank has an IDA, you allocate from the IDA then shift left and or
> in the bank number
> 
> Jason
> 

Thanks for your advice, we will achieve it and do some tests.

Weihang
