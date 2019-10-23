Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B7E11D6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfJWFsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 01:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfJWFsG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 01:48:06 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE0321872;
        Wed, 23 Oct 2019 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571809685;
        bh=V5EEbrWPtx+bFnAIK4lpwVA1Qr2oCaXBjrpcAWLPkpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5nrA/nE3XlsNQisjwFgZkuc2zINYHj4bzNkjKAnIzVgmWfzRopGqv4RLDazWNruV
         OrXhE9EIIhuz5E0Kl7+ezk0PA+OnrPidN/NIxYIhX+UvDr2bG1m783JvmPyaRxvFYp
         5AYBDQxZ2w8pAGV2CB2QmzWt87aYnVfoygFe/YaY=
Date:   Wed, 23 Oct 2019 08:48:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>, bharat@chelsio.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
Message-ID: <20191023054802.GI4853@unreal>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
 <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
 <20191022175821.GB23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022175821.GB23952@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 02:58:21PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2019 at 01:57:18PM -0400, Doug Ledford wrote:
> > On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> > > diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> > > headers/rdma/rdma_user_ioctl_cmds.h
> > > index b8bb285f..b2680051 100644
> > > +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> > >         RDMA_DRIVER_UNKNOWN,
> > >         RDMA_DRIVER_MLX5,
> > >         RDMA_DRIVER_MLX4,
> > > -       RDMA_DRIVER_CXGB3,
> > >         RDMA_DRIVER_CXGB4,
> > >         RDMA_DRIVER_MTHCA,
> > >         RDMA_DRIVER_BNXT_RE,
> >
> > This is the same bug the kernel patch had.  We can't change that enum.
>
> This patch shouldn't touch the kernel headers, delete the driver, then
> we will get the kernel header changes on the next resync.

If you are doing that, can you please delete nes provider too?
Maybe ipathverbs too?

Thanks

>
> Jason
>
