Return-Path: <linux-rdma+bounces-4891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE4975E51
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 03:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700171C2182C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FC6FBF;
	Thu, 12 Sep 2024 01:04:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9332F30;
	Thu, 12 Sep 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103095; cv=none; b=AdTLFCRBYlh1iizH81d8YTMGHUCp8ZJ7jjJudO+0Svo1qsv+nIc80wdbzu7xd9SYAczZzcYxwS2HLpMuS7FQNZZZGGOuxRyGNLp6prBQXbpAtFn6gYrByUlMguxYbJJF2ISRy0/ZObL0O6JXbGtALO3jb/O/roDGGvWQb2mjF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103095; c=relaxed/simple;
	bh=zVQn18GO5cJp5Wo1E0VvFtuCOv5EkeLUsLXy8xhctxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U8kuE6a7I2qLUlZ2YN18fd22oB8xNsv5chhIJuvGvBG9mJ7UXram5A/o8h4kMHnZv6r0jPKvfU8hCFktabxzNtWTLGk2VAX8O23L63gl3SFE7qg5VclmFe4dTPTSzPAwsx0TjgeOhzVEMvQroftgGkyAoLd0OYuBTk+emd55WzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X3zgg05T5zfc5q;
	Thu, 12 Sep 2024 09:02:39 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D169F1403D1;
	Thu, 12 Sep 2024 09:04:49 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 09:04:49 +0800
Message-ID: <0a5bc370-a51a-22ac-a000-cf8635fbe700@hisilicon.com>
Date: Thu, 12 Sep 2024 09:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Fix cpu stuck caused by printings
 during reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-4-huangjunxian6@hisilicon.com>
 <20240910130946.GA4026@unreal>
 <4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com>
 <20240911132517.GH4026@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240911132517.GH4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/11 21:25, Leon Romanovsky wrote:
> On Wed, Sep 11, 2024 at 09:34:19AM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/9/10 21:09, Leon Romanovsky wrote:
>>> On Fri, Sep 06, 2024 at 05:34:38PM +0800, Junxian Huang wrote:
>>>> From: wenglianfa <wenglianfa@huawei.com>
>>>>
>>>> During reset, cmd to destroy resources such as qp, cq, and mr may
>>>> fail, and error logs will be printed. When a large number of
>>>> resources are destroyed, there will be lots of printings, and it
>>>> may lead to a cpu stuck. Replace the printing functions in these
>>>> paths with the ratelimited version.
>>>
>>> At lease some of them if not most should be deleted.
>>>
>>
>> Hi Leon,I wonder if there is a clear standard about whether printing
>> can be added?
> 
> I don't think so, but there are some guidelines that can help you to do it:
> 1. Don't print error messages in the fast path.
> 2. Don't print error messages if other function down in the stack already
>    printed it.
> 3. Don't print error messages if it is possible to trigger them from
> unprivileged user.
> ...
> 

Thanks

>>
>> Thanks,
>> Junxian
>>
>>> Thanks

