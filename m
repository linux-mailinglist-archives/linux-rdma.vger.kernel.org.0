Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D446F1CEF29
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgELIbM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgELIbM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 04:31:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52EE320643;
        Tue, 12 May 2020 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589272272;
        bh=ctnEW5BeqlyhQsUECfcARsMrZLX7AaAHL6uvNrlhZlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3fOmKZHOTxNdsb/KUJC6dHamNmH79e0U1lCl5VHHOZodeeLOMgxtMv/DgLcajwjl
         5p0cni3uWE5aCZRvOPnThwVGZCcGGYfcOaq3/W6Gr2mpHsEahzeDzpZDXmGvRTp//5
         yzirjy1Zgu8u8ziRNJwOwaB5D/LsvUvkZkGDbjP4=
Date:   Tue, 12 May 2020 11:31:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Message-ID: <20200512083107.GI4814@unreal>
References: <20200511183742.GB225608@mwanda>
 <20200512062936.GE4814@unreal>
 <20200512070203.GG4814@unreal>
 <20200512081706.GJ9365@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512081706.GJ9365@kadam>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 11:17:06AM +0300, Dan Carpenter wrote:
> On Tue, May 12, 2020 at 10:02:03AM +0300, Leon Romanovsky wrote:
> > On Tue, May 12, 2020 at 09:29:36AM +0300, Leon Romanovsky wrote:
> > > On Mon, May 11, 2020 at 09:37:42PM +0300, Dan Carpenter wrote:
> > > > This function used to always return -EINVAL but we updated it to try
> > > > preserve the error codes.  Unfortunately the copy_to_user() is returning
> > > > the number of bytes remaining to be copied instead of a negative error
> > > > code.
> > > >
> > > > Fixes: a3a974b4654d ("RDMA/rxe: Always return ERR_PTR from rxe_create_mmap_info()")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  drivers/infiniband/sw/rxe/rxe_queue.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > >
> > > Thanks,
> > > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> >
> > Actually Yanjun is right and "err" can be removed.
> >
> > Thanks
>
> I don't know if the code you guys are looking at is older or newer than
> linux-next...  :P

We both looked on rdma-next, but the wrong code was added to -rc.

Jason, that patch was marked as stable@.

Thanks
