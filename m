Return-Path: <linux-rdma+bounces-12427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EAAB0F76F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5849A3B080B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB41C1AAA;
	Wed, 23 Jul 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ysV8DPur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mmI8SqH/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ysV8DPur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mmI8SqH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3893BB48
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285771; cv=none; b=WYBhWJWp0C94IOWWeLXHdm3h9fiW4T1dnN34/3MyOWfgWwKJP8PbxOqder0pIypDKfvfFj41iWTiG149hUHAqR38Gt102pRwVymDAF7ic3cIukwdZd3lJ3FLgIbRvnUBOnGxFbHoTiLG+mfGBkgcJ5V06b2BrHb//2aCX92EDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285771; c=relaxed/simple;
	bh=syczCdhMxQyLngZauc2fDgFfMdPMll7Z6Z/FG9UQe4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEAI9EVQlzSMOVefD70cb3JiNWHSa4l5PXvZ0L4u7ad5ZwTsUNb2yJuv65bHBWTskRNpsjisErEam2ezVM6l4B15CV/8p/B71S/hXIEoPC//JoW+m38hLFieDDagWKOlbVNhc4cCuwZ7aJ+ayZoPzB8Ybnbbv582eG0HOphCS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ysV8DPur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mmI8SqH/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ysV8DPur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mmI8SqH/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0C90218EE;
	Wed, 23 Jul 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753285767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBoIe6DOYwbo/ooXZzBNUXT2Ob0AdnhJHRYgqQ0Ppd0=;
	b=ysV8DPurYfiv0QrH6gi+mTpIEKrDb90juAZaWo64TfLZ9KG3oxoV2XIMoAgsm+uN1oimSU
	I8k8LAq7H91w+5AEfH2kY1UUPntZaTupm/7A41WR90NznJz3J2pkE6IWaCPS/bzBr2UrBN
	OtRxSDJXNMnowMhb00b4TfP70HFn9zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753285767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBoIe6DOYwbo/ooXZzBNUXT2Ob0AdnhJHRYgqQ0Ppd0=;
	b=mmI8SqH/z1aA4BQ/COyObuJDZpcluUE3vaOIToK0US1+EbhoKsoBi/1rnORM6VK6IpCZ3y
	rW3NyLPSSiYZMQDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753285767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBoIe6DOYwbo/ooXZzBNUXT2Ob0AdnhJHRYgqQ0Ppd0=;
	b=ysV8DPurYfiv0QrH6gi+mTpIEKrDb90juAZaWo64TfLZ9KG3oxoV2XIMoAgsm+uN1oimSU
	I8k8LAq7H91w+5AEfH2kY1UUPntZaTupm/7A41WR90NznJz3J2pkE6IWaCPS/bzBr2UrBN
	OtRxSDJXNMnowMhb00b4TfP70HFn9zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753285767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBoIe6DOYwbo/ooXZzBNUXT2Ob0AdnhJHRYgqQ0Ppd0=;
	b=mmI8SqH/z1aA4BQ/COyObuJDZpcluUE3vaOIToK0US1+EbhoKsoBi/1rnORM6VK6IpCZ3y
	rW3NyLPSSiYZMQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D8613ABE;
	Wed, 23 Jul 2025 15:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Em5NYYEgWjVSwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 15:49:26 +0000
Date: Wed, 23 Jul 2025 16:49:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
Message-ID: <nwtutmewgtziygnp7drmhdxpenrbxumrjprcz7ls2afwub5lwf@due2djp7llv5>
References: <20250723104123.190518-1-pfalcato@suse.de>
 <DS0SPRMB00679C99808A4D85BAB6DADF995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0SPRMB00679C99808A4D85BAB6DADF995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed, Jul 23, 2025 at 02:52:12PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Pedro Falcato <pfalcato@suse.de>
> > Sent: Wednesday, 23 July 2025 12:41
> > To: Jason Gunthorpe <jgg@ziepe.ca>; Bernard Metzler <BMT@zurich.ibm.com>;
> > Leon Romanovsky <leon@kernel.org>; Vlastimil Babka <vbabka@suse.cz>
> > Cc: Jakub Kicinski <kuba@kernel.org>; David Howells <dhowells@redhat.com>;
> > Tom Talpey <tom@talpey.com>; linux-rdma@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-mm@kvack.org; Pedro Falcato
> > <pfalcato@suse.de>; stable@vger.kernel.org; kernel test robot
> > <oliver.sang@intel.com>
> [snip]
> > ---
> >  drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > index 3a08f57d2211..9576a2b766c4 100644
> > --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > @@ -340,11 +340,11 @@ static int siw_tcp_sendpages(struct socket *s, struct
> > page **page, int offset,
> >  		if (!sendpage_ok(page[i]))
> >  			msg.msg_flags &= ~MSG_SPLICE_PAGES;
> >  		bvec_set_page(&bvec, page[i], bytes, offset);
> > -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> > +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
> > 
> >  try_page_again:
> >  		lock_sock(sk);
> > -		rv = tcp_sendmsg_locked(sk, &msg, size);
> > +		rv = tcp_sendmsg_locked(sk, &msg, bytes);
> >  		release_sock(sk);
> > 
> 
> Pedro, many thanks for catching this! I completely
> missed it during my too sloppy review of that patch.
> It's a serious bug which must be fixed asap.
> BUT, looking closer, I do not see the offset being taken
> into account when retrying a current segment. So,
> resend attempts seem to send old data which are already
> out. Shouldn't the try_page_again: label be above
> bvec_set_page()??

This was raised off-list by Vlastimil - I think it's harmless to bump (but not use)
the offset here, because by reusing the iov_iter we progressively consume the data
(it keeps its own size and offset tracking internally). So the only thing we
need to track is the size we pass to tcp_sendmsg_locked[1].

If desired (and if my logic is correct!) I can send a v2 deleting that bit.


[1] Assuming tcp_sendmsg_locked guarantees it will never consume something out
of the iovec_iter without reporting it as bytes copied, which from a code reading
it seems like it won't...


-- 
Pedro

