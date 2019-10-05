Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95378CC8C5
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2019 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJEI0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Oct 2019 04:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfJEI0e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 5 Oct 2019 04:26:34 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BFB222BE;
        Sat,  5 Oct 2019 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570263993;
        bh=c1pFtaKSaMkKUk402FoBrJ7gWzx05BUrV4oYi88W9DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gojT4u6JgVNMKOAz2mRWOZF4w92UkWYFCTZiSaHlzl/tbTgHdwO66b46CW50/3ESN
         2t+H4J6jXV8ZEHM8t6d9NeVC4q0epSS2Hzp8beKggZkAA1NtnkgK1HXQpsMonWHWyb
         zs/+WC5+wsNyPSdc6LUnlrJ045Sg05D5vSdOfB88=
Date:   Sat, 5 Oct 2019 11:26:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
        nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
Subject: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191005082629.GS5855@unreal>
References: <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
> <...>
>
> >>   *
> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp, const
> >struct ib_send_wr *wr,
> >>  	unsigned long flags;
> >>  	int rv = 0;
> >>
> >> +	if (wr && !qp->kernel_verbs) {
> >
> >It is not related to this specific patch, but all siw "kernel_verbs"
> >should go, we have standard way to distinguish between kernel and
> >user
> >verbs.
> >
> >Thanks
> >
> Understood. I think we touched on that already.
> rdma core objects have a uobject pointer which
> is valid only if it belongs to a user land
> application. We might better use that. Let me
> see if I can compact QP objects to contain the
> ib_qp. I'd like to avoid following pointers
> potentially causing cache misses on the
> fast path. This is why I still have that
> little boolean within the siw private
> structure.

You have this variable in CQ and SRQ too.

I have serious doubts that this value gives any performance advantages.
In both flows, you will need to fetch ib_qp pointer, so you don't save
here anything by looking on kernel_verbs value.

Thanks

>
> Thanks and best regards,
> Bernard.
>
