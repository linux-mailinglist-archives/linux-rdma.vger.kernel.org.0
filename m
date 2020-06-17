Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84121FC545
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 06:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgFQEfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 00:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgFQEfT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 00:35:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51C42067B;
        Wed, 17 Jun 2020 04:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592368518;
        bh=JhPRJePYUiltrwu2BveNv1D+06ElI5cQtec7vuZGDNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/b9e+85H6iq++OGZNmZU65sxzzWYrqmZFmWedR4HW+G9jumaFcbCIxEGDvpZLneo
         CXIRxSYDFO9Q6EeayIxk6GBwRAzUv7Un5Jof4c4dIzWJPtT8W2fPx+sCOt/CiHE67d
         jJKa/0PL+NdrUSc4lnJZllHA1NMd5himuLlefYqE=
Date:   Wed, 17 Jun 2020 07:35:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, dledford@redhat.com,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200617043514.GD2383158@unreal>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
 <20200616062534.GB2141420@unreal>
 <53f86386-780d-4b06-9848-f8a6eede57ee@intel.com>
 <20200616192112.GG4160762@iweiny-DESK2.sc.intel.com>
 <a27d361e-9122-1825-72e7-6a4d2a0627ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27d361e-9122-1825-72e7-6a4d2a0627ec@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 03:27:34PM -0400, Dennis Dalessandro wrote:
> On 6/16/2020 3:21 PM, Ira Weiny wrote:
> > On Tue, Jun 16, 2020 at 03:14:51PM -0400, Dennis Dalessandro wrote:
> > > On 6/16/2020 2:25 AM, Leon Romanovsky wrote:
> > > > On Mon, Jun 15, 2020 at 05:56:50PM -0700, Nathan Chancellor wrote:
> > > > > On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
> > > > > > On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
> > > > > >
> > > > > > > They should probably all be in "enum ib_mtu". Jason any issues with us donig
> > > > > > > that? I can't for certain recall the real reason they were kept separate in
> > > > > > > the first place.
> > > > > >
> > > > > > It is probably OK
> > > > > >
> > > > > > Jason
> > > > >
> > > > > I don't mind taking a wack at this if you guys are too busy (I'm rather
> > > > > tired of seeing the warning across all of my builds). However, I am
> > > > > wondering how far should this be unwound? Should 'enum opa_mtu' be
> > > > > collapsed into 'enum ib_mtu' and then all of the opa conversion
> > > > > functions be eliminated in favor of the ib ones? It looks like
> > > > > OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
> > > > > drivers/infiniband/hw/hfi1, should all of those instances be converted
> > > > > over to IB_MTU_* and the defines at the top of
> > > > > drivers/infiniband/hw/hfi1/hfi.h be eliminated?
> > >
> > > My opinion is yes.
> > >
> > > > We rather keep separation due to logic separation.
> > >
> > > To be fair, "you" rather. Not we. I'd like some others to weigh in here.
> > > Increasing the available MTUs an an enum just makes sense. Why does it
> > > matter if IB doesn't need them right now. Maybe someday.
> > >
> > > > While ib_* defines come from IBTA and interoperable across different
> > > > devices and vendors, opa_* definitions are Intel proprietary ones used
> > > > for the product that was canceled.
> > >
> > > But does it hurt to have more potentially available? Can you please explain
> > > the technical reason here?
> >
> > The problem is that the IBTA _may_ define those enums to mean something
> > different in the future.  Hopefully, the Intel representatives within the IBTA
> > would try to make them compatible but I don't know that 10K 'fits' with the
> > IBTA's future.  8K seems like a reasonable extension for the IBTA but again we
> > as Linux developers can't say that will happen for sure.  We just don't control
> > what the IBTA does in that regard.
> >
>
> I guess I buy that. However I believe I have seen it claimed in the past
> that we aren't the IBTA, we are the Linux kernel and can do what we think
> makes sense. But to be honest I don't feel strongly, and I'm not gonna argue
> strongly one way or the other.

Thanks Ira for the explanation.

Regarding "we are the Linux kernel and can do what we think makes sense"
sentence, it is correct for SW interfaces and implementation only.
Everything that touches already defined HW interfaces and wire protocol
should follow the spec or should be separated.

Thanks

>
> -Denny
>
