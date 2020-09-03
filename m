Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95925C35C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgICOuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 3 Sep 2020 10:50:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:43065 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgICOTC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:19:02 -0400
IronPort-SDR: PBI7pW43EBRGPxLn4ReLswUxCKimGwmhyREHxOI/NYsxC5hzxt6zzxLlzqr6ds0TDYRgvm+dpM
 A7lLBCecHOtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="154979394"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="154979394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:18:58 -0700
IronPort-SDR: kGGbLtE2Nm8hGpxHtFEfNOCNar/PIGEkie+95Opu6+6ojs1FjTe23Ara22T0WqnpZ2FM1O7sXd
 KMTRcOl0IjYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="446919820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2020 07:18:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:18:57 -0700
Received: from orsmsx106.amr.corp.intel.com (10.22.225.133) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 07:18:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.122]) with mapi id 14.03.0439.000;
 Thu, 3 Sep 2020 07:18:56 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 02/14] RDMA/umem: Prevent small pages from being
 returned by ib_umem_find_best_pgsz()
Thread-Topic: [PATCH 02/14] RDMA/umem: Prevent small pages from being
 returned by ib_umem_find_best_pgsz()
Thread-Index: AQHWgMIvlK3UiZHkXUSnz9HsWkCUf6lW6QWAgACEpAD//4rpoA==
Date:   Thu, 3 Sep 2020 14:18:56 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A701071411D2@ORSMSX101.amr.corp.intel.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A70107141173@ORSMSX101.amr.corp.intel.com>
 <20200903141712.GF1152540@nvidia.com>
In-Reply-To: <20200903141712.GF1152540@nvidia.com>
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

> Subject: Re: [PATCH 02/14] RDMA/umem: Prevent small pages from being
> returned by ib_umem_find_best_pgsz()
> 
> On Thu, Sep 03, 2020 at 02:11:37PM +0000, Saleem, Shiraz wrote:
> > > Subject: [PATCH 02/14] RDMA/umem: Prevent small pages from being
> > > returned by
> > > ib_umem_find_best_pgsz()
> > >
> > > rdma_for_each_block() makes assumptions about how the SGL is
> > > constructed that don't work if the block size is below the page size used to to
> build the SGL.
> > >
> > > The rules for umem SGL construction require that the SG's all be
> > > PAGE_SIZE aligned and we don't encode the actual byte offset of the
> > > VA range inside the SGL using offset and length. So
> > > rdma_for_each_block() has no idea where the actual starting/ending
> > > point is to compute the first/last block boundary if the starting address should
> be within a SGL.
> >
> > Not sure if we were exposed today. i.e. rdma drivers working with
> > block sizes smaller than system page size?
> 
> Yes, it could happen, here are some examples:
> 
> drivers/infiniband/hw/i40iw/i40iw_verbs.c:
>               iwmr->page_size = ib_umem_find_best_pgsz(region, SZ_4K | SZ_2M,
> 
> drivers/infiniband/hw/bnxt_re/ib_verbs.c:
>         page_shift = __ffs(ib_umem_find_best_pgsz(umem,
>                                 BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M,
>                                 virt_addr));
> 
> Eg that breaks on a ARM with 16k or 64k page sizes.
> 

Yes. Make sense. Thanks for the patch!
