Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637FF39E9A3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGWd3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 7 Jun 2021 18:33:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:55096 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFGWd1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 18:33:27 -0400
IronPort-SDR: GFENVdevvopXg5v4AkUEsSgaI/e5v+eVpfjPu6fQDCLXNpZMeL5GE1Jm2SmM7NCnRsAA4rScjE
 Vz86/7S61x2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204751241"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="204751241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 15:31:35 -0700
IronPort-SDR: 8HiC0l31L1CwOMaXO3y311sIsSx4Qdsr4jrFqUgCbwLojt3J5BWZ40+ac5kYPQhSv0NI9v75x8
 cSrn7m1VAJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="481704278"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2021 15:31:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 15:31:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 15:31:34 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 7 Jun 2021 15:31:34 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: RE: [PATCH for-next] RDMA/irdma: Fix return error sign from
 irdma_modify_qp
Thread-Topic: [PATCH for-next] RDMA/irdma: Fix return error sign from
 irdma_modify_qp
Thread-Index: AQHXW+q9ky8PtuPtZ066zLYfW0GhSqsJILtQ
Date:   Mon, 7 Jun 2021 22:31:34 +0000
Message-ID: <e0c4178e7a7f460dae43abd767761155@intel.com>
References: <20210607221543.254144-1-kamalheib1@gmail.com>
In-Reply-To: <20210607221543.254144-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next] RDMA/irdma: Fix return error sign from
> irdma_modify_qp
> 
> There is a typo in the returned error code sign from irdma_modify_qp() when the
> attr_mask is not supported - Fix it.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 294155293243..154ca25e7e32 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1472,7 +1472,7 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr, int attr_mask,
>  	unsigned long flags;
> 
>  	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
> -		return ~EOPNOTSUPP;
> +		return -EOPNOTSUPP;
> 
Oops. That's a bad one. Thanks!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>


