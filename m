Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CB58582
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0PZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 11:25:52 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:43831 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0PZw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 11:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1561649149; x=1593185149;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4fM0UaTNwa7CP32lvbvZJVm78YMxDUaXZMehVlG7QL4=;
  b=DhAQrUi//UseQ2jQc0TXKZ3WRWGbQVbXm4Zn5rbRxIvZ2frYPS+moQRq
   ovoqq3E7dk/V3uA/PR6qriCSvz+PgfDGzao6o1ty5KZaO17TI/U5hDX4J
   MfGcwhwBOey0ApLJHPt6zi9Xa2oDaEC11A3sYLglRHHWk3hI00UlF2y22
   c=;
X-IronPort-AV: E=Sophos;i="5.62,424,1554768000"; 
   d="scan'208";a="772329959"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 27 Jun 2019 15:25:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 0581AA2377;
        Thu, 27 Jun 2019 15:25:46 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 27 Jun 2019 15:25:46 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.109) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 27 Jun 2019 15:25:42 +0000
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Michal Kalderon <michal.kalderon@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <leon@kernel.org>, <sleybo@amazon.com>,
        <ariel.elior@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
Date:   Thu, 27 Jun 2019 18:25:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627135825.4924-2-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D01UWA003.ant.amazon.com (10.43.160.107) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/06/2019 16:58, Michal Kalderon wrote:
> Create a common API for adding entries to a xa_mmap.
> This API can be used by drivers that don't require special
> mapping for user mapped memory.
> 
> The code was copied from the efa driver almost as is, just renamed
> function to be generic and not efa specific.

I don't think we should force the mmap flags to be the same for all drivers..
Take a look at mlx5 for example:

enum mlx5_ib_mmap_cmd {
	MLX5_IB_MMAP_REGULAR_PAGE               = 0,
	MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES       = 1,
	MLX5_IB_MMAP_WC_PAGE                    = 2,
	MLX5_IB_MMAP_NC_PAGE                    = 3,
	/* 5 is chosen in order to be compatible with old versions of libmlx5 */
	MLX5_IB_MMAP_CORE_CLOCK                 = 5,
	MLX5_IB_MMAP_ALLOC_WC                   = 6,
	MLX5_IB_MMAP_CLOCK_INFO                 = 7,
	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
};

The flags taken from EFA aren't necessarily going to work for other drivers.
Maybe the flags bits should be opaque to ib_core and leave the actual mmap
callbacks in the drivers. Not sure how dealloc_ucontext is going to work with
opaque flags though?

> 
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/core/rdma_core.c   |   1 +
>  drivers/infiniband/core/uverbs_cmd.c  |   1 +
>  drivers/infiniband/core/uverbs_main.c | 177 ++++++++++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h               |  29 ++++++
>  4 files changed, 208 insertions(+)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index ccf4d069c25c..7166741834c8 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	rdma_restrack_del(&ucontext->res);
>  
>  	ib_dev->ops.dealloc_ucontext(ucontext);
> +	rdma_user_mmap_entries_remove_free(ucontext);

Should this happen before calling dealloc_ucontext?

>  	kfree(ucontext);
>  
>  	ufile->ucontext = NULL;
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 911533081db5..53cd38e4c509 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -243,6 +243,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
>  
>  	mutex_init(&ucontext->per_mm_list_lock);
>  	INIT_LIST_HEAD(&ucontext->per_mm_list);
> +	xa_init(&ucontext->mmap_xa);
>  
>  	ret = get_unused_fd_flags(O_CLOEXEC);
>  	if (ret < 0)
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 11c13c1381cf..e7ba855e137b 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -932,6 +932,18 @@ static const struct vm_operations_struct rdma_umap_ops = {
>   * their mmap() functions if they wish to send something like PCI-E BAR memory
>   * to userspace.
>   */
> +
> +struct rdma_user_mmap_entry {
> +	void  *obj;
> +	u64 address;
> +	u64 length;
> +	u32 mmap_page;
> +	u8 mmap_flag;
> +};
> +
> +#define RDMA_USER_MMAP_FLAG_SHIFT 56
> +#define RDMA_USER_MMAP_PAGE_MASK GENMASK(RDMA_USER_MMAP_FLAG_SHIFT - 1, 0)
> +
>  int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>  		      unsigned long pfn, unsigned long size, pgprot_t prot)
>  {
> @@ -965,6 +977,171 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL(rdma_user_mmap_io);
>  
> +static inline u64
> +rdma_user_mmap_get_key(const struct rdma_user_mmap_entry *entry)
> +{
> +	return ((u64)entry->mmap_flag << RDMA_USER_MMAP_FLAG_SHIFT) |
> +	       ((u64)entry->mmap_page << PAGE_SHIFT);
> +}
> +
> +static struct rdma_user_mmap_entry *
> +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key, u64 len)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	u64 mmap_page;
> +
> +	mmap_page = (key & RDMA_USER_MMAP_PAGE_MASK) >> PAGE_SHIFT;
> +	if (mmap_page > U32_MAX)
> +		return NULL;
> +
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> +	if (!entry || rdma_user_mmap_get_key(entry) != key ||
> +	    entry->length != len)
> +		return NULL;
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +		  entry->obj, key, entry->address, entry->length);
> +
> +	return entry;
> +}
> +
> +/*
> + * Note this locking scheme cannot support removal of entries, except during
> + * ucontext destruction when the core code guarentees no concurrency.
> + */
> +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
> +				u64 address, u64 length, u8 mmap_flag)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	int err;
> +
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return RDMA_USER_MMAP_INVALID;
> +
> +	entry->obj = obj;
> +	entry->address = address;
> +	entry->length = length;
> +	entry->mmap_flag = mmap_flag;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +	entry->mmap_page = ucontext->mmap_xa_page;
> +	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
> +	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
> +			  GFP_KERNEL);
> +	xa_unlock(&ucontext->mmap_xa);
> +	if (err) {
> +		kfree(entry);
> +		return RDMA_USER_MMAP_INVALID;
> +	}
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
> +		  entry->obj, entry->address, entry->length,
> +		  rdma_user_mmap_get_key(entry));
> +
> +	return rdma_user_mmap_get_key(entry);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_insert);

Line break here.

> +/*
> + * This is only called when the ucontext is destroyed and there can be no
> + * concurrent query via mmap or allocate on the xarray, thus we can be sure no
> + * other thread is using the entry pointer. We also know that all the BAR
> + * pages have either been zap'd or munmaped at this point.  Normal pages are
> + * refcounted and will be freed at the proper time.
> + */
> +void rdma_user_mmap_entries_remove_free(struct ib_ucontext *ucontext)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	unsigned long mmap_page;
> +
> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> +		xa_erase(&ucontext->mmap_xa, mmap_page);
> +
> +		ibdev_dbg(ucontext->device,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			  entry->obj, rdma_user_mmap_get_key(entry),
> +			  entry->address, entry->length);
> +		if (entry->mmap_flag == RDMA_USER_MMAP_DMA_PAGE)
> +			/* DMA mapping is already gone, now free the pages */
> +			free_pages_exact(phys_to_virt(entry->address),
> +					 entry->length);
> +		kfree(entry);
> +	}
> +}
