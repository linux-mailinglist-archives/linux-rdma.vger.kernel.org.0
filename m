Return-Path: <linux-rdma+bounces-9186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A25A7E0C2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E913166366
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6751C701E;
	Mon,  7 Apr 2025 14:09:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5E1C5F29
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034969; cv=none; b=j867MXX3Qob2bTgMnQGrDDjtdFQ5rd3jWF+MsEGbzBx67uQeaoHXqAytoWVg9qiMZ+QSZqX0RRL4ubML9FDNUuZU53YZ6IVAk2LD3z6yVP8yF79VMLnQASkqs99mDxWmEUJ5kVn+GwO6WyWBuVyefBlry48sn0qzHnDqC23fQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034969; c=relaxed/simple;
	bh=xfAnh6GJVrcK0tomJ1hhRt0R4l4N+rAkPYDLdW/6usM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rqoACr8TvqvI0t1W0n6dkBlkWAEl6NlLXJRP/JfpNibUZ6DUWLZiH41lDmGcZFmzLtz9ojp4UWwFwa9rQvtJq8ZmrAvGM/FDv6E5/mR3Jrf1Uwy2AdVARv/QsEXRWczdd5H+3MP57kI8JFF50Axz0+HUM3PQaotBVd2iGS/TnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZWVsX1TCDz2CddC;
	Mon,  7 Apr 2025 21:48:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E957180042;
	Mon,  7 Apr 2025 21:51:38 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 21:51:38 +0800
Message-ID: <a7a68e5d-7648-d342-8b0f-2f1c55e9ea73@hisilicon.com>
Date: Mon, 7 Apr 2025 21:51:37 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
 <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
 <20250401163926.GA325474@nvidia.com>
 <bd0c0fa5-7579-8767-8c18-73fd5459de10@hisilicon.com>
 <20250404132757.GA1336818@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250404132757.GA1336818@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/4/4 21:27, Jason Gunthorpe wrote:
> On Wed, Apr 02, 2025 at 12:05:36PM +0800, Junxian Huang wrote:
>>
>>
>> On 2025/4/2 0:39, Jason Gunthorpe wrote:
>>> On Thu, Mar 27, 2025 at 07:47:24PM +0800, Junxian Huang wrote:
>>>> @@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>>>>  		if (ret)
>>>>  			return ret;
>>>>  	}
>>>> -	dma_set_max_seg_size(dev, UINT_MAX);
>>>> +	dma_set_max_seg_size(dev, SZ_2G);
>>>
>>> Are you sure? What do you think this does in the RDMA stack?
>>>
>>
>> This is the maximum DMA segment size when mapping ULP's scatter/gather
>> list to DMA address, right?
> 
> Yes, but only for ib_sge
> 
> But I think there are other possible problems if your HW cannot
> implement the full ib_sge :\

Why? According to IB spec, the maximum RDMA messgae size is 2GB,
so IMHO supporting ib_sge with DMA size larger than 2GB doesn't
seem to have much practical meaning.

Junxian

> 
> Jason

