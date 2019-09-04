Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDDA8474
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 15:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfIDNYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 09:24:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:20789 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfIDNYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567603483; x=1599139483;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TTBAAnDlNpf7jBV5LeavOK7xqu+EpQhsDbOsV7StXlM=;
  b=G/fteARJEjqHBNILx+EZAL3VaalwKRBN7EPteENNtF1I0nplLTHAm31M
   qVW5qFspIUeWSybUZ5dwHKVUlpzwWhyF7dj6bJCVmEAICqQf0l+JEG39e
   uhPImk2/UDP1JTtDJrrSQp+JUD7rORXNaEDDGgYdNRLWvj+k3Ts0GEX8v
   g=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="827202219"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Sep 2019 13:24:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 19396141C83;
        Wed,  4 Sep 2019 13:24:37 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:24:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.218) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:24:32 +0000
Subject: Re: [PATCH v10 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        "Ariel Elior" <ariel.elior@marvell.com>
References: <20190904071507.8232-1-michal.kalderon@marvell.com>
 <20190904071507.8232-4-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d6e4d513-556f-d2a4-f5c6-42a54c0ae7f1@amazon.com>
Date:   Wed, 4 Sep 2019 16:24:27 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904071507.8232-4-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.218]
X-ClientProxiedBy: EX13D31UWC004.ant.amazon.com (10.43.162.27) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/09/2019 10:15, Michal Kalderon wrote:
>  static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> -		      struct vm_area_struct *vma, u64 key, u64 length)
> +		      struct vm_area_struct *vma, u64 key, size_t length)
>  {
> -	struct efa_mmap_entry *entry;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct efa_user_mmap_entry *entry;
>  	unsigned long va;
>  	u64 pfn;
>  	int err;
>  
> -	entry = mmap_entry_get(dev, ucontext, key, length);
> -	if (!entry) {
> +	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
> +					      length, vma);
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
> +		goto err;
> +	}
>  
>  	ibdev_dbg(&dev->ibdev,
> -		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
> -		  entry->address, length, entry->mmap_flag);
> +		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
> +		  entry->address, entry->length, entry->mmap_flag);
>  
>  	pfn = entry->address >> PAGE_SHIFT;
>  	switch (entry->mmap_flag) {
> @@ -1630,15 +1623,16 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  		err = -EINVAL;
>  	}
>  
> -	if (err) {
> -		ibdev_dbg(
> -			&dev->ibdev,
> -			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
> -			entry->address, length, entry->mmap_flag, err);
> -		return err;
> -	}
> +	if (err)
> +		goto err;

Thanks Michal,
Acked-by: Gal Pressman <galpress@amazon.com>

If you're planning on doing another cycle, this error path now prints nothing, I
meant move the print from the goto inside this if (before goto err).

>  
>  	return 0;
> +
> +err:
> +	rdma_user_mmap_entry_put(&ucontext->ibucontext,
> +				 rdma_entry);
> +
> +	return err;
>  }
