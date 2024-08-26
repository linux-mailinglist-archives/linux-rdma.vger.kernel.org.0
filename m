Return-Path: <linux-rdma+bounces-4567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639D95F2CD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A3B286F29
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084317BEC7;
	Mon, 26 Aug 2024 13:21:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0A17C98A;
	Mon, 26 Aug 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678490; cv=none; b=KnMz99mHCVpgXPSDhBm3XdKuVZVf3FoDOzmJMKPij59ItnrIkh1HfrPo9hKVxbNBqXHjRJT85fNq/tPe70P4Q/j6vsCLosD3tH3OmYOKdATXCZtBRPax+fT64z9+SeAeWmwEaGxzKGUWY5fUQ9Y92OZahCX3FoXF3KBR1DTTJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678490; c=relaxed/simple;
	bh=Bqmj0LWAu7nxKIyNnrmh16NBDF6e9R1urZjvixULDF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YoaISBQdFQFxnkkA4HnrB3457XU73rf/T4oAITFGkyN/357fsMdjq002JewRm6/IPes8TqqJWekqZq/iCvW2i/eQLaEQN/JD9VaKueIreSM5VFLuN8u6n594I79kjMV/Sa7l2QcRPAv0YktJPr0D9pzwmJBLO+gAoc0tD5B6jWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wsrsm1cJ1z2Cnbw;
	Mon, 26 Aug 2024 21:21:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 185221A016C;
	Mon, 26 Aug 2024 21:21:25 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 21:21:24 +0800
Message-ID: <5d93095a-06f4-53d8-e92b-3a21e7667975@hisilicon.com>
Date: Mon, 26 Aug 2024 21:21:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next 1/3] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
 <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
 <20240823152501.GB2342875@nvidia.com>
 <29b2b4a5-7cdb-4e08-3503-02e4d1123a66@hisilicon.com>
 <20240826131635.GJ3773488@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240826131635.GJ3773488@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/8/26 21:16, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2024 at 09:12:33PM +0800, Junxian Huang wrote:
>  
>> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
>> index 821d93c8f712..05b589aad5ef 100644
>> --- a/drivers/infiniband/core/uverbs.h
>> +++ b/drivers/infiniband/core/uverbs.h
>> @@ -160,6 +160,9 @@ struct ib_uverbs_file {
>>         struct page *disassociate_page;
>>
>>         struct xarray           idr;
>> +
>> +       struct mutex disassociation_lock;
>> +       bool disassociated;
>>  };
>>
>>  struct ib_uverbs_event {
>> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
>> index 6b4d5a660a2f..6503f9a23211 100644
>> --- a/drivers/infiniband/core/uverbs_main.c
>> +++ b/drivers/infiniband/core/uverbs_main.c
>> @@ -722,12 +722,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>>                 return;
>>
>>         /* We are racing with disassociation */
>> -       if (!down_read_trylock(&ufile->hw_destroy_rwsem))
>> +       if (!mutex_trylock(&ufile->disassociation_lock))
>>                 goto out_zap;
> 
> Nonon, don't touch this stuff! It is fine as is
> 
> The extra lock should be in the mmap zap functions only
> 
> Jason

Okay, I got it. Thanks

Junxian

