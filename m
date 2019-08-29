Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F2A18D4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfH2LgB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 07:36:01 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41273 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2LgB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Aug 2019 07:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567078559; x=1598614559;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yGaVbFiHKaF/jKjm5DbJFrBzUyutIiokxG2qx6WiTDs=;
  b=gxqKaWazLELiqnFntOoOh0yrNx4aYbTPXOcfZ9vNPzI5SDZUzduHGsoZ
   7zPQbU9XQA1zU0g33vlErCgKFDVeNCugJ70AfdoTG5W0Ez5w6DhIXsrTB
   lzLBGRWwsYuNrjCLYGXvtUOvUjcq1O+qaU5AgUlC9sh69GsBCm30fbQ1f
   g=;
X-IronPort-AV: E=Sophos;i="5.64,442,1559520000"; 
   d="scan'208";a="412547650"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 29 Aug 2019 11:35:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 6447C222676;
        Thu, 29 Aug 2019 11:35:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 29 Aug 2019 11:35:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.242) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 29 Aug 2019 11:35:50 +0000
Subject: Re: [PATCH v8 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        Ariel Elior <ariel.elior@marvell.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-3-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <4d80bab8-d48c-70b3-52ba-494c98e8a349@amazon.com>
Date:   Thu, 29 Aug 2019 14:35:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827132846.9142-3-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D15UWA004.ant.amazon.com (10.43.160.219) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 16:28, Michal Kalderon wrote:
> +/**
> + * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @key: the key received from rdma_user_mmap_entry_insert which
> + *     is provided by user as the address to map.
> + * @len: the length the user wants to map.
> + * @vma: the vma related to the current mmap call.
> + *
> + * This function is called when a user tries to mmap a key it
> + * initially received from the driver. The key was created by
> + * the function rdma_user_mmap_entry_insert. The function should
> + * be called only once per mmap. It initializes the vma and
> + * increases the entries ref-count. Once the memory is unmapped
> + * the ref-count will decrease. When the refcount reaches zero
> + * the entry will be deleted.
> + *
> + * Return an entry if exists or NULL if there is no match.
> + */
> +struct rdma_user_mmap_entry *
> +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len,
> +			 struct vm_area_struct *vma)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u64 mmap_page;
> +
> +	mmap_page = key >> PAGE_SHIFT;
> +	if (mmap_page > U32_MAX)
> +		return NULL;
> +
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> +	if (!entry)
> +		return NULL;

I'm probably missing something, what happens if an insertion is done, a get is
called and right at this point (before kref_get) the entry is being removed (and
freed by the driver)?

> +
> +	kref_get(&entry->ref);
> +	rdma_umap_priv_init(vma, entry);
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: key[%#llx] npages[%#x] returned\n",
> +		  key, entry->npages);
> +
> +	return entry;
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
> +	/* need to erase all entries occupied... */

To be clear, this erases all pages of a single entry right? The comment is
confusing.

> +	for (i = 0; i < entry->npages; i++) {
> +		xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
> +
> +		ibdev_dbg(ucontext->device,
> +			  "mmap: key[%#llx] npages[%#x] removed\n",
> +			  rdma_user_mmap_get_key(entry),
> +			  entry->npages);

This print can be outside of the loop, it doesn't change between iterations.

> +	}
> +	if (ucontext->device->ops.mmap_free)
> +		ucontext->device->ops.mmap_free(entry);
> +}
> +/**
> + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @entry: the entry to insert into the mmap_xa
> + * @length: length of the address that will be mmapped
> + *
> + * This function should be called by drivers that use the rdma_user_mmap
> + * interface for handling user mmapped addresses. The database is handled in
> + * the core and helper functions are provided to insert entries into the
> + * database and extract entries when the user call mmap with the given key.
> + * The function returns a unique key that should be provided to user, the user
> + * will use the key to retrieve information such as address to
> + * be mapped and how.
> + *
> + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not added.
> + */
> +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> +				struct rdma_user_mmap_entry *entry,
> +				u64 length)
> +{
> +	struct ib_uverbs_file *ufile = ucontext->ufile;
> +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> +	u32 xa_first, xa_last, npages;
> +	int err, i;
> +
> +	if (!entry)
> +		return RDMA_USER_MMAP_INVALID;
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

Doesn't the mutex replace the xa_lock?

> +
> +	/* We want to find an empty range */
> +	npages = (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> +	entry->npages = npages;
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
> +		/* Now look for the next present entry. If such doesn't
> +		 * exist, we found an empty range and can proceed
> +		 */
> +		xas_next_entry(&xas, xa_last - 1);
> +		if (xas.xa_node == XAS_BOUNDS || xas.xa_index >= xa_last)
> +			break;
> +		/* o/w look for the next free entry */
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
> +	mutex_unlock(&ufile->umap_lock);
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: key[%#llx] npages[%#x] inserted\n",
> +		  rdma_user_mmap_get_key(entry), npages);
> +
> +	return rdma_user_mmap_get_key(entry);
> +
> +err_undo:
> +	for (; i > xa_first; i--)
> +		__xa_erase(&ucontext->mmap_xa, i - 1);
> +
> +err_unlock:
> +	xa_unlock(&ucontext->mmap_xa);
> +	mutex_unlock(&ufile->umap_lock);
> +	return RDMA_USER_MMAP_INVALID;
> +}
