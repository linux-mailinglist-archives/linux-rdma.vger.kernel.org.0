Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F277388280
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhERV7v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 18 May 2021 17:59:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:17689 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhERV7t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 17:59:49 -0400
IronPort-SDR: 7D8GQRf3oH+LwXNyNNWizqWkE29E1uNnSUccuadtDHAiEMV5sRkkbKMW7+o8v3ImcBLYMv61uO
 YJ3b1XtpekYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200525948"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200525948"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:58:30 -0700
IronPort-SDR: TNkUGdiqQuyqRcMZg83GqrstRgCuJ1lGOxIBALBoZCeM2Ds4HktVePykhN3QdJXsVm9vMigCRE
 sRnJ2MwdQyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="544281576"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2021 14:58:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 14:58:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 14:58:28 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 18 May 2021 14:58:28 -0700
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
Thread-Index: AQHXSzxfKpiSrsBJnEi7XaP3x/HUP6roAbcwgADA44D//47VQIAAhKYA//+S/jA=
Date:   Tue, 18 May 2021 21:58:28 +0000
Message-ID: <91089ed56df74ef2b1f0199ce7aaec5f@intel.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
 <20210517231045.GV1002214@nvidia.com>
 <641e6b83b8694f859281e74ee887c6b3@intel.com>
 <20210518002028.GX1002214@nvidia.com>
In-Reply-To: <20210518002028.GX1002214@nvidia.com>
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

> Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
> device variants
> 
> On Tue, May 18, 2021 at 12:18:13AM +0000, Saleem, Shiraz wrote:
> 
> > > What does the sysfs look like? Aren't there duplicated HW stats?
> >
> >
> > Yeah it is duplicated. So we are saying for phys_port_cnt = 1, we want
> > the stats to show up in only place?
> 
> Yes.
> 
> Imagine you had a multi port device, and assign the stats appropriately.
> 
> I didn't see anything in the list that made me think "device stat" but I don't know
> what several of these do

Are we exporting port stat when it should be really be device stat in some of the drivers though?

Most vendor drivers do port stats allocation only. Like...
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/hw/cxgb4/provider.c#L392
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/sw/rxe/rxe_hw_counters.c#L27

However .get_hw_stats callback appears to extract from same set of registers for each port

>
> If you can confirm that these are all port stats I can delete the device stats in this
> series.
> 

hfi1 seems to have this separation between device and port stat with a different set of counters
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/hw/hfi1/verbs.c#L1760

So your device and port stats op callback separation feels warranted.


