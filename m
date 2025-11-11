Return-Path: <linux-rdma+bounces-14398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C24C4E790
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3144FA9A7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C347328250;
	Tue, 11 Nov 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ6D1xUB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313173009F8;
	Tue, 11 Nov 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870790; cv=none; b=TYps8uiXJ4r66Y01Yba+ivbuB6ryzOSPVriduiGQY8SKFpdg65te16jLkp/9RUARvrwwIgrlC4Z9ZzIuN7zcwgY9x/Zjh/UWm0UzrVZSgdInssn6tHgdJedElTVM4NIFc/u4vdZ39pw1DqifYKEFaJdbMsJKeqc4Z7wgCOEWNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870790; c=relaxed/simple;
	bh=F/G18b/qrnGePtXJA8yNc/KyviNlsV6BniqKSGhcuKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGyXwLN/W5qkXGOLQXvdpoSG7dtmUSVM3+LfhxAkjv9VSPUNIwRFyjC6lRYFuK/M6ijqsAPZnKEIIfT6UR9DoL1vkzEnKd11uKdYQJ0ylodvQWilGo+063cPb2n4oPbvT26L9780ls9X6qOnRMsHzQ5eYTDH5WsHwcHYLjdhsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ6D1xUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360C1C4CEF5;
	Tue, 11 Nov 2025 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870789;
	bh=F/G18b/qrnGePtXJA8yNc/KyviNlsV6BniqKSGhcuKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ6D1xUBOHjSqie6c88Lfv8Vjj8UGymIATadTnHoCZU5AZ8TYJoADIMYaXBk3Dcd2
	 Rghi7mgqwqohPEhy33mfi1ZOEkCErCLSCmHC9t0PLTPATLREkrT1VBsXas7pubbZe0
	 ilxJcxehrPySNlQ6/sBA3YddzP2VzpAllOjvmYkswi6lBtjMDJko4b7yiIjx7pTfss
	 whxSASEyVAYV5Pknrc6RDwa1K2yjZ9MrIj+nM6AllROiGgPbskVZ5mdTDCMzitZDL9
	 2CYVb96vco3QDZ+czSzJXCGOUrRYzWfnGqZFw6OFQYEVeCLjky3FT+xlHSZao8yuRD
	 ZRVrCFTFfU3dQ==
Date: Tue, 11 Nov 2025 16:19:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251111141945.GQ15456@unreal>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251111115621.GO15456@unreal>
 <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>

On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/25 20:56, Leon Romanovsky wrote:
> > On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM) and a
> > > set of MEMBERS that would otherwise follow it.
> > > 
> > > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > > start of MEMBER aligned.
> > > 
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after the related structure --no
> > > blank line in between.
> > > 
> > > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > > to the end of the corresponding structure.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> > >   1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > index fd48075810dd..6498d61e8956 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> > >   	u32			rkey;
> > >   	u32			length;
> > > -	/* SRQ only */
> > > -	struct {
> > > -		struct rxe_recv_wqe	wqe;
> > > -		struct ib_sge		sge[RXE_MAX_SGE];
> > > -	} srq_wqe;
> > > -
> > >   	/* Responder resources. It's a circular list where the oldest
> > >   	 * resource is dropped first.
> > >   	 */
> > > @@ -232,7 +226,15 @@ struct rxe_resp_info {
> > >   	unsigned int		res_head;
> > >   	unsigned int		res_tail;
> > >   	struct resp_res		*res;
> > > +
> > > +	/* SRQ only */
> > > +	/* Must be last as it ends in a flexible-array member. */
> > > +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> > > +		struct ib_sge		sge[RXE_MAX_SGE];
> > > +	) srq_wqe;
> > 
> > Will this change be enough?
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > index fd48075810dd..9ab11421a585 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> >          u32                     rkey;
> >          u32                     length;
> > -       /* SRQ only */
> > -       struct {
> > -               struct rxe_recv_wqe     wqe;
> > -               struct ib_sge           sge[RXE_MAX_SGE];
> > -       } srq_wqe;
> > -
> >          /* Responder resources. It's a circular list where the oldest
> >           * resource is dropped first.
> >           */
> > @@ -232,6 +226,12 @@ struct rxe_resp_info {
> >          unsigned int            res_head;
> >          unsigned int            res_tail;
> >          struct resp_res         *res;
> > +
> > +       /* SRQ only */
> > +       struct {
> > +               struct ib_sge           sge[RXE_MAX_SGE];
> > +               struct rxe_recv_wqe     wqe;
> > +       } srq_wqe;
> >   };
> 
> The question is if this is really what you want?
> 
> sge[RXE_MAX_SGE] is of the following type:
> 
> struct ib_sge {
>         u64     addr;
>         u32     length;
>         u32     lkey;
> };
> 
> and struct rxe_recv_wqe::dma.sge[] is of type:
> 
> struct rxe_sge {
>         __aligned_u64 addr;
>         __u32   length;
>         __u32   lkey;
> };
> 
> Both types are basically the same, and the original code looks
> pretty much like what people do when they want to pre-allocate
> a number of elements (of the same element type as the flex array)
> for a flexible-array member.
> 
> Based on the above, the change you suggest seems a bit suspicious,
> and I'm not sure that's actually what you want?

You wrote about this error: "warning: structure containing a flexible array
member is not at the end of another structure".

My suggestion was simply to move that flex array to be the last element
and save us from the need to have some complex, magic macro in RXE.

Thanks

> 
> Thanks
> -Gustavo
> 
> 
> 
> 
> 

