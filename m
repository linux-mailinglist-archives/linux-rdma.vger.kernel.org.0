Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB86295FDE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfHTNV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 09:21:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46418 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Aug 2019 09:21:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so5902734qtl.13
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pmfBCcQdsvAyC0PmU8if8EKsdxS4xAr7InqmF2QzJQ=;
        b=VzCyDU2ECagwCZ/Hs4EJsWJKTYvRYYnr8uNM6vF1bplHvXFIImN+tgc0jIG3CVnyiN
         IVzC1Ur0VoCd1y9EPZbqnmHMp6U4UuSp6Fs2vVI/qhVF6KwntVPTqC8h5Cte/DwnIAIu
         4XF6vXziI2SpAYuSLg3G9sm/Wwu8hrf104ls8mZ2HrIgwti+IJJ2+6+AGYIDOZc6LTzI
         YqWd5dVMBPrJq2CdMc97xzd8VAAygk4u2oTRQR0ebBAcBDoiwgoyDOZ/gqR0EuW8a3qL
         ChNiw4J0aDf6681+xC+6mf9BuH9aoLuYeSGet2KwmQPHT6I/rNo8cScNvEpWZnHB94Vk
         bplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pmfBCcQdsvAyC0PmU8if8EKsdxS4xAr7InqmF2QzJQ=;
        b=BsubpRrXHZbIS5R6kEkl/bQw1SNl9kfn0O6+AyOiMZyoHPSBIVhMZWdxr7UZbuw4Cw
         BjuUmDb3zaRTjd3Edfd6rvehQpRrFAK1hjsOoceOW/+kJX9zg9jAeDvG/ZRXrdSrPXQV
         mhHtPIBFozdcb4ToXbz/7QvMaGLOA1TeQEEU6P0pul/ypiduc/RJ/wkk14ENUyyLqgLM
         leV2Ll0FiI4aEUlQNr8ghvvr5kbBk+a6caCOhKn9BRO1MXjihqxiQfnf98ZiY+C4HuPs
         CVLvHoYhVbN6to7WU9JcDS+ers82r6FbUFaYjFv5rejn5WNSDX58yZRHS8SQfTxmgDi1
         XZEg==
X-Gm-Message-State: APjAAAVxiFeqrhoqXMSqfz6BU6G6LqzlXV8hwWp26ew+BQBESYpsdFqT
        ELyt6r6jS8MCJ8pNgXiG1AK88Q==
X-Google-Smtp-Source: APXvYqzyrTCO/VP99JxtXczgA1rDyWFq7IhYPTHcavkwziNRRfJwyE9PqcK124vDbgSanUq3GZMrtQ==
X-Received: by 2002:a05:6214:1254:: with SMTP id q20mr535119qvv.164.1566307286128;
        Tue, 20 Aug 2019 06:21:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y194sm8371394qkb.111.2019.08.20.06.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 06:21:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i044j-0000KT-4h; Tue, 20 Aug 2019 10:21:25 -0300
Date:   Tue, 20 Aug 2019 10:21:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190820132125.GC29246@ziepe.ca>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820121847.25871-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 03:18:42PM +0300, Michal Kalderon wrote:
> Create some common API's for adding entries to a xa_mmap.
> Searching for an entry and freeing one.
> 
> Most of the code was copied from the efa driver almost as is, just renamed
> function to be generic and not efa specific.
> In addition to original code, the xa_mmap entries are now linked
> to a umap_priv object and reference counted according to umap operations.
> The fact that this code moved to core enabled managing it differently,
> so that now entries can be removed and deleted when driver+user are
> done with them. This enabled changing the insert algorithm in
> comparison to what was done in efa.
> 
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>  drivers/infiniband/core/core_priv.h      |  12 +-
>  drivers/infiniband/core/device.c         |   1 +
>  drivers/infiniband/core/ib_core_uverbs.c | 343 +++++++++++++++++++++++++++++--
>  drivers/infiniband/core/rdma_core.c      |   1 +
>  drivers/infiniband/core/uverbs_cmd.c     |   1 +
>  drivers/infiniband/core/uverbs_main.c    |  18 +-
>  include/rdma/ib_verbs.h                  |  41 +++-
>  7 files changed, 381 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index 6850e973401c..4951ecfbf133 100644
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -388,9 +388,17 @@ void rdma_nl_net_exit(struct rdma_dev_net *rnet);
>  struct rdma_umap_priv {
>  	struct vm_area_struct *vma;
>  	struct list_head list;
> +	struct rdma_user_mmap_entry *entry;
>  };
>  
> -void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> -			 struct vm_area_struct *vma);
> +int rdma_umap_priv_init(struct vm_area_struct *vma,
> +			struct rdma_user_mmap_entry *entry);
> +
> +void rdma_umap_priv_delete(struct ib_uverbs_file *ufile,
> +			   struct rdma_umap_priv *priv);
> +
> +void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext);
> +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> +			      struct rdma_user_mmap_entry *entry);
>  
>  #endif /* _CORE_PRIV_H */
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 8892862fb759..229977237d1a 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2594,6 +2594,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, map_mr_sg_pi);
>  	SET_DEVICE_OP(dev_ops, map_phys_fmr);
>  	SET_DEVICE_OP(dev_ops, mmap);
> +	SET_DEVICE_OP(dev_ops, mmap_free);
>  	SET_DEVICE_OP(dev_ops, modify_ah);
>  	SET_DEVICE_OP(dev_ops, modify_cq);
>  	SET_DEVICE_OP(dev_ops, modify_device);
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
> index cab7dc922cf0..cce20172cd71 100644
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -36,41 +36,98 @@
>  #include "uverbs.h"
>  #include "core_priv.h"
>  
> -/*
> - * Each time we map IO memory into user space this keeps track of the mapping.
> - * When the device is hot-unplugged we 'zap' the mmaps in user space to point
> - * to the zero page and allow the hot unplug to proceed.
> +/**
> + * rdma_umap_priv_init() - Initialize the private data of a vma
> + *
> + * @vma: The vm area struct that needs private data
> + * @entry: entry into the mmap_xa that needs to be linked with
> + *       this vma
> + *
> + * Each time we map IO memory into user space this keeps track
> + * of the mapping. When the device is hot-unplugged we 'zap' the
> + * mmaps in user space to point to the zero page and allow the
> + * hot unplug to proceed.
>   *
>   * This is necessary for cases like PCI physical hot unplug as the actual BAR
>   * memory may vanish after this and access to it from userspace could MCE.
>   *
>   * RDMA drivers supporting disassociation must have their user space designed
>   * to cope in some way with their IO pages going to the zero page.
> + *
> + * We extended the umap list usage to track all memory that was mapped by
> + * user space and not only the IO memory. This will occur for drivers that use
> + * the mmap_xa database and helper functions
> + *
> + * Return 0 on success or -ENOMEM if out of memory
>   */
> -void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> -			 struct vm_area_struct *vma)
> +int rdma_umap_priv_init(struct vm_area_struct *vma,
> +			struct rdma_user_mmap_entry *entry)
>  {
>  	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
> +	struct rdma_umap_priv *priv;
> +
> +	/* If the xa_mmap is used, private data will already be initialized.
> +	 * this is required for the cases that rdma_user_mmap_io is called
> +	 * from drivers that don't use the xa_mmap database yet
> +	 */
> +	if (vma->vm_private_data)
> +		return 0;

?? Still have to track the ufile->umaps though

> +/**
> + * rdma_user_mmap_entry_put() - drop reference to the mmap entry
> + *
> + * @ucontext: associated user context.
> + * @entry: An entry in the mmap_xa.
> + *
> + * This function is called when the mapping is closed or when
> + * the driver is done with the entry for some other reason.
> + * Should be called after rdma_user_mmap_entry_get was called
> + * and entry is no longer needed. This function will erase the
> + * entry and free it if it's refcnt reaches zero.
> + */
> +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> +			      struct rdma_user_mmap_entry *entry)
> +{
> +	WARN_ON(!kref_read(&entry->ref));

kref_put does this internally when refcount debugging is enabled

> +	kref_put(&entry->ref, rdma_user_mmap_entry_free);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_put);
> +
> +/**
> + * rdma_user_mmap_entry_remove() - Remove a key's entry from the mmap_xa
> + *
> + * @ucontext: associated user context.
> + * @key: The key to be deleted
> + *
> + * This function will find if there is an entry matching the key and if so
> + * decrease it's refcnt, which will in turn delete the entry if its refcount
> + * reaches zero.
> + */
> +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext, u64 key)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u32 mmap_page;
> +
> +	if (key == RDMA_USER_MMAP_INVALID)
> +		return;
> +
> +	mmap_page = key >> PAGE_SHIFT;
> +	if (mmap_page > U32_MAX)
> +		return;
> +
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> +	if (!entry)
> +		return;
> +
> +	rdma_user_mmap_entry_put(ucontext, entry);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
> +
> +/**
> + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @obj: opaque driver object that will be stored in the entry.
> + * @address: The address that will be mmapped to the user
> + * @length: Length of the address that will be mmapped
> + * @mmap_flag: opaque driver flags related to the address (For
> + *           example could be used for cachability)
> + *
> + * This function should be called by drivers that use the rdma_user_mmap
> + * interface for handling user mmapped addresses. The database is handled in
> + * the core and helper functions are provided to insert entries into the
> + * database and extract entries when the user call mmap with the given key.
> + * The function returns a unique key that should be provided to user, the user
> + * will use the key to map the given address.
> + *
> + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not added.
> + */
> +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
> +				u64 address, u64 length, u8 mmap_flag)
> +{
> +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> +	struct rdma_user_mmap_entry *entry;
> +	unsigned long index = 0, index_max;
> +	u32 xa_first, xa_last, npages;
> +	int err, i;
> +	void *ent;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return RDMA_USER_MMAP_INVALID;
> +
> +	entry->obj = obj;

It is more a kernel pattern to have the driver allocate a
rdma_user_mmap_entry and extend it with its 'priv', then use
container_of


> +	entry->address = address;
> +	entry->length = length;
> +	kref_init(&entry->ref);
> +	entry->mmap_flag = mmap_flag;
> +	entry->ucontext = ucontext;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +
> +	/* We want to find an empty range */
> +	npages = (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> +	do {
> +		/* First find an empty index */
> +		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
> +		if (xas.xa_node == XAS_RESTART)
> +			goto err_unlock;
> +
> +		xa_first = xas.xa_index;
> +
> +		/* Is there enough room to have the range? */
> +		if (check_add_overflow(xa_first, npages, &xa_last))
> +			goto err_unlock;
> +
> +		/* Iterate over all present entries in the range. If a present
> +		 * entry exists we will finish this with the largest index
> +		 * occupied in the range which will serve as the start of the
> +		 * new search
> +		 */
> +		index_max = xa_last;
> +		xa_for_each_start(&ucontext->mmap_xa, index, ent, xa_first)

I think this can just be written as xas_next_entry() ?

And if it returns something we know the range xa_first -> xas.xa_index
is not occupied, then check if it has the right size? Otherwise the
range xa_first -> U32_MAX


> +			if (index < xa_last)
> +				index_max = index;
> +			else
> +				break;
> +		if (index_max == xa_last) /* range is free */
> +			break;
> +		/* o/w start again from largest index found in range */
> +		xas_set(&xas, index_max);
> +	} while (true);
> +
> +	for (i = xa_first; i < xa_last; i++) {
> +		err = __xa_insert(&ucontext->mmap_xa, i, entry, GFP_KERNEL);

Hum, keep in mind this is a bit tricky as the __xa_insert will drop
the xa_lock lock to allocate and a parallel thread could jump into the
gap

This seems undesirable, so we probably need to enclose the whole thing
in a sleeping mutex. Can probably use the umap_lock

> +void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	unsigned long mmap_page;
> +
> +	WARN_ON(!xa_empty(&ucontext->mmap_xa));
> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> +		ibdev_dbg(ucontext->device,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			  entry->obj, rdma_user_mmap_get_key(entry),
> +			  entry->address, entry->length);
> +
> +		/* override the refcnt to make sure entry is deleted */
> +		kref_init(&entry->ref);

Yikes, no. The zap flow has to clean this up so the kref goes
naturally to zero.

> +		rdma_user_mmap_entry_put(ucontext, entry);
> +	}
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entries_remove_free);
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index ccf4d069c25c..7166741834c8 100644
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	rdma_restrack_del(&ucontext->res);
>  
>  	ib_dev->ops.dealloc_ucontext(ucontext);
> +	rdma_user_mmap_entries_remove_free(ucontext);
>  	kfree(ucontext);
>  
>  	ufile->ucontext = NULL;
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 7ddd0e5bc6b3..4903e6eee854 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -254,6 +254,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
>  
>  	mutex_init(&ucontext->per_mm_list_lock);
>  	INIT_LIST_HEAD(&ucontext->per_mm_list);
> +	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
>  
>  	ret = get_unused_fd_flags(O_CLOEXEC);
>  	if (ret < 0)
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 180a5e0f70e4..80d0d3467d93 100644
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -802,7 +802,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>  {
>  	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
>  	struct rdma_umap_priv *opriv = vma->vm_private_data;
> -	struct rdma_umap_priv *priv;
> +	int ret;
>  
>  	if (!opriv)
>  		return;
> @@ -816,10 +816,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>  	if (!ufile->ucontext)
>  		goto out_unlock;
>  
> -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	if (opriv->entry)
> +		kref_get(&opriv->entry->ref);
> +
> +	ret = rdma_umap_priv_init(vma, opriv->entry);
> +	if (ret)
>  		goto out_unlock;
> -	rdma_umap_priv_init(priv, vma);
>  
>  	up_read(&ufile->hw_destroy_rwsem);
>  	return;
> @@ -844,15 +846,15 @@ static void rdma_umap_close(struct vm_area_struct *vma)
>  	if (!priv)
>  		return;
>  
> +	if (priv->entry)
> +		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
> +
>  	/*
>  	 * The vma holds a reference on the struct file that created it, which
>  	 * in turn means that the ib_uverbs_file is guaranteed to exist at
>  	 * this point.
>  	 */
> -	mutex_lock(&ufile->umap_lock);
> -	list_del(&priv->list);
> -	mutex_unlock(&ufile->umap_lock);
> -	kfree(priv);
> +	rdma_umap_priv_delete(ufile, priv);
>  }
>  
>  /*
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 391499008a22..b66c197a7079 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1479,6 +1479,7 @@ struct ib_ucontext {
>  	 * Implementation details of the RDMA core, don't use in drivers:
>  	 */
>  	struct rdma_restrack_entry res;
> +	struct xarray mmap_xa;
>  };
>  
>  struct ib_uobject {
> @@ -2259,6 +2260,19 @@ struct iw_cm_conn_param;
>  
>  #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
>  
> +#define RDMA_USER_MMAP_FLAG_SHIFT 56
> +#define RDMA_USER_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)

Why is something called EFA_MMAP_FLAGS_SHIFT in ib_verbs.h?

Jason
