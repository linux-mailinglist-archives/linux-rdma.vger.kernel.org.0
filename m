Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1380513280C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgAGNrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 08:47:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgAGNrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 08:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SxuV5Cc5QkSPqHbEGgQj9EU3pDPkAmFnLH+JYodGQyw=; b=E8kbk40gT4pnda12zv8jnIz0F
        RmntHd+qs4bBQEUKZw0q5F3Tw2sh2Zzc8BsAkoz1YFNQFEjvJ8gQ9cmtS7vPYtVInHNcjJoJ4kCvj
        79rK+GZGEIzOXLjwPMfEXYfkSQgs4J+bCSmbBSRl6QDwklrR4TqnAQXrkQvTiirxZZuPoaTup+NhC
        aBW91rU051rpAnjcCvvP2gbI5w7wSg6fKtv9iNgzYPRqjot0vj9zKTi7HcLmflSLiN3jLzXYtPS0Q
        EdsYjCKd0Kq/D3Ww2MgpbKCGA0qp3mrmkqdv/ZHeCrM6hXgvzZjgLbkYrZVUz4bTgKYNgjGuDq8MA
        xFGhNdMAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iopCi-0001bD-QA; Tue, 07 Jan 2020 13:47:28 +0000
Date:   Tue, 7 Jan 2020 05:47:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] Proposed trace points for RDMA/core
Message-ID: <20200107134728.GA375@infradead.org>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
 <20191218002214.GL16762@mellanox.com>
 <20191218053644.GJ66555@unreal>
 <FFC65516-E488-472C-90EA-DBE54BE341C8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFC65516-E488-472C-90EA-DBE54BE341C8@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 18, 2019 at 08:20:20AM -0500, Chuck Lever wrote:
> 
> 
> > On Dec 18, 2019, at 12:36 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Dec 18, 2019 at 12:22:19AM +0000, Jason Gunthorpe wrote:
> >> On Mon, Dec 16, 2019 at 10:53:43AM -0500, Chuck Lever wrote:
> >>> Hey y'all-
> >>> 
> >>> Refresh of the RDMA/core trace point patches. Anything else needed
> >>> before these are acceptable?
> >> 
> >> Can Leon compile and run it yet?
> > 
> > Nope, it is enough to apply first patch to see compilation error.
> 
> I've never seen that here. There is another report of this problem
> with an earlier version of the series, so I thought it had been
> resolved.
> 
> I'll look into it.

You tend to need a line like:

ccflags-y += -I $(srctree)/$(src)               # needed for trace events

to ensure the trace header actually gets included for out of source
tree builds.  Or move the trace header to include/trave/events/.  I find
that annoying for simple modules, but for a subsystem where the trace
header might be spread over various directories that might end up being
much easier.
