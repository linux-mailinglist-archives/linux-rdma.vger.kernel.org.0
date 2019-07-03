Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354F35DF9C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 10:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGCITs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 04:19:48 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:10162 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGCITr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 04:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562141987; x=1593677987;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ngrYx7fMAOvLuPUGyHl5u550dKHzz30L7j6ECDc9/O4=;
  b=MurNqRhYyicLQ+9gzC7IR05SBjZFA+7SayytOgIu49TmxmGBbakLcvUa
   /wya3tbZAvQ1scrThb3LpD9p7YoPq/33o5gQNQSn0vO3kYsnxI4wi1g+E
   H6Dj5RBLWCw9/iy1Ili+s0OZUl8w56IiC2OPGYul3uEax8St+aWRPDzBi
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,446,1554768000"; 
   d="scan'208";a="409139480"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Jul 2019 08:19:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 3CBB2A1FA5;
        Wed,  3 Jul 2019 08:19:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Jul 2019 08:19:43 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.239) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Jul 2019 08:19:39 +0000
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
Date:   Wed, 3 Jul 2019 11:19:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702223126.GA11860@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.239]
X-ClientProxiedBy: EX13D07UWB004.ant.amazon.com (10.43.161.196) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/07/2019 1:31, Jason Gunthorpe wrote:
>> Seems except Mellanox + hns the mmap flags aren't ABI. 
>> Also, current Mellanox code seems like it won't benefit from 
>> mmap cookie helper functions in any case as the mmap function is very specific and the flags used indicate 
>> the address and not just how to map it.
> 
> IMHO, mlx5 has a goofy implementaiton here as it codes all of the object
> type, handle and cachability flags in one thing.

Do we need object type flags as well in the generic mmap code?

> 
>> For most drivers (efa, qedr, siw, cxgb3/4, ocrdma) mmap is called on
>> address received by kernel in some response. Meaning driver can
>> write anything in the response that will serve as the key / flag.
>> Other drivers ( i40iw ) have a simple mmap function that doesn't
>> require a mmap database at all.
> 
> Are you sure? I thought the reason to have to flags at all was so that
> userspace could specify different cachability..
> 
> Otherwise the offset should just be an opaque cookie and internal xa
> should specify the cachability mode..

That was my intention as well. The driver returns a "hint" flag to the
user, but the userspace library can override it with its own cachability flags.
However, I now notice EFA lost that functionality when it was merged
as the mmap function looks at 'entry->mmap_flag' (hint) instead of the
given offset flag:

static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
		      struct vm_area_struct *vma, u64 key, u64 length)
{
	struct efa_mmap_entry *entry;
	unsigned long va;
	u64 pfn;
	int err;

	entry = mmap_entry_get(dev, ucontext, key, length);
	if (!entry) {
		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
			  key);
		return -EINVAL;
	}

	ibdev_dbg(&dev->ibdev,
		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
		  entry->address, length, entry->mmap_flag);

	pfn = entry->address >> PAGE_SHIFT;
	switch (entry->mmap_flag) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^

	case EFA_MMAP_IO_NC:
		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
					pgprot_noncached(vma->vm_page_prot));
		break;
	case EFA_MMAP_IO_WC:
		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
					pgprot_writecombine(vma->vm_page_prot));
		break;
	case EFA_MMAP_DMA_PAGE:
		for (va = vma->vm_start; va < vma->vm_end;
		     va += PAGE_SIZE, pfn++) {
			err = vm_insert_page(vma, va, pfn_to_page(pfn));
			if (err)
				break;
		}
		break;
	default:
		err = -EINVAL;
	}

	if (err) {
		ibdev_dbg(
			&dev->ibdev,
			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
			entry->address, length, entry->mmap_flag, err);
		return err;
	}

	return 0;
}

Another issue is that these flags aren't exposed in an ABI file, so a userspace library can't
really make use of it in current state.
