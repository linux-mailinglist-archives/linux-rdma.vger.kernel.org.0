Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82FE72F5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfJ1N55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJ1N55 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 09:57:57 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD252086D;
        Mon, 28 Oct 2019 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572271077;
        bh=auTisxDBqPAovqdOLJ4zRzbvYr1seh/4dOnj8zyrEAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFQooDh9zNY6Olq/UPz3/bH3gK2+/rMspyz2Kw+HJFolmP8CQ9PRjDugsb7xEQst3
         ww55M6GHvTNvYmmnttHTyZXh39ztj/Kh6ruLCUAu/AmZoQ4FfbGXTuTkAuyc87R1aL
         Wnuf5jiB3oYA/3/Tyu7hSO+jRgCR+MW7ZoWsI1so=
Date:   Mon, 28 Oct 2019 15:57:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Message-ID: <20191028135752.GG5146@unreal>
References: <20191028134444.25537-1-leon@kernel.org>
 <20191028134528.GW22766@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028134528.GW22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:45:33PM +0200, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 03:44:44PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > IBTA declares QPN as 24bits, mask input to ensure that kernel
> > doesn't get higher bits.
> >
> > Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  * Not fully tested yet, passed sanity tests for now.
> >  drivers/infiniband/core/ucma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index 0274e9b704be..57e68491a2fd 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
> >  	dst->retry_count = src->retry_count;
> >  	dst->rnr_retry_count = src->rnr_retry_count;
> >  	dst->srq = src->srq;
>
> srq too?

If I read IBTA correctly, the answer is yes. In all CM messages, QPN, SRQ number and EECN are 24 bits.

Thanks

>
> Jason
