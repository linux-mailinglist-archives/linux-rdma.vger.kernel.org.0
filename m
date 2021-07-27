Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8503D74B1
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhG0MDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 08:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhG0MDB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 08:03:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB3A76124D;
        Tue, 27 Jul 2021 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627387381;
        bh=vaY9Lm/Bw/E5GLFzTKQJlNBbdlcDd+lS7ec2tBQ3poI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LU3wZXjNYWkjjahQg5cId8lqrfM6++/rgdENVDw0BUC5aThaf3EP9VYc+U+pelxOi
         c2kJgXCFJoF6n1LrLcpnimdsIUOVIXNM5zcIXiJP3Uf8gVEAN5upLsIdgZs7lkn3zC
         Pnn15Fn1XxFn62bgYF4RiCcWBNsIbFUyqfmaaXK3JDDyywTVvVCI3lNJaeyt55Bg48
         yQ2jdGzDMsFS9rC0F0N7eP1UnE0pMltH1N396e0MQEiDb8cuL1WXgh8yZUn3SFbhAI
         UW4gnlPjv/+ocY0jDrlZioZ1sRbwBeJ7uBBZdbn3kYaD2y5CjvdMSDgNjED2AasLcz
         73+s8oc9dK6Wg==
Date:   Tue, 27 Jul 2021 15:02:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
Message-ID: <YP/18Ycu+EMLA8T8@unreal>
References: <20210726215815.17056-1-rpearsonhpe@gmail.com>
 <YP/uTbQ71dZWYIal@unreal>
 <c181c1b9-a2a6-3cf0-8644-762f6398bb5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c181c1b9-a2a6-3cf0-8644-762f6398bb5e@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 06:31:59AM -0500, Bob Pearson wrote:
> On 7/27/21 6:30 AM, Leon Romanovsky wrote:
> > On Mon, Jul 26, 2021 at 04:58:16PM -0500, Bob Pearson wrote:
> >> Currently several rxe objects hold references to PDs which are ref-
> >> counted. This replicates work already done by RDMA core which takes
> >> references to PDs in the ib objects which are contained in the rxe
> >> objects. This patch removes struct rxe_pd from rxe objects and removes
> >> reference counting for PDs except for PD alloc and PD dealloc. It also
> >> adds inline extractor routines which return PDs from the PDs in the
> >> ib objects. The names of these are made consistent including a rxe_
> >> prefix.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
> >>  drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
> >>  drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
> >>  drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
> >>  drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
> >>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
> >>  drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
> >>  drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
> >>  drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
> >>  9 files changed, 48 insertions(+), 64 deletions(-)
> > 
> > Last time when I looked on it, I came to conclusion that all RXE
> > references can be dropped.
> > 
> > Thanks
> > 
> This is a step in that direction. There are more coming.

Glad to hear, thank you for your work.

> Regards,
> 
> Bob
