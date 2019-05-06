Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C315383
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFSR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 14:17:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35599 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEFSR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 14:17:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id d20so5831039qto.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THtTa1KibYuMz32iNRJ1G2PfcXauZRdB4fcmEqQBcgg=;
        b=agD0brL/EywFZEksyYSmoFWpsL4GOxam5QxOCXl1QESnt6anvlS1d6kuzDQN1MqIB4
         E/koO3Uf3Zr4cy+4ZAORSykdvSxMMNGE/2OLH4HLy/PzYjFMMENkNGTIIDlUgHRAE7vA
         hug+W1P6ZyioDNrJjQfGEtsH7oj56P6jJWRau+K/kwXL2C4xZ0u84qVbmhcyNXg9HoLe
         I+UouFlu/o10EI8IC5esu08BIcFPC/e8j3SJVyp9X7hHK/Tqa6Ga96yhDL8XLTKxZ79V
         wDNZQha0p+Dwm7Kthzxq9IFDt1CFsGLh6v//vLAePZsEHFgmF2PWpIX/Yn5MCk2ltXu5
         ulrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THtTa1KibYuMz32iNRJ1G2PfcXauZRdB4fcmEqQBcgg=;
        b=coef0DLclNoD6whDDE65ETgMHixkd2ptOASmkphlIPKni93H2ultHm2wcqHKkpt+da
         hUxpnTVriDGIyw9HpqEIozisrzIfKCSEmMsyo4DnMu7xnOe9FgJ4XCMfzjSrhlB1qDMJ
         Gwxptk7nPXt880rEXud6Ec5EH86Fq1n4XziZJW39VUrgKum/RI8cBBpqGHSDSEgvQ72I
         //YwQtPSiB5QHyWtBO9f971ZLO1+vdNDLSasNeztlBMjtfhgO3KZ3AaW+MpLJhYdE85l
         R0UCxP/5NubJ9AoK5BcRl3jWBor9iIVVsYrqTDtieTtCLJURMbM+QNilFIrvSbQ3yigM
         lhUg==
X-Gm-Message-State: APjAAAUp0rpw/048dXgOYfYqGcTLzbJpjpRglhJFCEa6GQiM2V9QYwsB
        hAda+sSswq5J/1tivnvdICsQVw==
X-Google-Smtp-Source: APXvYqxfR7EXtjYdMJ25aEti1WoDX6mB63cccNbImzMUJg3QSk8jkbEbdvXwGuMx+i+AlZabth09pg==
X-Received: by 2002:ac8:27aa:: with SMTP id w39mr23677401qtw.227.1557166647893;
        Mon, 06 May 2019 11:17:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 62sm6283459qtf.89.2019.05.06.11.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 11:17:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNiB4-0006Qk-CD; Mon, 06 May 2019 15:17:26 -0300
Date:   Mon, 6 May 2019 15:17:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v7 09/11] RDMA/efa: Add EFA verbs implementation
Message-ID: <20190506181726.GA3231@ziepe.ca>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
 <1557079171-19329-10-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557079171-19329-10-git-send-email-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 08:59:29PM +0300, Gal Pressman wrote:
> +/*
> + * Since we don't track munmaps, we can't know when a user stopped using his
> + * mmapped buffers.
> + * This should be called on dealloc_ucontext in order to drain the mmap entries
> + * and free the (unmapped) DMA buffers.
> + */
> +static void mmap_entries_remove_free(struct efa_dev *dev,
> +				     struct efa_ucontext *ucontext)
> +{
> +	struct efa_mmap_entry *entry;
> +	unsigned long mmap_page;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> +		__xa_erase(&ucontext->mmap_xa, mmap_page);
> +		ibdev_dbg(&dev->ibdev,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			  entry->obj, entry->key, entry->address, entry->length);
> +		if (get_mmap_flag(entry->key) == EFA_MMAP_DMA_PAGE)
> +			/* DMA mapping is already gone, now free the pages */
> +			free_pages_exact(phys_to_virt(entry->address),
> +					 entry->length);
> +		kfree(entry);
> +	}
> +	xa_unlock(&ucontext->mmap_xa);
> +}
> +
> +static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
> +					     struct efa_ucontext *ucontext,
> +					     u64 key,
> +					     u64 len)
> +{
> +	struct efa_mmap_entry *entry;
> +	u32 mmap_page;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +	mmap_page = lower_32_bits(key >> PAGE_SHIFT);
> +	entry = xa_load(&ucontext->mmap_xa, mmap_page);
> +	if (!entry || entry->key != key || entry->length != len) {
> +		xa_unlock(&ucontext->mmap_xa);
> +		return NULL;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +		  entry->obj, key, entry->address,
> +		  entry->length);
> +	xa_unlock(&ucontext->mmap_xa);
> +
> +	return entry;

Bah, this is now so convoluted.

The prior code had two locking problems, the first was it was freeing
entries during error unwind and the second was around xa_alloc.

The error unwind was solved by deleting the error unwind and leaking
the ID's (fine)

The xa_alloc thing is much better solved by just using xa_alloc
properly than trying to squeeze in a weird looking xa_lock like this

Also, I'm sure I mentioned this once, but when using the xarray you
still have to generate non overlapping offset ranges for the various
objects of different size being returned.

Also the lookup doesn't work right if PAGE_SIZE is too big (doesn't
mask EFA_FLAGS)

I fixed all this with this patch. Let me know by EOD Tueday if I got
it right:

 drivers/infiniband/hw/efa/efa.h       |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 264 +++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------
 2 files changed, 110 insertions(+), 155 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 0061e6257d1c14..9e3cc3239c13da 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -74,6 +74,7 @@ struct efa_dev {
 struct efa_ucontext {
 	struct ib_ucontext ibucontext;
 	struct xarray mmap_xa;
+	u32 mmap_xa_page;
 	u16 uarn;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 33a8018362835d..16a9a109f32195 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -14,6 +14,8 @@
 #include "efa.h"
 
 #define EFA_MMAP_FLAG_SHIFT 56
+#define EFA_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
+#define EFA_MMAP_INVALID U64_MAX
 
 enum {
 	EFA_MMAP_DMA_PAGE = 0,
@@ -21,16 +23,6 @@ enum {
 	EFA_MMAP_IO_NC,
 };
 
-static void set_mmap_flag(u64 *mmap_key, u8 mmap_flag)
-{
-	*mmap_key |= (u64)mmap_flag << EFA_MMAP_FLAG_SHIFT;
-}
-
-static u8 get_mmap_flag(u64 mmap_key)
-{
-	return mmap_key >> EFA_MMAP_FLAG_SHIFT;
-}
-
 #define EFA_AENQ_ENABLED_GROUPS \
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
@@ -39,9 +31,16 @@ struct efa_mmap_entry {
 	void  *obj;
 	u64 address;
 	u64 length;
-	u64 key;
+	u32 mmap_page;
+	u8 mmap_flag;
 };
 
+static inline u64 get_mmap_key(const struct efa_mmap_entry *efa)
+{
+	return ((u64)efa->mmap_flag << EFA_MMAP_FLAG_SHIFT) |
+	       ((u64)efa->mmap_page << PAGE_SHIFT);
+}
+
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
 #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
 #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
@@ -147,10 +146,11 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
 }
 
 /*
- * Since we don't track munmaps, we can't know when a user stopped using his
- * mmapped buffers.
- * This should be called on dealloc_ucontext in order to drain the mmap entries
- * and free the (unmapped) DMA buffers.
+ * This is only called when the ucontext is destroyed and there can be no
+ * concurrent query via mmap or allocate on the xarray, thus we can be sure no
+ * other thread is using the entry pointer. We also know that all the BAR
+ * pages have either been zap'd or munmaped at this point.  Normal pages are
+ * refcounted and will be freed at the proper time.
  */
 static void mmap_entries_remove_free(struct efa_dev *dev,
 				     struct efa_ucontext *ucontext)
@@ -158,72 +158,82 @@ static void mmap_entries_remove_free(struct efa_dev *dev,
 	struct efa_mmap_entry *entry;
 	unsigned long mmap_page;
 
-	xa_lock(&ucontext->mmap_xa);
 	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
-		__xa_erase(&ucontext->mmap_xa, mmap_page);
-		ibdev_dbg(&dev->ibdev,
-			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-			  entry->obj, entry->key, entry->address, entry->length);
-		if (get_mmap_flag(entry->key) == EFA_MMAP_DMA_PAGE)
+		xa_erase(&ucontext->mmap_xa, mmap_page);
+
+		ibdev_dbg(
+			&dev->ibdev,
+			"mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
+			entry->obj, get_mmap_key(entry), entry->address,
+			entry->length);
+		if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
 			/* DMA mapping is already gone, now free the pages */
 			free_pages_exact(phys_to_virt(entry->address),
 					 entry->length);
 		kfree(entry);
 	}
-	xa_unlock(&ucontext->mmap_xa);
 }
 
 static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
 					     struct efa_ucontext *ucontext,
-					     u64 key,
-					     u64 len)
+					     u64 key, u64 len)
 {
 	struct efa_mmap_entry *entry;
-	u32 mmap_page;
+	u64 mmap_page;
+
+	mmap_page = (key & EFA_MMAP_PAGE_MASK) >> PAGE_SHIFT;
+	if (mmap_page > U32_MAX)
+		return NULL;
 
-	xa_lock(&ucontext->mmap_xa);
-	mmap_page = lower_32_bits(key >> PAGE_SHIFT);
 	entry = xa_load(&ucontext->mmap_xa, mmap_page);
-	if (!entry || entry->key != key || entry->length != len) {
+	if (!entry || get_mmap_key(entry) != key || entry->length != len) {
 		xa_unlock(&ucontext->mmap_xa);
 		return NULL;
 	}
 
 	ibdev_dbg(&dev->ibdev,
 		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-		  entry->obj, key, entry->address,
-		  entry->length);
-	xa_unlock(&ucontext->mmap_xa);
+		  entry->obj, key, entry->address, entry->length);
 
 	return entry;
 }
 
-static int mmap_entry_insert(struct efa_dev *dev,
-			     struct efa_ucontext *ucontext,
-			     struct efa_mmap_entry *entry,
-			     u8 mmap_flag)
+/*
+ * Note this locking scheme cannot support removal of entries, except during
+ * ucontext destruction when the core code guarentees no concurrency.
+ */
+static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
+			     void *obj, u64 address, u64 length, u8 mmap_flag)
 {
-	u32 mmap_page;
+	struct efa_mmap_entry *entry;
 	int err;
 
-	xa_lock(&ucontext->mmap_xa);
-	err = __xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
-			 GFP_KERNEL);
-	if (err) {
-		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
-		xa_unlock(&ucontext->mmap_xa);
-		return err;
-	}
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return EFA_MMAP_INVALID;
 
-	entry->key = (u64)mmap_page << PAGE_SHIFT;
-	set_mmap_flag(&entry->key, mmap_flag);
+	entry->obj = obj;
+	entry->address = address;
+	entry->length = length;
+	entry->mmap_flag = mmap_flag;
 
-	ibdev_dbg(&dev->ibdev,
-		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
-		  entry->obj, entry->address, entry->length, entry->key);
+	xa_lock(&ucontext->mmap_xa);
+	entry->mmap_page = ucontext->mmap_xa_page;
+	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
+	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
+			  GFP_KERNEL);
 	xa_unlock(&ucontext->mmap_xa);
+	if (err){
+		kfree(entry);
+		return EFA_MMAP_INVALID;
+	}
 
-	return 0;
+	ibdev_dbg(
+		&dev->ibdev,
+		"mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
+		entry->obj, entry->address, entry->length, get_mmap_key(entry));
+
+	return get_mmap_key(entry);
 }
 
 int efa_query_device(struct ib_device *ibdev,
@@ -481,84 +491,45 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 				 struct efa_com_create_qp_params *params,
 				 struct efa_ibv_create_qp_resp *resp)
 {
-	struct efa_mmap_entry *rq_db_entry;
-	struct efa_mmap_entry *sq_db_entry;
-	struct efa_mmap_entry *rq_entry;
-	struct efa_mmap_entry *sq_entry;
-	int err;
-
 	/*
 	 * Once an entry is inserted it might be mmapped, hence cannot be
 	 * cleaned up until dealloc_ucontext.
 	 */
-	sq_db_entry = kzalloc(sizeof(*sq_db_entry), GFP_KERNEL);
-	if (!sq_db_entry)
-		return -ENOMEM;
-
-	sq_db_entry->obj = qp;
-	sq_db_entry->address = dev->db_bar_addr + resp->sq_db_offset;
 	resp->sq_db_offset &= ~PAGE_MASK;
-	sq_db_entry->length = PAGE_SIZE;
-	err = mmap_entry_insert(dev, ucontext, sq_db_entry,
-				EFA_MMAP_IO_NC);
-	if (err) {
-		kfree(sq_db_entry);
-		return -ENOMEM;
-	}
-
-	resp->sq_db_mmap_key = sq_db_entry->key;
-
-	sq_entry = kzalloc(sizeof(*sq_entry), GFP_KERNEL);
-	if (!sq_entry)
+	resp->sq_db_mmap_key =
+		mmap_entry_insert(dev, ucontext, qp,
+				  dev->db_bar_addr + resp->sq_db_offset,
+				  PAGE_SIZE, EFA_MMAP_IO_NC);
+	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
 		return -ENOMEM;
 
-	sq_entry->obj = qp;
-	sq_entry->address = dev->mem_bar_addr + resp->llq_desc_offset;
 	resp->llq_desc_offset &= ~PAGE_MASK;
-	sq_entry->length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
-				      resp->llq_desc_offset);
-	err = mmap_entry_insert(dev, ucontext, sq_entry, EFA_MMAP_IO_WC);
-	if (err) {
-		kfree(sq_entry);
+	resp->llq_desc_mmap_key =
+		mmap_entry_insert(dev, ucontext, qp,
+				  dev->mem_bar_addr + resp->llq_desc_offset,
+				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
+					     resp->llq_desc_offset),
+				  EFA_MMAP_IO_WC);
+	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
 		return -ENOMEM;
-	}
-
-	resp->llq_desc_mmap_key = sq_entry->key;
 
 	if (qp->rq_size) {
-		rq_db_entry = kzalloc(sizeof(*rq_db_entry), GFP_KERNEL);
-		if (!rq_db_entry)
+		resp->rq_db_mmap_key =
+			mmap_entry_insert(dev, ucontext, qp,
+					  dev->db_bar_addr + resp->rq_db_offset,
+					  PAGE_SIZE, EFA_MMAP_IO_NC);
+		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
 			return -ENOMEM;
 
-		rq_db_entry->obj = qp;
-		rq_db_entry->address = dev->db_bar_addr +
-				       resp->rq_db_offset;
-		rq_db_entry->length = PAGE_SIZE;
-		err = mmap_entry_insert(dev, ucontext, rq_db_entry,
-					EFA_MMAP_IO_NC);
-		if (err) {
-			kfree(rq_db_entry);
-			return -ENOMEM;
-		}
-
-		resp->rq_db_mmap_key = rq_db_entry->key;
 		resp->rq_db_offset &= ~PAGE_MASK;
 
-		rq_entry = kzalloc(sizeof(*rq_entry), GFP_KERNEL);
-		if (!rq_entry)
-			return -ENOMEM;
-
-		rq_entry->obj = qp;
-		rq_entry->address = virt_to_phys(qp->rq_cpu_addr);
-		rq_entry->length = qp->rq_size;
-		err = mmap_entry_insert(dev, ucontext, rq_entry,
-					EFA_MMAP_DMA_PAGE);
-		if (err) {
-			kfree(rq_entry);
+		resp->rq_mmap_key =
+			mmap_entry_insert(dev, ucontext, qp,
+					  virt_to_phys(qp->rq_cpu_addr),
+					  qp->rq_size, EFA_MMAP_DMA_PAGE);
+		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
 			return -ENOMEM;
-		}
 
-		resp->rq_mmap_key = rq_entry->key;
 		resp->rq_mmap_size = qp->rq_size;
 	}
 
@@ -918,25 +889,13 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 				 struct efa_ibv_create_cq_resp *resp)
 {
-	struct efa_mmap_entry *cq_entry;
-	int err;
-
-	cq_entry = kzalloc(sizeof(*cq_entry), GFP_KERNEL);
-	if (!cq_entry)
+	resp->q_mmap_size = cq->size;
+	resp->q_mmap_key = mmap_entry_insert(dev, cq->ucontext, cq,
+					     virt_to_phys(cq->cpu_addr),
+					     cq->size, EFA_MMAP_DMA_PAGE);
+	if (resp->q_mmap_key == EFA_MMAP_INVALID)
 		return -ENOMEM;
 
-	cq_entry->obj = cq;
-	cq_entry->address = virt_to_phys(cq->cpu_addr);
-	cq_entry->length = cq->size;
-	err = mmap_entry_insert(dev, cq->ucontext, cq_entry, EFA_MMAP_DMA_PAGE);
-	if (err) {
-		kfree(cq_entry);
-		return err;
-	}
-
-	resp->q_mmap_key = cq_entry->key;
-	resp->q_mmap_size = cq_entry->length;
-
 	return 0;
 }
 
@@ -1663,7 +1622,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 
 	ucontext->uarn = result.uarn;
-	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
+	xa_init(&ucontext->mmap_xa);
 
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
@@ -1696,23 +1655,27 @@ void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
 	efa_dealloc_uar(dev, ucontext->uarn);
 }
 
-static int __efa_mmap(struct efa_dev *dev,
-		      struct efa_ucontext *ucontext,
-		      struct vm_area_struct *vma,
-		      struct efa_mmap_entry *entry)
+static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
+		      struct vm_area_struct *vma, u64 key, u64 length)
 {
-	u8 mmap_flag = get_mmap_flag(entry->key);
-	u64 pfn = entry->address >> PAGE_SHIFT;
-	u64 address = entry->address;
-	u64 length = entry->length;
+	struct efa_mmap_entry *entry;
 	unsigned long va;
+	u64 pfn;
 	int err;
 
+	entry = mmap_entry_get(dev, ucontext, key, length);
+	if (!entry) {
+		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
+			  key);
+		return -EINVAL;
+	}
+
 	ibdev_dbg(&dev->ibdev,
 		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
-		  address, length, mmap_flag);
+		  entry->address, length, entry->mmap_flag);
 
-	switch (mmap_flag) {
+	pfn = entry->address >> PAGE_SHIFT;
+	switch (entry->mmap_flag) {
 	case EFA_MMAP_IO_NC:
 		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
 					pgprot_noncached(vma->vm_page_prot));
@@ -1733,14 +1696,13 @@ static int __efa_mmap(struct efa_dev *dev,
 		err = -EINVAL;
 	}
 
-	if (err) {
-		ibdev_dbg(&dev->ibdev,
-			  "Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
-			  address, length, mmap_flag, err);
-		return err;
-	}
+	if (err)
+		ibdev_dbg(
+			&dev->ibdev,
+			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
+			entry->address, length, entry->mmap_flag, err);
 
-	return 0;
+	return err;
 }
 
 int efa_mmap(struct ib_ucontext *ibucontext,
@@ -1750,7 +1712,6 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 	struct efa_dev *dev = to_edev(ibucontext->device);
 	u64 length = vma->vm_end - vma->vm_start;
 	u64 key = vma->vm_pgoff << PAGE_SHIFT;
-	struct efa_mmap_entry *entry;
 
 	ibdev_dbg(&dev->ibdev,
 		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
@@ -1769,14 +1730,7 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 	}
 	vma->vm_flags &= ~VM_MAYEXEC;
 
-	entry = mmap_entry_get(dev, ucontext, key, length);
-	if (!entry) {
-		ibdev_dbg(&dev->ibdev,
-			  "key[%#llx] does not have valid entry\n", key);
-		return -EINVAL;
-	}
-
-	return __efa_mmap(dev, ucontext, vma, entry);
+	return __efa_mmap(dev, ucontext, vma, key, length);
 }
 
 static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
