Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0828518C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgJFSXr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Oct 2020 14:23:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:59532 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgJFSXr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 14:23:47 -0400
IronPort-SDR: 8DO+9gQYFuX1Rmg2i3pubQjrckZQsjjuIGxUZO4pdv06sHcXoFiI3KU3TaGU7JqFWisYWOl+xM
 5QqhKad4nwAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="152387306"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="152387306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:23:41 -0700
IronPort-SDR: qf8FwMjwp4jA64b69yFhWu8OWFIP18/o/mhSRNvY2n0RrtXFTy/7i9Dl9zoLRj4hrKRr2xSvU3
 DDoEwiu9uMhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="343896034"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2020 11:23:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:23:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:23:38 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 6 Oct 2020 11:23:38 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
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
Thread-Index: AQHWmdvWcd96fv5yeEquYPwOa7HQC6mK4OQwgAB5ggD//41dcA==
Date:   Tue, 6 Oct 2020 18:23:35 +0000
Message-ID: <b0ab06afe6894f4186e5caa70ded64fa@intel.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <7-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <dae8db3a1d134141bdd6dbcca5564433@intel.com>
 <20201006181326.GM4734@nvidia.com>
In-Reply-To: <20201006181326.GM4734@nvidia.com>
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

> Subject: Re: [PATCH 07/11] RDMA: Check flags during create_cq
> 
> On Tue, Oct 06, 2020 at 06:04:29PM +0000, Saleem, Shiraz wrote:
> > > a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > index 26a61af2d3977f..4aade66ad2aea8 100644
> > > +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > > @@ -1107,6 +1107,9 @@ static int i40iw_create_cq(struct ib_cq *ibcq,
> > >  	int err_code;
> > >  	int entries = attr->cqe;
> > >
> > > +	if (attr->flags)
> > > +		return -EOPNOTSUPP;
> > > +
> >
> > I am slightly confused.
> > So these flags are set for drivers that support the extended create CQ API?
> 
> No, the flags can be set by any user or kernel program creating a CQ. The driver
> must ensure it supports all requested flags.
> 
> Omitting the flags check was always a mistake because an in-kernel ULP could
> attempt to use them - luckily none due today.
> 
OK. Makes sense now. Thanks!
