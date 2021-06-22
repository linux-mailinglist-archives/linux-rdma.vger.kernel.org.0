Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E583AFCFC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFVGWm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVGWk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:22:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C6260FDC;
        Tue, 22 Jun 2021 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624342825;
        bh=BSNrQaGnE56ColQS9Xz8vuwYpEPpdyzKkePfYGU4fYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GynAKk9Dj1zc+PM2NKbtOn9u1zyzRQ0AByCDeqzIsEzfUS5SKQ4QHiVNH1+229QJf
         NC0H/P9WihzdNTc/e07SCh+JKjvuiSMsc8uGaXDBBZJC4SY/Zrl3n5KRF1KMml40X1
         cuxCYlMIsDbijZpSsXeMB2zZRTR06K3clKbGZ5SefVC3AeCeNacq1aVGuaT+rSxYR1
         1YYRTCW/xgjXPuwpOteICZePErsSJ7GWmbGizirBwKIjWRIdsRQno6+w/68pxJqzts
         M26t4FuG07ENLexpwSeVb5XFw4ZMFoNOlkpt+Q6w6yhZF+6htpmfrMZzWfjXIGeGSs
         32vxVZZRzQYVA==
Date:   Tue, 22 Jun 2021 09:20:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <YNGBJRRWBql413nM@unreal>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210621180205.GA2332110@nvidia.com>
 <20210621202033.GB13822@lst.de>
 <20210621231837.GT1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621231837.GT1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 08:18:37PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 21, 2021 at 10:20:33PM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 21, 2021 at 03:02:05PM -0300, Jason Gunthorpe wrote:
> > > Someone is working on dis-entangling the access flags? It took a long
> > > time to sort out that this mess in wr.c actually does have a
> > > distinct user/kernel call chain too..
> > 
> > I'd love to see it done, but I won't find time for it anytime soon.
> 
> Heh, me too..
> 
> I did actually once try to get a start on doing something to wr.c but
> it rapidly started to get into mire..
> 
> I thought I recalled Leon saying he or Avihai would work on the ACCESS
> thing anyhow?

Yes, we are planning to do it for the next cycle. 

Thanks

> 
> Thanks,
> Jason
