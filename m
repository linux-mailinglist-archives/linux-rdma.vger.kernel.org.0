Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C198DDD
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfHVIg1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 04:36:27 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55769 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbfHVIg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 04:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566462985; x=1597998985;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qPtrDoHvuXRi8D5RaEyuT3IUKGT89DX9QNed/DaIHJ0=;
  b=PFm+DIrD0m5r2i9V3Ahz66fP/l/3I/o9FanR3t5fJ6Bi2SxamivdDgfh
   wzU91Eev7KTRGcyngsT0nM8Gag43p+iF/NbeAGSMNT+ElxKK02ZVptX4E
   BYfWr4kL4T+dqAjFVoCNh9PRvIobgjsbF0bdv+b7loDRz982VAGdVegMJ
   A=;
X-IronPort-AV: E=Sophos;i="5.64,416,1559520000"; 
   d="scan'208";a="696396636"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Aug 2019 08:35:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 3F548A26F1;
        Thu, 22 Aug 2019 08:35:38 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 08:35:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.177) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 08:35:31 +0000
Subject: Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        Ariel Elior <ariel.elior@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3b297196-1ef6-c046-d0b2-c68648a50913@amazon.com>
Date:   Thu, 22 Aug 2019 11:35:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820121847.25871-3-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.177]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/08/2019 15:18, Michal Kalderon wrote:
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

Yet? I don't think all drivers are going to use it.

> +	 */
> +	if (vma->vm_private_data)
> +		return 0;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>  
>  	priv->vma = vma;
> +	priv->entry = entry;
>  	vma->vm_private_data = priv;
>  
>  	mutex_lock(&ufile->umap_lock);
>  	list_add(&priv->list, &ufile->umaps);
>  	mutex_unlock(&ufile->umap_lock);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(rdma_umap_priv_init);
>  
> +void rdma_user_mmap_entry_free(struct kref *kref)
> +{
> +	struct rdma_user_mmap_entry *entry =
> +		container_of(kref, struct rdma_user_mmap_entry, ref);
> +	unsigned long i, npages = (u32)DIV_ROUND_UP(entry->length, PAGE_SIZE);
> +	struct ib_ucontext *ucontext = entry->ucontext;
> +
> +	/* need to erase all entries occupied... */
> +	for (i = 0; i < npages; i++) {
> +		xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
> +
> +		ibdev_dbg(ucontext->device,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] npages[%#lx] removed\n",
> +			  entry->obj, rdma_user_mmap_get_key(entry),
> +			  entry->address, entry->length, npages);
> +
> +		if (ucontext->device->ops.mmap_free)
> +			ucontext->device->ops.mmap_free(entry);
> +	}

Should this loop be surrounded with a lock? What happens with concurrent insertions?

> +	kfree(entry);
> +}
> +
> +/**
> + * rdma_user_mmap_entry_put() - drop reference to the mmap entry
> + *
> + * @ucontext: associated user context.
> + * @entry: An entry in the mmap_xa.

Nit: sometimes a capital letter is used and sometimes not.

> + *
> + * This function is called when the mapping is closed or when
> + * the driver is done with the entry for some other reason.
> + * Should be called after rdma_user_mmap_entry_get was called
> + * and entry is no longer needed. This function will erase the
> + * entry and free it if it's refcnt reaches zero.

"it's" -> "its".

> + */
> +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> +			      struct rdma_user_mmap_entry *entry)
> +{
> +	WARN_ON(!kref_read(&entry->ref));
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

Same.

> + * reaches zero.
> + */
> +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext, u64 key)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u32 mmap_page;
> +
> +	if (key == RDMA_USER_MMAP_INVALID)
> +		return;

How could this happen?

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
> +		if (err)
> +			goto err_undo;
> +	}
> +
> +	entry->mmap_page = xa_first;
> +	xa_unlock(&ucontext->mmap_xa);
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] npages[%#x] inserted\n",
> +		  entry->obj, entry->address, entry->length,
> +		  rdma_user_mmap_get_key(entry), npages);
> +
> +	return rdma_user_mmap_get_key(entry);
> +
> +err_undo:
> +	for (; i > xa_first; i--)
> +		__xa_erase(&ucontext->mmap_xa, i - 1);

Personal taste, but I find this clearer:
	for (i--; i >= xa_first; i--)
		__xa_erase(&ucontext->mmap_xa, i);

> +
> +err_unlock:
> +	xa_unlock(&ucontext->mmap_xa);
> +	kfree(entry);
> +	return RDMA_USER_MMAP_INVALID;
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
> +
> +/**
> + * rdma_user_mmap_entries_remove_free() - Free remaining entries
> + * in mmap_xa.
> + *
> + * @ucontext: associated user context
> + *
> + * This is only called when the ucontext is destroyed and there
> + * can be no concurrent query via mmap or allocate on the
> + * xarray, thus we can be sure no other thread is using the
> + * entry pointer. We also know that all the BAR pages have
> + * either been zap'd or munmaped at this point. Normal pages are
> + * refcounted and will be freed at the proper time.
> + */
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
> +		rdma_user_mmap_entry_put(ucontext, entry);
> +	}
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entries_remove_free);
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index ccf4d069c25c..7166741834c8 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	rdma_restrack_del(&ucontext->res);
>  
>  	ib_dev->ops.dealloc_ucontext(ucontext);
> +	rdma_user_mmap_entries_remove_free(ucontext);

Why did you switch the order again?

>  	kfree(ucontext);
>  
>  	ufile->ucontext = NULL;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 391499008a22..b66c197a7079 100644
> --- a/include/rdma/ib_verbs.h
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

These are unused.

> +#define RDMA_USER_MMAP_INVALID U64_MAX
> +struct rdma_user_mmap_entry {
> +	struct kref ref;
> +	struct ib_ucontext *ucontext;
> +	void *obj;
> +	u64 address;
> +	u64 length;
> +	u32 mmap_page;
> +	u8 mmap_flag;
> +};
