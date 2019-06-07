Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD96839929
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfFGWyk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:54:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:61062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbfFGWyk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 18:54:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:54:39 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2019 15:54:38 -0700
Date:   Fri, 7 Jun 2019 15:55:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
Message-ID: <20190607225552.GG14559@iweiny-DESK2.sc.intel.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
 <20190607133107.GF14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607133107.GF14802@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 10:31:07AM -0300, Jason Gunthorpe wrote:
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
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
> -- 
> 2.21.0
> 
