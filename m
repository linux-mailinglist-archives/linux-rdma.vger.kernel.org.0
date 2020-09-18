Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6A26F4AA
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRDXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 23:23:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgIRDXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 23:23:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65EED8DBBF3B60304858;
        Fri, 18 Sep 2020 11:23:22 +0800 (CST)
Received: from [10.174.177.116] (10.174.177.116) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 11:23:19 +0800
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal> <20200917123806.GA114613@nvidia.com>
 <20200917170511.GI869610@unreal> <20200917172451.GK8409@ziepe.ca>
 <20200917173346.GK869610@unreal>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <59dfb43f-04a7-b02a-1619-81d92ca69278@huawei.com>
Date:   Fri, 18 Sep 2020 11:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200917173346.GK869610@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.116]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/18 1:33, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 02:24:51PM -0300, Jason Gunthorpe wrote:
>> On Thu, Sep 17, 2020 at 08:05:11PM +0300, Leon Romanovsky wrote:
>>> On Thu, Sep 17, 2020 at 09:38:06AM -0300, Jason Gunthorpe wrote:
>>>> On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
>>>>> On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
>>>>>> sizeof() when applied to a pointer typed expression should give the
>>>>>> size of the pointed data, even if the data is a pointer.
>>>>>>
>>>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>> Needs a fixes line
>>>>
>>>>>>  	if (!cnts->names)
>>>>>>  		return -ENOMEM;
>>>>>>
>>>>>>  	cnts->offsets = kcalloc(num_counters,
>>>>>> -				sizeof(cnts->offsets), GFP_KERNEL);
>>>>>> +				sizeof(*cnts->offsets), GFP_KERNEL);
>>>>> This is not.
>>>> Why not?
>>> cnts->offsets is array of pointers that we will set later.
>>> The "sizeof(*cnts->offsets)" will return the size of size_t, while we
>>> need to get "size_t *".
>> Then why isn't a pointer to size **?
>>
>> Something is rotten here
> No problem, I'll check.
I think cnts->offsets is an array pointer whose element is size_t rathen than pointer,
so the patch description does not correspond.
And I think it should be modified to sizeof(*cnts->offsets) with other description.
>
>> Jason
> .
>

