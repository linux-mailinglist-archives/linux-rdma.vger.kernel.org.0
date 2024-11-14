Return-Path: <linux-rdma+bounces-5985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530249C8931
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 12:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AC11F23034
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22911F8901;
	Thu, 14 Nov 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpGBsDvP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456D18C02F
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584728; cv=none; b=jA6znuCJVtYljzbx5N3A/iQm2ejyzPhvpOazSYpEdHlVEnQMS15VQtKabyiU9PswCw8fiIDV1/ND+oRLph85BMNzYoIyxbu4z79GUTB9V1IfvOEDA9Ddv45ps5pCul3/aJhi/SOFXLuyRKn+WbQLT5XlRtYkCx1XJ4Pky0UzFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584728; c=relaxed/simple;
	bh=Hw3aSfTDSQrRuk/AGyqknutYrY6k8+kY9sYMgStUoOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKarX0C6GWHHBji/mGBSGS7ZBrpriF1pEnbgQH+Vadv06xDG3338tac29XFX+kcs4cSOYH/gEN0jnu2ch9zVUkzX2Fw0YbqZAFCbFQFONnM2La5Eo6cc52vsqWP0QTWt+2/uzwNoGY6hSJ6GEYyy7v276nrtExiuFtEDBNFiYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpGBsDvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD6C4CECD;
	Thu, 14 Nov 2024 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584726;
	bh=Hw3aSfTDSQrRuk/AGyqknutYrY6k8+kY9sYMgStUoOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpGBsDvPOq3Cmn31YGi16re8GZv9GOCOcUMFpf8wWXRppp87TbykIcQL5Np9aik29
	 5OMys0jpCqFKZC3wD+sYYC+s3BFxyxpTCG4TlWc/b/ujnNFSNCgsSHu4oQi5q/3lz0
	 absCTB/zoKN8U0t/apOrhNf0LiUeLjT6K9WHJ6uMcKQr9N43V3rT4w/CmmoB8oZIE9
	 dr1AuowR+KD/99nZBARr+5dqoqgKHodfzaC5xX/pZMg1zjZosgH60nqze4s+WI44Ws
	 TmL2zuPXLgCmRIHaEnl+6Y8Tf0T1wGwMcxPTzpn2hWYJdVsHOKSCIgf0EnbzSZW7ej
	 MIB02yGRwnd6Q==
Date: Thu, 14 Nov 2024 13:45:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Mohammad Heib <mheib@redhat.com>, linux-rdma@vger.kernel.org,
	kashyap.desai@broadcom.com
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
Message-ID: <20241114114521.GF499069@unreal>
References: <20241112134956.1415343-1-mheib@redhat.com>
 <20241114100413.GA499069@unreal>
 <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:37:30PM +0530, Selvin Xavier wrote:
> On Thu, Nov 14, 2024 at 3:34 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> > > If bnxt FW behaves unexpectedly because of FW bug or unexpected behavior it
> > > can send completions for old  cookies that have already been handled by the
> > > bnxt driver. If that old cookie was associated with an old calling context
> > > the driver will try to access that caller memory again because the driver
> > > never clean the is_waiter_alive flag after the caller successfully complete
> > > waiting, and this access will cause the following kernel panic:
> > >
> > > Call Trace:
> > >  <IRQ>
> > >  ? __die+0x20/0x70
> > >  ? page_fault_oops+0x75/0x170
> > >  ? exc_page_fault+0xaa/0x140
> > >  ? asm_exc_page_fault+0x22/0x30
> > >  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
> > >  ? srso_return_thunk+0x5/0x5f
> > >  ? __wake_up_common+0x78/0xa0
> > >  ? srso_return_thunk+0x5/0x5f
> > >  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
> > >  tasklet_action_common+0xac/0x210
> > >  handle_softirqs+0xd3/0x2b0
> > >  __irq_exit_rcu+0x9b/0xc0
> > >  common_interrupt+0x7f/0xa0
> > >  </IRQ>
> > >  <TASK>
> > >
> > > To avoid the above unexpected behavior clear the is_waiter_alive flag
> > > every time the caller finishes waiting for a completion.
> > >
> > > Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after driver detect a timedout")
> > > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > Selvin?
> Someone is confirming the fix. Will ack in a day. Thanks

Thanks

