Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4878939A08
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfFHBcn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:32:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10333 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfFHBcn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:32:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfb102a0001>; Fri, 07 Jun 2019 18:32:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 18:32:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 18:32:42 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 8 Jun
 2019 01:32:39 +0000
Subject: Re: [PATCH v3 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
 <20190607133107.GF14802@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4c1a18b7-6dcb-7ce3-c178-9efd255e8056@nvidia.com>
Date:   Fri, 7 Jun 2019 18:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607133107.GF14802@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559957547; bh=xVgyj/Sltl83MtwATtJ5A8fGsNYheaZeYpyqP7L5KAE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GYKNG1guS/PHUsAd0J2qN9HUV4d3WKr9M1/GPzqHHGQhrOJ6/d/qZI2z5UvXkDVSn
         Ng/R0UmHQgBZALpk+QV7PGHkieBLm5sE+nOdT9PnB9vhI0YwIaj7FcafynhrREdkaC
         LVWTBVe98W53OWJnxbiRTu68ZRBvOMlVxzr34UOPe4fHKZMZJBuyJLUupa6MjR5L+i
         Vvc7YeCTnOwpFbhUOGQnW0FfnLcky93noaVhM7A3AWMPrAFOWIu7BhzYB1hrF1WCP3
         WI5gua45CZvoJhs+zWsNFiKgRpZH45b1dnLmOB/r8OgGpM4n9GPBKWbsM20ZhqCDzl
         tB81whaCw2vig==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/7/19 6:31 AM, Jason Gunthorpe wrote:
> The wait_event_timeout macro already tests the condition as its first
> action, so there is no reason to open code another version of this, all
> that does is skip the might_sleep() debugging in common cases, which is
> not helpful.
> 
> Further, based on prior patches, we can now simplify the required condition
> test:
>  - If range is valid memory then so is range->hmm
>  - If hmm_release() has run then range->valid is set to false
>    at the same time as dead, so no reason to check both.
>  - A valid hmm has a valid hmm->mm.
> 
> Allowing the return value of wait_event_timeout() (along with its internal
> barriers) to compute the result of the function.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---


    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA



> v3
> - Simplify the wait_event_timeout to not check valid
> ---
>  include/linux/hmm.h | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 1d97b6d62c5bcf..26e7c477490c4e 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -209,17 +209,8 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
>  static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
>  					      unsigned long timeout)
>  {
> -	/* Check if mm is dead ? */
> -	if (range->hmm == NULL || range->hmm->dead || range->hmm->mm == NULL) {
> -		range->valid = false;
> -		return false;
> -	}
> -	if (range->valid)
> -		return true;
> -	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
> -			   msecs_to_jiffies(timeout));
> -	/* Return current valid status just in case we get lucky */
> -	return range->valid;
> +	return wait_event_timeout(range->hmm->wq, range->valid,
> +				  msecs_to_jiffies(timeout)) != 0;
>  }
>  
>  /*
> 

