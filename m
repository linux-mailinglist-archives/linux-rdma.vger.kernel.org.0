Return-Path: <linux-rdma+bounces-19296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INO1LjIV3WkOZQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:09:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FD3EE5EB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D90B300D87C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED723EA94;
	Mon, 13 Apr 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR6Ae6s1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C41D6DB5
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096152; cv=none; b=OkIIrUW/dCQjBtTUExsf8IFW3VW2Sy57fCTKaRmb2xCkQpvXQZQSY+l0F3Q5If2BIQb3TbOG2pctdp8GlX2F3sqgG0N4MEsUQGGodwuwvxKyAeG2GGeNwqabtgaybOXRx280cW+17sr14prx+UT1KQoIs1t1irM5H1qSx5qGwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096152; c=relaxed/simple;
	bh=c6JpOMffdkSGrkgzCuBpN3ufVfDBHC7InMwr+fJfRH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmAmic9+7/AA/53oPjcYxDh72juKd7l+NIH0zlhrgRWnBP73ci2eZrJf9zGLcyQNbnp3m2aEpt60SXbXlOxnzVFUC9p8xCa+k7LmtO4+uNvUeOYU2ntPRRdScnlF4WEH0wZ/th3JrdcBJQ+dpuDN0YmeZHdOMY2bMR6U1CPk3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR6Ae6s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C99C2BCAF;
	Mon, 13 Apr 2026 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776096152;
	bh=c6JpOMffdkSGrkgzCuBpN3ufVfDBHC7InMwr+fJfRH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR6Ae6s1mDiLOB6hfhHvGbmC64L0gWGc3Ubmcy7ZILDh4G/f6do+FTYl/I8zy+YWX
	 /BkAlAJT79mJrRiMmmVCXftBbHjH0DT8cznCLreaaM50J/4O+OOVS0aRXH3fkPdoNd
	 7a09RR2dtYk0eJ3qhHQ/62DrBEYgJ450EyXp7pd1uj4YOYCsMaZ5PwZIK2Dyji131D
	 R/2EifaLie2fZnWnW0uFAbc9hjASlPCJIp7K5K+o1Ft0Xw9TfXhLrZpADZuGt5Unlw
	 RMv/aae3dVtL2J4G0WdJulEDFa8nKIwbUL2SEfeyVQcgfGORbIUOwcITJ9ugQ1lRYV
	 2Jzn1mE/NKJ0Q==
Date: Mon, 13 Apr 2026 19:02:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Korb, Andreas" <andreas.korb@aisec.fraunhofer.de>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
Message-ID: <20260413160227.GM21470@unreal>
References: <BE1P281MB24351AAE7EF6E96BFC08D5C9CA5AA@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260412140401.GC21470@unreal>
 <BE1P281MB24354B8B12B48B807C4453E5CA242@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB24354B8B12B48B807C4453E5CA242@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19296-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fraunhofer.de:email,man7.org:url]
X-Rspamd-Queue-Id: 295FD3EE5EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 06:54:32AM +0000, Korb, Andreas wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Sonntag, 12. April 2026 16:04
> > To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> > Cc: linux-rdma@vger.kernel.org
> > Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
> > 
> > On Tue, Apr 07, 2026 at 01:14:45PM +0000, Korb, Andreas wrote:
> > > The function `ds_init_ep` in librdmacm/rsocket.c may access memory via an object that is not allocated for this object.
> > >
> > > Relevant lines from this function:
> > >
> > > // (1): Prepare `struct rsocket`
> > > ds_set_qp_size(rs);
> > > // (2): Allocation
> > > rs->sbuf = calloc(rs->sq_size, RS_SNDLOWAT);
> > > // (3): Copy pointer to rs->smsg_free
> > > rs->smsg_free = (struct ds_smsg *) rs->sbuf;
> > > // (4): Copy pointer to msg
> > > msg = rs->smsg_free;
> > > // (5): Write to msg->next
> > > msg->next = NULL;
> > >
> > > Within my podman container:
> > > Before (1): rs->sq_size = rs->rq_size = 384
> > > After (1): rs->sq_size = rs->rq_size = 0
> > > Therefore, (2) does not reserve a buffer, but still returns a pointer which can be freed later, as described by man-page calloc(3p).
> > > (5) writes data to the buffer allocated in (2). If no actual buffer is allocated, it overwrites arbitrary data, yielding undefined
> > > behavior.
> > >
> > > I found it by executing /usr/bin/udpong (without any arguments) with libscudo on an arm64 server with memory tagging enabled. It
> > > immediately crashes with a segmentation fault, then. Without memory tagging, the bug stays undetected, and execution continues.
> > > The code behavior described above also happens on x86-64, there it doesn't result in a crash and is silently ignored because of the
> > > lack of MemoryTagging. Valgrind also detects this violation, however.
> > >
> > > In summary:
> > > The libc man-page states that if the allocated buffer size is 0, then either:
> > > >        *  A null pointer shall be returned and errno may be set to an
> > > >        implementation-defined value, or
> > > >        *  A pointer to the allocated space shall be returned. The
> > > >        application shall ensure that the pointer is not used to
> > > >        access an object.
> > 
> > Can you please provide a link to these sentences in the manual?
> > 
> > You provided invalid value as sq_size and rq_size. It is expected that
> > library won't work after that.
> > 
> > Thanks
> 
> These sentences are from: https://man7.org/linux/man-pages/man3/calloc.3p.html
> 
> When the incoming values of sq_size and rq_size are wrong, that is a
> bug in udpong then. However, since librdmacm is doing the calloc allocation,
> it should still refrain from undefined behavior with the own allocated buffer.

I don't think so. This buffer is allocated in application memory, and if  
the application is buggy, that is its problem, not the library's.

Thanks

