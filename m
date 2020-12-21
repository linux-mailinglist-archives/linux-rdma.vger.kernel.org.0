Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C42DFBA0
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Dec 2020 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgLULnR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Dec 2020 06:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgLULnR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Dec 2020 06:43:17 -0500
Date:   Mon, 21 Dec 2020 13:42:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608550956;
        bh=I1s82VVqqE9ijzGHoOsceUKjPRaV6rKSG7gj76Bo9X4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPVzpUl/M34rcr4oiVOpLdJup0O3I8IZkenPKh17RSXxVAj+puk7sjbaSsL4svBSe
         ax2htFgjFZSyJPoaZ/dMYAAgXcscEyBDrHHemhtztrOeWzxt/ScfLVW43SJsMd5H8K
         ujgTafAmyAwgPHmeC2Bz0OEdUqHi8O5luShU426+KhHzH9cHkISTylgVSo0u2DvTnt
         XEda8nXiQ3ya2sbeAMaCB0lndhUOs71xm4aXxrKufF/C9lCo+ujGJ6as9a0Aaw454f
         zCkS+j4SL4TJuV2xbh8WF/3z7aYj74CZ1+okgAuxT0E0E9ROzXRxpoQOJwbOHgt172
         /jnxzsrMlLg1w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] librdmacm: Make some functions report proper errno
Message-ID: <20201221114231.GB3128@unreal>
References: <20201216092252.155110-1-yangx.jy@cn.fujitsu.com>
 <5FD9D8B2.1020208@cn.fujitsu.com>
 <20201216095549.GC1060282@unreal>
 <5FDFF9CA.1060109@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FDFF9CA.1060109@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 21, 2020 at 09:26:34AM +0800, Xiao Yang wrote:
> On 2020/12/16 17:55, Leon Romanovsky wrote:
> > On Wed, Dec 16, 2020 at 05:51:46PM +0800, Xiao Yang wrote:
> > > Hi Leon,
> > >
> > > Thanks for your quick reply. :-)
> > > I have done the same change on three
> > > functions(ucma_get_device,ucma_create_cqs, rdma_create_qp_ex).
> > >
> > > On 2020/12/16 17:22, Xiao Yang wrote:
> > > > Some functions reports fixed ENOMEM when getting any failure, so
> > > > it's hard for user to know which actual error happens on them.
> > > >
> > > > Fixes(ucma_get_device):
> > > > 2ffda7f29913 ("librdmacm: Only allocate verbs resources when needed")
> > > > 191c9346f335 ("librdmacm: Reference count access to verbs context")
> > > > Fixes(ucma_create_cqs):
> > > > f8f1335ad8d8 ("librdmacm: make CQs optional for rdma_create_qp")
> > > > 9e33488e8e50 ("librdmacm: fix all calls to set errno")
> > > > Fixes(rdma_create_qp_ex):
> > > > d2efdede11f7 ("r4019: Add support for userspace RDMA connection management abstraction (CMA)")
> > > > 4e33a4109a62 ("librdmacm: returns errors from the library consistently")
> > > > 995eb0c90c1a ("rdmacm: Add support for XRC QPs")
> > > For every function, I am not sure which one is an exact commit so just
> > > attach all related commits ids.
> > No problem, I'll try to sort it out now.
> Hi Leon,
>
> Sorry to bother you.
> Is there anything blocking the patch? :-)

Nothing, we are in the middle of Christmas vacation here,
so everything takes more time than usual.

Thanks

>
> Best Regards,
> Xiao Yang
> > Thanks
> >
> >
> > .
> >
>
>
>
