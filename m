Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B31FAAC6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFPIJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 04:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPIJx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 04:09:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9EE20767;
        Tue, 16 Jun 2020 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592294993;
        bh=MrDHfv0ezjPCMyKdXGG8FPBUUTVGj424o/3GoClN138=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tk6KtAgHYggkyA5fMM/4dFCdrxfWKwtfAfTDjt0x5awR7IgfKmEOb1tDi0prMOaBP
         9HTG3gkO7RLhGw0AXniaNxuBQWW4PV2wvlq9ZP/MgokycsN+8YaePafFJtT8wFHPcw
         ucnHEwWzGet2jJ8Cl/Du5yxqDSQDwcwn8L7BT4EQ=
Date:   Tue, 16 Jun 2020 09:25:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200616062534.GB2141420@unreal>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 15, 2020 at 05:56:50PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
> >
> > > They should probably all be in "enum ib_mtu". Jason any issues with us donig
> > > that? I can't for certain recall the real reason they were kept separate in
> > > the first place.
> >
> > It is probably OK
> >
> > Jason
>
> I don't mind taking a wack at this if you guys are too busy (I'm rather
> tired of seeing the warning across all of my builds). However, I am
> wondering how far should this be unwound? Should 'enum opa_mtu' be
> collapsed into 'enum ib_mtu' and then all of the opa conversion
> functions be eliminated in favor of the ib ones? It looks like
> OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
> drivers/infiniband/hw/hfi1, should all of those instances be converted
> over to IB_MTU_* and the defines at the top of
> drivers/infiniband/hw/hfi1/hfi.h be eliminated?

We rather keep separation due to logic separation.

While ib_* defines come from IBTA and interoperable across different
devices and vendors, opa_* definitions are Intel proprietary ones used
for the product that was canceled.

Thanks

>
> Cheers,
> Nathan
