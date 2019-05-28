Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7521F2C54B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfE1LUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1LUn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 07:20:43 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD5220883;
        Tue, 28 May 2019 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559042443;
        bh=vNMx68m8t+QUI9mFbgeykBo8Vua6AYbbB6Hz4+8Gcao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guAS7RWKsNeXf1zGVq4iRJcP8DxXrfQhXJWWUXHFX8n/066Md1enBA4u+tNcQ90Ez
         xQFFXiYFn7YcjpSi/hM2CmndHEo5crqTwaYFe5kfPYyuVOWozlNITMxxBPY2gt6jHk
         hyFJCfJlRGH+u3XMlSZQ+GUUF8VpsJM/OX0iHJc0=
Date:   Tue, 28 May 2019 14:20:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 00/15] Convert CQ allocations
Message-ID: <20190528112039.GH4633@mtr-leonro.mtl.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190521185443.GA23445@ziepe.ca>
 <1dcd9e36-8eda-2a10-5b69-cc76677366ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcd9e36-8eda-2a10-5b69-cc76677366ed@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 07:20:33AM -0400, Dennis Dalessandro wrote:
> On 5/21/2019 2:54 PM, Jason Gunthorpe wrote:
> > On Mon, May 20, 2019 at 09:54:18AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Hi,
> > >
> > > This is my next series of allocation conversion patches.
> > >
> > > Thanks
> > >
> > > Leon Romanovsky (15):
> > >    rds: Don't check return value from destroy CQ
> > >    RDMA/ipoib: Remove check of destroy CQ
> > >    RDMA/core: Make ib_destroy_cq() void
> > >    RDMA/nes: Remove useless NULL checks
> > >    RDMA/i40iw: Remove useless NULL checks
> > >    RDMA/nes: Remove second wait queue initialization call
> >
> > These trivial ones all applied to for-rc, thanks
>
> rc or next?

-next

Thanks

>
> -Denny
