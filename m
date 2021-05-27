Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650F0392C5A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhE0LLD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhE0LLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 07:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B180C061574;
        Thu, 27 May 2021 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mUj/KLzHyimS0VF7iBofriF7+m1srvzXS1fU/QNihxQ=; b=B8YD5YCHcq0Bx75TxQGYDpMAzS
        3C+eGJoz5WIbX01ckvA77VNx7X4otkyp4JclK9/bdNpSdlmuVB/nYZqXKawBaMrstjlWU2zjtPs7w
        tk54Ppk62tg45W5fmyGIVtWEvAhvGXHyutCprnj3z0PU0qpM7VeG4PO87YNyDJqbExG62EQkKyg9+
        vDxj83YC+sT1ETlFF40meNBP4UM0gR2Ypn439WbRz3h/Uie3HjeYTLJW5ze4d0XIOu1+hpZ5/cr0H
        5Pa1BbU3VbD6JbEBp38kD6fa5N4HhLsqajI0JInFF8+zvSt8rcJDOAYAFakTnObimzmvlRS34Stit
        toJqirGg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmDt3-005SKS-Ud; Thu, 27 May 2021 11:09:17 +0000
Date:   Thu, 27 May 2021 12:09:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed
 Ordering via fast registration
Message-ID: <YK992cLoTRWG30H9@infradead.org>
References: <cover.1621505111.git.leonro@nvidia.com>
 <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
 <20210526194906.GA3646419@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526194906.GA3646419@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 04:49:06PM -0300, Jason Gunthorpe wrote:
> Nothing does a FRWR with IB_ACCESS_DISABLE_RELAXED_ORDERING set
> 
> So why not leave the relaxed ordering bits masked in the UMR for FWRW
> so that the UMR doesn't change them at all and fail/panic if the
> caller requests IB_ACCESS_DISABLE_RELAXED_ORDERING ?

Yeah.  In fact we should check for that in the core, or by going even
further than my previous proposal and split IB_ACCESS_* even more fine
grained.

AFAICS we have the following uses cases:

 1) qp_access_flags as a bitmask of possible operations on the queue pair
    The way I understood the queue pairs this should really be just bits
    for remote read, remote write and atomics, but a few places also
    mess with memory windows and local write, which seems to be some
    sort of iWarp cludge
 2) IB_UVERBS_ACCESS_*.  These just get checked using ib_check_mr_access
    and then passed into ->reg_user_mr, ->rereg_user_mr and
    ->reg_user_mr_dmabuf
 3) in-kernel FRWR uses IB_ACCESS_*, but all users seem to hardcode it
    to IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
    IB_ACCESS_REMOTE_WRITE anyway

In other words:  I wonder if we should just kill off the current from of
IB_ACCESS_* entirely, as it is a weird mess used in totally different
ways in different code paths.
