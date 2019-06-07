Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD639939
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 01:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfFGXBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 19:01:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:41671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfFGXBd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 19:01:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 16:01:33 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2019 16:01:32 -0700
Date:   Fri, 7 Jun 2019 16:02:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 hmm 10/11] mm/hmm: Do not use list*_rcu() for
 hmm->ranges
Message-ID: <20190607230246.GI14559@iweiny-DESK2.sc.intel.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-11-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606184438.31646-11-jgg@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 03:44:37PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This list is always read and written while holding hmm->lock so there is
> no need for the confusing _rcu annotations.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Reviewed-by: Ira Weiny <iweiny@intel.com>

> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c2fecb3ecb11e1..709d138dd49027 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -911,7 +911,7 @@ int hmm_range_register(struct hmm_range *range,
>  	mutex_lock(&hmm->lock);
>  
>  	range->hmm = hmm;
> -	list_add_rcu(&range->list, &hmm->ranges);
> +	list_add(&range->list, &hmm->ranges);
>  
>  	/*
>  	 * If there are any concurrent notifiers we have to wait for them for
> @@ -941,7 +941,7 @@ void hmm_range_unregister(struct hmm_range *range)
>  		return;
>  
>  	mutex_lock(&hmm->lock);
> -	list_del_rcu(&range->list);
> +	list_del(&range->list);
>  	mutex_unlock(&hmm->lock);
>  
>  	/* Drop reference taken by hmm_range_register() */
> -- 
> 2.21.0
> 
