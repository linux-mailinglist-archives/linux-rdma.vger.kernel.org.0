Return-Path: <linux-rdma+bounces-4687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B341967FCF
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22786284E7B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4716EB76;
	Mon,  2 Sep 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw6ZSg9Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42874165F1E;
	Mon,  2 Sep 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260251; cv=none; b=fEMqFY3w8giuCFti/70J3NVdGApAHrge57w1Hdvy6yd8U1VkNPA83mwhOFqX3UI6G3bScZCbf59XsHRwrEjCXZMf2D7Nwxy4X2MOwz/APAIKs3dKhNsdHpzpEP8y3ZgHH4zRTNZjfyjWBho3b0bRE3+lJ5siF33ONuDFgzCdmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260251; c=relaxed/simple;
	bh=+rxT6nGjBvHpKZJIS+7QqR3ngox5kULSd/HbaUgtzt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWQpAXyHD2EjWdg+KlXminUx3n05zKDYGZbbgJzRYSGh9Z7IZV85C4vJ3twzTY9j18i91AKrzMVEzyLiO+7VY2g1lV4Y1ibcAsvxVmZpci/F23zed7jW75HlHocbIvCPn9CXQB2RWgnb3rQmo/2OlrqMYmHFR/iBwZqW63KRzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw6ZSg9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C0DC4CEC2;
	Mon,  2 Sep 2024 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725260250;
	bh=+rxT6nGjBvHpKZJIS+7QqR3ngox5kULSd/HbaUgtzt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hw6ZSg9Ynr71Ve0VeVTuCN8WQpV0viX250+/Yk2H0jwDw08lhmFUpqZdEPH/TEujv
	 9iYYUAHDRS1fpkPX64jph+Wl8nHH75qr0VK8ezAqhgHX/NP4i02znE/aVTe1GFMdGS
	 A+E/Tg51kH1ijcqs53X5crOKRny1XGWrs+qvsQpKIlfbLghLtmZgotmE+dErwX1EqM
	 5VoL6691gPsnu0Zm/OLdZuTjHyUN668ZYJ+pts3c1cFe2KhlRkiMUyalrmWiRbTUru
	 IcAp8XQhIIUt2yFPDKYu1vVicp6zmbzaHKgu1KmAHZWSiarv6APDOhkH6Vx4vhrAWu
	 BSydjjSodLXgw==
Date: Mon, 2 Sep 2024 09:57:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240902065726.GA4026@unreal>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
 <20240828064605.887519-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828064605.887519-2-huangjunxian6@hisilicon.com>

On Wed, Aug 28, 2024 at 02:46:04PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Provide a new api rdma_user_mmap_disassociate() for drivers to
> disassociate mmap pages for a device.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/uverbs.h      |  3 ++
>  drivers/infiniband/core/uverbs_main.c | 45 +++++++++++++++++++++++++--
>  include/rdma/ib_verbs.h               |  8 +++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 821d93c8f712..0999d27cb1c9 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -160,6 +160,9 @@ struct ib_uverbs_file {
>  	struct page *disassociate_page;
>  
>  	struct xarray		idr;
> +
> +	struct mutex disassociation_lock;
> +	atomic_t disassociated;
>  };
>  
>  struct ib_uverbs_event {
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index bc099287de9a..589f27c09a2e 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -76,6 +76,7 @@ static dev_t dynamic_uverbs_dev;
>  static DEFINE_IDA(uverbs_ida);
>  static int ib_uverbs_add_one(struct ib_device *device);
>  static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
> +static struct ib_client uverbs_client;
>  
>  static char *uverbs_devnode(const struct device *dev, umode_t *mode)
>  {
> @@ -217,6 +218,7 @@ void ib_uverbs_release_file(struct kref *ref)
>  
>  	if (file->disassociate_page)
>  		__free_pages(file->disassociate_page, 0);
> +	mutex_destroy(&file->disassociation_lock);
>  	mutex_destroy(&file->umap_lock);
>  	mutex_destroy(&file->ucontext_lock);
>  	kfree(file);
> @@ -700,6 +702,12 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
>  		ret = PTR_ERR(ucontext);
>  		goto out;
>  	}
> +
> +	if (atomic_read(&file->disassociated)) {

I don't see any of the newly introduced locks here. If it is
intentional, it needs to be documented.

> +		ret = -EPERM;
> +		goto out;
> +	}
> +
>  	vma->vm_ops = &rdma_umap_ops;
>  	ret = ucontext->device->ops.mmap(ucontext, vma);
>  out:
> @@ -726,7 +734,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>  	/*
>  	 * Disassociation already completed, the VMA should already be zapped.
>  	 */
> -	if (!ufile->ucontext)
> +	if (!ufile->ucontext || atomic_read(&ufile->disassociated))
>  		goto out_unlock;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> @@ -822,6 +830,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  	struct rdma_umap_priv *priv, *next_priv;
>  
>  	lockdep_assert_held(&ufile->hw_destroy_rwsem);
> +	mutex_lock(&ufile->disassociation_lock);
> +	atomic_set(&ufile->disassociated, 1);

Why do you use atomic_t and not regular bool?

>  
>  	while (1) {
>  		struct mm_struct *mm = NULL;
> @@ -847,8 +857,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  			break;
>  		}
>  		mutex_unlock(&ufile->umap_lock);
> -		if (!mm)
> +		if (!mm) {
> +			mutex_unlock(&ufile->disassociation_lock);
>  			return;
> +		}
>  
>  		/*
>  		 * The umap_lock is nested under mmap_lock since it used within
> @@ -878,8 +890,34 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  		mmap_read_unlock(mm);
>  		mmput(mm);
>  	}
> +
> +	mutex_unlock(&ufile->disassociation_lock);
>  }
>  
> +/**
> + * rdma_user_mmap_disassociate() - Revoke mmaps for a device
> + * @device: device to revoke
> + *
> + * This function should be called by drivers that need to disable mmaps for the
> + * device, for instance because it is going to be reset.
> + */
> +void rdma_user_mmap_disassociate(struct ib_device *device)
> +{
> +	struct ib_uverbs_device *uverbs_dev =
> +		ib_get_client_data(device, &uverbs_client);
> +	struct ib_uverbs_file *ufile;
> +
> +	mutex_lock(&uverbs_dev->lists_mutex);
> +	list_for_each_entry(ufile, &uverbs_dev->uverbs_file_list, list) {
> +		down_read(&ufile->hw_destroy_rwsem);

I personally don't understand this locking scheme at all. I see newly
introduced locks mixed together some old locks. 

Jason, do you agree with this proposed locking scheme?

Thanks

> +		if (ufile->ucontext && !atomic_read(&ufile->disassociated))
> +			uverbs_user_mmap_disassociate(ufile);
> +		up_read(&ufile->hw_destroy_rwsem);
> +	}
> +	mutex_unlock(&uverbs_dev->lists_mutex);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_disassociate);
> +
>  /*
>   * ib_uverbs_open() does not need the BKL:
>   *
> @@ -949,6 +987,9 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
>  	mutex_init(&file->umap_lock);
>  	INIT_LIST_HEAD(&file->umaps);
>  
> +	mutex_init(&file->disassociation_lock);
> +	atomic_set(&file->disassociated, 0);
> +
>  	filp->private_data = file;
>  	list_add_tail(&file->list, &dev->uverbs_file_list);
>  	mutex_unlock(&dev->lists_mutex);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index a1dcf812d787..09b80c8253e2 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2948,6 +2948,14 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
>  				      size_t length, u32 min_pgoff,
>  				      u32 max_pgoff);
>  
> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
> +void rdma_user_mmap_disassociate(struct ib_device *device);
> +#else
> +static inline void rdma_user_mmap_disassociate(struct ib_device *device)
> +{
> +}
> +#endif
> +
>  static inline int
>  rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
>  				  struct rdma_user_mmap_entry *entry,
> -- 
> 2.33.0
> 
> 

