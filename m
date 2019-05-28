Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591E42C8F7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE1Ol5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 10:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfE1Ol5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 10:41:57 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C542081C;
        Tue, 28 May 2019 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559054516;
        bh=Xm9YyCKBsx9O2HNQSfZa2+bWOrx5iDX0XPYwSPl/72k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olyja75wS6lgGLoxwOmf+VNiS3ZM1qFFUJa3r30lcUSqOz7oHzcsl2fCYos8IwB5N
         Of0SvjHss9yMdwABaaXSCLuVm7V2vpW4hHpNJzOuXQOcksDlvFCw9NIo2i0hnlTo9U
         sIuwObiv2RQrJhvEfDbYeDIZoK92lclk3V0Ywgts=
Date:   Tue, 28 May 2019 17:41:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 2/3] RDMA: Clean destroy CQ in drivers do
 not return errors
Message-ID: <20190528144153.GR4633@mtr-leonro.mtl.com>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-3-leon@kernel.org>
 <1934b1ce-d700-2cd1-d4eb-a30d8d13770d@amazon.com>
 <20190528130901.GL4633@mtr-leonro.mtl.com>
 <426cc597-65b9-3fbe-753f-31338ffac79b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426cc597-65b9-3fbe-753f-31338ffac79b@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 10:34:44AM -0400, Dennis Dalessandro wrote:
> On 5/28/2019 9:09 AM, Leon Romanovsky wrote:
> > On Tue, May 28, 2019 at 04:03:42PM +0300, Gal Pressman wrote:
> > > On 28/05/2019 14:37, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > Like all other destroy commands, .destroy_cq() call is not supposed
> > > > to fail. In all flows, the attempt to return earlier caused to memory
> > > > leaks.
> > > >
> > > > This patch converts .destroy_cq() to do not return any errors.
> > > >
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > This patch doesn't apply to my tree for some reason.
> >
> > I rebased it on top of rdma/wip/jgg-for-next branch.
>
> Can you provide the SHA? I pulled: ea996974 and still get conflicts applying
> 2/3.

https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=039f6e8ce30ad812e2e8c3e0c35974b518d4794a
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=ed32c1219d35f2568a3283d7a399d79df09c4d1b
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=039ba0525b0e651a42eca818d117102cc4e631ff

Thanks

>
> -Denny
