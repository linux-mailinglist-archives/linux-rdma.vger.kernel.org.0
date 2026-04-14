Return-Path: <linux-rdma+bounces-19330-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLb0EL8H3mlRmQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19330-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:24:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6233F7DA0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF9323008C8E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC02A3B4EBD;
	Tue, 14 Apr 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToZwh81i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1323A3E72
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158649; cv=none; b=BCgGhE9mW3mcCTGOG7asuYYbhrm2MQV/EbC0i7KepZ2WwoPBsZIA96d8K/pYFyhIXF0OJfFGZrZDmYiv3UcPbQlT4cgc/SsT9LtZd4f9+pQ7p+Ry3L9DLgfomoOvFmMQrnB6ij8IHf8N7icfwelli59XLtO6mr/Zu0Qrshb3nwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158649; c=relaxed/simple;
	bh=fiJ6/ZwS3tugj8OSsXIlst25mbMPsWsebDWCFH5gu/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI5kOxrx8iigvGgqzeBOwqp4odlpTNyZlEbpl74YQYwne+t4/kBOWdX3yTJIWPxNLNYdlrNYF0oI3yGK41l347UJEsQwrOGkGFhtDHOjD4MCznv69fXD8XzcQHIVt7IdeyJYHJ9s3c+5Ipq35Cv0ANexwNwVw4Fn+Ma6XoeJ4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToZwh81i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893E0C19425;
	Tue, 14 Apr 2026 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158649;
	bh=fiJ6/ZwS3tugj8OSsXIlst25mbMPsWsebDWCFH5gu/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToZwh81iK2CUOVtKou4XBtJGu1KBqRzmRyTv6kiGbPqjmN+m5blNzyyfUiXDS7WXt
	 fDDvDrBYmuYo+rO6thPW9+5r8iK8HdPy8iVCGYJrMvrIhdiebIKqKlonURFg5zqmCo
	 L7gVHe2DkzoHNLclKobYSVrd4r+PbAd8BmeMQDhiwA2xkQlTD9DcIoEW3w/BMd9fN3
	 ehiJQnQTSncc0UtVRZ9peKak/G0jlhKWcbdTdj4461hFHG5pbsBizpsMKeFfarK2JO
	 pcgtzzjSnW+5twga/zmo/f2ul0b5h5l2zqPDNPrY1KzzjODtFvbUxc6M27Ma6CJaiV
	 JlhvG3zbWzuSw==
Date: Tue, 14 Apr 2026 12:24:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Korb, Andreas" <andreas.korb@aisec.fraunhofer.de>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
Message-ID: <20260414092404.GU21470@unreal>
References: <BE1P281MB24351AAE7EF6E96BFC08D5C9CA5AA@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260412140401.GC21470@unreal>
 <BE1P281MB24354B8B12B48B807C4453E5CA242@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260413160227.GM21470@unreal>
 <BE1P281MB24357992741C16BFEF1E33B3CA252@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB24357992741C16BFEF1E33B3CA252@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19330-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fraunhofer.de:email]
X-Rspamd-Queue-Id: 3D6233F7DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:37:38AM +0000, Korb, Andreas wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Montag, 13. April 2026 18:02
> > To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> > Cc: linux-rdma@vger.kernel.org
> > Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
> > 
> > On Mon, Apr 13, 2026 at 06:54:32AM +0000, Korb, Andreas wrote:
> > > > -----Original Message-----
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Sonntag, 12. April 2026 16:04
> > > > To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
> > > >
> > > > On Tue, Apr 07, 2026 at 01:14:45PM +0000, Korb, Andreas wrote:
> > > > > The function `ds_init_ep` in librdmacm/rsocket.c may access memory via an object that is not allocated for this object.
> > > > >
> > > > > Relevant lines from this function:
> > > > >
> > > > > // (1): Prepare `struct rsocket`
> > > > > ds_set_qp_size(rs);
> > > > > // (2): Allocation
> > > > > rs->sbuf = calloc(rs->sq_size, RS_SNDLOWAT);
> > > > > // (3): Copy pointer to rs->smsg_free
> > > > > rs->smsg_free = (struct ds_smsg *) rs->sbuf;
> > > > > // (4): Copy pointer to msg
> > > > > msg = rs->smsg_free;
> > > > > // (5): Write to msg->next
> > > > > msg->next = NULL;
> > > > >
> > > > > Within my podman container:
> > > > > Before (1): rs->sq_size = rs->rq_size = 384
> > > > > After (1): rs->sq_size = rs->rq_size = 0
> > > > > Therefore, (2) does not reserve a buffer, but still returns a pointer which can be freed later, as described by man-page calloc(3p).
> > > > > (5) writes data to the buffer allocated in (2). If no actual buffer is allocated, it overwrites arbitrary data, yielding undefined
> > > > > behavior.
> > > > >
> > > > > I found it by executing /usr/bin/udpong (without any arguments) with libscudo on an arm64 server with memory tagging enabled.
> > It
> > > > > immediately crashes with a segmentation fault, then. Without memory tagging, the bug stays undetected, and execution
> > continues.
> > > > > The code behavior described above also happens on x86-64, there it doesn't result in a crash and is silently ignored because of
> > the
> > > > > lack of MemoryTagging. Valgrind also detects this violation, however.
> > > > >
> > > > > In summary:
> > > > > The libc man-page states that if the allocated buffer size is 0, then either:
> > > > > >        *  A null pointer shall be returned and errno may be set to an
> > > > > >        implementation-defined value, or
> > > > > >        *  A pointer to the allocated space shall be returned. The
> > > > > >        application shall ensure that the pointer is not used to
> > > > > >        access an object.
> > > >
> > > > Can you please provide a link to these sentences in the manual?
> > > >
> > > > You provided invalid value as sq_size and rq_size. It is expected that
> > > > library won't work after that.
> > > >
> > > > Thanks
> > >
> > > These sentences are from: https://man7.org/linux/man-pages/man3/calloc.3p.html
> > >
> > > When the incoming values of sq_size and rq_size are wrong, that is a
> > > bug in udpong then. However, since librdmacm is doing the calloc allocation,
> > > it should still refrain from undefined behavior with the own allocated buffer.
> > 
> > I don't think so. This buffer is allocated in application memory, and if
> > the application is buggy, that is its problem, not the library's.
> > 
> > Thanks
> 
> Maybe we're not talking about the same thing. I'm specifically talking about this line of code:
> https://github.com/linux-rdma/rdma-core/blob/de593a02932a5ee7c729bd92df90e1fe8892b584/librdmacm/rsocket.c#L1169
> 
> Here, the buffer is allocated within the library, and the violating access happens in the same function in line 1186.
> Both appear to me to be part of librdmacm. However, I'm not that familiar about this entire system.

Yes, we are talking about the same. "rs" is allocated in the user context. It will crash user-application
and not whole librdmacm library.

Thanks

> 
> Thanks

