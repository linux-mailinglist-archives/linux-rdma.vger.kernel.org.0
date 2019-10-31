Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E634BEB067
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJaMfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 08:35:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55006 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaMfo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Oct 2019 08:35:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id c12so1202907wml.4
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mVyPXYP/FFiNwxa1Vc2u/QNpm6CC5c1w7tylj9kQAmU=;
        b=kBoP8Cimwf1gsAZI/1MOsBmTi8u8A7zSTcQFxtCQ7PfVqJ1Y9MWAjog4sqVRfdSpgn
         jFJeHOZs4dqVVHz/eyNM5YMkGq8+IF8gBjk4yKs7QpuLmQIyesOeBHbMO1iHiNRoaS8l
         t1xp/CzoW4zzbOS1PowfobsIP9yeJVw71uaK28AjDcyBd5C5YGYAWwcl7GjcydRXhw9I
         mPiamcA//evm0YNgGN1IVe7z6cnBnmWbxeqRdhzk3Hg86MValHbmrHczj9+OWFpztjY0
         zgLv3j+y99EmM0ZemZw8y0PAoXwN0r5IvvMIkGlvtQC2qXVhMbfA/ght20RT8p19Rz1G
         D/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mVyPXYP/FFiNwxa1Vc2u/QNpm6CC5c1w7tylj9kQAmU=;
        b=Xy0GwFDYUAmjzqf7gbLMS84naZjAV3V9Gfo4XKItS2McI84VxETaHvfDSFcfHTWVJL
         kyF7vcc8XmXS6RA5zV71X/5nk7+6CxfGIcYA1MiGmHMgaYJ2Dnob1KMPYSLZmrQbzHs3
         Bn9is9JLxENZzNuVC6xQcaAS5aj7dAdQ7qSO/E3pIUSt5wCRyp8Tuf2zSpXri1adb9JV
         IjqqFduokYffB7Dtxq/an4NQAr2l/yw2MWmKzwSy5rOLR8Sx7CHOdvWukX4slXgwhskZ
         b9sRiRYJHwfs4dvQPJlkHgWcKXqZe5BaeyyIfQ5WFbX1T/eb8rhKVZNhB68Y+ysgr6nM
         oaRQ==
X-Gm-Message-State: APjAAAUFrvILP9apf6W15URYDBaYh9HvTg/W1iiqIOBP12/E8c56rz13
        3mF5G+kwt3dJk9NCHZxnqVyO92Da2y4=
X-Google-Smtp-Source: APXvYqxPOpx2sRqxDH4P8ghMUGyox/+macGL3Vkv7eKV6drDGFATMb5/6zjVJjgcWtz876khXioBjA==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr4985391wme.53.1572525340653;
        Thu, 31 Oct 2019 05:35:40 -0700 (PDT)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id x205sm4215671wmb.5.2019.10.31.05.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 05:35:40 -0700 (PDT)
Subject: Re: [PATCH v12 rdma-next 2/8] RDMA/core: Create mmap database and
 cookie helper functions
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com, jgg@ziepe.ca,
        galpress@amazon.com, yishaih@mellanox.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191030094417.16866-3-michal.kalderon@marvell.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <3f660dd4-860b-39a6-adb0-c052a0a67ae9@dev.mellanox.co.il>
Date:   Thu, 31 Oct 2019 14:35:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030094417.16866-3-michal.kalderon@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/30/2019 11:44 AM, Michal Kalderon wrote:
> Create some common API's for adding entries to a xa_mmap.
> Searching for an entry and freeing one.
> 
> Most of the code was copied from the efa driver almost as is, just renamed
> function to be generic and not efa specific.
> The fact that this code moved to core enabled managing it differently,
> so that now entries can be removed and deleted when driver+user are
> done with them. This enabled changing the insert algorithm in
> comparison to what was done in efa.
> 
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>   drivers/infiniband/core/device.c         |   1 +
>   drivers/infiniband/core/ib_core_uverbs.c | 201 +++++++++++++++++++++++++++++++
>   drivers/infiniband/core/rdma_core.c      |   1 +
>   drivers/infiniband/core/uverbs_cmd.c     |   2 +
>   include/rdma/ib_verbs.h                  |  34 ++++++
>   5 files changed, 239 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index a667636f74bf..bf3a683057bc 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2629,6 +2629,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   	SET_DEVICE_OP(dev_ops, map_mr_sg_pi);
>   	SET_DEVICE_OP(dev_ops, map_phys_fmr);
>   	SET_DEVICE_OP(dev_ops, mmap);
> +	SET_DEVICE_OP(dev_ops, mmap_free);
>   	SET_DEVICE_OP(dev_ops, modify_ah);
>   	SET_DEVICE_OP(dev_ops, modify_cq);
>   	SET_DEVICE_OP(dev_ops, modify_device);
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
> index b74d2a2fb342..1ffc89fd5d94 100644
> --- a/drivers/infiniband/core/ib_core_uverbs.c
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -71,3 +71,204 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>   	return 0;
>   }
>   EXPORT_SYMBOL(rdma_user_mmap_io);
> +
> +/**
> + * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @key: the key received from rdma_user_mmap_entry_insert which
> + *     is provided by user as the address to map.
> + * @vma: the vma related to the current mmap call.
> + *
> + * This function is called when a user tries to mmap a key it
> + * initially received from the driver. The key was created by
> + * the function rdma_user_mmap_entry_insert.
> + * This function increases the refcnt of the entry so that it won't
> + * be deleted from the xa in the meantime.
> + *
> + * Return an entry if exists or NULL if there is no match.
> + */
> +struct rdma_user_mmap_entry *
> +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
> +			 struct vm_area_struct *vma)

Where @vma is used in this function ? I would expect that this API will 
return the entry pointed by @key without any relation to the @vma, 
wasn't that the plan ?

> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u64 mmap_page;
> +
> +	mmap_page = key >> PAGE_SHIFT;
> +	if (mmap_page > U32_MAX)
> +		return NULL;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> +
> +	/* if refcount is zero, entry is already being deleted */
> +	if (!entry || entry->invalid || !kref_get_unless_zero(&entry->ref))
> +		goto err;
> +
> +	xa_unlock(&ucontext->mmap_xa);
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: key[%#llx] npages[%#x] returned\n",
> +		  key, entry->npages);
> +
> +	return entry;
> +
> +err:
> +	xa_unlock(&ucontext->mmap_xa);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_get);
> +
> +void rdma_user_mmap_entry_free(struct kref *kref)
> +{
> +	struct rdma_user_mmap_entry *entry =
> +		container_of(kref, struct rdma_user_mmap_entry, ref);
> +	struct ib_ucontext *ucontext = entry->ucontext;
> +	unsigned long i;
> +
> +	/* need to erase all entries occupied by this single entry */
> +	xa_lock(&ucontext->mmap_xa);
> +	for (i = 0; i < entry->npages; i++)
> +		__xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
> +	xa_unlock(&ucontext->mmap_xa);
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: key[%#llx] npages[%#x] removed\n",
> +		  rdma_user_mmap_get_key(entry),
> +		  entry->npages);
> +
> +	if (ucontext->device->ops.mmap_free)
> +		ucontext->device->ops.mmap_free(entry);
> +}
> +
> +/**
> + * rdma_user_mmap_entry_put() - Drop reference to the mmap entry
> + *
> + * @ucontext: associated user context.
> + * @entry: an entry in the mmap_xa.
> + *
> + * This function is called when the mapping is closed if it was
> + * an io mapping or when the driver is done with the entry for
> + * some other reason.
> + * Should be called after rdma_user_mmap_entry_get was called
> + * and entry is no longer needed. This function will erase the
> + * entry and free it if its refcnt reaches zero.
> + */
> +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> +			      struct rdma_user_mmap_entry *entry)
> +{
> +	kref_put(&entry->ref, rdma_user_mmap_entry_free);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_put);
> +
> +/**
> + * rdma_user_mmap_entry_remove() - Drop reference to entry and
> + *				   mark it as invalid.
> + *
> + * @ucontext: associated user context.
> + * @entry: the entry to insert into the mmap_xa
> + */
> +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
> +				 struct rdma_user_mmap_entry *entry)
> +{
> +	if (!entry)
> +		return;
> +
> +	entry->invalid = true;
> +	kref_put(&entry->ref, rdma_user_mmap_entry_free);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
> +
> +/**
> + * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @entry: the entry to insert into the mmap_xa
> + * @length: length of the address that will be mmapped
> + *
> + * This function should be called by drivers that use the rdma_user_mmap
> + * interface for handling user mmapped addresses. The database is handled in
> + * the core and helper functions are provided to insert entries into the
> + * database and extract entries when the user calls mmap with the given key.
> + * The function allocates a unique key that should be provided to user, the user
> + * will use the key to retrieve information such as address to
> + * be mapped and how.
> + *
> + * Return: 0 on success and -ENOMEM on failure
> + */
> +int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> +				struct rdma_user_mmap_entry *entry,
> +				size_t length)
> +{
> +	struct ib_uverbs_file *ufile = ucontext->ufile;
> +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> +	u32 xa_first, xa_last, npages;
> +	int err, i;
> +
> +	if (!entry)
> +		return -EINVAL;
> +
> +	kref_init(&entry->ref);
> +	entry->ucontext = ucontext;
> +
> +	/* We want the whole allocation to be done without interruption
> +	 * from a different thread. The allocation requires finding a
> +	 * free range and storing. During the xa_insert the lock could be
> +	 * released, we don't want another thread taking the gap.
> +	 */
> +	mutex_lock(&ufile->umap_lock);
> +
> +	xa_lock(&ucontext->mmap_xa);
> +
> +	/* We want to find an empty range */
> +	npages = (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> +	entry->npages = npages;
> +	while (true) {
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
> +		/* Now look for the next present entry. If such doesn't
> +		 * exist, we found an empty range and can proceed
> +		 */
> +		xas_next_entry(&xas, xa_last - 1);
> +		if (xas.xa_node == XAS_BOUNDS || xas.xa_index >= xa_last)
> +			break;
> +		/* o/w look for the next free entry */
> +	}
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
> +	mutex_unlock(&ufile->umap_lock);
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: key[%#llx] npages[%#x] inserted\n",
> +		  rdma_user_mmap_get_key(entry), npages);
> +
> +	return 0;
> +
> +err_undo:
> +	for (; i > xa_first; i--)
> +		__xa_erase(&ucontext->mmap_xa, i - 1);
> +
> +err_unlock:
> +	xa_unlock(&ucontext->mmap_xa);
> +	mutex_unlock(&ufile->umap_lock);
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index ccf4d069c25c..6c72773faf29 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>   	rdma_restrack_del(&ucontext->res);
>   
>   	ib_dev->ops.dealloc_ucontext(ucontext);
> +	WARN_ON(!xa_empty(&ucontext->mmap_xa));
>   	kfree(ucontext);
>   
>   	ufile->ucontext = NULL;
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 14a80fd9f464..06ed32c8662f 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -252,6 +252,8 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
>   	ucontext->closing = false;
>   	ucontext->cleanup_retryable = false;
>   
> +	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
> +
>   	ret = get_unused_fd_flags(O_CLOEXEC);
>   	if (ret < 0)
>   		goto err_free;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6a47ba85c54c..8a87c9d442bc 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1471,6 +1471,7 @@ struct ib_ucontext {
>   	 * Implementation details of the RDMA core, don't use in drivers:
>   	 */
>   	struct rdma_restrack_entry res;
> +	struct xarray mmap_xa;
>   };
>   
>   struct ib_uobject {
> @@ -2251,6 +2252,20 @@ struct iw_cm_conn_param;
>   
>   #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
>   
> +struct rdma_user_mmap_entry {
> +	struct kref ref;
> +	struct ib_ucontext *ucontext;
> +	u32 npages;
> +	u32 mmap_page;
> +	bool invalid;
> +};
> +
> +static inline u64
> +rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
> +{
> +	return (u64)entry->mmap_page << PAGE_SHIFT;
> +}
> +
>   /**
>    * struct ib_device_ops - InfiniBand device operations
>    * This structure defines all the InfiniBand device operations, providers will
> @@ -2363,6 +2378,13 @@ struct ib_device_ops {
>   			      struct ib_udata *udata);
>   	void (*dealloc_ucontext)(struct ib_ucontext *context);
>   	int (*mmap)(struct ib_ucontext *context, struct vm_area_struct *vma);
> +	/**
> +	 * This will be called once refcount of an entry in mmap_xa reaches
> +	 * zero. The type of the memory that was mapped may differ between
> +	 * entries and is opaque to the rdma_user_mmap interface.
> +	 * Therefore needs to be implemented by the driver in mmap_free.
> +	 */
> +	void (*mmap_free)(struct rdma_user_mmap_entry *entry);
>   	void (*disassociate_ucontext)(struct ib_ucontext *ibcontext);
>   	int (*alloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
>   	void (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
> @@ -2801,6 +2823,18 @@ static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
>   	return -EINVAL;
>   }
>   #endif
> +int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> +				struct rdma_user_mmap_entry *entry,
> +				size_t length);
> +struct rdma_user_mmap_entry *
> +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
> +			 struct vm_area_struct *vma);
> +
> +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> +			      struct rdma_user_mmap_entry *entry);
> +
> +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
> +				 struct rdma_user_mmap_entry *entry);
>   
>   static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
>   {
> 

