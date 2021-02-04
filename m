Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8802830E859
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhBDALp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 19:11:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7259 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhBDALp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 19:11:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b3b960000>; Wed, 03 Feb 2021 16:11:02 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 00:11:01 +0000
Subject: Re: [PATCH 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-4-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b6ab15a7-7cee-34e8-f680-7c4cc0d9bc56@nvidia.com>
Date:   Wed, 3 Feb 2021 16:11:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203220025.8568-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612397462; bh=DNBYb3L4KiWY74m9biXZbcqQW9XI3txRrkSsbMu9ghQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=B6AYUoKu4Trv11icR0SWcDtM6e5GqJOX86hQXkoRhyCMGr0TxiOHewbCIY3u9I4J8
         3bLYBIFWlJQlDEPE7Fd1RgVOpQazabZtXhE4IjK2IzMMMWvLUb3UXCk0RD0XvK0irU
         W4fV5kmKugwxesipwjlGyBDrPU7oWCXdyKzemc+p4oD1toFab8hMVJ2v8u/G4gstRu
         B5OBAVwu2qOKMQ3U4pr2FTjNmxJhcs8ZsnrsVXythen7nyQm72Zgr070er4OuqO7Rv
         nT2s8xyrqAtGnEvFG/o5prm6eaUUPZaXUHTRdT1jcZzFiES0oZX02Ub0Sj+tDGMPtk
         C+pjeHd8ry65Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 2:00 PM, Joao Martins wrote:
...
> +void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
> +				      bool make_dirty)
> +{
> +	unsigned long index;
> +	struct page *head;
> +	unsigned int ntails;
> +
> +	for_each_compound_range(index, &page, npages, head, ntails) {
> +		if (make_dirty && !PageDirty(head))
> +			set_page_dirty_lock(head);
> +		put_compound_head(head, ntails, FOLL_PIN);
> +	}
> +}
> +EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
> +

Also, looking at this again while trying to verify the sg diffs in patch #4, I noticed
that the name is tricky. Usually a "range" would not have a single struct page* as the
argument. So in this case, perhaps a comment above the function would help, something
approximately like this:

/*
  * The "range" in the function name refers to the fact that the page may be a
  * compound page. If so, then that compound page will be treated as one or more
  * ranges of contiguous tail pages.
  */

...I guess. Or maybe the name is just wrong (a comment block explaining a name is
always a bad sign). Perhaps we should rename it to something like:

	unpin_user_compound_page_dirty_lock()

?

thanks,
-- 
John Hubbard
NVIDIA
