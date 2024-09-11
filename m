Return-Path: <linux-rdma+bounces-4880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1699752A3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 14:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D1BB2999B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CE187336;
	Wed, 11 Sep 2024 12:38:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92E185B4C;
	Wed, 11 Sep 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058323; cv=none; b=qxCdaC0N9QQkx7inXaKFcnmpA3MnS5y7fbBj6hEqLlwZMveNXknBFT4Prpp1/PIaHZDPlw/O2rLym8D79HR1orpZpxkgLZBg/F/hqQG2InHJZpCM/ScqaBOwAoARli1WobDdzLVTrDboTEpPaInHYD8Cavs22iXbzwCthtfsKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058323; c=relaxed/simple;
	bh=hpZscvYNtOfhk9PiPZCJ8VHW132F3mGpgJjhXSuER2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fo7w+0rFMFDhmxFCyWfqo+HlC2UdCsLEzZex91MN05keB0HnTnW9vgKxRg0QNBjRmK05/VR4PeVn7Y6H1VNVvi0/4KQrWk4bWcEtgdzZA1J5T6WY0atIPSCBIA053U1qqolJdOPe8CsPKbvgrPZr5T+oSTNKkxlrcsmFFgXkYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3g8b1qwxz1j8SB;
	Wed, 11 Sep 2024 20:38:07 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DDCD1401F0;
	Wed, 11 Sep 2024 20:38:36 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 20:38:35 +0800
Message-ID: <d8015dc6-c65c-2eed-0ffe-0c35a4cd0b2a@hisilicon.com>
Date: Wed, 11 Sep 2024 20:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
 <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
 <20240911102018.GF4026@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240911102018.GF4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/11 18:20, Leon Romanovsky wrote:
> On Mon, Sep 09, 2024 at 04:41:00PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/9/7 20:12, Jason Gunthorpe wrote:
>>> On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:
>>>
>>>> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>>>>  	ucontext = ib_uverbs_get_ucontext_file(file);
>>>>  	if (IS_ERR(ucontext)) {
>>>>  		ret = PTR_ERR(ucontext);
>>>> -		goto out;
>>>> +		goto out_srcu;
>>>>  	}
>>>> +
>>>> +	mutex_lock(&file->disassociation_lock);
>>>> +	if (file->disassociated) {
>>>> +		ret = -EPERM;
>>>> +		goto out_mutex;
>>>> +	}
>>>
>>> What sets disassociated back to false once the driver reset is
>>> completed?
>>>
>>> I think you should probably drop this and instead add a lock and test
>>> inside the driver within its mmap op. While reset is ongoing fail all
>>> new mmaps.
>>>
>>
>> disassociated won't be set back to false. This is to stop new mmaps on
>> this ucontext even after reset is completed, because during hns reset,
>> all resources will be destroyed, and the ucontexts will become unavailable.
> 
> ucontext is SW object and not HW object, why will it become unavailable?
> 

Once hns device is reset, we don't allow any doorbell until driver's
re-initialization is completed. Not only all existing mmaps on ucontexts
will be zapped, no more new mmaps are allowed either.

This actually makes ucontexts unavailable since userspace cannot access
HW with them any more. Users will have to destroy the old ucontext and
allocate a new one after driver's re-initialization is completed.

Junxian

> Thanks

