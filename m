Return-Path: <linux-rdma+bounces-3015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD6901592
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801631C20AB3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685781CD0C;
	Sun,  9 Jun 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD1PW662"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D85A3F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Jun 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929544; cv=none; b=dvzaFMpQqvmyba6oBglNS9i5/BLLkez3q361HnJR9aL4UYq39BrMTidsIWGwxVj1YczT3ygfLoLLI9XJ4eVcjeWLeI3ArwYO5271wsF0WAwzzFf15ykXo0edd5hg4COJlUkgGoHdYfEel2ziYDhVMndKorUmH/5j4I0T8Zya5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929544; c=relaxed/simple;
	bh=wfr0NiZllO+OzYHh0xRG4urr+aQ8JphvrltYxfftw2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5QGBma637MQ72bnqhyD3jx0clgWXzX7G5s2LjfBCkKK/7NUBOusMoLS937t7Y90jx8VZDNIVoMcAiBYzANUL62SXxus2yrgnpWYjvvwVRZMmpQsKxtAHpILYca5o2j/H9wvg8k8KkZ6tCXZtk6/moyNWsgZdXYruask4+x3+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD1PW662; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E16C2BD10;
	Sun,  9 Jun 2024 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717929543;
	bh=wfr0NiZllO+OzYHh0xRG4urr+aQ8JphvrltYxfftw2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WD1PW6627Xo+PCPEP0WHQE4KdXqx+SUHNG3/sijWyLFBZbSSKgtCkO4RKm6QG9/gg
	 BLffKfEEn4pCCSTwzC26Pc/0oOVF77XckByt4twI/YD36s00js+zDuWwzsDZwGVwlK
	 NwzyZYxSQ4keA8vAmWABlanRUi6CmV75eiKaseKQWCzLSYNeIJnLW5QJipPh1z+J83
	 l7099wXtWtmWit1F7nDc87Fl7xQaxuKnlILwuuim0au6Re+UEZfrHUjtg1/gq859mv
	 iSSPyhxaZ3aniQL5m2iiRC54IyNzNSKPB7qE9yTbTM0mWyhntmLxTeh8Nz7VbJEdC/
	 tAPBm8mWoG9cA==
Date: Sun, 9 Jun 2024 13:38:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
	linux-rdma@vger.kernel.org, Honggang LI <honggangli@163.com>
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
Message-ID: <20240609103859.GB8976@unreal>
References: <20240523094617.141148-1-honggangli@163.com>
 <171707866514.136408.14977812016177496326.b4-ty@kernel.org>
 <4b082825-af44-40fe-a6e9-a33d7caa4351@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b082825-af44-40fe-a6e9-a33d7caa4351@linux.dev>

On Fri, Jun 07, 2024 at 10:57:12AM +0200, Zhu Yanjun wrote:
> 
> On 30.05.24 16:17, Leon Romanovsky wrote:
> > On Thu, 23 May 2024 17:46:17 +0800, Honggang LI wrote:
> > > According to the IBA specification:
> > > If a UD request packet is detected with an invalid length, the request
> > > shall be an invalid request and it shall be silently dropped by
> > > the responder. The responder then waits for a new request packet.
> > > 
> > > commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length checking")
> > > defers responder length check for UD QPs in function `copy_data`.
> > > But it introduces a regression issue for UD QPs.
> > > 
> > > [...]
> > Applied, thanks!
> > 
> > [1/1] RDMA/rxe: Fix responder length checking for UD request packets
> >        https://git.kernel.org/rdma/rdma/c/05301cb42a5567
> 
> Hi, Leon
> 
> When I built this commit with gcc (Debian 8.3.0-6) 8.3.0, the following
> warnings will pop out.

Thanks, I fixed it in my tree.

> 
> "
> drivers/infiniband/sw/rxe/rxe_resp.c: In function ‘rxe_resp_check_length’:
> drivers/infiniband/sw/rxe/rxe_resp.c:401:3: error: ‘for’ loop initial
> declarations are only allowed in C99 or C11 mode
>    for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>    ^~~
> drivers/infiniband/sw/rxe/rxe_resp.c:401:3: note: use option -std=c99,
> -std=gnu99, -std=c11 or -std=gnu11 to compile your code
> "
> 
> The following diff will fix this problem.
> 
> "
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ad3c7bf76752..6596a85723c9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -345,10 +345,11 @@ static enum resp_states rxe_resp_check_length(struct
> rxe_qp *qp,
>          * length checks are performed in check_rkey.
>          */
>         if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
> -               unsigned int recv_buffer_len = 0;
>                 unsigned int payload = payload_size(pkt);
> +               unsigned int recv_buffer_len = 0;
> +               int i;
> 
> -               for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
> +               for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>                         recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>                 if (payload + 40 > recv_buffer_len) {
>                         rxe_dbg_qp(qp, "The receive buffer is too small for
> this UD packet.\n");
> 
> "
> 
> Zhu Yanjun
> 
> > 
> > Best regards,
> 
> -- 
> Best Regards,
> Yanjun.Zhu
> 

