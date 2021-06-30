Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6D3B8118
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhF3LPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 07:15:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14544 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3LPA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Jun 2021 07:15:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210630111228euoutp0190140d8932576fa6e50deadcf229d894~NV8YDtFQc2009320093euoutp01T
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jun 2021 11:12:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210630111228euoutp0190140d8932576fa6e50deadcf229d894~NV8YDtFQc2009320093euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625051548;
        bh=DBhQiqnyaEcnmYW9rAcKcJr53aru8+yj2xqDE4QGRb0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aMY9kONbCaQmdUCZ3F6ESjCcIRIqzRQ9/KofLB2p948ikIkiZJqWW5egjtuB6Om6/
         Q25Mv8zgMCeMNn5Lg5UrvXf9qt85qvAyDbDoFBOT25R6ajXiWls2Hq6xu+2rO7CYY/
         83ZxCS0lP2M04fsoFg65eC1KqEoHzvAxEk+d/J4o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210630111227eucas1p2a3eacbb4afd334d5e95f56382fa866ea~NV8Xg-fX11124411244eucas1p2P;
        Wed, 30 Jun 2021 11:12:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 51.1E.42068.B915CD06; Wed, 30
        Jun 2021 12:12:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4~NV8W996F01601316013eucas1p2i;
        Wed, 30 Jun 2021 11:12:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210630111227eusmtrp253edc5d7797c74c617621ceadd526c86~NV8W9DKud2520925209eusmtrp2k;
        Wed, 30 Jun 2021 11:12:27 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-17-60dc519bf3dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.48.20981.B915CD06; Wed, 30
        Jun 2021 12:12:27 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210630111226eusmtip1fc9667faf8afc06752f6e23e4928e446~NV8WGQsZn0506005060eusmtip1q;
        Wed, 30 Jun 2021 11:12:26 +0000 (GMT)
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
Date:   Wed, 30 Jun 2021 13:12:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87qzA+8kGLQdNrbYOGM9q8XrPfOZ
        LV6e/8BqsXL1USaLBfutLa7828NoMeXXUmaLy7vmsFk8O9TLYrHxOqfFu7dfWSwOfnjCarFs
        KpfF+WP97A58HmvmrWH02HZtC4vHzll32T02repk85h8Yzmjx+6bDWwevc3v2Dze77vK5tG3
        ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZk9tnMRVcMKt4fKGFqYGxS7uLkZNDQsBE4urOJUxd
        jFwcQgIrGCW+Hl/LBuF8YZRYvu0MI4TzmVGi7cNDli5GDrCWz7+MIeLLGSUWTuxkgXA+MkpM
        PDmLCaRIWCBcYlKHF8gKEYFciS+zFrKD1DALvGGWmLlzDRtIgk3AUKLrbReYzStgJ7G+ZwqY
        zSKgKnHu72UmEFtUIFni/bwZrBA1ghInZz5hAbE5BSIktt5YwgxiMwvISzRvnQ1li0vcejIf
        7B8Jgc2cEjdbO1ghHnWR+L9jAhuELSzx6vgWdghbRuL/TpiGZkaJh+fWskM4PYwSl5tmMEJU
        WUvcOfeLDeQ1ZgFNifW79CHCjhKzTx9lggQLn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4
        Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7
        iRGY9k7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4Y3aeTtBiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OG/SljXxQgLpiSWp2ampBalFMFkmDk6pBib+3108cx8dlj81i/mzg94K1WUzRHjD3z9fpSau
        VlEXFDnBUnpm3elTrTqWoS/2OHS6Ch7KTn92POlVxZ5zkzefvZjxmdsw/IvBKdU3EbuU+M4G
        MgiIyTv6XaxbbfXszsXA7MO21te2yL7c/vBQzhJ7lQniYU5BKgnafjPtm+43XxDfysu8+dzx
        gnnpRzruf9EXOL9JpfOQ90HGJztFHh+5Xu1bxpH2q2H6080FnwM/Z7jdO2uo4PI86L7yxLLd
        Kp/O6L+bofv1lyan2Gdjuy8dG8/GyjptWqx3Z8+NeMOTvp/qWG8dS+HbIC9SpFdef/D7/n1/
        7HbveTCJT2fJ9z3Sm30XuFizHFGtYL/9ZIWhEktxRqKhFnNRcSIAUTDuJOoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7qzA+8kGPQ0c1tsnLGe1eL1nvnM
        Fi/Pf2C1WLn6KJPFgv3WFlf+7WG0mPJrKbPF5V1z2CyeHeplsdh4ndPi3duvLBYHPzxhtVg2
        lcvi/LF+dgc+jzXz1jB6bLu2hcVj56y77B6bVnWyeUy+sZzRY/fNBjaP3uZ3bB7v911l8+jb
        sorR4/MmuQCuKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2Mye2zmAoumFU8vtDC1MDYpd3FyMEhIWAi8fmXcRcjF4eQwFJGiYY7Hxm7GDmB4jIS
        J6c1sELYwhJ/rnWxQRS9Z5S4cmcNO0izsEC4xKQOL5AaEYFciUfN7SwgNcwCb5gl1r++xwLR
        0MQoMf9CExtIFZuAoUTX2y4wm1fATmJ9zxQwm0VAVeLc38tMILaoQLLEz/XtUDWCEidnPmEB
        sTkFIiS23ljCDGIzC5hJzNv8EMqWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyr
        GEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuN827GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeqJ23
        E4R4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5H5ho8kriDc0MTA1NzCwNTC3NjJXEeU2OrIkX
        EkhPLEnNTk0tSC2C6WPi4JRqYJodc36GXT1fp5BuyC6lAv+SE3tPVz98qzL/Y3Ze1oRn0ms8
        DlfHMBz+enbCRfEtz1Ja9pzuXLPQxjjkf/2jJ4vqZvz+YP5W7fv2Nv/5R4yKqkwOH2xQOR3/
        R68me149y+Fo98W/Fp5s3PaJ9U3jqR27a699Sc569W2KiPxaJdlnE+8dCmpiebY96rTO82fz
        2W2l5F7uW7tz3u2HZz9N99jrtPh72uROwbb7/9ROMNZ/FQz8kMdjf/d3xLMIzrsXj9oVfVSf
        6nVOW1D0374d4neq3O9Pmj3RJNitz7jX7VOzdZpt84GV17e1PX+TFP3N5d2mD3Z9xjMqjb8w
        qb2pW7fjaPyjrT/NpCt2es5bvK/BQImlOCPRUIu5qDgRAC5Gy8B8AwAA
X-CMS-MailID: 20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4
References: <cover.1624955710.git.leonro@nvidia.com>
        <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
        <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On 29.06.2021 10:40, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
>
> orig_nents should represent the number of entries with pages,
> but __sg_alloc_table_from_pages sets orig_nents as the number of
> total entries in the table. This is wrong when the API is used for
> dynamic allocation where not all the table entries are mapped with
> pages. It wasn't observed until now, since RDMA umem who uses this
> API in the dynamic form doesn't use orig_nents implicit or explicit
> by the scatterlist APIs.
>
> Fix it by:
> 1. Set orig_nents as number of entries with pages also in
>     __sg_alloc_table_from_pages.
> 2. Add a new field total_nents to reflect the total number of entries
>     in the table. This is required for the release flow (sg_free_table).
>     This filed should be used internally only by scatterlist.
>
> Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

This patch landed in linux-next 20210630 as commit a52724456928 
("lib/scatterlist: Fix wrong update of orig_nents"). It causes serious 
regression in DMA-IOMMU integration, which can be observed for example 
on ARM Juno board during boot:

Unable to handle kernel paging request at virtual address 00376f42a6e40454
Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
[00376f42a6e40454] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.13.0-next-20210630+ #3585
Hardware name: ARM Juno development board (r1) (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : __sg_free_table+0x60/0xa0
lr : __sg_free_table+0x7c/0xa0
..
Call trace:
  __sg_free_table+0x60/0xa0
  sg_free_table+0x1c/0x28
  iommu_dma_alloc+0xc8/0x388
  dma_alloc_attrs+0xcc/0xf0
  dmam_alloc_attrs+0x68/0xb8
  sil24_port_start+0x60/0xe0
  ata_host_start.part.32+0xbc/0x208
  ata_host_activate+0x64/0x150
  sil24_init_one+0x1e8/0x268
  local_pci_probe+0x3c/0xa0
  pci_device_probe+0x128/0x1c8
  really_probe+0x138/0x2d0
  __driver_probe_device+0x78/0xd8
  driver_probe_device+0x40/0x110
  __driver_attach+0xcc/0x118
  bus_for_each_dev+0x68/0xc8
  driver_attach+0x20/0x28
  bus_add_driver+0x168/0x1f8
  driver_register+0x60/0x110
  __pci_register_driver+0x5c/0x68
  sil24_pci_driver_init+0x20/0x28
  do_one_initcall+0x84/0x450
  kernel_init_freeable+0x31c/0x38c
  kernel_init+0x20/0x120
  ret_from_fork+0x10/0x18
Code: d37be885 6b01007f 52800004 540000a2 (f8656813)
---[ end trace 4ba4f0c9c48711a1 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

It looks that some changes to the scatterlist structures are missing 
outside of the lib/scatterlist.c.

For now I would suggest to revert this change.

> ---
>   include/linux/scatterlist.h |  8 ++++++--
>   lib/scatterlist.c           | 32 ++++++++------------------------
>   2 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6f70572b2938..1c889141eb91 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -35,8 +35,12 @@ struct scatterlist {
>   
>   struct sg_table {
>   	struct scatterlist *sgl;	/* the list */
> -	unsigned int nents;		/* number of mapped entries */
> -	unsigned int orig_nents;	/* original size of list */
> +	unsigned int nents;		/* number of DMA mapped entries */
> +	unsigned int orig_nents;	/* number of CPU mapped entries */
> +	/* The fields below should be used internally only by
> +	 * scatterlist implementation.
> +	 */
> +	unsigned int total_nents;	/* number of total entries in the table */
>   };
>   
>   /*
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index a59778946404..6db70a1e7dd0 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -192,33 +192,26 @@ static void sg_kfree(struct scatterlist *sg, unsigned int nents)
>   void __sg_free_table(struct sg_table *table, unsigned int max_ents,
>   		     unsigned int nents_first_chunk, sg_free_fn *free_fn)
>   {
> -	struct scatterlist *sgl, *next;
> +	struct scatterlist *sgl, *next = NULL;
>   	unsigned curr_max_ents = nents_first_chunk ?: max_ents;
>   
>   	if (unlikely(!table->sgl))
>   		return;
>   
>   	sgl = table->sgl;
> -	while (table->orig_nents) {
> -		unsigned int alloc_size = table->orig_nents;
> -		unsigned int sg_size;
> +	while (table->total_nents) {
> +		unsigned int alloc_size = table->total_nents;
>   
>   		/*
>   		 * If we have more than max_ents segments left,
>   		 * then assign 'next' to the sg table after the current one.
> -		 * sg_size is then one less than alloc size, since the last
> -		 * element is the chain pointer.
>   		 */
>   		if (alloc_size > curr_max_ents) {
>   			next = sg_chain_ptr(&sgl[curr_max_ents - 1]);
>   			alloc_size = curr_max_ents;
> -			sg_size = alloc_size - 1;
> -		} else {
> -			sg_size = alloc_size;
> -			next = NULL;
>   		}
>   
> -		table->orig_nents -= sg_size;
> +		table->total_nents -= alloc_size;
>   		if (nents_first_chunk)
>   			nents_first_chunk = 0;
>   		else
> @@ -301,20 +294,11 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
>   		} else {
>   			sg = alloc_fn(alloc_size, gfp_mask);
>   		}
> -		if (unlikely(!sg)) {
> -			/*
> -			 * Adjust entry count to reflect that the last
> -			 * entry of the previous table won't be used for
> -			 * linkage.  Without this, sg_kfree() may get
> -			 * confused.
> -			 */
> -			if (prv)
> -				table->nents = ++table->orig_nents;
> -
> +		if (unlikely(!sg))
>   			return -ENOMEM;
> -		}
>   
>   		sg_init_table(sg, alloc_size);
> +		table->total_nents += alloc_size;
>   		table->nents = table->orig_nents += sg_size;
>   
>   		/*
> @@ -385,12 +369,11 @@ static struct scatterlist *get_next_sg(struct sg_table *table,
>   	if (!new_sg)
>   		return ERR_PTR(-ENOMEM);
>   	sg_init_table(new_sg, alloc_size);
> +	table->total_nents += alloc_size;
>   	if (cur) {
>   		__sg_chain(next_sg, new_sg);
> -		table->orig_nents += alloc_size - 1;
>   	} else {
>   		table->sgl = new_sg;
> -		table->orig_nents = alloc_size;
>   		table->nents = 0;
>   	}
>   	return new_sg;
> @@ -515,6 +498,7 @@ struct scatterlist *__sg_alloc_table_from_pages(struct sg_table *sgt,
>   		cur_page = j;
>   	}
>   	sgt->nents += added_nents;
> +	sgt->orig_nents = sgt->nents;
>   out:
>   	if (!left_pages)
>   		sg_mark_end(s);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

