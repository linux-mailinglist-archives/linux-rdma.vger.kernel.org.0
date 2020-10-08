Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D0287A35
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgJHQlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 12:41:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:21842 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgJHQlR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 12:41:17 -0400
IronPort-SDR: 7wCIG1j6ZUQCEtyKImagUxbzrnD+qgPaz1zkaoikvKQtSrszPugdzOlNEdHQ+pa8T3gS9gmpo7
 XPO3eNWdV2Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250061447"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250061447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 09:41:16 -0700
IronPort-SDR: +8ZEaOJS5YzgJtL53kO3bUHDLC2vYYqPW0YrpuCxHqJ65QBr+1bHZuNvQSSMvwB8l0iEn6d9ao
 4DWPEcjt59zw==
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="461870258"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 09:41:16 -0700
Date:   Thu, 8 Oct 2020 09:41:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: Fix sizeof mismatch
Message-ID: <20201008164116.GS2046448@iweiny-DESK2.sc.intel.com>
References: <20201008095204.82683-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008095204.82683-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 10:52:04AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An incorrect sizeof is being used, struct rvt_ibport ** is not correct,
> it should be struct rvt_ibport *. Note that since ** is the same size as
> * this is not causing any issues.  Improve this fix by using
> sizeof(*rdi->ports) as this allows us to not even reference the type
> of the pointer.  Also remove line breaks as the entire statement can
> fit on one line.
> 
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: ff6acd69518e ("IB/rdmavt: Add device structure allocation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/infiniband/sw/rdmavt/vt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
> index f904bb34477a..2d534c450f3c 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -95,9 +95,7 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
>  	if (!rdi)
>  		return rdi;
>  
> -	rdi->ports = kcalloc(nports,
> -			     sizeof(struct rvt_ibport **),
> -			     GFP_KERNEL);
> +	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
>  	if (!rdi->ports)
>  		ib_dealloc_device(&rdi->ibdev);
>  
> -- 
> 2.27.0
> 
