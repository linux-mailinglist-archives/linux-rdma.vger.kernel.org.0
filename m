Return-Path: <linux-rdma+bounces-8816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA18A68756
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783693B75BE
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA725179D;
	Wed, 19 Mar 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lURGKeQm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C92505C7
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374710; cv=none; b=STE8o7tDUG2Hopw/9wkRqf2tLAJi77i+dD2j/oXf3+Bq1gq1LUdlUdDvi5G4uwHZx2Ivtr7Rxw6sRpCQ19+SrSF/toAfO6f6k+8N4oRhDnkKlLOHfzyF2ez09hqvcUWp5nbhlXorw4LNBL6epM2Q5DS2v0q+j8CuC3YcYFJCVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374710; c=relaxed/simple;
	bh=6zyS6bBaDd6mQ4XtILWYsdlboN5l+xKCa8PtMxxKapk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONLXjMZ7iugspMp7BpTyf2Vx7m/bnBw32/CKn+3FLxXKGY8ZVHc+rqL1CKdDQ7N0SJy/J0rCfWXusqSwAwia9JoCLTghxIgHdCH8gYihYBFbjHUgafrQiiY1fkGkp2Za4fW8iAHLlkgO292ptlhNNepyTpGwhkHoKo+t4TAGElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lURGKeQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F41C4CEE9;
	Wed, 19 Mar 2025 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742374710;
	bh=6zyS6bBaDd6mQ4XtILWYsdlboN5l+xKCa8PtMxxKapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lURGKeQmDB3IIObmcY671hLbkSc6TrjvjHfcZyZUPjdtdRy0Tj4bX/PuS630LBzB9
	 B1cH/P8GxMO7mKbSJreU0RHklo7zgwR+qDeIATMy1Npo0yyog+BYohe+XSkN/YQxiT
	 NLpzKHkS/+Sn4aE/ZPTWAy4Kh9bKOoHy3BDWlTqzKvAg+BWm4A1iga5tkcx+UV3i9N
	 OSFHzKhCx0Hb/u3pPNrUZh509AYPbsSl04F34PzQLF+nWfaWZijqcDt4DCBDCaPUxF
	 HycZJC7NZTytRVhjeDXDvvI0PdoAv53d0D7/XkRVeRNdl7rmOdVT+VT5PPYDqQrOFR
	 yX+87CBwNgdSg==
Date: Wed, 19 Mar 2025 10:58:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Message-ID: <20250319085825.GH1322339@unreal>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
 <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>
 <20250318101014.GA1322339@unreal>
 <OS3PR01MB98651EE8E000B0682056B381E5D92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB98651EE8E000B0682056B381E5D92@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Wed, Mar 19, 2025 at 02:58:51AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Tue, Mar 18, 2025 7:10 PM Leon Romanovsky wrote:
> > On Tue, Mar 18, 2025 at 06:49:32PM +0900, Daisuke Matsuda wrote:
> > 
> > <...>
> > 
> > > +static inline int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > +{
> > > +	return RESPST_ERR_UNSUPPORTED_OPCODE;
> > > +}
> > >  #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> > 
> > You are returning "enum resp_states", while function expects to return "int". You should return -EOPNOTSUPP.
> 
> Other than my patches, there are some functions that do the same thing.

Yes, but you are adding new code and in the new code you should try to
have correlated function declaration and returned values.

> I would like to post a patch to make them consistent, but I think we need
> reach an agreement on the design of rxe responder before taking up.
> Please see my opinion below.
> 
> > 
> > >
> > >  #endif /* RXE_LOC_H */
> 
> <...>
> 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > index 9a9aae967486..f3443c604a7f 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > @@ -378,3 +378,56 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
> > >
> > >  	return 0;
> > >  }
> > > +
> > > +#if defined CONFIG_64BIT
> > > +/* only implemented or called for 64 bit architectures */
> > > +int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> > > +{
> > > +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> > > +	unsigned int page_offset;
> > > +	unsigned long index;
> > > +	struct page *page;
> > > +	int err;
> > > +	u64 *va;
> > > +
> > > +	/* See IBA oA19-28 */
> > > +	err = mr_check_range(mr, iova, sizeof(value));
> > > +	if (unlikely(err)) {
> > > +		rxe_dbg_mr(mr, "iova out of range\n");
> > > +		return RESPST_ERR_RKEY_VIOLATION;
> > 
> > Please don't redefine returned errors.
> 
> As a general principle, I think your comment is totally correct.
> The problem is that rxe_receiver(), the responder of rxe, is originally designed
> as a state machine, and the returned values of "enum resp_states" are used
> to specify the next state.
> 
> One thing to note is that rxe_receiver() run solely in workqueue, so the errors
> generated in the bottom half context are never returned to userspace. In that regard,
> I think redefining the error codes with different enum values can be justified.

In places where rxe_odp_do_atomic_write() respond is important, you can
write something like:
err = rxe_odp_do_atomic_write(...)
if (err == -EPERM)
   state = RESPST_ERR_RKEY_VIOLATION
...

or declare rxe_odp_do_atomic_write() to return enum resp_state.

Thanks

