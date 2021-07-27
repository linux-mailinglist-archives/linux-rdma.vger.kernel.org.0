Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EE3D7574
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhG0M7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 08:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236543AbhG0M7B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 08:59:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B40EA608FB;
        Tue, 27 Jul 2021 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627390741;
        bh=eggWKE+oX82AYmaJ7wG8DcolSjeuSNSMo/1kAHpyaU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNuRUxJrZ8300Dm6RgfypVImp/bPKFmDdpEyd1/qXQeuyhWg2hhnjKGg3f8GSiBh3
         yfjNeWUGhPIOkIW1SHyp1QB3dSyS1j0OYoAeZV+JhQWEP33uQMbkr+drYdIG0jp3Re
         yDYGXH8o1oi1JrtROEaNjoKS93Rs/knFqqpY3n8T0VHKR9e9PZY6o2HXufdo+E/8tm
         pD0c4/M2JwcbLfo5XMS64NxTnnJIjIlV1vT4nuJFIVfsadD2mFcb7JfTte9Hv9UR4j
         HbRw/M+UeOV1Wl++yFTkH9OpUvIbbY2OStxNQUYtHYr5lUivX5Z2WTxwDvPpMaQuqT
         RUlxzhN1VqAtA==
Date:   Tue, 27 Jul 2021 15:58:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
Message-ID: <YQADEX4UBnueXrYU@unreal>
References: <20210726215815.17056-1-rpearsonhpe@gmail.com>
 <YP/uTbQ71dZWYIal@unreal>
 <c181c1b9-a2a6-3cf0-8644-762f6398bb5e@gmail.com>
 <YP/18Ycu+EMLA8T8@unreal>
 <ceea9bc1-1e9d-a30c-a875-442a0c8d9c47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceea9bc1-1e9d-a30c-a875-442a0c8d9c47@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 07:44:52AM -0500, Bob Pearson wrote:
> On 7/27/21 7:02 AM, Leon Romanovsky wrote:
> > On Tue, Jul 27, 2021 at 06:31:59AM -0500, Bob Pearson wrote:
> >> On 7/27/21 6:30 AM, Leon Romanovsky wrote:
> >>> On Mon, Jul 26, 2021 at 04:58:16PM -0500, Bob Pearson wrote:
> >>>> Currently several rxe objects hold references to PDs which are ref-
> >>>> counted. This replicates work already done by RDMA core which takes
> >>>> references to PDs in the ib objects which are contained in the rxe
> >>>> objects. This patch removes struct rxe_pd from rxe objects and removes
> >>>> reference counting for PDs except for PD alloc and PD dealloc. It also
> >>>> adds inline extractor routines which return PDs from the PDs in the
> >>>> ib objects. The names of these are made consistent including a rxe_
> >>>> prefix.
> >>>>
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
> >>>>  drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
> >>>>  drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
> >>>>  drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
> >>>>  drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
> >>>>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
> >>>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
> >>>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
> >>>>  drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
> >>>>  9 files changed, 48 insertions(+), 64 deletions(-)
> >>>
> >>> Last time when I looked on it, I came to conclusion that all RXE
> >>> references can be dropped.
> >>>
> >>> Thanks
> >>>
> >> This is a step in that direction. There are more coming.
> > 
> > Glad to hear, thank you for your work.
> > 
> >> Regards,
> >>
> >> Bob
> 
> The other ones I can immediately get rid of are AHs, CQs and SRQs.
> 
> The ones I think may require ref counting are MRs, MWs, QPs, and XRCSRQs. Each of these
> get looked up from information in RoCE packets from rkeys, qpns, and srq_nums, For reliable transports
> on slow networks this can require that these objects hang around for a while and the user has no
> visibility to this unless there is a completion event waiting but not for e.g. reads, writes or atomics on the target side. There can be races between destroying these objects and messages completing causing
> kernel oops. Do you know another way to address these cases?

IMHO, everything that was converted to general allocation scheme is safe
to drop RXE internal counting.

Thanks

> 
> Bob
