Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93225C388
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgICOx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 3 Sep 2020 10:53:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:63748 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgICOMc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:12:32 -0400
IronPort-SDR: f6sTwE7Ud/bkO4x4ucGk7JQBnSbNTz2Q9JogftMPi9QQ3cxHKDDzHylmoGmcFAIMxfs5hAcvrN
 HKptuoJ/6Oow==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="242397469"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="242397469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:12:04 -0700
IronPort-SDR: Tb5iBs+zR5OzL4ST5hE4ddRpcKuA6cKvRHoeBvivJUq9PSoSb92iRclZlj1eDlMP1qROL0qD1c
 8eLMdpyYrHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="446917415"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2020 07:12:05 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:12:04 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 07:12:04 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.106]) with mapi id 14.03.0439.000;
 Thu, 3 Sep 2020 07:12:04 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: RE: [PATCH 04/14] RDMA/umem: Add rdma_umem_for_each_dma_block()
Thread-Topic: [PATCH 04/14] RDMA/umem: Add rdma_umem_for_each_dma_block()
Thread-Index: AQHWgMIntC2/yrsQsUCiSEZI1UVpa6lW7AtA
Date:   Thu, 3 Sep 2020 14:12:04 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70107141181@ORSMSX101.amr.corp.intel.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <4-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <4-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
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

> Subject: [PATCH 04/14] RDMA/umem: Add rdma_umem_for_each_dma_block()
> 
> This helper does the same as rdma_for_each_block(), except it works on a umem.
> This simplifies most of the call sites.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

[...]

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index b51339328a51ef..beb611b157bc8d 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -1320,8 +1320,7 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr
> *iwmr,
>  	if (iwmr->type == IW_MEMREG_TYPE_QP)
>  		iwpbl->qp_mr.sq_page = sg_page(region->sg_head.sgl);
> 
> -	rdma_for_each_block(region->sg_head.sgl, &biter, region->nmap,
> -			    iwmr->page_size) {
> +	rdma_umem_for_each_dma_block(region, &biter, iwmr->page_size) {
>  		*pbl = rdma_block_iter_dma_address(&biter);
>  		pbl = i40iw_next_pbl_addr(pbl, &pinfo, &idx);
>  	}

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>


[....]
> +static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
> +						struct ib_umem *umem,
> +						unsigned long pgsz)
> +{
> +	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz); }
> +
> +/**
> + * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of
> +the umem
> + * @umem: umem to iterate over
> + * @pgsz: Page size to split the list into
> + *
> + * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz().

>= ?
