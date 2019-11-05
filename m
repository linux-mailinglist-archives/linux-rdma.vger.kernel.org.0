Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D784EF0664
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 20:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKETzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 14:55:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37823 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKETzB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 14:55:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id g50so30994705qtb.4
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 11:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5gbwi+5Die0DCRTWbqSYAFEnO6zWJ4vWxC8Zh/KpKA=;
        b=BZ4HvAtpa38aZ5lSGx0D8Mev1wSWztu+sGZ+5iBk9qeG5IJsDIwP1Jupz8xurLmXWp
         gWzQFKWiyY3QN4eJlH2OKgsrg/92Ga9Y2lyxM9leIPRWGfYfUx+YDskqwNZg1vwaxyhu
         8V4/D/y9UCTECDMOV2SwlKBbw4vaA7Kj0AiBQL5K5WZYgxUKqfvRg65lvH0OWTgK0ZXS
         Y+cGpQPKR+bY2hB4wey62Gq5R/udUf40nPcF3l7PFzbjoP2vQTt9Pc7OwvqpOfz7kF/p
         J3RPJFEjPPEDyTj3nHjD4nsfyAjSApzXM4vF2Vex7CWnFdM/hsX3B3soK5YYW9QVzned
         ZaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5gbwi+5Die0DCRTWbqSYAFEnO6zWJ4vWxC8Zh/KpKA=;
        b=Ycji+m0aWALQW7H6/AdBJBJGRO+XoLR2tauCIqvv1dlizJYZk0tovS+9Atmlqh/6Ca
         RhIsvalldXKDiiwOAj7xhNsp4QnGcA5kk87IpawyqRWQM4iMQo7892fmMUcydgnZpmmn
         PaObaze95d1oGNE6mxyoc2j3BYKhw1ws1drvDznpXaIxF4dfPxOjAnZ59sRoW81ZeobH
         WW+2N7f7+FYzHvVj+KD5bYQlimIJLswj1k9BeenA76QZhXD1JRa9ERZuHtyFmD5Atvhs
         +mQjfsPVooT8fSzl0Zgs0IFxZkudQn6+yKRD4aMQpFvfPDWbNxCf2Rmi5AM1Q0aGXH1j
         wPIw==
X-Gm-Message-State: APjAAAVKQKLZgiMXIouBq1udc18l1TFAQdzqMhMktBlcZNBxd6KRBGDe
        YwsnM1NlMDiViMcY+SdEwkvxaA==
X-Google-Smtp-Source: APXvYqyBR+rt/6JjKlW6zIay3akhoPZLhwUPIJbS+Av4HC1+FeQq9JR+oNdClLB6GGnSUS85wqGXHg==
X-Received: by 2002:ac8:2894:: with SMTP id i20mr18972965qti.270.1572983700315;
        Tue, 05 Nov 2019 11:55:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l129sm10716767qkd.84.2019.11.05.11.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 11:54:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iS4up-0005O4-6V; Tue, 05 Nov 2019 15:54:59 -0400
Date:   Tue, 5 Nov 2019 15:54:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com, galpress@amazon.com,
        yishaih@mellanox.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v12 rdma-next 4/8] RDMA/efa: Use the common mmap_xa
 helpers
Message-ID: <20191105195459.GA19938@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191030094417.16866-5-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030094417.16866-5-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 11:44:13AM +0200, Michal Kalderon wrote:

> @@ -116,6 +122,13 @@ struct efa_ah {
>  	u8 id[EFA_GID_SIZE];
>  };
>  
> +struct efa_user_mmap_entry {
> +	struct rdma_user_mmap_entry rdma_entry;
> +	u64 address;
> +	size_t length;
> +	u8 mmap_flag;
> +};

There is no reason to move this struct out of efa_verbs.c

length is redundant with rdma_entry.npages

>  static int qp_mmap_entries_setup(struct efa_qp *qp,
>  				 struct efa_dev *dev,
>  				 struct efa_ucontext *ucontext,
>  				 struct efa_com_create_qp_params *params,
>  				 struct efa_ibv_create_qp_resp *resp)
>  {
> -	/*
> -	 * Once an entry is inserted it might be mmapped, hence cannot be
> -	 * cleaned up until dealloc_ucontext.
> -	 */
> -	resp->sq_db_mmap_key =
> -		mmap_entry_insert(dev, ucontext, qp,
> -				  dev->db_bar_addr + resp->sq_db_offset,
> -				  PAGE_SIZE, EFA_MMAP_IO_NC);
> -	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
> +	size_t length;
> +	u64 address;
> +
> +	address = dev->db_bar_addr + resp->sq_db_offset;
> +	qp->sq_db_mmap_entry =
> +		efa_user_mmap_entry_insert(&ucontext->ibucontext,
> +					   address,
> +					   PAGE_SIZE, EFA_MMAP_IO_NC,
> +					   &resp->sq_db_mmap_key);

I'm still confused how this is OK for the lifetime, 'sq_db_offset'
comes from the device, does the device prevent re-use of the same
db_offset until the ucontext is closed? If so that deserves a comment
in here.

>  static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> -		      struct vm_area_struct *vma, u64 key, u64 length)
> +		      struct vm_area_struct *vma, u64 key, size_t length)
>  {
> -	struct efa_mmap_entry *entry;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct efa_user_mmap_entry *entry;
>  	unsigned long va;
> +	int err = 0;
>  	u64 pfn;
> -	int err;
>  
> -	entry = mmap_entry_get(dev, ucontext, key, length);
> -	if (!entry) {
> +	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
> +					      vma);
> +	if (!rdma_entry) {
>  		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
>  			  key);
>  		return -EINVAL;
>  	}
> +	entry = to_emmap(rdma_entry);
> +	if (entry->length != length) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "key[%#llx] does not have valid length[%#zx] expected[%#zx]\n",
> +			  key, length, entry->length);
> +		err = -EINVAL;
> +		goto out;
> +	}

Should be in common code

Same with the VM_SHARED (whichi s only needed for the vm_insert_page
flow)

Also driver should not be messing with VM_EXEC as that is known to
cause problems.

> @@ -1648,16 +1615,16 @@ int efa_mmap(struct ib_ucontext *ibucontext,
>  {
>  	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
>  	struct efa_dev *dev = to_edev(ibucontext->device);
> -	u64 length = vma->vm_end - vma->vm_start;
> +	size_t length = vma->vm_end - vma->vm_start;
>  	u64 key = vma->vm_pgoff << PAGE_SHIFT;
>  
>  	ibdev_dbg(&dev->ibdev,
> -		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
> +		  "start %#lx, end %#lx, length = %#zx, key = %#llx\n",
>  		  vma->vm_start, vma->vm_end, length, key);
>  
>  	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {

vm_end - vm_start is always page aligned

Jason
