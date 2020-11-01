Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F262A1C6E
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Nov 2020 07:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgKAGRz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Nov 2020 01:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgKAGRz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Nov 2020 01:17:55 -0500
Received: from localhost (host-213-179-129-39.customer.m-online.net [213.179.129.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F68217A0;
        Sun,  1 Nov 2020 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604211474;
        bh=VeuO+f701JpLdIM7qySjG2KXpG4P98NkNb/ToArQvk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VecH6KOXbbem4XqCKw9TS3rP2cgKrcve+H25PInA325f0/4w8sm7upFgrY4uSjA2X
         9GvMKXeqBmNHrLFExSmUDqPCfHR97/lGE/FtRi0nXuWzRv8H5mlXgdB2x2vb9KYPjv
         o0ksQzSh4zA2Xm2OPz/ASYdh9qu09sL0J6rK35DM=
Date:   Sun, 1 Nov 2020 08:17:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe fixed bug in rxe_requester
Message-ID: <20201101061750.GB5429@unreal>
References: <20201013170741.3590-1-rpearson@hpe.com>
 <20201029092754.GE114054@unreal>
 <329c2fec-926d-b2de-2049-650503db8893@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329c2fec-926d-b2de-2049-650503db8893@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 29, 2020 at 12:09:05PM -0500, Bob Pearson wrote:
> On 10/29/20 4:27 AM, Leon Romanovsky wrote:
> > On Tue, Oct 13, 2020 at 12:07:42PM -0500, Bob Pearson wrote:
> >> The code which limited the number of unacknowledged PSNs was incorrect.
> >> The PSNs are limited to 24 bits and wrap back to zero from 0x00ffffff.
> >> The test was computing a 32 bit value which wraps at 32 bits so that
> >> qp->req.psn can appear smaller than the limit when it is actually larger.
> >>
> >> Replace '>' test with psn_compare which is used for other PSN comparisons
> >> and correctly handles the 24 bit size.
> >>
> >> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_req.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> >> index af3923bf0a36..d4917646641a 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> >> @@ -634,7 +634,8 @@ int rxe_requester(void *arg)
> >>  	}
> >>
> >>  	if (unlikely(qp_type(qp) == IB_QPT_RC &&
> >> -		     qp->req.psn > (qp->comp.psn + RXE_MAX_UNACKED_PSNS))) {
> >> +		psn_compare(qp->req.psn, (qp->comp.psn +
> >> +				RXE_MAX_UNACKED_PSNS)) > 0)) {
> >
> > qp->comp.psn is u32, so you are checking that
> > qp->comp.psn + RXE_MAX_UNACKED_PSNS != 0, am I right?
> >
> >>  		qp->req.wait_psn = 1;
> >>  		goto exit;
> >>  	}
> >> --
> >> 2.25.1
>
> First, qp->comp.psn is a 24 bit unsigned quantity as is qp->req.psn.
>
> RXE_MAX_UNACKED_PSNS is a reasonably small number e.g. 128 for now.
>
> So qp->comp.psn + RXE_MAX_UNACKED_PSNS which is a 32 bit number never wraps to zero and remains in the
> range [RXE_MAX_UNACKED_PSNS, RXE_MAX_UNACKED_PSNS + 2^24 -1]. The upper limit will not wrap back zero unless
> RXE_MAX_UNACKED_PSNS is > 2^32 - 2^24 which would be a grossly unreasonable upper limit. You would have long
> since run out of memory.
>
> psn_compare(a, b) = (a - b) << 8 and is a signed 32 bit number.
>
> This correctly determines the magnitude and sign of the difference between a and b as long as that difference
> is less than 2^23.

Ohh, I see what confused me, missed extra ")".

Thanks

>
> Bob
