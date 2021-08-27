Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C63F9956
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhH0NGP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 09:06:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27744 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231271AbhH0NGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 09:06:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYr0QVqmlqBQyAA+94pNQpu/8oSXpDfJJ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vrPoB1173LJYVoqMk3I+urgBEDjexzhHPdOiOF7AV7LZniEhI?=
 =?us-ascii?q?LCFu1fBOXZrQHdJw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,356,1620662400"; 
   d="scan'208";a="113570550"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2021 21:05:23 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 881E54D0DC66;
        Fri, 27 Aug 2021 21:05:22 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 27 Aug 2021 21:05:23 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 27 Aug 2021 21:05:23 +0800
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        Yishai Hadas <yishaih@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
 <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
 <20210806014559.GM543798@ziepe.ca>
 <b5e6c4cd-8842-59ef-c089-2802057f3202@cn.fujitsu.com>
 <10c4bead-c778-8794-f916-80bf7ba3a56b@fujitsu.com>
 <20210827121034.GG1200268@ziepe.ca>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <d276eeda-7f30-6c91-24cd-a40916fcc4c8@cn.fujitsu.com>
Date:   Fri, 27 Aug 2021 21:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210827121034.GG1200268@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 881E54D0DC66.AD63D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


on 2021/8/27 20:10, Jason Gunthorpe wrote:
> On Fri, Aug 27, 2021 at 08:15:40AM +0000, lizhijian@fujitsu.com wrote:
>> i looked over the change-log of hmm_vma_handle_pte(), and found that before
>> 4055062 ("mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling")
>>
>> hmm_vma_handle_pte() will not check pte_special(pte) if pte_devmap(pte) is true.
>>
>> when we reached
>> "if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {"
>> the pte have already presented and its pte's flag already fulfilled the request flags.
>>
>>
>> My question is that
>> Per https://01.org/blogs/dave/2020/linux-consumption-x86-page-table-bits,
>> pte_devmap(pte) and pte_special(pte) could be both true in fsdax user case, right ?
> How? what code creates that?
>
> I see:
>
> insert_pfn():
> 	/* Ok, finally just insert the thing.. */
> 	if (pfn_t_devmap(pfn))
> 		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
> 	else
> 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
>
> So what code path ends up setting both bits?

  pte_mkdevmap() will set both _PAGE_SPECIAL | PAGE_DEVMAP

  395 static inline pte_t pte_mkdevmap(pte_t pte)
  396 {
  397         return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
  398 }

below is a calltrace example

[  400.728559] Call Trace:
[  400.731595] dump_stack+0x6d/0x8b
[  400.735536] insert_pfn+0x16c/0x180
[  400.739596] __vm_insert_mixed+0x84/0xc0
[  400.744144] dax_iomap_pte_fault+0x845/0x870
[  400.749089] ext4_dax_huge_fault+0x171/0x1e0
[  400.754096] __do_fault+0x31/0xe0
[  400.758090]  ? pmd_devmap_trans_unstable+0x37/0x90
[  400.763541] handle_mm_fault+0x11b1/0x1680
[  400.768260] exc_page_fault+0x2f4/0x570
[  400.772788]  ? asm_exc_page_fault+0x8/0x30
[  400.777539]  asm_exc_page_fault+0x1e/0x30


So is my previous change reasonable ?

Thanks

Zhijian



