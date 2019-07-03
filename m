Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342EE5E264
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCK6S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 06:58:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32239 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCK6S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 06:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562151497; x=1593687497;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kdfSvvfLGIGH/Ni4KDTmw4paUXQ1nQqyvYU61kGukHI=;
  b=twQZdYZYEcbQ1zCIn8mG80Zke71qGCe5GpamCBnLwmOFH0916g77vw1b
   aThnyaza+Skbop52ojhnnRy752Vl6U6qSOo/0vW/ZEYXkbVDLZEKFJ86J
   dFmcAAT8+/TCS67NX3ehTxMJsHV6K6ueUq04iqHvjRYpf6BXPaA54RzO8
   Q=;
X-IronPort-AV: E=Sophos;i="5.62,446,1554768000"; 
   d="scan'208";a="809141157"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Jul 2019 10:58:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 8BB60A17A2;
        Wed,  3 Jul 2019 10:58:13 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Jul 2019 10:58:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.177) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Jul 2019 10:58:08 +0000
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Michal Kalderon <mkalderon@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <MN2PR18MB318246C85617FD32F4F54526A1FB0@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <26eb18f7-2e64-53a3-bbcb-277dea13a112@amazon.com>
Date:   Wed, 3 Jul 2019 13:58:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB318246C85617FD32F4F54526A1FB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.177]
X-ClientProxiedBy: EX13D23UWA003.ant.amazon.com (10.43.160.194) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/07/2019 11:53, Michal Kalderon wrote:
>> From: Gal Pressman <galpress@amazon.com>
>> Sent: Wednesday, July 3, 2019 11:20 AM
>>
>> On 03/07/2019 1:31, Jason Gunthorpe wrote:
>>>> Seems except Mellanox + hns the mmap flags aren't ABI.
>>>> Also, current Mellanox code seems like it won't benefit from mmap
>>>> cookie helper functions in any case as the mmap function is very
>>>> specific and the flags used indicate the address and not just how to map
>> it.
>>>
>>> IMHO, mlx5 has a goofy implementaiton here as it codes all of the
>>> object type, handle and cachability flags in one thing.
>>
>> Do we need object type flags as well in the generic mmap code?
>>
>>>
>>>> For most drivers (efa, qedr, siw, cxgb3/4, ocrdma) mmap is called on
>>>> address received by kernel in some response. Meaning driver can write
>>>> anything in the response that will serve as the key / flag.
>>>> Other drivers ( i40iw ) have a simple mmap function that doesn't
>>>> require a mmap database at all.
>>>
>>> Are you sure? I thought the reason to have to flags at all was so that
>>> userspace could specify different cachability..
>>>
>>> Otherwise the offset should just be an opaque cookie and internal xa
>>> should specify the cachability mode..
>>
>> That was my intention as well. The driver returns a "hint" flag to the user, but
>> the userspace library can override it with its own cachability flags.
>> However, I now notice EFA lost that functionality when it was merged as the
>> mmap function looks at 'entry->mmap_flag' (hint) instead of the given offset
>> flag:
>>
>> static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>> 		      struct vm_area_struct *vma, u64 key, u64 length) {
>> 	struct efa_mmap_entry *entry;
>> 	unsigned long va;
>> 	u64 pfn;
>> 	int err;
>>
>> 	entry = mmap_entry_get(dev, ucontext, key, length);
>> 	if (!entry) {
>> 		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid
>> entry\n",
>> 			  key);
>> 		return -EINVAL;
>> 	}
>>
>> 	ibdev_dbg(&dev->ibdev,
>> 		  "Mapping address[%#llx], length[%#llx],
>> mmap_flag[%d]\n",
>> 		  entry->address, length, entry->mmap_flag);
>>
>> 	pfn = entry->address >> PAGE_SHIFT;
>> 	switch (entry->mmap_flag) {
>>         ^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> 	case EFA_MMAP_IO_NC:
>> 		err = rdma_user_mmap_io(&ucontext->ibucontext, vma,
>> pfn, length,
>> 					pgprot_noncached(vma-
>>> vm_page_prot));
>> 		break;
>> 	case EFA_MMAP_IO_WC:
>> 		err = rdma_user_mmap_io(&ucontext->ibucontext, vma,
>> pfn, length,
>> 					pgprot_writecombine(vma-
>>> vm_page_prot));
>> 		break;
>> 	case EFA_MMAP_DMA_PAGE:
>> 		for (va = vma->vm_start; va < vma->vm_end;
>> 		     va += PAGE_SIZE, pfn++) {
>> 			err = vm_insert_page(vma, va, pfn_to_page(pfn));
>> 			if (err)
>> 				break;
>> 		}
>> 		break;
>> 	default:
>> 		err = -EINVAL;
>> 	}
>>
>> 	if (err) {
>> 		ibdev_dbg(
>> 			&dev->ibdev,
>> 			"Couldn't mmap address[%#llx] length[%#llx]
>> mmap_flag[%d] err[%d]\n",
>> 			entry->address, length, entry->mmap_flag, err);
>> 		return err;
>> 	}
>>
>> 	return 0;
>> }
>>
>> Another issue is that these flags aren't exposed in an ABI file, so a userspace
>> library can't really make use of it in current state.
> 
> Can you give an example of a use-case where the user would want to override the kernel hint ? 
> Do you plan on changing this and exposing the flags to ABI? 

I don't have an example of such use case currently, I thought it's good to have
such capability.

Regarding the ABI, I guess it depends on how this RFC is going to end up.
