Return-Path: <linux-rdma+bounces-19328-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM/1KPQD3mkQmQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19328-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:08:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4D3F7A8F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62005300E6A1
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDA344DA2;
	Tue, 14 Apr 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUBd5FTL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538A1A23A4
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157679; cv=none; b=hROsFXhuUbOLS63xsrj0i7t5SNUCiGgKMdZhl/fyc6VST6q8mSI1Ht6EAbnFiELxlhjqjEifG9ZRiYczErUc+FJU1YyTcyd073okk9Q6OGpYNiA8QAK9Yem4hFwD4+otjPGl25gFKlIgYixO3S3jALA82guLh+OqhRFoAokk1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157679; c=relaxed/simple;
	bh=74ny5oLd3SfWNFXDj9N75p51Z9YkhNCZX5SF0rBXvKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+GoklCDX5aSuR8NicW3Nexln+xL6P3WIsuKzxZaldRkhT0aCE/XqprpJI0pk+3/ipdZR7/tFcTXxiLYJrvGNON1TYp8Ee/XO5qw326exwJkQ1rh+csS5HqnMwGL/caSZupRTomUPQDQYJgfxOvuh4KRNASYatpHwBuMqqV+2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUBd5FTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA0EC19425;
	Tue, 14 Apr 2026 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776157678;
	bh=74ny5oLd3SfWNFXDj9N75p51Z9YkhNCZX5SF0rBXvKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUBd5FTLaIWvKoIXZ50bD7hkawIA8Yh3DKcgCeE+I+cYN32uyg5o7BigLUR9pXFrT
	 pM2MuzpHfakgje7tpzRAns6c33wdto2+UpIkRRru04C+ZWjGi8sgUOHJ584zU3AVM3
	 BNem/+bhv70NQ1eu1arCau+IOs6PCkrBkI4SOzBmr6jWr2bRT06xo6A19+3RBFdbL/
	 D22NrDgqh7WguSgNMKCSjcxcl0BP+UWuCFAo1AZzeHUkprIiIQIzqvaZop1fl2HyGG
	 5a3ksFfFeBzYjN06xflZIAabxQ5wrJDeOWtcc58XQxFxsUTOcjHHKQva4HtSqCpojs
	 yE9o9oXUr4iZA==
Date: Tue, 14 Apr 2026 12:07:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, security@kernel.org,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	hkbinbin <hkbinbinbin@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Reject unknown opcodes before ICRC processing
Message-ID: <20260414090753.GS21470@unreal>
References: <20260414011725.1615286-1-michael.bommarito@gmail.com>
 <e71fe83d-3e15-4bf2-89bf-4e0e42cbe2b5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e71fe83d-3e15-4bf2-89bf-4e0e42cbe2b5@linux.dev>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19328-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE4D3F7A8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:23:55PM -0700, Zhu Yanjun wrote:
> 
> 在 2026/4/13 18:17, Michael Bommarito 写道:
> > Even after applying commit 7244491dab34 ("RDMA/rxe: Validate pad and ICRC
> > before payload_size() in rxe_rcv"), a single unauthenticated UDP packet
> > can still trigger panic.  That patch handled payload_size() underflow
> > only for valid opcodes with short packets, not for packets carrying an
> > unknown opcode.  The unknown-opcode OOB read described below
> > predates that commit and reaches back to the initial Soft RoCE driver.
> > 
> > The check added there reads
> > 
> >      pkt->paylen < header_size(pkt) + bth_pad(pkt) + RXE_ICRC_SIZE
> > 
> > where header_size(pkt) expands to rxe_opcode[pkt->opcode].length.  The
> > rxe_opcode[] array has 256 entries but is only populated for defined IB
> > opcodes; any other entry (for example opcode 0xff) is zero-initialized,
> > so length == 0 and the check degenerates to
> > 
> >      pkt->paylen < 0 + bth_pad(pkt) + RXE_ICRC_SIZE
> > 
> > which does not constrain pkt->paylen enough.  rxe_icrc_hdr() then
> > computes
> > 
> >      rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES
> > 
> > which underflows when length == 0 and passes a huge value to
> > rxe_crc32(), causing an out-of-bounds read of the skb payload.
> > 
> > Reproduced on v7.0-rc7 with that fix applied, QEMU/KVM with
> > CONFIG_RDMA_RXE=y and CONFIG_KASAN=y, after
> > 
> >      rdma link add rxe0 type rxe netdev eth0
> > 
> > A single 48-byte UDP packet to port 4791 with BTH opcode=0xff and
> > QPN=IB_MULTICAST_QPN triggers:
> > 
> >      BUG: KASAN: slab-out-of-bounds in crc32_le+0x115/0x170
> >      Read of size 1 at addr ...
> >      The buggy address is located 0 bytes to the right of
> >       allocated 704-byte region
> >      Call Trace:
> >       crc32_le+0x115/0x170
> >       rxe_icrc_hdr.isra.0+0x226/0x300
> >       rxe_icrc_check+0x13f/0x3a0
> >       rxe_rcv+0x6e1/0x16e0
> >       rxe_udp_encap_recv+0x20a/0x320
> >       udp_queue_rcv_one_skb+0x7ed/0x12c0
> > 
> > Subsequent packets with the same shape fault on unmapped memory and
> > panic the kernel.  The trigger requires only module load and
> > "rdma link add"; no QP, no connection, and no authentication.
> > 
> > Fix this by rejecting packets whose opcode has no rxe_opcode[] entry,
> > detected via the zero mask, before any length arithmetic runs.
> > 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Cc:stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Michael Bommarito<michael.bommarito@gmail.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_recv.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> > index f79214738c2b..413e1e954ce0 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> > @@ -330,6 +330,15 @@ void rxe_rcv(struct sk_buff *skb)
> >   	pkt->qp = NULL;
> >   	pkt->mask |= rxe_opcode[pkt->opcode].mask;
> > +	/*
> > +	 * Unknown opcodes have a zeroed rxe_opcode[] entry (mask == 0 and
> > +	 * length == 0).  Reject them before any length math: rxe_icrc_hdr()
> > +	 * would otherwise compute length - RXE_BTH_BYTES and pass the
> > +	 * underflowed value to rxe_crc32(), producing an out-of-bounds read.
> > +	 */
> > +	if (unlikely(rxe_opcode[pkt->opcode].mask == 0))
> 
> Add rdma maillist.
> 
> if (unlikely(!rxe_opcode[pkt->opcode].mask &&
> !rxe_opcode[pkt->opcode].length))
> 
> I am not sure if "rxe_opcode[pkt->opcode].length == 0" should also be taken
> into account.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

We need patch to be sent to the ML, so we can merge it.

Thanks

> 
> Zhu Yanjun
> 
> > +		goto drop;
> > +
> >   	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
> >   		       RXE_ICRC_SIZE))
> >   		goto drop;
> 
> -- 
> Best Regards,
> Yanjun.Zhu

