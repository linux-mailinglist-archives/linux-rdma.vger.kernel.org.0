Return-Path: <linux-rdma+bounces-4704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122679688EB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA30286A27
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC40210189;
	Mon,  2 Sep 2024 13:32:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC920FAB0;
	Mon,  2 Sep 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283939; cv=none; b=qLMI2mkfKrmJOfFhnTfbwzSuXufQy6+PKnPOeEegZ7dK552Qldwc70JchvELRRpQican42LTGLNdawK3sYHDyT4plmKNVB70FjuTc6AQoej5n3GDkRJtZuafpYrW2Xx0KEPjeinQ0JWd3re6AW9pHwEg0tQ+jNYr8+C0WPYh32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283939; c=relaxed/simple;
	bh=prQ9E383e/Ik9UQBxO3VJOUYriEzhIeQ3kZbBNRcPtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KnwUJcALmg2mFGpRR4I3TtyySLaa96DXty0ANPtxXB/7lAwmA7uaOzoAYtMC2XrUH923cEycWgAlXBIykpAj3IgPnXYKkfxmCPeNkPQ5cmuzxnw0fvf4OybYUvX7AogAXCy+Umx0duFKIulEqdKG8eDlCSmkXOAamRG07g1cCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy8mn312mz2DbhM;
	Mon,  2 Sep 2024 21:31:53 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 544261A0188;
	Mon,  2 Sep 2024 21:32:11 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 21:32:10 +0800
Message-ID: <e999d699-b764-5a58-c1ec-6f53e0e8521d@hisilicon.com>
Date: Mon, 2 Sep 2024 21:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, <jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
 <20240828064605.887519-2-huangjunxian6@hisilicon.com>
 <20240902065726.GA4026@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240902065726.GA4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/2 14:57, Leon Romanovsky wrote:
> On Wed, Aug 28, 2024 at 02:46:04PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Provide a new api rdma_user_mmap_disassociate() for drivers to
>> disassociate mmap pages for a device.
>>
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/core/uverbs.h      |  3 ++
>>  drivers/infiniband/core/uverbs_main.c | 45 +++++++++++++++++++++++++--
>>  include/rdma/ib_verbs.h               |  8 +++++
>>  3 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
>> index 821d93c8f712..0999d27cb1c9 100644
>> --- a/drivers/infiniband/core/uverbs.h
>> +++ b/drivers/infiniband/core/uverbs.h
>> @@ -160,6 +160,9 @@ struct ib_uverbs_file {
>>  	struct page *disassociate_page;
>>  
>>  	struct xarray		idr;
>> +
>> +	struct mutex disassociation_lock;
>> +	atomic_t disassociated;
>>  };
>>  
>>  struct ib_uverbs_event {
>> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
>> index bc099287de9a..589f27c09a2e 100644
>> --- a/drivers/infiniband/core/uverbs_main.c
>> +++ b/drivers/infiniband/core/uverbs_main.c
>> @@ -76,6 +76,7 @@ static dev_t dynamic_uverbs_dev;
>>  static DEFINE_IDA(uverbs_ida);
>>  static int ib_uverbs_add_one(struct ib_device *device);
>>  static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
>> +static struct ib_client uverbs_client;
>>  
>>  static char *uverbs_devnode(const struct device *dev, umode_t *mode)
>>  {
>> @@ -217,6 +218,7 @@ void ib_uverbs_release_file(struct kref *ref)
>>  
>>  	if (file->disassociate_page)
>>  		__free_pages(file->disassociate_page, 0);
>> +	mutex_destroy(&file->disassociation_lock);
>>  	mutex_destroy(&file->umap_lock);
>>  	mutex_destroy(&file->ucontext_lock);
>>  	kfree(file);
>> @@ -700,6 +702,12 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>>  		ret = PTR_ERR(ucontext);
>>  		goto out;
>>  	}
>> +
>> +	if (atomic_read(&file->disassociated)) {
> 
> I don't see any of the newly introduced locks here. If it is
> intentional, it needs to be documented.
> 

<...>

>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +
>>  	vma->vm_ops = &rdma_umap_ops;
>>  	ret = ucontext->device->ops.mmap(ucontext, vma);
>>  out:
>> @@ -726,7 +734,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>>  	/*
>>  	 * Disassociation already completed, the VMA should already be zapped.
>>  	 */
>> -	if (!ufile->ucontext)
>> +	if (!ufile->ucontext || atomic_read(&ufile->disassociated))
>>  		goto out_unlock;
>>  
>>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> @@ -822,6 +830,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>>  	struct rdma_umap_priv *priv, *next_priv;
>>  
>>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
>> +	mutex_lock(&ufile->disassociation_lock);
>> +	atomic_set(&ufile->disassociated, 1);
> 
> Why do you use atomic_t and not regular bool?
> 

The original thought was that ib_uverbs_mmap() reads ufile->disassociated while
uverbs_user_mmap_disassociate() writes it, and there might be a racing. We tried
to use atomic_t to avoid racing without adding locks.

But I looked into the code again and now I think ufile->disassociated is not
sufficient to deal with the racing like this:

ib_uverbs_mmap()                                       uverbs_user_mmap_disassociate()
----------------                                       ------------------------------
atomic_read(&file->disassociated) == 0
                                                       atomic_set(&ufile->disassociated, 1)

                                                       all mmaps from the list are zapped

ucontext->device->ops.mmap(ucontext, vma)
rdma_user_mmap_io()
rdma_umap_priv_init() adds a new mmap to the list


So we may still need a lock, and ufile->disassociated can be bool now, something like:

@@ -700,9 +702,17 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
                ret = PTR_ERR(ucontext);
                goto out;
        }
+
+       mutex_lock(&file->disassociation_lock);
+       if (file->disassociated) {
+               ret = -EPERM;
+               goto out;
+       }
+
        vma->vm_ops = &rdma_umap_ops;
        ret = ucontext->device->ops.mmap(ucontext, vma);
 out:
+       mutex_unlock(&file->disassociation_lock);
        srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
        return ret;
 }

Similar changes on rdma_umap_open():

@@ -723,10 +733,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
        /* We are racing with disassociation */
        if (!down_read_trylock(&ufile->hw_destroy_rwsem))
                goto out_zap;
+
+       mutex_lock(&ufile->disassociation_lock);
        /*
         * Disassociation already completed, the VMA should already be zapped.
         */
-       if (!ufile->ucontext)
+       if (!ufile->ucontext || ufile->disassociated)
                goto out_unlock;

        priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -734,10 +746,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
                goto out_unlock;
        rdma_umap_priv_init(priv, vma, opriv->entry);

+       mutex_unlock(&ufile->disassociation_lock);
        up_read(&ufile->hw_destroy_rwsem);
        return;

 out_unlock:
+       mutex_unlock(&ufile->disassociation_lock);
        up_read(&ufile->hw_destroy_rwsem);
 out_zap:
        /*

>>  
>>  	while (1) {
>>  		struct mm_struct *mm = NULL;
>> @@ -847,8 +857,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>>  			break;
>>  		}
>>  		mutex_unlock(&ufile->umap_lock);
>> -		if (!mm)
>> +		if (!mm) {
>> +			mutex_unlock(&ufile->disassociation_lock);
>>  			return;
>> +		}
>>  
>>  		/*
>>  		 * The umap_lock is nested under mmap_lock since it used within
>> @@ -878,8 +890,34 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>>  		mmap_read_unlock(mm);
>>  		mmput(mm);
>>  	}
>> +
>> +	mutex_unlock(&ufile->disassociation_lock);
>>  }
>>  
>> +/**
>> + * rdma_user_mmap_disassociate() - Revoke mmaps for a device
>> + * @device: device to revoke
>> + *
>> + * This function should be called by drivers that need to disable mmaps for the
>> + * device, for instance because it is going to be reset.
>> + */
>> +void rdma_user_mmap_disassociate(struct ib_device *device)
>> +{
>> +	struct ib_uverbs_device *uverbs_dev =
>> +		ib_get_client_data(device, &uverbs_client);
>> +	struct ib_uverbs_file *ufile;
>> +
>> +	mutex_lock(&uverbs_dev->lists_mutex);
>> +	list_for_each_entry(ufile, &uverbs_dev->uverbs_file_list, list) {
>> +		down_read(&ufile->hw_destroy_rwsem);
> 
> I personally don't understand this locking scheme at all. I see newly
> introduced locks mixed together some old locks. 
> 

We must hold the rwsem because of the lockdep. The newly introduced lock
is also needed to prevent the racing that one thread is calling
rdma_user_mmap_disassociate(), while the other thread is calling
ib_uverbs_mmap() or rdma_umap_open().

Thanks,
Junxian

> Jason, do you agree with this proposed locking scheme?
> 
> Thanks
> 
>> +		if (ufile->ucontext && !atomic_read(&ufile->disassociated))
>> +			uverbs_user_mmap_disassociate(ufile);
>> +		up_read(&ufile->hw_destroy_rwsem);
>> +	}
>> +	mutex_unlock(&uverbs_dev->lists_mutex);
>> +}
>> +EXPORT_SYMBOL(rdma_user_mmap_disassociate);
>> +
>>  /*
>>   * ib_uverbs_open() does not need the BKL:
>>   *
>> @@ -949,6 +987,9 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
>>  	mutex_init(&file->umap_lock);
>>  	INIT_LIST_HEAD(&file->umaps);
>>  
>> +	mutex_init(&file->disassociation_lock);
>> +	atomic_set(&file->disassociated, 0);
>> +
>>  	filp->private_data = file;
>>  	list_add_tail(&file->list, &dev->uverbs_file_list);
>>  	mutex_unlock(&dev->lists_mutex);
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index a1dcf812d787..09b80c8253e2 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -2948,6 +2948,14 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
>>  				      size_t length, u32 min_pgoff,
>>  				      u32 max_pgoff);
>>  
>> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>> +void rdma_user_mmap_disassociate(struct ib_device *device);
>> +#else
>> +static inline void rdma_user_mmap_disassociate(struct ib_device *device)
>> +{
>> +}
>> +#endif
>> +
>>  static inline int
>>  rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
>>  				  struct rdma_user_mmap_entry *entry,
>> -- 
>> 2.33.0
>>
>>

