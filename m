Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDF9B83C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392812AbfHWVdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 23 Aug 2019 17:33:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:23346 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392807AbfHWVdL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 17:33:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 14:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="378989703"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2019 14:33:10 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 23 Aug 2019 14:33:10 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 23 Aug 2019 14:33:09 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.72]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.138]) with mapi id 14.03.0439.000;
 Fri, 23 Aug 2019 15:33:07 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Yuval Shaia <yuval.shaia@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "Mark Zhang" <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "Denis Drozdov" <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: RE: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvZmDSd66uZEUuzBhvtgWBiJKcGMbcAgAENL4CAABWyAIAAdp+A///NYNCAAW+PAIAANQcQ
Date:   Fri, 23 Aug 2019 21:33:06 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E898B2F17@CRSMSX102.amr.corp.intel.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com>
 <2807E5FD2F6FDA4886F6618EAC48510E898ADD18@CRSMSX102.amr.corp.intel.com>
 <20190823115731.GA12847@mellanox.com>
In-Reply-To: <20190823115731.GA12847@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmUzNzM0MWItOGExZS00ZDE0LTliYzktNGEwMGI5MmYyNjU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSjdvNllqcXNCaWdJcjNkcUN1cDcrdDZtaVNHVDdFS3h0S1wvanlYbDU2akxEZXhWQzVzUDdNcVwvaElyY1U2QndGIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH v1 00/24] Shared PD and MR
> 
> On Thu, Aug 22, 2019 at 08:10:09PM +0000, Weiny, Ira wrote:
> > > On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> > >
> > > > Add to your list "how does destruction of a MR in 1 process get
> > > > communicated to the other?"  Does the 2nd process just get failed
> WR's?
> > >
> > > IHMO a object that has been shared can no longer be asynchronously
> destroyed.
> > > That is the whole point. A lkey/rkey # alone is inherently unsafe
> > > without also holding a refcount on the MR.
> > >
> > > > I have some of the same concerns as Doug WRT memory sharing.
> FWIW
> > > > I'm not sure that what SCM_RIGHTS is doing is safe or correct.
> > > >
> > > > For that work I'm really starting to think SCM_RIGHTS transfers
> > > > should be blocked.
> > >
> > > That isn't possible, SCM_RIGHTS is just some special case, fork(),
> > > exec(), etc all cause the same situation. Any solution that blocks those is a
> total non-starter.
> >
> > Right, except in the case of fork(), exec() all of the file system
> > references which may be pinned also get copied.
> 
> And what happens one one child of the fork closes the reference, or exec with
> CLOEXEC causes it to no inherent?

Dave Chinner is suggesting the close will hang.  Exec with CLOEXEC would probably not because the RDMA close would release the pin allowing the close of the data file to finish...  At least as far as my testing has shown.

> 
> It completely breaks the unix model to tie something to a process not to a
> FD.

But that is just it.  Dave is advocating that the FD's must get transferred.  It has nothing to do with a process.

I'm somewhat confused at this point because in this thread I was advocating that the RDMA context FD is what needs to get "shared" between the processes.  Is that what you are advocating as well?  Does this patch set do that?

> 
> > > Except for ODP, a MR doesn't reference the mm_struct. It references the
> pages.
> > > It is not unlike a memfd.
> >
> > I'm thinking of the owner_mm...  It is not like it is holding the
> > entire process address space I know that.  But it is holding onto
> > memory which Process A allocated.
> 
> It only hold the mm for some statistics accounting, it is really just holding
> pages outside the mm.

But those pages aren't necessarily mapped in Process B.  and if they are mapped in Process A then you are sending data to Process A not "B"...  That is one twisted way to look at it anyway...

Ira

