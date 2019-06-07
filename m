Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD00838331
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFGDrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 23:47:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2406 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFGDrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 23:47:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9de530000>; Thu, 06 Jun 2019 20:47:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 20:47:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 20:47:34 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 03:47:28 +0000
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <3edc47bd-e8f6-0e65-5844-d16901890637@nvidia.com>
Date:   Thu, 6 Jun 2019 20:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-12-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559879252; bh=bZvuY/i6GNCDoB9S/9ycfjQg/GlXUjYF/GtxOCf0uXU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A7b3B9MIZYE2j+v3mXjKis5leb/eVo7kaz4HeWlw96qB4oJdGtB86PLsdX70nI9ax
         x3/wFcbHrGloJGNYAG+xmMO+ti4FMUCxIPFMH+21XCi150Jn6NaUYQx0kq04Bf6jKj
         LkktxvYAUlD5Ove8fENnNtyaieAVfZiEKInsVhqpxtqRzXZAStQjBmX1EmXNW9wVD0
         qRd9vtBuVuOZRuz1WMqrpCwQNfKp37kqYjYZ8hbRrh6CM+QdjaHZLXTSzrJBYQvPb/
         tMZ+XTvLFuSez92di1HCFzs1bE/CVkNOISup9kLBndzsy8o/zyKWeRc6duPhudgnyM
         tfNzpFVVgkGIg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_release() is called exactly once per hmm. ops->release() cannot
> accidentally trigger any action that would recurse back onto
> hmm->mirrors_sem.
> 
> This fixes a use after-free race of the form:
> 
>        CPU0                                   CPU1
>                                            hmm_release()
>                                              up_write(&hmm->mirrors_sem);
>  hmm_mirror_unregister(mirror)
>   down_write(&hmm->mirrors_sem);
>   up_write(&hmm->mirrors_sem);
>   kfree(mirror)
>                                              mirror->ops->release(mirror)
> 
> The only user we have today for ops->release is an empty function, so this
> is unambiguously safe.
> 
> As a consequence of plugging this race drivers are not allowed to
> register/unregister mirrors from within a release op.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  mm/hmm.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 709d138dd49027..3a45dd3d778248 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -136,26 +136,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	WARN_ON(!list_empty(&hmm->ranges));
>  	mutex_unlock(&hmm->lock);
>  
> -	down_write(&hmm->mirrors_sem);
> -	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
> -					  list);
> -	while (mirror) {
> -		list_del_init(&mirror->list);
> -		if (mirror->ops->release) {
> -			/*
> -			 * Drop mirrors_sem so the release callback can wait
> -			 * on any pending work that might itself trigger a
> -			 * mmu_notifier callback and thus would deadlock with
> -			 * us.
> -			 */
> -			up_write(&hmm->mirrors_sem);
> +	down_read(&hmm->mirrors_sem);

This is cleaner and simpler, but I suspect it is leading to the deadlock
that Ralph Campbell is seeing in his driver testing. (And in general, holding
a lock during a driver callback usually leads to deadlocks.)

Ralph, is this the one? It's the only place in this patchset where I can
see a lock around a callback to driver code, that wasn't there before. So
I'm pretty sure it is the one...


thanks,
-- 
John Hubbard
NVIDIA
