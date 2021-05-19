Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5A389415
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhESQwN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 19 May 2021 12:52:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:59018 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231124AbhESQwM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 12:52:12 -0400
IronPort-SDR: /3DcR93rBS4NeIfHQD6EFPFaeSjxtEMmTGxNz2UmdEbsBPV+54BTH1CVq9fR/ul27Q0SZTZnb9
 moWgM7Gfjiaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="262252083"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262252083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 09:50:51 -0700
IronPort-SDR: 3iU63YcdY7pTDbG3uOUzGORWKkVIGeT5+kacB9ff9o6VcMx6/lGiY9i3LChlVbJ4r8zNE6ca7x
 YWOJI4CluG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439804360"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2021 09:50:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 19 May 2021 09:50:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 19 May 2021 09:50:50 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Wed, 19 May 2021 09:50:50 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Topic: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Index: AQHXSzxfKpiSrsBJnEi7XaP3x/HUP6roAbcwgADA44D//47VQIAAhKYA//+S/jCAAsniAP//qu5g
Date:   Wed, 19 May 2021 16:50:50 +0000
Message-ID: <b130c0fd865d46e98761646ddff6f34e@intel.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
 <20210517231045.GV1002214@nvidia.com>
 <641e6b83b8694f859281e74ee887c6b3@intel.com>
 <20210518002028.GX1002214@nvidia.com>
 <91089ed56df74ef2b1f0199ce7aaec5f@intel.com>
 <20210519122524.GH1002214@nvidia.com>
In-Reply-To: <20210519122524.GH1002214@nvidia.com>
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

> Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
> device variants
> 
> On Tue, May 18, 2021 at 09:58:28PM +0000, Saleem, Shiraz wrote:
> > > Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to
> > > port and device variants
> > >
> > > On Tue, May 18, 2021 at 12:18:13AM +0000, Saleem, Shiraz wrote:
> > >
> > > > > What does the sysfs look like? Aren't there duplicated HW stats?
> > > >
> > > >
> > > > Yeah it is duplicated. So we are saying for phys_port_cnt = 1, we
> > > > want the stats to show up in only place?
> > >
> > > Yes.
> > >
> > > Imagine you had a multi port device, and assign the stats appropriately.
> > >
> > > I didn't see anything in the list that made me think "device stat"
> > > but I don't know what several of these do
> >
> > Are we exporting port stat when it should be really be device stat in some of the
> drivers though?
> >
> > Most vendor drivers do port stats allocation only. Like...
> > https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/h
> > w/cxgb4/provider.c#L392
> > https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/s
> > w/rxe/rxe_hw_counters.c#L27
> 
> Yes they don't have global device counters, presumably because they only have 1
> port.
> 
> > However .get_hw_stats callback appears to extract from same set of
> > registers for each port
> 
> Most devices should only have port counters
> 
> > > If you can confirm that these are all port stats I can delete the
> > > device stats in this series.
> >
> > So your device and port stats op callback separation feels warranted.
> 
> So should I delete the device counters here?

For i40iw, yes. Just expose port stats and NULL out the device stat op.

