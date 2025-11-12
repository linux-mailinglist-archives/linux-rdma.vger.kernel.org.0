Return-Path: <linux-rdma+bounces-14442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088CC52330
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 13:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0081888581
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665B30E854;
	Wed, 12 Nov 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqOm95zB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2323148BE;
	Wed, 12 Nov 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949209; cv=none; b=YouG2lpe7b7OvesU7Pch4GeAQ2uQX29q8hvQcnHumL23F/Ol7oCUOMzPi7Y1iX+noZcR9DQ24O5QDGA68o3WoIFzdSSm+LjLpoAgjXels886QF1I+4OGHNzx0zBpO4gRFFcS4Jx9XLsXla9ziZ8aBv8etSwZR4xNyNagv19pKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949209; c=relaxed/simple;
	bh=yVtS8pRP+adgg8sl6Md/aPafQ8QdghQXjnl9n6aUeFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry7bojGUOKVJt13pQQt+kNNUG1d08TQFL31Sv1CZkiNCjwC9vqfMDB711+/PbBl6Gi7NZ80rjqpGlPEvvbrr3LRRdSmh5NWmd7REnsKHsJJbqFOyrJXROXpVUDQlGlxBJqvFfiE75IaeucFABvVOpeKdb1npxkQAT3F3O/kD77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqOm95zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC2BC4CEF5;
	Wed, 12 Nov 2025 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762949209;
	bh=yVtS8pRP+adgg8sl6Md/aPafQ8QdghQXjnl9n6aUeFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqOm95zBibddQtdO1bWejRsX26TZ3LUw737DGdw4PPYUxbrwkz+pJrVBnmkUXW7Jt
	 A6IDEllCpCpAYQJBqRe0ddGfyGeChcV2QFmsImr7GZH1/RZ1cqPHVsnUjsBVTCjVgo
	 AyFgT4BXP1pbqSfqzvulNIBxACVABxsQyKG/yrrPGg11bM8FAkMJjUU4PkUV2eWo4N
	 /X8REycVGQhdPU8RLC2Ii9zcQphxLK2C1zxNfoyfjdONTTM4l3pRFlTY9ygOsG7mDq
	 SG9VKSpPsnmKxKp+fXLySHCtbKoMfgh5w0DCazN7ACpIRiQY3aC7DTcRQVhXvUgKWu
	 BKmrLG1v2kEcg==
Date: Wed, 12 Nov 2025 14:06:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251112120644.GD17382@unreal>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251111115621.GO15456@unreal>
 <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
 <20251111141945.GQ15456@unreal>
 <d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com>
 <20251112093226.GA17382@unreal>
 <01dde656-f41f-48f1-944c-b69cf1c3543e@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01dde656-f41f-48f1-944c-b69cf1c3543e@embeddedor.com>

On Wed, Nov 12, 2025 at 06:50:16PM +0900, Gustavo A. R. Silva wrote:
> 
> 
> On 11/12/25 18:32, Leon Romanovsky wrote:
> > On Wed, Nov 12, 2025 at 05:49:05PM +0900, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 11/11/25 23:19, Leon Romanovsky wrote:
> > > > On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
> > > > > 
> > > > > 
> > > > > On 11/11/25 20:56, Leon Romanovsky wrote:
> > > > > > On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
> > > > > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > > > > getting ready to enable it, globally.
> > > > > > > 
> > > > > > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > > > > > 
> > > > > > > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > > > > > 
> > > > > > > This helper creates a union between a flexible-array member (FAM) and a
> > > > > > > set of MEMBERS that would otherwise follow it.
> > > > > > > 
> > > > > > > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > > > > > > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > > > > > > start of MEMBER aligned.
> > > > > > > 
> > > > > > > The static_assert() ensures this alignment remains, and it's
> > > > > > > intentionally placed inmediately after the related structure --no
> > > > > > > blank line in between.
> > > > > > > 
> > > > > > > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > > > > > > to the end of the corresponding structure.
> > > > > > > 
> > > > > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > > > ---
> > > > > > >     drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> > > > > > >     1 file changed, 11 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > > index fd48075810dd..6498d61e8956 100644
> > > > > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > > > > > >     	u32			rkey;
> > > > > > >     	u32			length;
> > > > > > > -	/* SRQ only */
> > > > > > > -	struct {
> > > > > > > -		struct rxe_recv_wqe	wqe;
> > > > > > > -		struct ib_sge		sge[RXE_MAX_SGE];
> > > > > > > -	} srq_wqe;
> > > > > > > -
> > > > > > >     	/* Responder resources. It's a circular list where the oldest
> > > > > > >     	 * resource is dropped first.
> > > > > > >     	 */
> > > > > > > @@ -232,7 +226,15 @@ struct rxe_resp_info {
> > > > > > >     	unsigned int		res_head;
> > > > > > >     	unsigned int		res_tail;
> > > > > > >     	struct resp_res		*res;
> > > > > > > +
> > > > > > > +	/* SRQ only */
> > > > > > > +	/* Must be last as it ends in a flexible-array member. */
> > > > > > > +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> > > > > > > +		struct ib_sge		sge[RXE_MAX_SGE];
> > > > > > > +	) srq_wqe;
> > > > > > 
> > > > > > Will this change be enough?
> > > > > > 
> > > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > index fd48075810dd..9ab11421a585 100644
> > > > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > > > > >            u32                     rkey;
> > > > > >            u32                     length;
> > > > > > -       /* SRQ only */
> > > > > > -       struct {
> > > > > > -               struct rxe_recv_wqe     wqe;
> > > > > > -               struct ib_sge           sge[RXE_MAX_SGE];
> > > > > > -       } srq_wqe;
> > > > > > -
> > > > > >            /* Responder resources. It's a circular list where the oldest
> > > > > >             * resource is dropped first.
> > > > > >             */
> > > > > > @@ -232,6 +226,12 @@ struct rxe_resp_info {
> > > > > >            unsigned int            res_head;
> > > > > >            unsigned int            res_tail;
> > > > > >            struct resp_res         *res;
> > > > > > +
> > > > > > +       /* SRQ only */
> > > > > > +       struct {
> > > > > > +               struct ib_sge           sge[RXE_MAX_SGE];
> > > > > > +               struct rxe_recv_wqe     wqe;
> > > > > > +       } srq_wqe;
> > > > > >     };
> > > > > 
> > > > > The question is if this is really what you want?
> > > > > 
> > > > > sge[RXE_MAX_SGE] is of the following type:
> > > > > 
> > > > > struct ib_sge {
> > > > >           u64     addr;
> > > > >           u32     length;
> > > > >           u32     lkey;
> > > > > };
> > > > > 
> > > > > and struct rxe_recv_wqe::dma.sge[] is of type:
> > > > > 
> > > > > struct rxe_sge {
> > > > >           __aligned_u64 addr;
> > > > >           __u32   length;
> > > > >           __u32   lkey;
> > > > > };
> > > > > 
> > > > > Both types are basically the same, and the original code looks
> > > > > pretty much like what people do when they want to pre-allocate
> > > > > a number of elements (of the same element type as the flex array)
> > > > > for a flexible-array member.
> > > > > 
> > > > > Based on the above, the change you suggest seems a bit suspicious,
> > > > > and I'm not sure that's actually what you want?
> > > > 
> > > > You wrote about this error: "warning: structure containing a flexible array
> > > > member is not at the end of another structure".
> > > > 
> > > > My suggestion was simply to move that flex array to be the last element
> > > > and save us from the need to have some complex, magic macro in RXE.
> > > 
> > > Yep, but as I commented above, that doesn't seem to be the right change.
> > > 
> > > Look at the following couple of lines:
> > > 
> > > drivers/infiniband/sw/rxe/rxe_resp.c-286-       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
> > > drivers/infiniband/sw/rxe/rxe_resp.c-287-       memcpy(&qp->resp.srq_wqe, wqe, size);
> > > 
> > > Notice that line 286 is the open-coded arithmetic (struct_size(wqe,
> > > dma.sge, wqe->dma.num_sge) is preferred) to get the number of bytes
> > > to allocate for a flexible structure, in this case struct rxe_recv_wqe,
> > > and its flexible-array member, in this case struct rxe_recv_wqe::dma.sge[].
> > > 
> > > So, `size` bytes are written in qp->resp.srq_wqe, and the reason this works
> > > seems to be because of the pre-allocation of RXE_MAX_SGE number of elements
> > > for flex array struct rxe_recv_wqe::dma.sge[] given by:
> > > 
> > > struct {
> > > 	struct rxe_recv_wqe	wqe;
> > > 	struct ib_sge		sge[RXE_MAX_SGE];
> > > } srq_wqe;
> > 
> > So you are saying that it works because it is written properly, so what
> > is the problem? Why do we need to fix properly working and written code
> > to be less readable?
> 
> No one said the original code is not working as expected. The issue here is
> that the FAM is not at the end, and this causes a -Wflex-array-member-not-at-end
> warning. The change I propose places the FAM at the end, and the functionality
> remains exactly the same.
> 
> You're probably not aware of the work we've been doing to enable
> -Wflex-array-member-not-at-end in mainline. If you're interested, below you
> can take a look at other similar changes I (and others) have been doing to
> complete this work:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=-Wflex-array-member-not-at-end

I'm aware of that work, just trying to find a simplest possible solution
for this specific driver. RXE is a development driver which won't benefit
from this hardening work at all.

> 
> > 
> > > 
> > > So, unless I'm missing something, struct ib_sge sge[RXE_MAX_SGE];
> > > should be aligned with struct rxe_recv_wqe wqe::dma.sge[].
> > 
> > It is and moving to the end of struct will continue to keep it aligned.
> 
> I think there is something you are missing here. The following pieces of
> code are no equivalent:
> 
> struct {
> 	struct rxe_recv_wqe	wqe;
>  	struct ib_sge		sge[RXE_MAX_SGE];
> } srq_wqe;
> 
> struct {
>  	struct ib_sge		sge[RXE_MAX_SGE];
> 	struct rxe_recv_wqe	wqe;
> } srq_wqe;
> 
> What I'm understanding from your last couple of responses is that you think
> the above are equivalent. My previous response tried to explain why that is
> not the case.

Yes, I already forgot about change in srq_wqe.

Thanks

> 
> > 
> > > 
> > > The TRAILING_OVERLAP() macro is also designed to ensure alignment in these
> > > cases (and the static_assert() to preserve it). See this thread:
> > > 
> > > https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
> > > 
> 
> Thanks
> -Gustavo

