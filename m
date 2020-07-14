Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD021E8C5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgGNHCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 03:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgGNHCH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 03:02:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C03221ED;
        Tue, 14 Jul 2020 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594710127;
        bh=2Yab0a4jpaZQwce+LRFW73IQunzNBQlta6nkIC3Ul5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMql7cy+W6wYz+ne4+TjQleeJnkCTsyRava04squKaY7yMwkf04tMOsoxrG5GN14K
         ZVJrG9qDiLDbg9E3qiUEmAZftgJ8X9GYuWaSNtqWT6drWJSe50hTrK0BACjPW2Z2ow
         v9KbUCOXZlrsMQ//AV7Dnr/krGbN0BVmoYnIxOKM=
Date:   Tue, 14 Jul 2020 10:02:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
Message-ID: <20200714070201.GG7287@unreal>
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
 <20200612195511.GA6578@ziepe.ca>
 <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
 <20200616120847.GB3542686@kroah.com>
 <16760723-e9ac-88b7-0b95-170e43abee2b@oracle.com>
 <20200617050341.GG2383158@unreal>
 <20200713145344.GB3767483@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713145344.GB3767483@kroah.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 13, 2020 at 04:53:44PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 17, 2020 at 08:03:41AM +0300, Leon Romanovsky wrote:
> > On Tue, Jun 16, 2020 at 09:35:38AM -0700, Gerd Rausch wrote:
> > > Hi,
> > >
> > > On 16/06/2020 05.08, Greg Kroah-Hartman wrote:
> > > >> I considered backporting commit 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
> > > >> with all the dependencies it may have a considerably higher risk
> > > >> than just arming the TX CQ.
> > > >
> > > > 90% of the time when we apply a patch that does NOT match the upstream
> > > > tree, it has a bug in it and needs to have another fix or something
> > > > else.
> > > >
> > > > So please, if at all possible, stick to the upstream tree, so
> > > > backporting the current patches are the best thing to do.
> > > >
> > >
> > > Jason,
> > >
> > > With Mellanox writing and fixing the vast majority of the code found
> > > in IB/IPoIB, do you or one of your colleagues want to look into this?
> > >
> > > It would be considerably less error-prone if the authors of that code
> > > did that more risky work of backporting.
> > >
> > > AFAIK, Mellanox also has the regression tests to ensure that everything
> > > still works after this re-write as it did before.
> >
> > Please approach your Mellanox FAE representatives, they will know how to
> > handle it internally.
>
> Ah, so you all don't care about any IB fixes for 4.14 and older kernels
> anymore?  If so, great, please let us know so we will not do any
> backporting anymore, that will save us time!

Greg,

This is not what I said. As a Mellanox employee, I can't commit for any
internal resources, the FAE path is a standard way for our customers
to get proper attention.

Thanks

>
> thanks,
>
> greg k-h
