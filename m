Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B625C247
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgICONc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 3 Sep 2020 10:13:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:30855 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgICOMi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:12:38 -0400
IronPort-SDR: 8JwRaZsrP53DsnBUZCBWo2x5NcDEeBoJi5l5srEyEUr+uE0pw0Fwjq5ExDMC6fWugOJKpoV+JI
 5z9rnSsqQBVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137095991"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="137095991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:12:12 -0700
IronPort-SDR: ZEwJDg1GIHBfZb2js+1oiSUebDrMry1m5YEEwCWwaGBu9wzpdh4dQzehA653j6oXy7Bv4rMZXm
 yiOw47VlG/BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="478063597"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2020 07:12:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:12:11 -0700
Received: from orsmsx105.amr.corp.intel.com (10.22.225.132) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 07:12:11 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.22]) with mapi id 14.03.0439.000;
 Thu, 3 Sep 2020 07:12:11 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: RE: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
Thread-Topic: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
Thread-Index: AQHWgMI6tM4ljRzdsECysbgsj3wYx6lW8hEQ
Date:   Thu, 3 Sep 2020 14:12:10 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70107141188@ORSMSX101.amr.corp.intel.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
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

> Subject: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into
> ib_umem_num_dma_blocks()
> 
> ib_num_pages() should only be used by things working with the SGL in CPU
> pages directly.
> 
> Drivers building DMA lists should use the new ib_num_dma_blocks() which returns
> the number of blocks rdma_umem_for_each_block() will return.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
>  drivers/infiniband/hw/mlx5/mem.c             |  5 +++--
>  drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
> drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  2 +-
>  include/rdma/ib_umem.h                       | 14 +++++++++++---
>  5 files changed, 17 insertions(+), 8 deletions(-)
> 

Perhaps the one in the bnxt_re too?

https://elixir.bootlin.com/linux/v5.9-rc3/source/drivers/infiniband/hw/bnxt_re/qplib_res.c#L94

