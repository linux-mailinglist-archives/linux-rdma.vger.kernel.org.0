Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B01FBEDD
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgFPTVU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 15:21:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:48335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbgFPTVO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 15:21:14 -0400
IronPort-SDR: I6xGTpNG4Mc/4hu03OPJxGvEHsLIEXf3Herrcm5gvfQtgLDlw7KV+JYUBSSM1tYsGX7/SnlesZ
 WYF750xtUIMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:21:13 -0700
IronPort-SDR: 3CJ5OXf22s4yTbLUhBA5yMIbBUnhteCeDMN0dE1dio89g2IGIhYCSELGvXk8y1T/vrIewTXub/
 aJuCGccSVQWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="476552122"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2020 12:21:13 -0700
Date:   Tue, 16 Jun 2020 12:21:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, dledford@redhat.com,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200616192112.GG4160762@iweiny-DESK2.sc.intel.com>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
 <20200616062534.GB2141420@unreal>
 <53f86386-780d-4b06-9848-f8a6eede57ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f86386-780d-4b06-9848-f8a6eede57ee@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 03:14:51PM -0400, Dennis Dalessandro wrote:
> On 6/16/2020 2:25 AM, Leon Romanovsky wrote:
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
> 
> My opinion is yes.
> 
> > We rather keep separation due to logic separation.
> 
> To be fair, "you" rather. Not we. I'd like some others to weigh in here.
> Increasing the available MTUs an an enum just makes sense. Why does it
> matter if IB doesn't need them right now. Maybe someday.
> 
> > While ib_* defines come from IBTA and interoperable across different
> > devices and vendors, opa_* definitions are Intel proprietary ones used
> > for the product that was canceled.
> 
> But does it hurt to have more potentially available? Can you please explain
> the technical reason here?

The problem is that the IBTA _may_ define those enums to mean something
different in the future.  Hopefully, the Intel representatives within the IBTA
would try to make them compatible but I don't know that 10K 'fits' with the
IBTA's future.  8K seems like a reasonable extension for the IBTA but again we
as Linux developers can't say that will happen for sure.  We just don't control
what the IBTA does in that regard.

Ira

> 
> -Denny
> 
