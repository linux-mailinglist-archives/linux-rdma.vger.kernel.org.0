Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838491FC998
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgFQJQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 05:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQJQQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 05:16:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846B92082F;
        Wed, 17 Jun 2020 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592385376;
        bh=GYUX5pje2WoxVZXsWACUd+4uswJMss3TqbLIy7apKik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZX3i0Ve4LuS78NtNeMhPWsrZ2OkUZBP05qPxLbek+AlwESxBcX6zhIDX2SCrgYo4
         z+PJIlhxmQvWHbNIaaesXJRPmgKTMgSEylqAI7mpEIATHAlToxzmNCOmfxNmrQwIgH
         eCPgIajnJlsA6NJS4gGzSN3taXnah7GNRi68vLhs=
Date:   Wed, 17 Jun 2020 12:16:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
Message-ID: <20200617091612.GJ2383158@unreal>
References: <20200616105531.2428010-1-leon@kernel.org>
 <20200617082916.GA13188@infradead.org>
 <20200617083138.GI2383158@unreal>
 <20200617083450.GA25700@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617083450.GA25700@infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 01:34:50AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 17, 2020 at 11:31:38AM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 17, 2020 at 01:29:16AM -0700, Christoph Hellwig wrote:
> > > I think you are talking about UABIs (which in linux we actually call
> > > uapis).
> >
> > Yes, I used Yishai's cover letter as is.
>
> Why can't he just posted his patches himeself?  And if you forward it
> you could actually add value by fixing up obvious issues :)

To say that I'm not adding any value, you need to see patches before
they arrive to me and after they sent to the mailing list.

Thanks
