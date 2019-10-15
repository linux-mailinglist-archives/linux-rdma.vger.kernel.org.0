Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEAD707A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfJOHtO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 03:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfJOHtO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 03:49:14 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8CE2089C;
        Tue, 15 Oct 2019 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571125753;
        bh=EafrKd6R6KuOD7qvy+ErOxWTsZJUXkij6RSQ7zUox8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAtuDdZQKV5occillMzsor45e9LouGngKFKRH6ozh0OZx57f14kIWuv+KjcaU7ygu
         5lqhWXO7Tw8r37FathOmMKM7dp0GeowAp/Psp6xY/Jnumk9hA0p0/wf9/CTAJtx4OG
         lWbY/PfWPOTQA6O6UyOQHN2yOaEWlZGEZb0lKOfM=
Date:   Tue, 15 Oct 2019 10:49:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH rdma-next] RDMA/uapi: Fix and re-organize the usage of
 rdma_driver_id
Message-ID: <20191015074910.GB6957@unreal>
References: <20191010120541.30841-1-leon@kernel.org>
 <20191010192053.GD11569@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010192053.GD11569@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 10, 2019 at 07:20:57PM +0000, Jason Gunthorpe wrote:
> On Thu, Oct 10, 2019 at 03:05:41PM +0300, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@mellanox.com>
> >
> > Fix 'enum rdma_driver_id' to preserve other driver values before that
> > RDMA_DRIVER_CXGB3 was deleted.  As this value is UAPI we can't affect
> > other values as of a deletion of one driver id.
> >
> > In addition,
> > - Expose 'enum rdma_driver_id' to user applications by moving it to
> >   ib_user_ioctl_verbs.h which is exposed in rdma-core to applications.
> >
> > - Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h which
> >   is not really required.
>
> One change per patch when it is a fixes..
>
> > Fixes: 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel")
> > Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  include/uapi/rdma/ib_user_ioctl_verbs.h  | 47 +++++++++++++++++++++++-
> >  include/uapi/rdma/ib_user_verbs.h        | 25 -------------
> >  include/uapi/rdma/rdma_user_ioctl_cmds.h | 21 -----------
> >  3 files changed, 46 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> > index 72c7fc75f960..3d703be40012 100644
> > +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> > @@ -35,7 +35,6 @@
> >  #define IB_USER_IOCTL_VERBS_H
> >
> >  #include <linux/types.h>
> > -#include <rdma/ib_user_verbs.h>
> >
> >  #ifndef RDMA_UAPI_PTR
> >  #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
> > @@ -167,10 +166,56 @@ enum ib_uverbs_advise_mr_flag {
> >  	IB_UVERBS_ADVISE_MR_FLAG_FLUSH = 1 << 0,
> >  };
> >
> > +struct ib_uverbs_query_port_resp {
> > +	__u32 port_cap_flags;		/* see ib_uverbs_query_port_cap_flags */
> > +	__u32 max_msg_sz;
> > +	__u32 bad_pkey_cntr;
> > +	__u32 qkey_viol_cntr;
> > +	__u32 gid_tbl_len;
> > +	__u16 pkey_tbl_len;
> > +	__u16 lid;
> > +	__u16 sm_lid;
> > +	__u8  state;
> > +	__u8  max_mtu;
> > +	__u8  active_mtu;
> > +	__u8  lmc;
> > +	__u8  max_vl_num;
> > +	__u8  sm_sl;
> > +	__u8  subnet_timeout;
> > +	__u8  init_type_reply;
> > +	__u8  active_width;
> > +	__u8  active_speed;
> > +	__u8  phys_state;
> > +	__u8  link_layer;
> > +	__u8  flags;			/* see ib_uverbs_query_port_flags */
> > +	__u8  reserved;
> > +};
>
> Probably better to move ib_uverbs_query_port_resp_ex, since it is
> really more of write() style interface

It is already in ib_user_ioctl_verbs.h.

Thanks
>
> Jason
