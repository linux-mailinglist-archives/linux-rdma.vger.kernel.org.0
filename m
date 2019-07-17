Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0046C3B0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfGQXz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 19:55:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:8083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfGQXz2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jul 2019 19:55:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 16:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; 
   d="scan'208";a="319475088"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2019 16:55:26 -0700
Date:   Wed, 17 Jul 2019 16:55:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/25] Shared PD and MR
Message-ID: <20190717235526.GB4936@iweiny-DESK2.sc.intel.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190717050931.GA18936@infradead.org>
 <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
 <20190717115507.GD12119@ziepe.ca>
 <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 04:35:30PM +0300, Shamir Rabinovitch wrote:
> On Wed, Jul 17, 2019 at 2:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jul 17, 2019 at 02:09:50PM +0300, Shamir Rabinovitch wrote:
> > > On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > > > > Following patch-set introduce the shared object feature.
> > > > >
> > > > > A shared object feature allows one process to create HW objects (currently
> > > > > PD and MR) so that a second process can import.
> > > >
> > > > That sounds like a major complication, so you'd better also explain
> > > > the use case very well.
> > >
> > > The main use case was that there is a server that has giant shared
> > > memory that is shared across many processes (lots of mtts).
> > > Each process needs the same memory registration (lots of mrs that
> > > register same memory).
> > > In such scenario, the HCA runs out of mtts.
> > > To solve this problem, an single memory registration is shared across
> > > all the process in that server saving hca mtts.
> >
> > Well, why not just share the entire uverbs FD then? Once the PD is
> > shared all security is lost anyhow..
> >
> > This is not the model that was explained to me last year
> >
> > Jason
> 
> We do share the whole uvrbs FD (context) with the second process and
> let that process to instantiate the PD & MR from the shared FD.

Then the first (both) process(es) should have access to the MR right?

> The instantiation include creating new uobject in the second process
> context that points to the same ib_x HW objects.
> The second process does not own the shared context.
> It just use it to get access to the shared ib_x objects and then it
> mark those & shared FD as shared.

I'm not following this?

> 
> What was the expectation from "import_from_xxx" ?

... and I don't understand this question.

Ira

