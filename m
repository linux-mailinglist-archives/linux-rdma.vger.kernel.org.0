Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8A162F7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEGLmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 07:42:01 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59712 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGLmB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 07:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557229317; x=1588765317;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=U0QkKnxkfHHTfAiXA3QJyroFVJ0dB75hLrmbygUem54=;
  b=d5bmEJ0r8f4r4a3OSMC6JeSUh3n8h8B6m9S6wdS4Wr2gD8b05YJU71nl
   +xg8fz0UGSPZKxSX47OU4nSkxcZ2XjxSQr73gzeNjh3OO3VhbAg+ioOKi
   SuMUyA1VStdskmyhTUUXVtfF8vDVL5b0e0bNfITE5ZlcDqf85x+eb8K06
   M=;
X-IronPort-AV: E=Sophos;i="5.60,441,1549929600"; 
   d="scan'208";a="803288845"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 May 2019 11:41:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x47Bfiuw013670
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 May 2019 11:41:50 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 May 2019 11:41:49 +0000
Received: from [10.218.62.23] (10.43.160.175) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 7 May
 2019 11:41:41 +0000
Subject: Re: [PATCH for-next v7 09/11] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
 <1557079171-19329-10-git-send-email-galpress@amazon.com>
 <20190506181726.GA3231@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <70d1232b-eca2-ca8a-b964-7c82af1f7654@amazon.com>
Date:   Tue, 7 May 2019 14:41:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506181726.GA3231@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.175]
X-ClientProxiedBy: EX13D11UWC003.ant.amazon.com (10.43.162.162) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06-May-19 21:17, Jason Gunthorpe wrote:
> On Sun, May 05, 2019 at 08:59:29PM +0300, Gal Pressman wrote:
>> +/*
>> + * Since we don't track munmaps, we can't know when a user stopped using his
>> + * mmapped buffers.
>> + * This should be called on dealloc_ucontext in order to drain the mmap entries
>> + * and free the (unmapped) DMA buffers.
>> + */
>> +static void mmap_entries_remove_free(struct efa_dev *dev,
>> +				     struct efa_ucontext *ucontext)
>> +{
>> +	struct efa_mmap_entry *entry;
>> +	unsigned long mmap_page;
>> +
>> +	xa_lock(&ucontext->mmap_xa);
>> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
>> +		__xa_erase(&ucontext->mmap_xa, mmap_page);
>> +		ibdev_dbg(&dev->ibdev,
>> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
>> +			  entry->obj, entry->key, entry->address, entry->length);
>> +		if (get_mmap_flag(entry->key) == EFA_MMAP_DMA_PAGE)
>> +			/* DMA mapping is already gone, now free the pages */
>> +			free_pages_exact(phys_to_virt(entry->address),
>> +					 entry->length);
>> +		kfree(entry);
>> +	}
>> +	xa_unlock(&ucontext->mmap_xa);
>> +}
>> +
>> +static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
>> +					     struct efa_ucontext *ucontext,
>> +					     u64 key,
>> +					     u64 len)
>> +{
>> +	struct efa_mmap_entry *entry;
>> +	u32 mmap_page;
>> +
>> +	xa_lock(&ucontext->mmap_xa);
>> +	mmap_page = lower_32_bits(key >> PAGE_SHIFT);
>> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
>> +	if (!entry || entry->key != key || entry->length != len) {
>> +		xa_unlock(&ucontext->mmap_xa);
>> +		return NULL;
>> +	}
>> +
>> +	ibdev_dbg(&dev->ibdev,
>> +		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
>> +		  entry->obj, key, entry->address,
>> +		  entry->length);
>> +	xa_unlock(&ucontext->mmap_xa);
>> +
>> +	return entry;
> 
> Bah, this is now so convoluted.
> 
> The prior code had two locking problems, the first was it was freeing
> entries during error unwind and the second was around xa_alloc.
> 
> The error unwind was solved by deleting the error unwind and leaking
> the ID's (fine)
> 
> The xa_alloc thing is much better solved by just using xa_alloc
> properly than trying to squeeze in a weird looking xa_lock like this
> 
> Also, I'm sure I mentioned this once, but when using the xarray you
> still have to generate non overlapping offset ranges for the various
> objects of different size being returned.
> 
> Also the lookup doesn't work right if PAGE_SIZE is too big (doesn't
> mask EFA_FLAGS)
> 
> I fixed all this with this patch. Let me know by EOD Tueday if I got
> it right:
> 
>  drivers/infiniband/hw/efa/efa.h       |   1 +
>  drivers/infiniband/hw/efa/efa_verbs.c | 264 +++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------
>  2 files changed, 110 insertions(+), 155 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> index 0061e6257d1c14..9e3cc3239c13da 100644
> --- a/drivers/infiniband/hw/efa/efa.h
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -74,6 +74,7 @@ struct efa_dev {
>  struct efa_ucontext {
>  	struct ib_ucontext ibucontext;
>  	struct xarray mmap_xa;
> +	u32 mmap_xa_page;
>  	u16 uarn;
>  };
>  
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 33a8018362835d..16a9a109f32195 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -14,6 +14,8 @@
>  #include "efa.h"
>  
>  #define EFA_MMAP_FLAG_SHIFT 56
> +#define EFA_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
> +#define EFA_MMAP_INVALID U64_MAX
>  
>  enum {
>  	EFA_MMAP_DMA_PAGE = 0,
> @@ -21,16 +23,6 @@ enum {
>  	EFA_MMAP_IO_NC,
>  };
>  
> -static void set_mmap_flag(u64 *mmap_key, u8 mmap_flag)
> -{
> -	*mmap_key |= (u64)mmap_flag << EFA_MMAP_FLAG_SHIFT;
> -}
> -
> -static u8 get_mmap_flag(u64 mmap_key)
> -{
> -	return mmap_key >> EFA_MMAP_FLAG_SHIFT;
> -}
> -
>  #define EFA_AENQ_ENABLED_GROUPS \
>  	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
>  	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
> @@ -39,9 +31,16 @@ struct efa_mmap_entry {
>  	void  *obj;
>  	u64 address;
>  	u64 length;
> -	u64 key;
> +	u32 mmap_page;
> +	u8 mmap_flag;
>  };
>  
> +static inline u64 get_mmap_key(const struct efa_mmap_entry *efa)
> +{
> +	return ((u64)efa->mmap_flag << EFA_MMAP_FLAG_SHIFT) |
> +	       ((u64)efa->mmap_page << PAGE_SHIFT);
> +}
> +
>  #define EFA_CHUNK_PAYLOAD_SHIFT       12
>  #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
>  #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
> @@ -147,10 +146,11 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
>  }
>  
>  /*
> - * Since we don't track munmaps, we can't know when a user stopped using his
> - * mmapped buffers.
> - * This should be called on dealloc_ucontext in order to drain the mmap entries
> - * and free the (unmapped) DMA buffers.
> + * This is only called when the ucontext is destroyed and there can be no
> + * concurrent query via mmap or allocate on the xarray, thus we can be sure no
> + * other thread is using the entry pointer. We also know that all the BAR
> + * pages have either been zap'd or munmaped at this point.  Normal pages are
> + * refcounted and will be freed at the proper time.
>   */
>  static void mmap_entries_remove_free(struct efa_dev *dev,
>  				     struct efa_ucontext *ucontext)
> @@ -158,72 +158,82 @@ static void mmap_entries_remove_free(struct efa_dev *dev,
>  	struct efa_mmap_entry *entry;
>  	unsigned long mmap_page;
>  
> -	xa_lock(&ucontext->mmap_xa);
>  	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> -		__xa_erase(&ucontext->mmap_xa, mmap_page);
> -		ibdev_dbg(&dev->ibdev,
> -			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> -			  entry->obj, entry->key, entry->address, entry->length);
> -		if (get_mmap_flag(entry->key) == EFA_MMAP_DMA_PAGE)
> +		xa_erase(&ucontext->mmap_xa, mmap_page);
> +
> +		ibdev_dbg(
> +			&dev->ibdev,
> +			"mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			entry->obj, get_mmap_key(entry), entry->address,
> +			entry->length);
> +		if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
>  			/* DMA mapping is already gone, now free the pages */
>  			free_pages_exact(phys_to_virt(entry->address),
>  					 entry->length);
>  		kfree(entry);
>  	}
> -	xa_unlock(&ucontext->mmap_xa);
>  }
>  
>  static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
>  					     struct efa_ucontext *ucontext,
> -					     u64 key,
> -					     u64 len)
> +					     u64 key, u64 len)
>  {
>  	struct efa_mmap_entry *entry;
> -	u32 mmap_page;
> +	u64 mmap_page;
> +
> +	mmap_page = (key & EFA_MMAP_PAGE_MASK) >> PAGE_SHIFT;
> +	if (mmap_page > U32_MAX)
> +		return NULL;
>  
> -	xa_lock(&ucontext->mmap_xa);
> -	mmap_page = lower_32_bits(key >> PAGE_SHIFT);
>  	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> -	if (!entry || entry->key != key || entry->length != len) {
> +	if (!entry || get_mmap_key(entry) != key || entry->length != len) {
>  		xa_unlock(&ucontext->mmap_xa);
>  		return NULL;
>  	}
>  
>  	ibdev_dbg(&dev->ibdev,
>  		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> -		  entry->obj, key, entry->address,
> -		  entry->length);
> -	xa_unlock(&ucontext->mmap_xa);
> +		  entry->obj, key, entry->address, entry->length);
>  
>  	return entry;
>  }
>  
> -static int mmap_entry_insert(struct efa_dev *dev,
> -			     struct efa_ucontext *ucontext,
> -			     struct efa_mmap_entry *entry,
> -			     u8 mmap_flag)
> +/*
> + * Note this locking scheme cannot support removal of entries, except during
> + * ucontext destruction when the core code guarentees no concurrency.
> + */
> +static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
> +			     void *obj, u64 address, u64 length, u8 mmap_flag)
>  {
> -	u32 mmap_page;
> +	struct efa_mmap_entry *entry;
>  	int err;
>  
> -	xa_lock(&ucontext->mmap_xa);
> -	err = __xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
> -			 GFP_KERNEL);
> -	if (err) {
> -		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
> -		xa_unlock(&ucontext->mmap_xa);
> -		return err;
> -	}
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return EFA_MMAP_INVALID;
>  
> -	entry->key = (u64)mmap_page << PAGE_SHIFT;
> -	set_mmap_flag(&entry->key, mmap_flag);
> +	entry->obj = obj;
> +	entry->address = address;
> +	entry->length = length;
> +	entry->mmap_flag = mmap_flag;
>  
> -	ibdev_dbg(&dev->ibdev,
> -		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
> -		  entry->obj, entry->address, entry->length, entry->key);
> +	xa_lock(&ucontext->mmap_xa);
> +	entry->mmap_page = ucontext->mmap_xa_page;
> +	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
> +	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
> +			  GFP_KERNEL);
>  	xa_unlock(&ucontext->mmap_xa);
> +	if (err){
> +		kfree(entry);
> +		return EFA_MMAP_INVALID;
> +	}
>  
> -	return 0;
> +	ibdev_dbg(
> +		&dev->ibdev,
> +		"mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
> +		entry->obj, entry->address, entry->length, get_mmap_key(entry));
> +
> +	return get_mmap_key(entry);
>  }
>  
>  int efa_query_device(struct ib_device *ibdev,
> @@ -481,84 +491,45 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
>  				 struct efa_com_create_qp_params *params,
>  				 struct efa_ibv_create_qp_resp *resp)
>  {
> -	struct efa_mmap_entry *rq_db_entry;
> -	struct efa_mmap_entry *sq_db_entry;
> -	struct efa_mmap_entry *rq_entry;
> -	struct efa_mmap_entry *sq_entry;
> -	int err;
> -
>  	/*
>  	 * Once an entry is inserted it might be mmapped, hence cannot be
>  	 * cleaned up until dealloc_ucontext.
>  	 */
> -	sq_db_entry = kzalloc(sizeof(*sq_db_entry), GFP_KERNEL);
> -	if (!sq_db_entry)
> -		return -ENOMEM;
> -
> -	sq_db_entry->obj = qp;
> -	sq_db_entry->address = dev->db_bar_addr + resp->sq_db_offset;
>  	resp->sq_db_offset &= ~PAGE_MASK;
> -	sq_db_entry->length = PAGE_SIZE;
> -	err = mmap_entry_insert(dev, ucontext, sq_db_entry,
> -				EFA_MMAP_IO_NC);
> -	if (err) {
> -		kfree(sq_db_entry);
> -		return -ENOMEM;
> -	}
> -
> -	resp->sq_db_mmap_key = sq_db_entry->key;
> -
> -	sq_entry = kzalloc(sizeof(*sq_entry), GFP_KERNEL);
> -	if (!sq_entry)
> +	resp->sq_db_mmap_key =
> +		mmap_entry_insert(dev, ucontext, qp,
> +				  dev->db_bar_addr + resp->sq_db_offset,
> +				  PAGE_SIZE, EFA_MMAP_IO_NC);
> +	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
>  		return -ENOMEM;
>  
> -	sq_entry->obj = qp;
> -	sq_entry->address = dev->mem_bar_addr + resp->llq_desc_offset;
>  	resp->llq_desc_offset &= ~PAGE_MASK;
> -	sq_entry->length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
> -				      resp->llq_desc_offset);
> -	err = mmap_entry_insert(dev, ucontext, sq_entry, EFA_MMAP_IO_WC);
> -	if (err) {
> -		kfree(sq_entry);
> +	resp->llq_desc_mmap_key =
> +		mmap_entry_insert(dev, ucontext, qp,
> +				  dev->mem_bar_addr + resp->llq_desc_offset,
> +				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
> +					     resp->llq_desc_offset),
> +				  EFA_MMAP_IO_WC);
> +	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
>  		return -ENOMEM;
> -	}
> -
> -	resp->llq_desc_mmap_key = sq_entry->key;
>  
>  	if (qp->rq_size) {
> -		rq_db_entry = kzalloc(sizeof(*rq_db_entry), GFP_KERNEL);
> -		if (!rq_db_entry)
> +		resp->rq_db_mmap_key =
> +			mmap_entry_insert(dev, ucontext, qp,
> +					  dev->db_bar_addr + resp->rq_db_offset,
> +					  PAGE_SIZE, EFA_MMAP_IO_NC);
> +		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
>  			return -ENOMEM;
>  
> -		rq_db_entry->obj = qp;
> -		rq_db_entry->address = dev->db_bar_addr +
> -				       resp->rq_db_offset;
> -		rq_db_entry->length = PAGE_SIZE;
> -		err = mmap_entry_insert(dev, ucontext, rq_db_entry,
> -					EFA_MMAP_IO_NC);
> -		if (err) {
> -			kfree(rq_db_entry);
> -			return -ENOMEM;
> -		}
> -
> -		resp->rq_db_mmap_key = rq_db_entry->key;
>  		resp->rq_db_offset &= ~PAGE_MASK;
>  
> -		rq_entry = kzalloc(sizeof(*rq_entry), GFP_KERNEL);
> -		if (!rq_entry)
> -			return -ENOMEM;
> -
> -		rq_entry->obj = qp;
> -		rq_entry->address = virt_to_phys(qp->rq_cpu_addr);
> -		rq_entry->length = qp->rq_size;
> -		err = mmap_entry_insert(dev, ucontext, rq_entry,
> -					EFA_MMAP_DMA_PAGE);
> -		if (err) {
> -			kfree(rq_entry);
> +		resp->rq_mmap_key =
> +			mmap_entry_insert(dev, ucontext, qp,
> +					  virt_to_phys(qp->rq_cpu_addr),
> +					  qp->rq_size, EFA_MMAP_DMA_PAGE);
> +		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
>  			return -ENOMEM;
> -		}
>  
> -		resp->rq_mmap_key = rq_entry->key;
>  		resp->rq_mmap_size = qp->rq_size;
>  	}
>  
> @@ -918,25 +889,13 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
>  				 struct efa_ibv_create_cq_resp *resp)
>  {
> -	struct efa_mmap_entry *cq_entry;
> -	int err;
> -
> -	cq_entry = kzalloc(sizeof(*cq_entry), GFP_KERNEL);
> -	if (!cq_entry)
> +	resp->q_mmap_size = cq->size;
> +	resp->q_mmap_key = mmap_entry_insert(dev, cq->ucontext, cq,
> +					     virt_to_phys(cq->cpu_addr),
> +					     cq->size, EFA_MMAP_DMA_PAGE);
> +	if (resp->q_mmap_key == EFA_MMAP_INVALID)
>  		return -ENOMEM;
>  
> -	cq_entry->obj = cq;
> -	cq_entry->address = virt_to_phys(cq->cpu_addr);
> -	cq_entry->length = cq->size;
> -	err = mmap_entry_insert(dev, cq->ucontext, cq_entry, EFA_MMAP_DMA_PAGE);
> -	if (err) {
> -		kfree(cq_entry);
> -		return err;
> -	}
> -
> -	resp->q_mmap_key = cq_entry->key;
> -	resp->q_mmap_size = cq_entry->length;
> -
>  	return 0;
>  }
>  
> @@ -1663,7 +1622,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
>  		goto err_out;
>  
>  	ucontext->uarn = result.uarn;
> -	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
> +	xa_init(&ucontext->mmap_xa);
>  
>  	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
>  	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
> @@ -1696,23 +1655,27 @@ void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
>  	efa_dealloc_uar(dev, ucontext->uarn);
>  }
>  
> -static int __efa_mmap(struct efa_dev *dev,
> -		      struct efa_ucontext *ucontext,
> -		      struct vm_area_struct *vma,
> -		      struct efa_mmap_entry *entry)
> +static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> +		      struct vm_area_struct *vma, u64 key, u64 length)
>  {
> -	u8 mmap_flag = get_mmap_flag(entry->key);
> -	u64 pfn = entry->address >> PAGE_SHIFT;
> -	u64 address = entry->address;
> -	u64 length = entry->length;
> +	struct efa_mmap_entry *entry;
>  	unsigned long va;
> +	u64 pfn;
>  	int err;
>  
> +	entry = mmap_entry_get(dev, ucontext, key, length);
> +	if (!entry) {
> +		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
> +			  key);
> +		return -EINVAL;
> +	}
> +
>  	ibdev_dbg(&dev->ibdev,
>  		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
> -		  address, length, mmap_flag);
> +		  entry->address, length, entry->mmap_flag);
>  
> -	switch (mmap_flag) {
> +	pfn = entry->address >> PAGE_SHIFT;
> +	switch (entry->mmap_flag) {
>  	case EFA_MMAP_IO_NC:
>  		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
>  					pgprot_noncached(vma->vm_page_prot));
> @@ -1733,14 +1696,13 @@ static int __efa_mmap(struct efa_dev *dev,
>  		err = -EINVAL;
>  	}
>  
> -	if (err) {
> -		ibdev_dbg(&dev->ibdev,
> -			  "Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
> -			  address, length, mmap_flag, err);
> -		return err;
> -	}
> +	if (err)
> +		ibdev_dbg(
> +			&dev->ibdev,
> +			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
> +			entry->address, length, entry->mmap_flag, err);
>  
> -	return 0;
> +	return err;
>  }
>  
>  int efa_mmap(struct ib_ucontext *ibucontext,
> @@ -1750,7 +1712,6 @@ int efa_mmap(struct ib_ucontext *ibucontext,
>  	struct efa_dev *dev = to_edev(ibucontext->device);
>  	u64 length = vma->vm_end - vma->vm_start;
>  	u64 key = vma->vm_pgoff << PAGE_SHIFT;
> -	struct efa_mmap_entry *entry;
>  
>  	ibdev_dbg(&dev->ibdev,
>  		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
> @@ -1769,14 +1730,7 @@ int efa_mmap(struct ib_ucontext *ibucontext,
>  	}
>  	vma->vm_flags &= ~VM_MAYEXEC;
>  
> -	entry = mmap_entry_get(dev, ucontext, key, length);
> -	if (!entry) {
> -		ibdev_dbg(&dev->ibdev,
> -			  "key[%#llx] does not have valid entry\n", key);
> -		return -EINVAL;
> -	}
> -
> -	return __efa_mmap(dev, ucontext, vma, entry);
> +	return __efa_mmap(dev, ucontext, vma, key, length);
>  }
>  
>  static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
> 

Thanks Jason, looks good!
Some minor fixes:

 drivers/infiniband/hw/efa/efa_verbs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 16a9a109f321..6d6886c9009f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -186,10 +186,8 @@ static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
 		return NULL;
 
 	entry = xa_load(&ucontext->mmap_xa, mmap_page);
-	if (!entry || get_mmap_key(entry) != key || entry->length != len) {
-		xa_unlock(&ucontext->mmap_xa);
+	if (!entry || get_mmap_key(entry) != key || entry->length != len)
 		return NULL;
-	}
 
 	ibdev_dbg(&dev->ibdev,
 		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
@@ -495,7 +493,6 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	 * Once an entry is inserted it might be mmapped, hence cannot be
 	 * cleaned up until dealloc_ucontext.
 	 */
-	resp->sq_db_offset &= ~PAGE_MASK;
 	resp->sq_db_mmap_key =
 		mmap_entry_insert(dev, ucontext, qp,
 				  dev->db_bar_addr + resp->sq_db_offset,
@@ -503,16 +500,19 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
 		return -ENOMEM;
 
-	resp->llq_desc_offset &= ~PAGE_MASK;
+	resp->sq_db_offset &= ~PAGE_MASK;
+
 	resp->llq_desc_mmap_key =
 		mmap_entry_insert(dev, ucontext, qp,
 				  dev->mem_bar_addr + resp->llq_desc_offset,
 				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
-					     resp->llq_desc_offset),
+					     (resp->llq_desc_offset & ~PAGE_MASK)),
 				  EFA_MMAP_IO_WC);
 	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
 		return -ENOMEM;
 
+	resp->llq_desc_offset &= ~PAGE_MASK;
+
 	if (qp->rq_size) {
 		resp->rq_db_mmap_key =
 			mmap_entry_insert(dev, ucontext, qp,
