Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF66E317436
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 00:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhBJXTn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 18:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhBJXSQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 18:18:16 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0EC06178B
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:17:36 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m144so3539043qke.10
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvzBLzuUN3dC3Meck84dtvamYug02/uWoNAd2vuIlPw=;
        b=LnAhhZAcjBbe2PDzz7862JnfK5LxIO+60i0EKD0KDKz7s9HABmOblaFNhZTUV95vQ3
         TcpqQGbbR6j8YnR1u48ozRKREc9GR4REzg5lFNe+kdgPgDvdrcLmz2deN0izTXw3QuUf
         CKyhoUazx10m4WzbeTW77xpOInKqOMQ7CZZmeYD6FJvFu6C+mD+/iqcr/2pidKc0Rnf7
         Jqk0eHarHTXWC9Ze7H0NC0qbrN3xGiI28tIAu5vOpCKf9qh2y/Y6FHQpJgn5a2omapVU
         xzuMi8DlLmhVFvqnvrlfvplkDzanCmmL9lY5FHEnYjX8v1QLa51LV3+MmFVbTpVtEgZS
         vvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvzBLzuUN3dC3Meck84dtvamYug02/uWoNAd2vuIlPw=;
        b=Iq+oOZkRSyxHCZ9a9WZorGmW7jvwRTZzxtLHGma+tEXLWQ+LMyMIO0iC0wVsmmIeP6
         l3YeKCtZr6q4kRaoAVBe1lMeDrxFPls395F/jyBqEl24ZPNNv2jzJtVMNvvJHJuESQWt
         Q/DnuTOI0fE2psr6n4rt5KLjSLZ9r8MSVmKZ4eI8sQm4kZviLPNRmSQ7vMqSkvSxxa8l
         YYBgWR+pTUl5QVG7qGy5h3SXlT/DCLORy7eokDouLXYeJf/4Voc2RoZinUE2BDrvl0CK
         tFffxnEB0A1k26wyvVK+xp3PceAeE3TPJ5a2A9N0sR6MjML+vLdMGBkwMbH+Ja+HGVUJ
         wp9g==
X-Gm-Message-State: AOAM531g42kVoaORdJi1loJaiBgbbITkholbRMHlFQdLhXwnDAthaATc
        OK+q7Ef561XQbyF0tMBgjzjljA==
X-Google-Smtp-Source: ABdhPJyaU4n/wmBj/Fq8bDuOMNR3xhmXrfFN0BiPQEns2xCAk/uD0k5Fsy15pBBnyBYamD9xuF/xGg==
X-Received: by 2002:a37:484f:: with SMTP id v76mr5717061qka.312.1612999055416;
        Wed, 10 Feb 2021 15:17:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id t128sm2549683qka.46.2021.02.10.15.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:17:35 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9yjm-006HMP-FB; Wed, 10 Feb 2021 19:17:34 -0400
Date:   Wed, 10 Feb 2021 19:17:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
Message-ID: <20210210231734.GS4718@ziepe.ca>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-5-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205204127.29441-5-joao.m.martins@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 08:41:27PM +0000, Joao Martins wrote:
> Use the newly added unpin_user_page_range_dirty_lock()
> for more quickly unpinning a consecutive range of pages
> represented as compound pages. This will also calculate
> number of pages to unpin (for the tail pages which matching
> head page) and thus batch the refcount update.
> 
> Running a test program which calls mr reg/unreg on a 1G in size
> and measures cost of both operations together (in a guest using rxe)
> with THP and hugetlbfs:
> 
> Before:
> 590 rounds in 5.003 sec: 8480.335 usec / round
> 6898 rounds in 60.001 sec: 8698.367 usec / round
> 
> After:
> 2688 rounds in 5.002 sec: 1860.786 usec / round
> 32517 rounds in 60.001 sec: 1845.225 usec / round
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/infiniband/core/umem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Would best for this to go through Andrew's tree

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

4x improvement is pretty good!

Jason
