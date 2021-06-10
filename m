Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B403A2BEF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhFJMve convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Jun 2021 08:51:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:20258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFJMvd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:51:33 -0400
IronPort-SDR: ZUlcgAzsO+t0WeFw33EgKPbfz/VSlIFLkTjeQM9m9qSk5phycsivjYssDLmeF8IhRtZM9C+QmP
 ZZZF06yjQx2A==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205102644"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="205102644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 05:49:36 -0700
IronPort-SDR: tPSQuuDj1uJOQRd23vwbLwkzWj25UVFjSUDtOiMkIOA53xP1NQklBBjqtSA47fIaAusNTWJkit
 vNlS4ImiAGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="419702083"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2021 05:49:35 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 10 Jun 2021 05:49:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 10 Jun 2021 20:49:32 +0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Thu, 10 Jun 2021 05:49:30 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: RE: [PATCH rdma-next] irdma: Store PBL info address a pointer type
Thread-Topic: [PATCH rdma-next] irdma: Store PBL info address a pointer type
Thread-Index: AQHXXYqlelVLtS4nTUyyTu2Ajkn0bqsNpxUA//+LWgA=
Date:   Thu, 10 Jun 2021 12:49:30 +0000
Message-ID: <0e8c2d1c2c9a47da971a0b6b9e22f208@intel.com>
References: <20210609234924.938-1-shiraz.saleem@intel.com>
 <20210610124454.GA1264557@nvidia.com>
In-Reply-To: <20210610124454.GA1264557@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Shiraz Saleem
Network Software Engineer
Networking Division (DPG/CG/EPG)
Intel Corporation
Mobile: 1-617-633-1629

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, June 10, 2021 7:45 AM
> To: Saleem, Shiraz <shiraz.saleem@intel.com>
> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; lkp <lkp@intel.com>
> Subject: Re: [PATCH rdma-next] irdma: Store PBL info address a pointer type
> 
> On Wed, Jun 09, 2021 at 06:49:24PM -0500, Shiraz Saleem wrote:
> > The level1 PBL info address is stored as u64.
> > This requires casting through a uinptr_t before used as a pointer
> > type.
> >
> > And this leads to sparse warning such as this when uinptr_t is
> > missing:
> >
> > drivers/infiniband/hw/irdma/hw.c: In function 'irdma_destroy_virt_aeq':
> > drivers/infiniband/hw/irdma/hw.c:579:23: warning: cast to pointer from integer of
> different size [-Wint-to-pointer-cast]
> >   579 |  dma_addr_t *pg_arr = (dma_addr_t *)aeq->palloc.level1.addr;
> >
> > This can be fixed using an intermediate uintptr_t, but rather it is
> > better to fix the structure irdm_pble_info to store the address as
> > u64* and the VA it is assigned in irdma_chunk as a void*. This greatly
> > reduces the casting on this address.
> >
> > Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization
> > definitions")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > ---
> >  drivers/infiniband/hw/irdma/hw.c    |  2 +-
> >  drivers/infiniband/hw/irdma/pble.c  | 13 ++++++-------
> > drivers/infiniband/hw/irdma/pble.h  |  6 +++---
> > drivers/infiniband/hw/irdma/utils.c | 10 +++++-----
> > drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++--------
> >  5 files changed, 23 insertions(+), 24 deletions(-)
> 
> Applied to for-next, but please be careful with the commit messages, the tag
> should be 'RDMA/irdma' and word wrap to the standard 74 cols, not alot less. I
> fixed it up
> 

I see. Thanks!
