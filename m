Return-Path: <linux-rdma+bounces-4565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F695F280
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 15:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7301C21B64
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DFE17BEC3;
	Mon, 26 Aug 2024 13:12:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9021E871;
	Mon, 26 Aug 2024 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677961; cv=none; b=D/ByZlZ6yE3o5VdUUgnh4FZLfpUpMlZs0nO7NCZ4W0/8Pzuditn0ryu0LtwBUHRj7aml/WJFKlW0SxI/Yrg5hSg6JOl7K9OP4Pb3xlNvOTErR3NpeaxXLoIhtORIJwJq5O8ygiuvUpfMCbZFGrPLbzkvRMt19PFB01Xv7rwCiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677961; c=relaxed/simple;
	bh=1WU1aRbWnpYmm4HjOwhVK+bf9Bpias9xEcOwZh+DoPQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=HHKyoTL2xYJ734MyhF5QXQDMFqAhvUHWVfMsg2BU6utK6iiozrd17kzXehJhkngItv4106nonHaQGV5nzVEI1pElnTK6uiH1GO4zIhwbpJZQa1tn/u3M5TksX6toGT0gWFS9aINzy7UkAZDoufhqmXz3B6Ngobhyi8yzl3WsV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WsrdM3bBHzfZ39;
	Mon, 26 Aug 2024 21:10:31 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7613A1800A7;
	Mon, 26 Aug 2024 21:12:34 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 21:12:33 +0800
Message-ID: <29b2b4a5-7cdb-4e08-3503-02e4d1123a66@hisilicon.com>
Date: Mon, 26 Aug 2024 21:12:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From: Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next 1/3] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
 <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
 <20240823152501.GB2342875@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240823152501.GB2342875@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/8/23 23:25, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 08:56:38PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Provide a new api rdma_user_mmap_disassociate() for drivers to
>> disassociate mmap pages for ucontext.
>>
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/core/uverbs_main.c | 21 +++++++++++++++++++++
>>  include/rdma/ib_verbs.h               |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
>> index bc099287de9a..00dab5bfb78c 100644
>> --- a/drivers/infiniband/core/uverbs_main.c
>> +++ b/drivers/infiniband/core/uverbs_main.c
>> @@ -880,6 +880,27 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>>  	}
>>  }
>>  
>> +/**
>> + * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
>> + *
>> + * @ucontext: associated user context.
>> + *
>> + * This function should be called by drivers that need to disable mmap for
>> + * some ucontexts.
>> + */
>> +void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
>> +{
>> +	struct ib_uverbs_file *ufile = ucontext->ufile;
>> +
>> +	/* Racing with uverbs_destroy_ufile_hw */
>> +	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
>> +		return;
> 
> This is not quite right here, in the other cases lock failure is
> aborting an operation that is about to start, in this case we are must
> ensure the zap completed otherwise we break the contract of no mmaps
> upon return.
> 
> So at least this needs to be a naked down_read()
> 
> But..
> 
> That lock lockdep assertion in uverbs_user_mmap_disassociate() I think
> was supposed to say the write side is held, which we can't actually
> get here.
> 
> This is because the nasty algorithm works by pulling things off the
> list, if we don't have a lock then one thread could be working on an
> item while another thread is unaware which will also break the
> contract.
> 
> You may need to add a dedicated mutex inside
> uverbs_user_mmap_disassociate() and not try to re-use
> hw_destroy_rwsem.
> 

Thanks for the reply, Jason. Based on your modification in patch #3,
we plan to change the codes like this (some init and destroy are omitted
here). We'll re-send as soon as we finish the testings.

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 821d93c8f712..05b589aad5ef 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -160,6 +160,9 @@ struct ib_uverbs_file {
        struct page *disassociate_page;

        struct xarray           idr;
+
+       struct mutex disassociation_lock;
+       bool disassociated;
 };

 struct ib_uverbs_event {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 6b4d5a660a2f..6503f9a23211 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -722,12 +722,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
                return;

        /* We are racing with disassociation */
-       if (!down_read_trylock(&ufile->hw_destroy_rwsem))
+       if (!mutex_trylock(&ufile->disassociation_lock))
                goto out_zap;
        /*
         * Disassociation already completed, the VMA should already be zapped.
         */
-       if (!ufile->ucontext)
+       if (!ufile->ucontext || ufile->disassociated)
                goto out_unlock;

        priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -735,11 +735,11 @@ static void rdma_umap_open(struct vm_area_struct *vma)
                goto out_unlock;
        rdma_umap_priv_init(priv, vma, opriv->entry);

-       up_read(&ufile->hw_destroy_rwsem);
+       mutex_unlock(&ufile->disassociation_lock);
        return;

 out_unlock:
-       up_read(&ufile->hw_destroy_rwsem);
+       mutex_unlock(&ufile->disassociation_lock);
 out_zap:
        /*
         * We can't allow the VMA to be created with the actual IO pages, that
@@ -823,6 +823,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
        struct rdma_umap_priv *priv, *next_priv;

        lockdep_assert_held(&ufile->hw_destroy_rwsem);
+       mutex_lock(&ufile->disassociation_lock);
+       ufile->disassociated = true;

        while (1) {
                struct mm_struct *mm = NULL;
@@ -848,8 +850,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
                        break;
                }
                mutex_unlock(&ufile->umap_lock);
-               if (!mm)
+               if (!mm) {
+                       mutex_unlock(&ufile->disassociation_lock);
                        return;
+               }

                /*
                 * The umap_lock is nested under mmap_lock since it used within
@@ -879,6 +883,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
                mmap_read_unlock(mm);
                mmput(mm);
        }
+
+       mutex_unlock(&ufile->disassociation_lock);
 }

 /**
@@ -897,7 +903,8 @@ void rdma_user_mmap_disassociate(struct ib_device *device)
        mutex_lock(&uverbs_dev->lists_mutex);
        list_for_each_entry(ufile, &uverbs_dev->uverbs_file_list, list) {
                down_read(&ufile->hw_destroy_rwsem);
-               uverbs_user_mmap_disassociate(ufile);
+               if (ufile->ucontext && !ufile->disassociated)
+                       uverbs_user_mmap_disassociate(ufile);
                up_read(&ufile->hw_destroy_rwsem);
        }
        mutex_unlock(&uverbs_dev->lists_mutex);


> Jason

