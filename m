Return-Path: <linux-rdma+bounces-5976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07B9C86EF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C733B223CF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF51DEFFE;
	Thu, 14 Nov 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiupSf9T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2731632F2
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578659; cv=none; b=panDQ6DI+5d6XLUfnwzeWo/fZeVEc+Bpgl8vbJ0i/47oujGk6SPv/JJaVSJeU+Tl0VTB7MQ0L5YSlgV7jKTFQ7PJAyK6xajZo3izApmo0j3NrppTLDTkpBDI4Qdh0D9osWP3/vzw8gcbexdpdmCoHbycB9mafc1Ena8CXKpXhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578659; c=relaxed/simple;
	bh=pKsTofijKMsoBWLjNTahtb1RKJW1vHQ74ryLYxWfrcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3RVXI6eV/VtjeOmj38Lg2as7dUmmUg7wBkjWFOI6ZBf4abUcJ0sJE1cYzANv4Q3UUk2bAg16KcB22iTvjx6Ria3Ejx2LEiHq4CRgxrk8UiqKEvUK3JL/gPLnvkioeCLLSJ9adxugozrTua54SRr6ZjtFs/hZCjhXo+Azwoz9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiupSf9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12C4C4CECD;
	Thu, 14 Nov 2024 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731578658;
	bh=pKsTofijKMsoBWLjNTahtb1RKJW1vHQ74ryLYxWfrcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiupSf9TXhq8BPJgMtQpOvS1uRNau58E+ASH1Y/CFZHchMJLZCjPBlIKJAtkMrnFs
	 du1ZMX5yBvg9NLrFATCEaVQXBeFXMyL7XTCa50iUgK1NTpB34tbKDgn6QRi3yjeEOm
	 cViczNmicgyLAOxj+kCdgRPOrIB2cdM/ZE0Mp3FZzWKZEG5o85Gw9dxW/i/AtRz8/E
	 nvxKpb7F6KEpv1a/j8WOP9OHA7kJe+tv5ltmDn7t1+jsDbAqyZ/WWye+vr62gnUxQ9
	 mgF3DDiIUVOxfqShrqx4vbd8PBkJnGzclAwrQZpVx97xJxPhjdQDrd/HZqIZD63ks3
	 GRfPwIL/0lu4g==
Date: Thu, 14 Nov 2024 12:04:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Mohammad Heib <mheib@redhat.com>, selvin.xavier@broadcom.com
Cc: linux-rdma@vger.kernel.org, kashyap.desai@broadcom.com
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
Message-ID: <20241114100413.GA499069@unreal>
References: <20241112134956.1415343-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112134956.1415343-1-mheib@redhat.com>

On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> If bnxt FW behaves unexpectedly because of FW bug or unexpected behavior it
> can send completions for old  cookies that have already been handled by the
> bnxt driver. If that old cookie was associated with an old calling context
> the driver will try to access that caller memory again because the driver
> never clean the is_waiter_alive flag after the caller successfully complete
> waiting, and this access will cause the following kernel panic:
> 
> Call Trace:
>  <IRQ>
>  ? __die+0x20/0x70
>  ? page_fault_oops+0x75/0x170
>  ? exc_page_fault+0xaa/0x140
>  ? asm_exc_page_fault+0x22/0x30
>  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
>  ? srso_return_thunk+0x5/0x5f
>  ? __wake_up_common+0x78/0xa0
>  ? srso_return_thunk+0x5/0x5f
>  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
>  tasklet_action_common+0xac/0x210
>  handle_softirqs+0xd3/0x2b0
>  __irq_exit_rcu+0x9b/0xc0
>  common_interrupt+0x7f/0xa0
>  </IRQ>
>  <TASK>
> 
> To avoid the above unexpected behavior clear the is_waiter_alive flag
> every time the caller finishes waiting for a completion.
> 
> Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after driver detect a timedout")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Selvin?

