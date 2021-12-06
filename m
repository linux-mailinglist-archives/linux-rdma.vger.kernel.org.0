Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43E469735
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbhLFNi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 08:38:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16342 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240974AbhLFNi0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 08:38:26 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J74CZ5wTxz91Wm;
        Mon,  6 Dec 2021 21:34:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 21:34:55 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 21:34:55 +0800
Subject: Re: [PATCH v5 for-next 1/1] RDMA/hns: Support direct wqe of
 userspace'
To:     Barry Song <21cnbao@gmail.com>
References: <20211130135740.4559-2-liangwenpeng@huawei.com>
 <20211203101855.12598-1-21cnbao@gmail.com>
CC:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <7817eb50-0d7a-67bf-245b-9bb9cf4a6845@huawei.com>
Date:   Mon, 6 Dec 2021 21:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211203101855.12598-1-21cnbao@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/12/3 18:18, Barry Song wrote:
>> +	switch (entry->mmap_type) {
>> +	case HNS_ROCE_MMAP_TYPE_DB:
>> +		prot = pgprot_noncached(vma->vm_page_prot);
>> +		break;
>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
>> +		prot = vma->vm_page_prot;
>> +		break;
>> +	/*
>> +	 * The BAR region of direct WQE supports Early Write Ack,
>> +	 * so pgprot_device is used to improve performance.
>> +	 */
>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
>> +		prot = pgprot_device(vma->vm_page_prot);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> i am still not convinced why HNS_ROCE_MMAP_TYPE_DB needs nocache and HNS_ROCE_MMAP_TYPE_DWQE needs
> device. generally people use ioremap() to map pci bar spaces in pci device drivers, and ioremap()
> is pretty much nGnRE:
> #define ioremap(addr, size)             __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> #define ioremap_np(addr, size)          __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
> 
> i am only seeing four places which are using nE in kernel:
>    #   line  filename / context / line
>    1    866  drivers/of/address.c <<of_iomap>>
>              return ioremap_np(res.start, resource_size(&res));
>    2    901  drivers/of/address.c <<of_io_request_and_map>>
>              mem = ioremap_np(res.start, resource_size(&res));
>    3     89  include/linux/io.h <<pci_remap_cfgspace>>
>              return ioremap_np(offset, size) ?: ioremap(offset, size);
>    4     47  lib/devres.c <<__devm_ioremap>>
>              addr = ioremap_np(offset, size);
> 
> so i guess nGnRE is quite safe for pci device bar spaces. for config space, it is a different story
> though which is the 3rd one in the above list:
> 
> #ifdef CONFIG_PCI
> /*
>  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
>  * Posting") mandate non-posted configuration transactions. This default
>  * implementation attempts to use the ioremap_np() API to provide this
>  * on arches that support it, and falls back to ioremap() on those that
>  * don't. Overriding this function is deprecated; arches that properly
>  * support non-posted accesses should implement ioremap_np() instead, which
>  * this default implementation can then use to return mappings compliant with
>  * the PCI specification.
>  */
> #ifndef pci_remap_cfgspace
> #define pci_remap_cfgspace pci_remap_cfgspace
> static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
>                                                size_t size)
> {
>         return ioremap_np(offset, size) ?: ioremap(offset, size);
> }
> #endif
> #endif
> 
> Thanks
> Barry
> 
> .
> 

Thank you for your comment. After my reconsideration, HNS_ROCE_MMAP_TYPE_DB should use
the device attribute. I will submit another patch to fix this problem first.

Thanks
Wenpeng
