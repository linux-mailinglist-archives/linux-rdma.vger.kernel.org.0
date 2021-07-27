Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2F3D745F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhG0LaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 07:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhG0LaY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 07:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB6A619E5;
        Tue, 27 Jul 2021 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627385424;
        bh=Ic+S0GFMdiHQuHo5BezBn7Pmvdv0hYYWU5ML8pLqILY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+3KAR7VCZhKCyGHI+w55hmuAXIg7Hr8npbY/5FU6SU0CJS54Jeyww8C5dYoMirx+
         wsUsdsnA+IvaG2B+eDXkCP6RQiwu9mPmI3bTuipShs1wX2Kp2ORM1hGuqV8zgntExG
         GC0rEBF5T3WqL6uHgjY2JOGQugT3Z9JSoB0KfRJIVXWJT2ZCDN+hI4gU8ajHREPGJ+
         G7Evj/KDFiI/VHhamkmk5czsnABS4xJbXYhQKI4y5GHRyku3YT8dlnADhq0hnPHBFa
         EzJyo4QR6g1AaXM8g/XlXc40hjhB7jXg6nfdxsNpUsu33Z4fntUtnWc+j4xGhMlzhE
         1D1DICfLlCztg==
Date:   Tue, 27 Jul 2021 14:30:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
Message-ID: <YP/uTbQ71dZWYIal@unreal>
References: <20210726215815.17056-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726215815.17056-1-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 26, 2021 at 04:58:16PM -0500, Bob Pearson wrote:
> Currently several rxe objects hold references to PDs which are ref-
> counted. This replicates work already done by RDMA core which takes
> references to PDs in the ib objects which are contained in the rxe
> objects. This patch removes struct rxe_pd from rxe objects and removes
> reference counting for PDs except for PD alloc and PD dealloc. It also
> adds inline extractor routines which return PDs from the PDs in the
> ib objects. The names of these are made consistent including a rxe_
> prefix.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
>  9 files changed, 48 insertions(+), 64 deletions(-)

Last time when I looked on it, I came to conclusion that all RXE
references can be dropped.

Thanks
