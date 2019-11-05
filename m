Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DCF0634
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfKETor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 14:44:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40169 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbfKETor (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 14:44:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id o49so30894682qta.7
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I7IXEl0XRclf7HNqaFZdNc+HQbvGc3+z7cGmGB4HFb0=;
        b=iZn3+irLtOwjjAhkxAmC9huzZArpPZmGAzqTrQcTeWtNiO6+o6Kcy5a8NuxDzgbagq
         o3epqUDA0axvJb57UvQIhCDfI2mA5Z0b141c1Gzk9jnxcuPG//YijNNVyXysklED5YFU
         Tj7WuddS1hG+CV9I9M2t+mNS52Ew17GssXoeiWl+t4kJdBp9FYj+RBOkTz2FEzbUmH25
         xIXcRkdxUk8oWv0SAuFGFu+6EMJN1ZVed4S7Urgw2zeQncKQL3djOX/maBVUxTXy21Wd
         qSt2J9Gc+7dtQar+h2clVSOEbmI0boy7DhM4AOATbcUMIfwTq++UrUNxOu6DSdCVFY/Y
         mEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I7IXEl0XRclf7HNqaFZdNc+HQbvGc3+z7cGmGB4HFb0=;
        b=h51RntJrQ4kiE0tdkuUfaXY///2es/VOx47iX5sVvfxwzaj+eZ/EvkJg4Xyeswr/2z
         h6ACEpw9Wzd65LK6jpLUAdoVuuXtca42BHzeLBPHwC+1p6FsCK6XBaJetxo8OyedcI5j
         BVY/jXSCCIbaHVGnOhIkKckpIvYVc+k+sf1XPsXsWToXAPvjns9gY9g+IepTAIX4/IOV
         MfOA8f+CnfYxQHQUdo1lxIR4z7ir6pnBtHkHgev9zdLjVMMeqy+cd84ox/EL7k4+Ruk7
         trPCUesZfO1nUw2gSxuBWlg2E49asrkXLU9Yr/h7aSbbha9KYUaAmn32I96Vx5kkiLpk
         OcOw==
X-Gm-Message-State: APjAAAXbXlZaEo9wbEbRUbZPhNMneIC1nGuMktwbz1n8jtmwf/bIoOi5
        xtXpfBoyWYVGTkomgISsdRoxUg==
X-Google-Smtp-Source: APXvYqz2uAI/l2aplVgfj8HBXHjgwAOR/0JTTBDN1SavUiRdcKh5zQx6478FanTNSK8m7yZCE4FBfQ==
X-Received: by 2002:ac8:5514:: with SMTP id j20mr2806672qtq.286.1572983085833;
        Tue, 05 Nov 2019 11:44:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m22sm461820qka.28.2019.11.05.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 11:44:45 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iS4ku-000587-Jn; Tue, 05 Nov 2019 15:44:44 -0400
Date:   Tue, 5 Nov 2019 15:44:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com, galpress@amazon.com,
        yishaih@mellanox.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v12 rdma-next 2/8] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20191105194444.GA19518@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191030094417.16866-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030094417.16866-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 11:44:11AM +0200, Michal Kalderon wrote:
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
> index b74d2a2fb342..1ffc89fd5d94 100644
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -71,3 +71,204 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>  	return 0;
>  }
>  EXPORT_SYMBOL(rdma_user_mmap_io);
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

This should just accept 'key' (but called pgoff for clarity), but
since everyone has a vma a static inline wrapper should take in the
vma

> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u64 mmap_page;
> +
> +	mmap_page = key >> PAGE_SHIFT;

It isn't even really 'key' here if it was shifted as that is called
'offset'

> +	if (mmap_page > U32_MAX)
> +		return NULL;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);

Since each xarray entry in the range stores the same pointer this
needs to check that mmap_page is actually the right entry, attempting
to directly mmap the 2nd page should fail as we don't have the rest of
the infrastructure to make that work.


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

ucontext is not needed

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

ucontext is not needed

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

'i' should be u32

> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6a47ba85c54c..8a87c9d442bc 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1471,6 +1471,7 @@ struct ib_ucontext {
>  	 * Implementation details of the RDMA core, don't use in drivers:
>  	 */
>  	struct rdma_restrack_entry res;
> +	struct xarray mmap_xa;
>  };
>  
>  struct ib_uobject {
> @@ -2251,6 +2252,20 @@ struct iw_cm_conn_param;
>  
>  #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
>  
> +struct rdma_user_mmap_entry {
> +	struct kref ref;
> +	struct ib_ucontext *ucontext;
> +	u32 npages;
> +	u32 mmap_page;
> +	bool invalid;

These names are confusing, lets use:

       unsigned long start_pgoff;
       size_t npages;
       bool driver_removed;

> +};
> +
> +static inline u64
> +rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
> +{
> +	return (u64)entry->mmap_page << PAGE_SHIFT;
> +}

This is offset not key, in fact lets not use the word 'key' at
all. Either 'pgoff' or 'offset'

There are also a number of fixables in comments, grammer, indentation
and style..

Jason
