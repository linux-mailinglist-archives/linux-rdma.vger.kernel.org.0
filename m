Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC4386E3F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 02:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhERATd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 May 2021 20:19:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:15746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhERATd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 20:19:33 -0400
IronPort-SDR: 7JN4svsxMP653PrEjh2SBRsKcMGKPVbRdkrAhcxkkAG35L/wv5MmC212UFxU1rpQ0TRb1ZQlcb
 aNX+ikL1hJwg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="264507426"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="264507426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:18:15 -0700
IronPort-SDR: IXKfNCBmk9787GGeKOMPtqpq6xCbndnNVQYJcgLWehDzo0f4mHNkDUZRd4vbofSIgXeAYXSNhq
 OtEhrQbV5fkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472669132"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2021 17:18:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 17:18:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 17:18:14 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 17 May 2021 17:18:13 -0700
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
Thread-Index: AQHXSzxfKpiSrsBJnEi7XaP3x/HUP6roAbcwgADA44D//47VQA==
Date:   Tue, 18 May 2021 00:18:13 +0000
Message-ID: <641e6b83b8694f859281e74ee887c6b3@intel.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
 <20210517231045.GV1002214@nvidia.com>
In-Reply-To: <20210517231045.GV1002214@nvidia.com>
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
> On Mon, May 17, 2021 at 11:06:29PM +0000, Saleem, Shiraz wrote:
> > > Subject: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port
> > > and device variants
> > >
> > > This is being used to implement both the port and device global
> > > stats, which is causing some confusion in the drivers. For instance
> > > EFA and i40iw both seem to be misusing the device stats.
> > >
> > > Split it into two ops so drivers that don't support one or the other
> > > can leave the op NULL'd, making the calling code a little simpler to
> understand.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/infiniband/core/counters.c          |  4 +-
> > >  drivers/infiniband/core/device.c            |  3 +-
> > >  drivers/infiniband/core/nldev.c             |  2 +-
> > >  drivers/infiniband/core/sysfs.c             | 15 +++-
> > >  drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
> > > drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
> > >  drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
> > >  drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
> > >  drivers/infiniband/hw/efa/efa.h             |  3 +-
> > >  drivers/infiniband/hw/efa/efa_main.c        |  3 +-
> > >  drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
> > >  drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
> > >  drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 19 ++++-
> > >  drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
> > >  drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
> > >  drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
> > > drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
> > >  include/rdma/ib_verbs.h                     | 13 ++--
> > >  19 files changed, 158 insertions(+), 103 deletions(-)
> > >
> >
> > [...]
> >
> > >  /**
> > > - * i40iw_alloc_hw_stats - Allocate a hw stats structure
> > > + * i40iw_alloc_hw_port_stats - Allocate a hw stats structure
> > >   * @ibdev: device pointer from stack
> > >   * @port_num: port number
> > >   */
> > > -static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
> > > -						  u32 port_num)
> > > +static struct rdma_hw_stats *i40iw_alloc_hw_port_stats(struct ib_device
> *ibdev,
> > > +						       u32 port_num)
> > >  {
> > >  	struct i40iw_device *iwdev = to_iwdev(ibdev);
> > >  	struct i40iw_sc_dev *dev = &iwdev->sc_dev; @@ -2468,6 +2468,16 @@
> > > static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
> > >  					  lifespan);
> > >  }
> > >
> > > +static struct rdma_hw_stats *
> > > +i40iw_alloc_hw_device_stats(struct ib_device *ibdev) {
> > > +	/*
> > > +	 * It is probably a bug that i40iw reports its port stats as device
> > > +	 * stats
> > > +	 */
> >
> > The number of physical ports per ib device is 1.
> 
> Does something skip the port stats in this case? I don't see anything like that?

No I don't see any check perse to prevent port stats from getting initialized.
> 
> What does the sysfs look like? Aren't there duplicated HW stats?
> 

Yeah it is duplicated. So we are saying for phys_port_cnt = 1, we want the stats to show up in only place?


# cd /sys/class/infiniband/iwp3s0f0/hw_counters; for f in *; do echo -n "$f: "; cat "$f"; done; cd -
cnpHandled: 0
cnpIgnored: 0
cnpSent: 0
ip4InDiscards: 0
ip4InMcastOctets: 0
ip4InMcastPkts: 0
ip4InOctets: 5884668
ip4InPkts: 87399
ip4InReasmRqd: 0
ip4InTruncatedPkts: 0
ip4OutMcastOctets: 0
ip4OutMcastPkts: 0
ip4OutNoRoutes: 0
ip4OutOctets: 7224092
ip4OutPkts: 101959
ip4OutSegRqd: 0
ip6InDiscards: 0
ip6InMcastOctets: 0
ip6InMcastPkts: 0
ip6InOctets: 0
ip6InPkts: 0
ip6InReasmRqd: 0
ip6InTruncatedPkts: 0
ip6OutMcastOctets: 0
ip6OutMcastPkts: 0
ip6OutNoRoutes: 0
ip6OutOctets: 0
ip6OutPkts: 0
ip6OutSegRqd: 0
iwInRdmaReads: 3
iwInRdmaSends: 29127
iwInRdmaWrites: 0
iwOutRdmaReads: 14564
iwOutRdmaSends: 29126
iwOutRdmaWrites: 14562
iwRdmaBnd: 0
iwRdmaInv: 0
lifespan: 10
RxECNMrkd: 0
RxUDP: 9
rxVlanErrors: 0
tcpInOptErrors: 0
tcpInProtoErrors: 0
tcpInSegs: 87399
tcpOutSegs: 101959
tcpRetransSegs: 0
TxUDP: 0
/sys/class/infiniband/iwp3s0f0/hw_counters


# cd /sys/class/infiniband/iwp3s0f0/ports/1/hw_counters; for f in *; do echo -n "$f: "; cat "$f"; done; cd -
cnpHandled: 0
cnpIgnored: 0
cnpSent: 0
ip4InDiscards: 0
ip4InMcastOctets: 0
ip4InMcastPkts: 0
ip4InOctets: 5884668
ip4InPkts: 87399
ip4InReasmRqd: 0
ip4InTruncatedPkts: 0
ip4OutMcastOctets: 0
ip4OutMcastPkts: 0
ip4OutNoRoutes: 0
ip4OutOctets: 7224092
ip4OutPkts: 101959
ip4OutSegRqd: 0
ip6InDiscards: 0
ip6InMcastOctets: 0
ip6InMcastPkts: 0
ip6InOctets: 0
ip6InPkts: 0
ip6InReasmRqd: 0
ip6InTruncatedPkts: 0
ip6OutMcastOctets: 0
ip6OutMcastPkts: 0
ip6OutNoRoutes: 0
ip6OutOctets: 0
ip6OutPkts: 0
ip6OutSegRqd: 0
iwInRdmaReads: 3
iwInRdmaSends: 29127
iwInRdmaWrites: 0
iwOutRdmaReads: 14564
iwOutRdmaSends: 29126
iwOutRdmaWrites: 14562
iwRdmaBnd: 0
iwRdmaInv: 0
lifespan: 10
RxECNMrkd: 0
RxUDP: 9
rxVlanErrors: 0
tcpInOptErrors: 0
tcpInProtoErrors: 0
tcpInSegs: 87399
tcpOutSegs: 101959
tcpRetransSegs: 0
TxUDP: 0
/sys/class/infiniband/iwp3s0f0/hw_counters
