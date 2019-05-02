Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969B81156B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 10:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEBI27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 04:28:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:54069 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEBI27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556785738; x=1588321738;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WskScnG6p0JMbDYZjT6mMyqLHhIcPKB6e5GUbcml11I=;
  b=vfc8DD2UFgVx8XBBfcLHLZnZXsMCC6TgzE0StrvyUi6ICnXsO1jrZFz8
   EI8CdoqoR342JukrSCzIV//yqlfJB17FENPacr+ZRQpFuWBiSks34Ikt+
   25s3tXcDa3AzREp3FhYGD9yEtDXJ5K/ZSSz58dLYKTcwVicb/4AvRwR19
   E=;
X-IronPort-AV: E=Sophos;i="5.60,421,1549929600"; 
   d="scan'208";a="797431587"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 May 2019 08:28:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x428SpOm120210
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 2 May 2019 08:28:52 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 May 2019 08:28:51 +0000
Received: from [10.218.62.21] (10.43.160.48) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 2 May
 2019 08:28:43 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501163852.GA18049@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a5428152-3dab-cbf9-cf5f-0df9b8322bd7@amazon.com>
Date:   Thu, 2 May 2019 11:28:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501163852.GA18049@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D04UWA004.ant.amazon.com (10.43.160.234) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01-May-19 19:38, Jason Gunthorpe wrote:
>> +static int __efa_mmap(struct efa_dev *dev,
>> +		      struct efa_ucontext *ucontext,
>> +		      struct vm_area_struct *vma,
>> +		      struct efa_mmap_entry *entry)
>> +{
>> +	u8 mmap_flag = get_mmap_flag(entry->key);
>> +	u64 pfn = entry->address >> PAGE_SHIFT;
>> +	u64 address = entry->address;
>> +	u64 length = entry->length;
>> +	unsigned long va;
>> +	int err;
>> +
>> +	ibdev_dbg(&dev->ibdev,
>> +		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
>> +		  address, length, mmap_flag);
>> +
>> +	switch (mmap_flag) {
>> +	case EFA_MMAP_IO_NC:
>> +		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
>> +					pgprot_noncached(vma->vm_page_prot));
>> +		break;
>> +	case EFA_MMAP_IO_WC:
>> +		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
>> +					pgprot_writecombine(vma->vm_page_prot));
>> +		break;
>> +	case EFA_MMAP_DMA_PAGE:
>> +		for (va = vma->vm_start; va < vma->vm_end;
>> +		     va += PAGE_SIZE, pfn++) {
>> +			err = vm_insert_page(vma, va, pfn_to_page(pfn));
>> +			if (err)
>> +				break
> 
> This loop doesn't bound the number of pfns it accesses, so it is a
> security problem.
> 
> The core code was checking this before

Thanks Jason,
Core code was checking for
if (vma->vm_end - vma->vm_start != size)
	return ERR_PTR(-EINVAL);

Our code explicitly sets size as 'vma->vm_end - vma->vm_start'.
In addition, we validate that the mapping size matches the size of the allocated
buffers which are being mapped (and bounded).
