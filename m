Return-Path: <linux-rdma+bounces-4819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0B97124C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FCC1C22997
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6C11B14FC;
	Mon,  9 Sep 2024 08:41:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56261B1422;
	Mon,  9 Sep 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871268; cv=none; b=VqT8N7bbcb/RBAnXcRZ+UgQMcYki8hxZndvi2ILb2yCK25gU4VwuRv4mpmZg6M/c0S8SCHC8sPLR7oYMD6G6YbcgLfk9qbw6DWs3q9r0T/mav3Lfy4fUSN8J771s49o3mKynqeYt5rvlXJZ8oOIc+7vSULBL3Fdkjri6od1ZodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871268; c=relaxed/simple;
	bh=fWyICjDd1PoFRPTRlpA/ItjmGw253USiJyPAJ22M/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ntFMiNvFWwNpiNlNIBXX5dH0EBWf485Z471dpFBP8ktGeG/HGrJ66EdzyjXGfDbrRd8DAs0QhFtjr8PodAe8wkFwRFScQdc3Ul5cy9CyDpyYpf7s85EerwtcULdzll5Txyh9tJSzpbPbvCfrAHnvm0pe0/JW9F1IqaifeJ2GPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X2Kyk0wrHz1P9Nh;
	Mon,  9 Sep 2024 16:39:58 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id F2F571402CF;
	Mon,  9 Sep 2024 16:41:01 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 16:41:01 +0800
Message-ID: <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
Date: Mon, 9 Sep 2024 16:41:00 +0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <ZtxDF7EMY13tYny2@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/7 20:12, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:
> 
>> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>>  	ucontext = ib_uverbs_get_ucontext_file(file);
>>  	if (IS_ERR(ucontext)) {
>>  		ret = PTR_ERR(ucontext);
>> -		goto out;
>> +		goto out_srcu;
>>  	}
>> +
>> +	mutex_lock(&file->disassociation_lock);
>> +	if (file->disassociated) {
>> +		ret = -EPERM;
>> +		goto out_mutex;
>> +	}
> 
> What sets disassociated back to false once the driver reset is
> completed?
> 
> I think you should probably drop this and instead add a lock and test
> inside the driver within its mmap op. While reset is ongoing fail all
> new mmaps.
> 

disassociated won't be set back to false. This is to stop new mmaps on
this ucontext even after reset is completed, because during hns reset,
all resources will be destroyed, and the ucontexts will become unavailable.

But of course, other drivers may handle this case differently from hns, so
I will remove disassociated here and put it in hns driver.

>>  	/*
>>  	 * Disassociation already completed, the VMA should already be zapped.
>>  	 */
>> -	if (!ufile->ucontext)
>> +	if (!ufile->ucontext || ufile->disassociated)
>>  		goto out_unlock;
> 
> Is this needed? It protects agains fork, but since the driver is still
> present I wonder if it is OK
> 

Will remove it too.

>> @@ -822,6 +837,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>>  	struct rdma_umap_priv *priv, *next_priv;
>>  
>>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
>> +	mutex_lock(&ufile->disassociation_lock);
>> +	ufile->disassociated = true;
> 
> I think this doesn't need the hw_destroy_rwsem anymore since you are
> using this new disassociation_lock instead. It doesn't make alot of
> sense to hold the hw_destroy_rwsem for read here, it was ment to be
> held for write.
> 

Then it seems we should remove the lockdep_assert_held() here?

Junxian

> Jason

