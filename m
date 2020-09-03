Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925225C3B7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgICO4T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 3 Sep 2020 10:56:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:42378 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgICOLJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:11:09 -0400
IronPort-SDR: xRugnrvC7px47QOHMCV8iHFu8668wdPqvrFz8uSvrFs+CnOIBPfWOpdD+cVAaRBykhhy4R24xV
 FQ8PHOAVeaYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="154978197"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="154978197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:11:08 -0700
IronPort-SDR: ZOC8yqauj1RKGnItDr2E0tlXh7M0tIX8PXfoNGyaNmvVEqWHA7fR8p966LtWmmkM5u/Zw2W+bN
 RkGKj/b5E4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="478063327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2020 07:11:08 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:11:05 -0700
Received: from orsmsx104.amr.corp.intel.com (10.22.225.131) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 07:11:05 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.21]) with mapi id 14.03.0439.000;
 Thu, 3 Sep 2020 07:11:04 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for
 mappings that cross a page boundary
Thread-Topic: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for
 mappings that cross a page boundary
Thread-Index: AQHWgMIou+181d2BTUC3N2QHlRxPk6lW5dyg
Date:   Thu, 3 Sep 2020 14:11:03 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70107141165@ORSMSX101.amr.corp.intel.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for
> mappings that cross a page boundary
> 
> It is possible for a single SGL to span an aligned boundary, eg if the SGL is
> 
>   61440 -> 90112
> 
> Then the length is 28672, which currently limits the block size to 32k. With a 32k
> page size the two covering blocks will be:
> 
>   32768->65536 and 65536->98304
> 
> However, the correct answer is a 128K block size which will span the whole
> 28672 bytes in a single block.
> 
> Instead of limiting based on length figure out which high IOVA bits don't change
> between the start and end addresses. That is the highest useful page size.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page
> size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c index
> 831bff8d52e547..120e98403c345d 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -156,8 +156,14 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem
> *umem,
>  		return 0;
> 
>  	va = virt;
> -	/* max page size not to exceed MR length */
> -	mask = roundup_pow_of_two(umem->length);
> +	/* The best result is the smallest page size that results in the minimum
> +	 * number of required pages. Compute the largest page size that could
> +	 * work based on VA address bits that don't change.
> +	 */
> +	mask = pgsz_bitmap &
> +	       GENMASK(BITS_PER_LONG - 1,
> +		       bits_per((umem->length - 1 + umem->address) ^
> +				umem->address));
>  	/* offset into first SGL */
>  	pgoff = umem->address & ~PAGE_MASK;
> 
> --

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

