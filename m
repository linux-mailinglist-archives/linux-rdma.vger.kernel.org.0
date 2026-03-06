Return-Path: <linux-rdma+bounces-17583-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Pl+fGmOuqmmLVQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17583-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 11:37:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66221EE0D
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC405301A90A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D82874FB;
	Fri,  6 Mar 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUnODltq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14082494FF
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793196; cv=none; b=Z0rP2zyWHX4ucIcdONHZnbox0HiuP41cm3G3oIseH16y38N5RWXUT7oxyFOHE1IgIaPbPnIwXiVbehmzFja2m1Vf35YY6Nnn0dFVlBbzpHTF55Hpx1bLaGKhTbEIo6IMa/d/qXXdKH/LmyeBdH7JQf5YgPQ8sd7ZZL9xBtXeCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793196; c=relaxed/simple;
	bh=SHIko/MmFubMGiBXHMMBbPxNbS9V12LxaQpzaOqctRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkREbBgVu9wlfalWnwj1SJn/NN3atk6+FoBBYryndelN9CxscSHVAf825fmBOCmo+VoivBvFpFpQdIeNRXlrSrzSgV927i69zbxgAYVOs5d/cyL8KtCs6vAqTxc2N/6vNfH9We0SfzfaoTZvVC9r12yqajnS/SfCYD8W6u5xA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUnODltq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79A2C4CEF7;
	Fri,  6 Mar 2026 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772793196;
	bh=SHIko/MmFubMGiBXHMMBbPxNbS9V12LxaQpzaOqctRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUnODltqfoLqHqMxgnCTP5Zlv86+in4QAeMF60Xg6MWJ3M1qEzUHqE82gOGpRiJOX
	 xwV7AVfcai17eWdMo2zUMFmyCFheOTCrkqCauQWW+8znWaJNdMt5VMkf3hCSkfv1+I
	 yj1zRWdwSDH/FPO5NayBXERQrPz2suZfkYUZu3HtwLWHnj3lY7icOPB067AzjGRrd+
	 lTEWVTnP9BA4tQ49BvPVwOXGAH8opdwqsTUduiFASs+Q443bxNTHc+Va9X0DTZHYfR
	 W58IDEtPvgkGuj5EB72FVXwaFKd2nykHwwCi8+tuIHMIlW5cxfQl0r9RZSjs0W0E5z
	 +ocDjp0HBi9RQ==
Date: Fri, 6 Mar 2026 10:33:12 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Huiwen He <hehuiwen@kylinos.cn>, 
	Jerome Marchand <jmarchan@redhat.com>, Qing Wang <wangqing7171@gmail.com>, 
	Shengming Hu <hu.shengming@zte.com.cn>, Linux-MM <linux-mm@kvack.org>, 
	linux-rdma <linux-rdma@vger.kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
Message-ID: <8f60e23e-dd52-45df-89e6-bcc256ad704d@lucifer.local>
References: <20260305103941.11f1b27d@gandalf.local.home>
 <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
 <a8907468-d7e9-4727-af28-66d905093230@kernel.org>
 <CAHk-=whW890h4m8r0iYwXEJK=MUJx9nLxuOduttRJNCLrMdz7A@mail.gmail.com>
 <a21ea7c3-fbdb-4ac7-8be5-0173f54890c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21ea7c3-fbdb-4ac7-8be5-0173f54890c7@kernel.org>
X-Rspamd-Queue-Id: DD66221EE0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17583-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,ziepe.ca,kernel.org,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 07:59:14PM +0100, David Hildenbrand (Arm) wrote:
> On 3/5/26 18:17, Linus Torvalds wrote:
> > On Thu, 5 Mar 2026 at 09:00, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >>
> >> QEMU traditionally sets MADV_DONTFORK on guest RAM. One reason is to
> >> speed up fork(), because it doesn't need all the guest RAM in fork'ed
> >> child processes.
> >
> > Yes, I think the MADV_DONTFORK thing makes sense on its own - more so
> > than MADV_DOFORK does.
> >
> > Because it's a very valid thing for user space to do exactly for that
> > "speed up fork()" case.
> >
> > It's similar to how we also export a MADV_WIPEONFORK - for a different
> > use-case, where we don't want the copying behavior (typically because
> > we want the child to re-create its own set of data: I thin the main
> > reason tends to be for things like reseeding random number generation
> > after fork etc).
> >
> > So it's just MADV_DOFORK I don't particularly like, because it had
> > pre-existing kernel semantics (the VM_DONTCOPY bit predates the MADV_*
> > bits by many many years).
> >
> > Not copying on fork is always safe. But copying something that the
> > kernel has said "don't copy" just sounds *wrong*.
> >
> >>> But I get the feeling that maybe we should at least limit MADV_DOFORK
> >>> only to the case where the *source* of the DONTFORK was the user, not
> >>> some kernel mapping.
> >>
> >> ... that makes sense. Forbid toggling it on something that has
> >> VM_SPECIAL set, maybe.

Yes, I agree. It's odd that we explicitly gate on VM_IO there, it's unusual.

>
> CCing Lorenzo.
>
> >
> > Yeah, I think VM_SPECIAL would be a better match than just checking
> > VM_IO.  At least it would also catch things like that VM_DONTEXPAND,
> > and PFN mappings.

Some of the madvise() operations explicitly work with PFN mappings, but it
really makes no sense to fiddle with them in this case.

> >
> > So just changing the existing VM_IO test to cover all the VM_SPECIAL
> > bits would be a simple improvement.
>
> Ack.


Feel free to add:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

To a patch that simply does something like:

diff --git a/mm/madvise.c b/mm/madvise.c
index c0370d9b4e23..dbb69400786d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1389,7 +1389,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 		new_flags |= VM_DONTCOPY;
 		break;
 	case MADV_DOFORK:
-		if (new_flags & VM_IO)
+		if (new_flags & VM_SPECIAL)
 			return -EINVAL;
 		new_flags &= ~VM_DONTCOPY;
 		break;
--
2.53.0

That makes me wonder about whether we want to permit VM_DONTFORK for
MADV_DONTFORK, it's kinda a weird usecase but anyway this is the safer
change for now as I think it's pretty obviously sane.

>
> >
> > Maybe I should just do that and see if anybody even notices (and
> > revert and re-think if somebody does)
>
> Agreed. We could think about letting it sit a bit in -next before moving
> it to mainline.

I would eat my hat, board a flying pig and note the sound of several trees
falling when there's nobody around if anybody complained :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

