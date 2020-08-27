Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDA253B72
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 03:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0BfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 21:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgH0BfV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 21:35:21 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2462074A;
        Thu, 27 Aug 2020 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598492120;
        bh=7qVVxVRgHLIAbQt6FUd6V7CT56tLdcOFc7sCY/XcW4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4pTmfB3sgIMJjFbdFWoRbsU8OwiaxyKW+QuNkBKy9GSWjT/k15qFfn7RLWNGDTqS
         BJFRsSmCpgtGwhOq/T+6lt8yzWWtRHNlVRLevw7dNAh1Rt4e+a2j4mum8/GxihxbsM
         uU2ZQwBWpuvRsTh7kYANI78/IqpYwQPC3C9ilcHY=
Date:   Wed, 26 Aug 2020 20:41:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, dennis.dalessandro@intel.com,
        dledford@redhat.com, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mike.marciniszyn@intel.com, roland@purestorage.com
Subject: Re: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Message-ID: <20200827014120.GD2671@embeddedor>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
 <20200825171242.448447-1-alex.dewar90@gmail.com>
 <20200825193327.GA5504@embeddedor>
 <20200826191859.GB2671@embeddedor>
 <20200827001149.GK24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827001149.GK24045@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 09:11:49PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2020 at 02:18:59PM -0500, Gustavo A. R. Silva wrote:
> > Hi,
> > 
> > On Tue, Aug 25, 2020 at 02:33:27PM -0500, Gustavo A. R. Silva wrote:
> > > On Tue, Aug 25, 2020 at 06:12:42PM +0100, Alex Dewar wrote:
> > > > Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > > erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> > > > were later converted to fallthrough statements by commit df561f6688fe
> > > > ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> > > > warning about unreachable code.
> > > >
> > > 
> > > It's worth mentioning that this warning is triggered only by compilers
> > > that don't support __attribute__((__fallthrough__)), which has been
> > > supported since GCC 7.1.
> > > 
> > > > Remove the fallthrough statements.
> > > > 
> > > > Addresses-Coverity: ("Unreachable code")
> > > > Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > 
> > > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > 
> > 
> > I can take this in my tree for 5.9-rc3.
> 
> That would make conflicts for the 2nd patch, lets just send them all
> through the rdma tree please.

OK.

> Is there a reason this is -rc material?

It's just that this warning is currently in mainline.

Thanks
--
Gustavo
