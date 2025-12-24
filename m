Return-Path: <linux-rdma+bounces-15207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09317CDB8A8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 07:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E04301619B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD1298987;
	Wed, 24 Dec 2025 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsx+d/Os"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F12AE68;
	Wed, 24 Dec 2025 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766559073; cv=none; b=m9a8SJUu+1uE47bIAqX9wNl0okGcBNk6o8LWzRkmgIS7wrRkhtpEWmKnSl6PVOGb466vdcni/PSif14Cxr3k95Ld5R/2ZklmlkFulL8BxSsYODtJv99eHIFdxzNberORTyEXjO0TleXFEHmOTpEGY3fFqFPZnJjt3hBtK07eFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766559073; c=relaxed/simple;
	bh=wN+CZ14TNVYhOSI6zRCkmPX6qqGq+POmnK5vhHOveMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJbLOA/Z0cY4QjZd+zLA9vB1FeqUVLrZvi6cbaPYgYgfprMdN+DomOcHBvmMiOJHb4dI/9GWeVEnsnMfxzuxp1ZqQPRaSqpkPP1iJ+piVrqEFiMZnpe1I5h0SEXYg7xcO95JqmlYYKrPsprTvc20Y54eXBCSxBLVhBbufeBmHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsx+d/Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491FFC4CEFB;
	Wed, 24 Dec 2025 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766559072;
	bh=wN+CZ14TNVYhOSI6zRCkmPX6qqGq+POmnK5vhHOveMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hsx+d/OsTiuwTYog/IFdXXni28dZ3zrGOv0Yt7NJlcp3NQQ7cizlv5NIjloNqSmEf
	 PVbnJxT0Z4IAy0Jz5+tV/QMn6llzP3F2GQK8Qd3b+MeBmr+EzEIohDZjC/Zj6IcIaP
	 /zFbkMIz95qe4a2z+pHjzi+/EfVCSzVv5Vk9bRXqIUIuhaCJOB3iuEkDWC3KonZFb+
	 Bic9WAJ43ckIoXmhqEaGtTewQ2pDCNqecT1mVspuiuk+ZPFFW5gtFbtHb5q6KttDuz
	 g04ymtAvWxL3si+b3NRNHl4OWdwyp7xr9qGcTBYHOPzc3psGJFifByd3+ltYXu/Xpy
	 6cQcBrOT791kw==
Date: Wed, 24 Dec 2025 08:51:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Greg Sword <gregsword0@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251224065107.GD11869@unreal>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
 <CAEz=LcvVgX8VA4M3TJM38NXrhyx-QohBdSoZOG=p3X9pbTY4pA@mail.gmail.com>
 <d4f60741-b0af-4a51-a1dc-cded1f34f309@embeddedor.com>
 <CAEz=LcsLXuAiQ0Rv0Z7E9mV35Qd92xxGsoSdDFBT8F1AdfZcoA@mail.gmail.com>
 <911ba345-7da6-4d05-955a-d33dd4b1e8c8@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <911ba345-7da6-4d05-955a-d33dd4b1e8c8@embeddedor.com>

On Wed, Dec 24, 2025 at 02:26:22AM +0900, Gustavo A. R. Silva wrote:
> 
> 
> On 12/24/25 02:19, Greg Sword wrote:
> > On Wed, Dec 24, 2025 at 12:59 AM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> > > 
> > > 
> > > 
> > > On 12/24/25 01:38, Greg Sword wrote:
> > > > On Tue, Dec 23, 2025 at 5:35 PM Gustavo A. R. Silva
> > > > <gustavo@embeddedor.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 12/23/25 13:41, Zhu Yanjun wrote:
> > > > > > From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > > > > 
> > > > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > > > getting ready to enable it, globally.
> > > > > > 
> > > > > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > > > > 
> > > > > > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > > > > 
> > > > > > This helper creates a union between a flexible-array member (FAM) and a
> > > > > > set of MEMBERS that would otherwise follow it.
> > > > > > 
> > > > > > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > > > > > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > > > > > start of MEMBER aligned.
> > > > > > 
> > > > > > The static_assert() ensures this alignment remains, and it's
> > > > > > intentionally placed inmediately after the related structure --no
> > > > > > blank line in between.
> > > > > > 
> > > > > > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > > > > > to the end of the corresponding structure.
> > > > > > 
> > > > > > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > 
> > > > > NACK.
> > > > 
> > > > Just a small reminder about community conventions: reviewers can NACK
> > > > a patch, but authors generally should not NACK their own patches.
> > > 
> > > It's obvious that you don't understand what's going on here.
> > 
> > I’ve read through the full discussion and understand how this evolved.
> > Based on that, I believe there may be a misunderstanding on your side.
> 
> Okay, thanks for your contribution then.

Gustavo,

A more fundamental issue than patch granularity is simply treating others
with respect, even when you disagree with them.

Zhu cares about RXE, and he respected your work by trying to address your
problem, not his own. RXE functions correctly without your patch, and this
hardening effort does not apply to RXE at all.

So please remember that both of you want the same thing, and let's keep the
discussion focused on the technical issues.

Thanks

> 
> -Gustavo
> 
> > 
> > > 
> > > > > I didn't write this patch.
> > > 
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > This line should've given you a clue.
> > > 
> > > -Gustavo
> > > 
> > > > > 
> > > > > Please, don't ever submit modified patches on my behalf.
> > > > > 
> > > > > > ---
> > > > > > V2->V3: Replace struct ib_sge with struct rxe_sge
> > > > > 
> > > > > Patch granularity is a fundamental thing. Changes addressing different
> > > > > issues should not be mixed together. Previously existing issues (if any)
> > > > > must be addressed in separate patches.
> > > > > 
> > > > > -Gustavo
> > > > > 
> > > > > > ---
> > > > > >     drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> > > > > >     1 file changed, 11 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > index fd48075810dd..3ffd7be8e7b1 100644
> > > > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > > > > >         u32                     rkey;
> > > > > >         u32                     length;
> > > > > > 
> > > > > > -     /* SRQ only */
> > > > > > -     struct {
> > > > > > -             struct rxe_recv_wqe     wqe;
> > > > > > -             struct ib_sge           sge[RXE_MAX_SGE];
> > > > > > -     } srq_wqe;
> > > > > > -
> > > > > >         /* Responder resources. It's a circular list where the oldest
> > > > > >          * resource is dropped first.
> > > > > >          */
> > > > > > @@ -232,7 +226,15 @@ struct rxe_resp_info {
> > > > > >         unsigned int            res_head;
> > > > > >         unsigned int            res_tail;
> > > > > >         struct resp_res         *res;
> > > > > > +
> > > > > > +     /* SRQ only */
> > > > > > +     /* Must be last as it ends in a flexible-array member. */
> > > > > > +     TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> > > > > > +             struct rxe_sge          sge[RXE_MAX_SGE];
> > > > > > +     ) srq_wqe;
> > > > > >     };
> > > > > > +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) ==
> > > > > > +           offsetof(struct rxe_resp_info, srq_wqe.sge));
> > > > > > 
> > > > > >     struct rxe_qp {
> > > > > >         struct ib_qp            ibqp;
> > > > > > @@ -269,7 +271,6 @@ struct rxe_qp {
> > > > > > 
> > > > > >         struct rxe_req_info     req;
> > > > > >         struct rxe_comp_info    comp;
> > > > > > -     struct rxe_resp_info    resp;
> > > > > > 
> > > > > >         atomic_t                ssn;
> > > > > >         atomic_t                skb_out;
> > > > > > @@ -289,6 +290,9 @@ struct rxe_qp {
> > > > > >         spinlock_t              state_lock; /* guard requester and completer */
> > > > > > 
> > > > > >         struct execute_work     cleanup_work;
> > > > > > +
> > > > > > +     /* Must be last as it ends in a flexible-array member. */
> > > > > > +     struct rxe_resp_info    resp;
> > > > > >     };
> > > > > > 
> > > > > >     enum {
> > > > > 
> > > > > 
> > > 
> 

