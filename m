Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1C78690
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 09:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfG2Hq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 03:46:26 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:38577 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2Hq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jul 2019 03:46:26 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6T7kKcO005195;
        Mon, 29 Jul 2019 00:46:21 -0700
Date:   Mon, 29 Jul 2019 13:16:20 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190729074612.GA30030@chelsio.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
 <20190725181424.GB7467@ziepe.ca>
 <20190728083749.GH4674@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728083749.GH4674@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon Romanovsky wrote:
> On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat Teja wrote:
> > > match_device handler is no longer needed after latest device binding changes.
> > >
> > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > ---
> > >  providers/cxgb4/dev.c | 41 -----------------------------------------
> > >  1 file changed, 41 deletions(-)
> >
> > Do you know if we can also drop the same code in cxgb3?
> 
> Can we simply remove cxgb3?
>

I am in talks with the people here. I'll confirm it soon.

> Thanks
> 
> >
> > Jason
