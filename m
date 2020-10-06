Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB76285159
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgJFSEh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Oct 2020 14:04:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:55937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFSEh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 14:04:37 -0400
IronPort-SDR: P6XqaMWK4r0eMBCYdKvDpU/aD23lpWHiB1VF8UlwrJ3KfQMs2WRBqUE20KpL+nV4Vh8O7xdVBp
 1rIsOBvpzmGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="152376230"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="152376230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:04:36 -0700
IronPort-SDR: bX2ocFF1NXug2L6dqNWpJSOyDYRIH8oYpMFTV7jt1uD2fMNWIsUdZNcUw7LuyS76FYjwQHHjCG
 roXaXjNEl+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527480139"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2020 11:04:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:04:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:04:34 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 6 Oct 2020 11:04:34 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH 07/11] RDMA: Check flags during create_cq
Thread-Topic: [PATCH 07/11] RDMA: Check flags during create_cq
Thread-Index: AQHWmdvWcd96fv5yeEquYPwOa7HQC6mK4OQw
Date:   Tue, 6 Oct 2020 18:04:29 +0000
Message-ID: <dae8db3a1d134141bdd6dbcca5564433@intel.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <7-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <7-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
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

> Subject: [PATCH 07/11] RDMA: Check flags during create_cq
> 
> Each driver should check that the CQ attrs is supported. Unfortuantely when flags
> was added to the CQ attrs the drivers were not updated, uverbs_ex_cmd_mask
> was used to block it. This was missed when create CQ was converted to ioctl, so
> non-zero flags could have been passed into drivers.
> 
> Check that flags is zero in all drivers that don't use it, remove
> IB_USER_VERBS_EX_CMD_CREATE_CQ from uverbs_ex_cmd_mask.
> 
> Fixes: 41b2a71fc848 ("IB/uverbs: Move ioctl path of create_cq and destroy_cq to
> a new file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/device.c             | 1 +
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 3 +++
>  drivers/infiniband/hw/cxgb4/cq.c             | 2 +-
>  drivers/infiniband/hw/efa/efa_verbs.c        | 3 +++
>  drivers/infiniband/hw/hns/hns_roce_cq.c      | 3 +++
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 3 +++
>  drivers/infiniband/hw/mlx4/main.c            | 1 -
>  drivers/infiniband/hw/mlx5/main.c            | 1 -
>  drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
> drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c           | 3 +++
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
> drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c | 3 +++
>  drivers/infiniband/sw/rdmavt/cq.c            | 2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c        | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c        | 3 +++
>  16 files changed, 28 insertions(+), 8 deletions(-)
> 

[...]

> a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 26a61af2d3977f..4aade66ad2aea8 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -1107,6 +1107,9 @@ static int i40iw_create_cq(struct ib_cq *ibcq,
>  	int err_code;
>  	int entries = attr->cqe;
> 
> +	if (attr->flags)
> +		return -EOPNOTSUPP;
> +

I am slightly confused.
So these flags are set for drivers that support the extended create CQ API?

Shiraz
