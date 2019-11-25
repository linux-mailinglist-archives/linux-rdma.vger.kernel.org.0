Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7137410866D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 03:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKYCHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 21:07:21 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14181 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKYCHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 21:07:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb375b0000>; Sun, 24 Nov 2019 18:07:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 18:07:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Nov 2019 18:07:20 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 02:07:20 +0000
Subject: Re: [PATCH 0/2] mm/gup + IB: allow FOLL_FORCE for gup_fast and use in
 IB
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20191125003715.516290-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <25e8092a-3a5c-b75b-9ee8-940fece25389@nvidia.com>
Date:   Sun, 24 Nov 2019 18:07:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125003715.516290-1-jhubbard@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574647644; bh=VSqCxdntvMfhdiFrZMqW5HdafdMIAWDFCnXZR+sYDKY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q6JG///7ts3uN8kdWM/tTfdwCyxVNMDg64zNzAkJ0Jn+wf9RufTjn+kXhllGQof/i
         JkyfF3O9d0tqzeMwaPgZFP7CoHp07w40zI+58KIi0q9SjLi/jubvyW74+I+xnc9brB
         fxQwMl8I7h2X/ve77uG5U8quInmaT6oqJB+8ZP4ZYIc9AWy7BjSRTILPzZY5IGnGoA
         kv+KmH3vGBiuz/BPZPSM3iDs5BYditxB5ymKkwMKrmK9In7JRDwHncbi7UQW/uQXpM
         ooPymYDaxwUXZGWHNwXGcONNKDGu7bDRpkwDULsGfiIUy+XF+H7c1b1zQrU8CgbZIU
         wr40GLvZX+dsg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/24/19 4:37 PM, John Hubbard wrote:
> Hi Leon, Jason, Christoph,
> 
> Maybe I'm overlooking something, but as I wrote in patch 1, it looks
> like we can simply allow FOLL_FORCE to be passed to gup_fast().
> 
> This should fix Leon's reported RDMA failure [1]  when using patch 2 by
> itself. (I've compile- and boot-tested these, and also did short LTP
> and fio with direct IO tests, but I don't have an Infiniband runtime
> setup that exercises the umem.c code.)
> 
> [1] https://lore.kernel.org/r/20191124100724.GH136476@unreal
> 
> John Hubbard (2):
>   mm/gup: allow FOLL_FORCE for get_user_pages_fast()
>   IB/umem: use get_user_pages_fast() to pin DMA pages
> 
>  drivers/infiniband/core/umem.c | 17 ++++++-----------
>  mm/gup.c                       |  3 ++-
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 

OK, based on Jason's response [1] that it's too late to put this into
5.5, let's withdraw this, and I'll resend when it's time to send out
patches for 5.6.

[1] https://lore.kernel.org/r/20191125005339.GC5634@ziepe.ca

thanks,
-- 
John Hubbard
NVIDIA
