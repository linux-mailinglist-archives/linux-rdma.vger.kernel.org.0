Return-Path: <linux-rdma+bounces-2699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F28D4DF5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AEFB223AA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBABB17C9F2;
	Thu, 30 May 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak5DczBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC173186E57
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079184; cv=none; b=CnqQo9gKd+ffHKYZwd4UzNRwe9gMFGYaIn1NvVhG8prH7UtezuuVMCgqvoU3ua0u8mRR2Rni0oGxI22Vuk4/hPOmzubg5dvwCI9J9Lmpe1f0+PY1AFtsx6LTqsbpY4RwgGojWt2f/ossFDD8HGCJPyWha3EPKDpQEmSeE/Ae5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079184; c=relaxed/simple;
	bh=1lRBOQL5ATckQngMf5rC26Vt5Ua8lSkJCqQIJ7kuCb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEUr6VWhp0V1X3t/DfAvoHvMdJ+irtO2YN44ZNFMQpawtQnlOG8EH3y5gEnvY+fu8qqryI1ItGn3o7naw9qw/vAjy//1fxTCthbqOgiR01fCFjprRMuTk9Ra9icfHMBsoCZqM5PN75fCWLqghF8X30PjU1/Co3JesMR8f6z3uME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak5DczBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B251AC2BBFC;
	Thu, 30 May 2024 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079184;
	bh=1lRBOQL5ATckQngMf5rC26Vt5Ua8lSkJCqQIJ7kuCb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak5DczBF1jpWABFuRDxIYoQpWOLXcn1r3B3RBseONfWiZCT6Bxvnk1e73wqEvavGU
	 wymlqMmRCEnfnxh3ddOjvjXDQI1R622ehEI63AT+P2jrncRpV74JDExQFpaI4M1yL+
	 LzIa6A8vOTFxhY1LBLXLTAU+q3jFpbbm5anOKlGL2yKqTkwM5GwWn2nzq/Ftjj+Iow
	 1usvmBrXL9DjPdUwAia4f8lu+3D4U4uBfAI/bKL45mdm89sySwA984lSuRU4wZ3uAG
	 J0QguqnIRnU3b/wigdK1COrR/FDP1NmfKBtoiqXYx/6IRvDRHvdLARdQcKxbcVgBiN
	 8gLi23RfVc54w==
Date: Thu, 30 May 2024 17:13:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Honggang LI <honggangli@163.com>, jgg@ziepe.ca, rpearsonhpe@gmail.com,
	matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
Message-ID: <20240530141340.GA3884@unreal>
References: <20240523094617.141148-1-honggangli@163.com>
 <593dd175-c9c8-4bd0-a1bb-a7a19d1070d1@linux.dev>
 <579a7cf1-7eb8-442f-bae7-f929cfa82dda@linux.dev>
 <Zk_y-DYV_2fOSxOF@fc39>
 <71e37594-818a-493d-b3fa-9616e34bfe75@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71e37594-818a-493d-b3fa-9616e34bfe75@linux.dev>

On Tue, May 28, 2024 at 01:10:00PM +0200, Zhu Yanjun wrote:
> On 24.05.24 03:52, Honggang LI wrote:
> > On Thu, May 23, 2024 at 05:03:12PM +0200, Zhu Yanjun wrote:
> > > Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
> > >   packets
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > Date: Thu, 23 May 2024 17:03:12 +0200
> > > 
> > > 
> > > On 23.05.24 14:06, Zhu Yanjun wrote:
> > > > 
> > > > On 23.05.24 11:46, Honggang LI wrote:
> > > > > According to the IBA specification:
> > > > > If a UD request packet is detected with an invalid length, the request
> > > > > shall be an invalid request and it shall be silently dropped by
> > > > > the responder. The responder then waits for a new request packet.
> > > > > 
> > > > > commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
> > > > > checking")
> > > > > defers responder length check for UD QPs in function `copy_data`.
> > > > > But it introduces a regression issue for UD QPs.
> > > > > 
> > > > > When the packet size is too large to fit in the receive buffer.
> > > > > `copy_data` will return error code -EINVAL. Then `send_data_in`
> > > > > will return RESPST_ERR_MALFORMED_WQE. UD QP will transfer into
> > > > > ERROR state.
> > > > > 
> > > > > Fixes: 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
> > > > > checking")
> > > > > Signed-off-by: Honggang LI <honggangli@163.com>
> > > > > ---
> > > > >    drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++++++
> > > > >    1 file changed, 12 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > > b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > > index 963382f625d7..a74f29dcfdc9 100644
> > > > > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > > > @@ -354,6 +354,18 @@ static enum resp_states
> > > > > rxe_resp_check_length(struct rxe_qp *qp,
> > > > >         * receive buffer later. For rmda operations additional
> > > > >         * length checks are performed in check_rkey.
> > > > >         */
> > > > > +    if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
> > > > 
> > > >  From IBA specification:
> > > > 
> > > > "
> > > > 
> > > > QP1, used for the General Services Interface (GSI).
> > > > •This QP uses the Unreliable Datagram transport service.
> > > > •All traffic to and from this QP uses any VL other than VL15.
> > > > •GSI packets arriving before the current packet’s command completes may
> > > > be dropped (i.e. the minimum queue depth of QP1 is one).
> > > > 
> > > > "
> > > > 
> > > > GSI should be MAD packets. And it should have a fixed format. Not sure
> > > > if the payload of GSI packets will exceed the size of the recv buffer.
> > 
> > It's dangerous to trust remote GSI request packets always fit in local
> > receive buffer. A well-designed hostile GSI request packet can render
> > remote QP1 into ERROR state. That means the remote node can't establish
> > new RC QP connections.
> 
> Thanks, Honggang.
> Based on our discussion, this seems to be a security problem. It seems that
> this problem is related with MLX5. Before MLX5 engineers jump into this
> problem, to RXE, this commit can avoid RXE hang in ERROR state.

Current RDMA network is designed with assumption that all participants
are trusted.

Thanks

> 
> LGTM.
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> > 
> 

