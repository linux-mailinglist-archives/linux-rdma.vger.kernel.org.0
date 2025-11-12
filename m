Return-Path: <linux-rdma+bounces-14423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BCFC515F5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 10:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AF2189B97D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DBD2FFDEA;
	Wed, 12 Nov 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k++Gdm2e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D42FF66C;
	Wed, 12 Nov 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939951; cv=none; b=itu6HPUVlXydeTcoo7HM7MasQ3S9pR1rPu92ZLPWlC8ssrEjqY1i6FhIyEUb1zDKd8o049PhvVTbxsagn1cLYUW5j/DaI0CkLe8T9KmUymex6YI6R0OGM3kQjDkFJg52QoSvYbCassLgY0xi8i4PUUY/0msMZX8KjQCKqfewREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939951; c=relaxed/simple;
	bh=uDgqiKTZnV4++p6VffHqEG3cTXU/PY5QmS5TDQiUCCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU89ENFEzNHrzTP2fAwygE7hLXd2f8x2qTZ3C+G8gDHNWrjSfmBXEfCwdijyo2WT18dmWwele3yhxsmWf8OmNSnZFtuDYv630brqDemwc59Bxxthukj8uR33vAcPY1sHUfgvrHrEfQV61a7s6X/IWjN44K8OcOFh34IXMJeVb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k++Gdm2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40793C16AAE;
	Wed, 12 Nov 2025 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762939950;
	bh=uDgqiKTZnV4++p6VffHqEG3cTXU/PY5QmS5TDQiUCCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k++Gdm2e30hC1tal1dPHb3WlWUFviYvbuHsVtkLXDfmNBpiixKnRq6QBqy0C5gqzU
	 mEtutMvS+8NbJLTf905fYFdJgHRgdbVSZELutn97XzKvV7yVSSuE3PG3VtKeIJ9BkP
	 +KCbRTZitWzLNIebY1E5NxhMZ0RBiJkQlmX16/kyP/sjcpBh0ogLCMiA9Nq6BvtwfO
	 hV8yPmILH8jJYqpP64zpFajGb4yJgC14bKeeTLXtxf2YbjVwWs0JC5eIpkUwgXgbuJ
	 poefE/8d4qWuB6mFyqNBdyez/nG6tNYX3CyWAqpyIy30stQS7Ls+ZhKDmZhgtPCEyL
	 oPxoOt97nym/Q==
Date: Wed, 12 Nov 2025 11:32:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251112093226.GA17382@unreal>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251111115621.GO15456@unreal>
 <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
 <20251111141945.GQ15456@unreal>
 <d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com>

On Wed, Nov 12, 2025 at 05:49:05PM +0900, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/25 23:19, Leon Romanovsky wrote:
> > On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 11/11/25 20:56, Leon Romanovsky wrote:
> > > > On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
> > > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > > getting ready to enable it, globally.
> > > > > 
> > > > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > > > 
> > > > > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > > > 
> > > > > This helper creates a union between a flexible-array member (FAM) and a
> > > > > set of MEMBERS that would otherwise follow it.
> > > > > 
> > > > > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > > > > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > > > > start of MEMBER aligned.
> > > > > 
> > > > > The static_assert() ensures this alignment remains, and it's
> > > > > intentionally placed inmediately after the related structure --no
> > > > > blank line in between.
> > > > > 
> > > > > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > > > > to the end of the corresponding structure.
> > > > > 
> > > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > ---
> > > > >    drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> > > > >    1 file changed, 11 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > index fd48075810dd..6498d61e8956 100644
> > > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > > > >    	u32			rkey;
> > > > >    	u32			length;
> > > > > -	/* SRQ only */
> > > > > -	struct {
> > > > > -		struct rxe_recv_wqe	wqe;
> > > > > -		struct ib_sge		sge[RXE_MAX_SGE];
> > > > > -	} srq_wqe;
> > > > > -
> > > > >    	/* Responder resources. It's a circular list where the oldest
> > > > >    	 * resource is dropped first.
> > > > >    	 */
> > > > > @@ -232,7 +226,15 @@ struct rxe_resp_info {
> > > > >    	unsigned int		res_head;
> > > > >    	unsigned int		res_tail;
> > > > >    	struct resp_res		*res;
> > > > > +
> > > > > +	/* SRQ only */
> > > > > +	/* Must be last as it ends in a flexible-array member. */
> > > > > +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> > > > > +		struct ib_sge		sge[RXE_MAX_SGE];
> > > > > +	) srq_wqe;
> > > > 
> > > > Will this change be enough?
> > > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > index fd48075810dd..9ab11421a585 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > > >           u32                     rkey;
> > > >           u32                     length;
> > > > -       /* SRQ only */
> > > > -       struct {
> > > > -               struct rxe_recv_wqe     wqe;
> > > > -               struct ib_sge           sge[RXE_MAX_SGE];
> > > > -       } srq_wqe;
> > > > -
> > > >           /* Responder resources. It's a circular list where the oldest
> > > >            * resource is dropped first.
> > > >            */
> > > > @@ -232,6 +226,12 @@ struct rxe_resp_info {
> > > >           unsigned int            res_head;
> > > >           unsigned int            res_tail;
> > > >           struct resp_res         *res;
> > > > +
> > > > +       /* SRQ only */
> > > > +       struct {
> > > > +               struct ib_sge           sge[RXE_MAX_SGE];
> > > > +               struct rxe_recv_wqe     wqe;
> > > > +       } srq_wqe;
> > > >    };
> > > 
> > > The question is if this is really what you want?
> > > 
> > > sge[RXE_MAX_SGE] is of the following type:
> > > 
> > > struct ib_sge {
> > >          u64     addr;
> > >          u32     length;
> > >          u32     lkey;
> > > };
> > > 
> > > and struct rxe_recv_wqe::dma.sge[] is of type:
> > > 
> > > struct rxe_sge {
> > >          __aligned_u64 addr;
> > >          __u32   length;
> > >          __u32   lkey;
> > > };
> > > 
> > > Both types are basically the same, and the original code looks
> > > pretty much like what people do when they want to pre-allocate
> > > a number of elements (of the same element type as the flex array)
> > > for a flexible-array member.
> > > 
> > > Based on the above, the change you suggest seems a bit suspicious,
> > > and I'm not sure that's actually what you want?
> > 
> > You wrote about this error: "warning: structure containing a flexible array
> > member is not at the end of another structure".
> > 
> > My suggestion was simply to move that flex array to be the last element
> > and save us from the need to have some complex, magic macro in RXE.
> 
> Yep, but as I commented above, that doesn't seem to be the right change.
> 
> Look at the following couple of lines:
> 
> drivers/infiniband/sw/rxe/rxe_resp.c-286-       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
> drivers/infiniband/sw/rxe/rxe_resp.c-287-       memcpy(&qp->resp.srq_wqe, wqe, size);
> 
> Notice that line 286 is the open-coded arithmetic (struct_size(wqe,
> dma.sge, wqe->dma.num_sge) is preferred) to get the number of bytes
> to allocate for a flexible structure, in this case struct rxe_recv_wqe,
> and its flexible-array member, in this case struct rxe_recv_wqe::dma.sge[].
> 
> So, `size` bytes are written in qp->resp.srq_wqe, and the reason this works
> seems to be because of the pre-allocation of RXE_MAX_SGE number of elements
> for flex array struct rxe_recv_wqe::dma.sge[] given by:
> 
> struct {
> 	struct rxe_recv_wqe	wqe;
> 	struct ib_sge		sge[RXE_MAX_SGE];
> } srq_wqe;

So you are saying that it works because it is written properly, so what
is the problem? Why do we need to fix properly working and written code
to be less readable?

> 
> So, unless I'm missing something, struct ib_sge sge[RXE_MAX_SGE];
> should be aligned with struct rxe_recv_wqe wqe::dma.sge[].

It is and moving to the end of struct will continue to keep it aligned.

> 
> The TRAILING_OVERLAP() macro is also designed to ensure alignment in these
> cases (and the static_assert() to preserve it). See this thread:
> 
> https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
> 
> Thanks
> -Gustavo
> 
> 
> 
> 

