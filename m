Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906907E11F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfHARcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 13:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfHARcH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 13:32:07 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3C9205F4;
        Thu,  1 Aug 2019 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564680726;
        bh=uT898DY/h5AlbuNLdjIFzQnGHZILdJJSpYiv/gOrQx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loP3f3XlAbzCZn8O7wehdsdpagbpl41moB8hfOW9FZD4s3URSTO2Xh25OwZsh8yTI
         7MM0wcvrlTMrEA8ce3PVlPVXc+jRPCWizKS0+Ma5HZa6QSd6KPNZdrfYlnaJsx2tlc
         2rZwz+874rGntsbiF8nV+VhfhR20PU6arqs7fFz0=
Date:   Thu, 1 Aug 2019 20:31:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190801173154.GY4832@mtr-leonro.mtl.com>
References: <20190801082749.GH4832@mtr-leonro.mtl.com>
 <20190801120007.GB23885@mellanox.com>
 <20190801120821.GK4832@mtr-leonro.mtl.com>
 <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
 <20190801155912.GS4832@mtr-leonro.mtl.com>
 <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
 <20190801162008.GF23885@mellanox.com>
 <b74a9eb67af54e8f5050e97a3ab13899de17fe0a.camel@redhat.com>
 <20190801164330.GH23885@mellanox.com>
 <760cfc7eb23c6dc170856a3a60226f32f8c8bf9f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760cfc7eb23c6dc170856a3a60226f32f8c8bf9f.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 12:50:37PM -0400, Doug Ledford wrote:
> On Thu, 2019-08-01 at 16:43 +0000, Jason Gunthorpe wrote:
> > On Thu, Aug 01, 2019 at 12:40:43PM -0400, Doug Ledford wrote:
> >
> > > > It does have a lock though, the caller holds it, hence the request
> > > > for
> > > > the lockdep.
> > >
> > > You're right, although I think the lockdep annotation can be a
> > > separate
> > > patch as it's neeeded on more than just the function this patch
> > > touches.
> >
> > Why? This relies on that lock, so it should have the
> > lockdep_assert_held assert.
>
> It does, but this patch is about the scheduling while atomic, adding a
> lockdep assertion fix is doubling up on fixes in the patch.  A separate
> patch that addes the lockdep assert to both the bind and unbind calls
> makes more sense and just feels cleaner to me.

+1

Also, I'm not going to take any chances in -rc submission, and won't
change in -rc patches anything without verification approval and it will
take time and will come very late in -rcX.

Thanks

>
> > If there are more functions with implicit locking theyt they can be
> > fixed separately...
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


