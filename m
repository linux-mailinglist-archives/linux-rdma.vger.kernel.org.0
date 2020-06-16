Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CA1FBED1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgFPTRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 15:17:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:8411 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPTRJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 15:17:09 -0400
IronPort-SDR: 9Tk02Zv+8GIq7ScEyJGsiQz+h2nP1WJTaZtnY3MkCRRWCKh+Mi2HI2VLVg+0q2EF4xhabkHxiM
 YZrMwBgBylbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:17:08 -0700
IronPort-SDR: ObfVXwlzvncowVz3Erg8CbfXNsodsxggUOJ/NrSjXaZOePBn9yAl0pOYikIs3nSU6hOMxp17EF
 MbjPgTbjvKmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="317311158"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2020 12:17:08 -0700
Date:   Tue, 16 Jun 2020 12:17:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200616191708.GF4160762@iweiny-DESK2.sc.intel.com>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
 <20200616062534.GB2141420@unreal>
 <20200616184231.GA3734396@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616184231.GA3734396@ubuntu-n2-xlarge-x86>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 11:42:31AM -0700, Nathan Chancellor wrote:
> On Tue, Jun 16, 2020 at 09:25:34AM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 15, 2020 at 05:56:50PM -0700, Nathan Chancellor wrote:
> > > On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
> > > >
> > > > > They should probably all be in "enum ib_mtu". Jason any issues with us donig
> > > > > that? I can't for certain recall the real reason they were kept separate in
> > > > > the first place.
> > > >
> > > > It is probably OK
> > > >
> > > > Jason
> > >
> > > I don't mind taking a wack at this if you guys are too busy (I'm rather
> > > tired of seeing the warning across all of my builds). However, I am
> > > wondering how far should this be unwound? Should 'enum opa_mtu' be
> > > collapsed into 'enum ib_mtu' and then all of the opa conversion
> > > functions be eliminated in favor of the ib ones? It looks like
> > > OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
> > > drivers/infiniband/hw/hfi1, should all of those instances be converted
> > > over to IB_MTU_* and the defines at the top of
> > > drivers/infiniband/hw/hfi1/hfi.h be eliminated?
> > 
> > We rather keep separation due to logic separation.
> > 
> > While ib_* defines come from IBTA and interoperable across different
> > devices and vendors, opa_* definitions are Intel proprietary ones used
> > for the product that was canceled.
> > 
> > Thanks
> > 
> > >
> > > Cheers,
> > > Nathan
> 
> Fair enough, could someone take care of properly fixing the warning that
> was introduced by this patch then? I can send a patch that just adds an
> explicit cast but that looks like an eye sore to me. Otherwise, I am not
> familiar enough with this code to know what is an appropriate fix or
> not.

Leon is correct.  opa_* values should only be used on devices which are opa.

IPoIB needs to be 'opa aware' to do the right thing (be more efficient in this
case) when running on an OPA device.

Is that the case with the current code?

Ira

> 
> Cheers,
> Nathan
