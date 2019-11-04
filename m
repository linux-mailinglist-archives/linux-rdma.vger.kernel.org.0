Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8BED7C6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 03:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfKDCmM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Nov 2019 21:42:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbfKDCmM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 3 Nov 2019 21:42:12 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59F1D6C87D8B616D9750;
        Mon,  4 Nov 2019 10:42:10 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 10:42:01 +0800
Subject: Re: [PATCH rdma-core] libhns: Use syslog for debugging while no print
 by default
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@ziepe.ca>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1572574425-41927-1-git-send-email-liweihang@hisilicon.com>
 <20191101094444.GF8713@unreal>
 <c38ec00b-2d39-afe4-cbd8-c6d1f9c315fd@hisilicon.com>
 <20191102094713.GH8713@unreal>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <cc56f0b4-345c-9694-6a6a-893b1d77592d@hisilicon.com>
Date:   Mon, 4 Nov 2019 10:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191102094713.GH8713@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/2 17:47, Leon Romanovsky wrote:
> On Sat, Nov 02, 2019 at 10:37:50AM +0800, Weihang Li wrote:
>>
>>
>> On 2019/11/1 17:44, Leon Romanovsky wrote:
>>> On Fri, Nov 01, 2019 at 10:13:45AM +0800, Weihang Li wrote:
>>>> From: Lang Cheng <chenglang@huawei.com>
>>>>
>>>> There should be no fprintf/printf in libraries by default unless
>>>> debugging. So replace all fprintf/printf in libhns with a macro that is
>>>> controlled by HNS_ROCE_DEBUG.
>>>> This patch also standardizes all printtings to maintain a uniform style.
>>>>
>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>>>> ---
>>>>  providers/hns/hns_roce_u.c       | 12 +++++++-----
>>>>  providers/hns/hns_roce_u.h       | 13 +++++++++++--
>>>>  providers/hns/hns_roce_u_hw_v1.c | 28 ++++++++++++++--------------
>>>>  providers/hns/hns_roce_u_hw_v2.c | 18 +++++++++---------
>>>>  providers/hns/hns_roce_u_verbs.c | 36 ++++++++++++++++++------------------
>>>>  5 files changed, 59 insertions(+), 48 deletions(-)
>>>
>>> Thank you for pointing our attention that there are printf() in the library code.
>>> Yes, to removal all fprintf/printf.
>>> No, to introducing not-unified way to see debug messages.
>>> Any solution should be applicable to all providers at least.
>>>
>>> Thanks
>>>
>>> .
>>
>> Hi Leon,
>> Thanks for your advice, I will use debug file for printings like other providers and send a new PR.
> 
> The solution shouldn't be copy/paste of other provides, but unified approach to see debug messages
> from rdma-core.
> 
> Thanks
> 

I see, thank you.

>>
>> Weihang
>>
>>
>>
> 
> .
> 

