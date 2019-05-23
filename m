Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B73B28646
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfEWTFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 15:05:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17559 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWTFQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 15:05:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce6eeec0000>; Thu, 23 May 2019 12:05:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 12:05:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 12:05:15 -0700
Received: from [10.2.169.219] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 19:05:12 +0000
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6ee88cde-5365-9bbc-6c4d-7459d5c3ebe2@nvidia.com>
Date:   Thu, 23 May 2019 12:04:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558638316; bh=YP2OrLXcg7+GgleBA75F5zjB/aDAnmSGT6B98RFmL+A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ABVkXe49Iwt9HNArMqPpHmNl0uJRGzlQvFw8q92phwZF7JmzwKUNZOaNCTi4Wht9w
         2wNftys44mCri3WYu2IQsS2msA6zvIaHCp0Cvz8q/YjbkPDIKq5FTeqZu1sxr89D4b
         ETwGXxWTZ7LjM4ajaIOSMJb5z53WNPrhPwx5kNkFvNrISKpc8+UziwycRt5zENV+V6
         aAIVE0rDiZ/8+aNThPhKyWCWdv7hifp8UaGKiip1BrYHprhY5UlhjLLSFbym6ZcvBa
         Spflg8pZ4Ap8Q3REzEIkaKoWwuNIXzSTlv5sesMjG46x194a7GNeebHGp9IoEmoknK
         eZ9FzMjZUpzbg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This patch series arised out of discussions with Jerome when looking at the
> ODP changes, particularly informed by use after free races we have already
> found and fixed in the ODP code (thanks to syzkaller) working with mmu
> notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> 
> Overall this brings in a simplified locking scheme and easy to explain
> lifetime model:
> 
>   If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
>   is allocated memory.
> 
>   If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
>   then the mmget must be obtained via mmget_not_zero().
> 
> Locking of mm->hmm is shifted to use the mmap_sem consistently for all
> read/write and unlocked accesses are removed.
> 
> The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
> standard mmget() locking to prevent the mm from being released. Many of the
> debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
> which is much clearer as to the lifetime intent.
> 
> The trailing patches are just some random cleanups I noticed when reviewing
> this code.
> 
> I expect Jerome & Ralph will have some design notes so this is just RFC, and
> it still needs a matching edit to nouveau. It is only compile tested.
> 

Thanks so much for doing this. Jerome has already absorbed these into his
hmm-5.3 branch, along with Ralph's other fixes, so we can start testing,
as well as reviewing, the whole set. We'll have feedback soon.


thanks,
-- 
John Hubbard
NVIDIA
