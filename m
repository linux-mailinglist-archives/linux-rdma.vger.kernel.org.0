Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712F744039B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJ2Tz5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 29 Oct 2021 15:55:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:13584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhJ2Tz4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 15:55:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="228195389"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="228195389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="665947733"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2021 12:53:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 12:53:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 12:53:26 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Fri, 29 Oct 2021 12:53:26 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE: [PATCH 1/1] RDMA/irdma: optimize rx path by removing unnecessary
 copy
Thread-Topic: [PATCH 1/1] RDMA/irdma: optimize rx path by removing unnecessary
 copy
Thread-Index: AQHXzJ+il3xiIqtaKUW4zKshqU9+t6vqYitQ
Date:   Fri, 29 Oct 2021 19:53:26 +0000
Message-ID: <731072121b4245d2beefd07ce1cb757f@intel.com>
References: <20211029162340.241768-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211029162340.241768-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 1/1] RDMA/irdma: optimize rx path by removing unnecessary
> copy
> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_post_recv, the function irdma_copy_sg_list is not needed
> since the struct irdma_sge and ib_sge have the similar member variables. The
> struct irdma_sge can be replaced with the struct ib_sge totally.
> 
> This can increase the rx performance of irdma.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/uk.c    | 38 +++++++++++++-------------
>  drivers/infiniband/hw/irdma/user.h  | 23 ++++++----------
> drivers/infiniband/hw/irdma/verbs.c | 41 +++++++++--------------------
>  3 files changed, 39 insertions(+), 63 deletions(-)

Thanks much for the patch! Minor comment...

[....]

> a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 02ca1f80968e..7ab9645d6f18 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3039,24 +3039,6 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct
> ib_udata *udata)
>  	return 0;
>  }
> 
> -/**
> - * irdma_copy_sg_list - copy sg list for qp
> - * @sg_list: copied into sg_list
> - * @sgl: copy from sgl
> - * @num_sges: count of sg entries
> - */
> -static void irdma_copy_sg_list(struct irdma_sge *sg_list, struct ib_sge *sgl,
> -			       int num_sges)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; (i < num_sges) && (i < IRDMA_MAX_WQ_FRAGMENT_COUNT);
> i++) {
> -		sg_list[i].tag_off = sgl[i].addr;
> -		sg_list[i].len = sgl[i].length;
> -		sg_list[i].stag = sgl[i].lkey;
> -	}
> -}
> -
>  /**
>   * irdma_post_send -  kernel application wr
>   * @ibqp: qp ptr for wr
> @@ -3133,7 +3115,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
>  				ret = irdma_uk_inline_send(ukqp, &info, false);
>  			} else {
>  				info.op.send.num_sges = ib_wr->num_sge;
> -				info.op.send.sg_list = (struct irdma_sge *)
> +				info.op.send.sg_list = (struct ib_sge *)
>  						       ib_wr->sg_list;

Don't think we need the typecast.

Shiraz 
