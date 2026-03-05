Return-Path: <linux-rdma+bounces-17548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFUvDsW0qWkZCwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 17:52:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C75CB215944
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE94B3013DFF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033963C3BE2;
	Thu,  5 Mar 2026 16:52:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AE334373
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729536; cv=none; b=jTWDl/rykIOPoMqyfDt0Xs7kaP84Y2X9fvCi20flD6Fx2N+WtqBRaLXdY1rrwmhRL31Vk0o9G6FtW7vPCP6HSHtZjpzvepM8ynBNxQ+sdvlh0BYR5F42UrLP7QDlJh/TQ9Zx/nznuEu4BtereBoRwubLVosvQvfpDU/IWVNFUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729536; c=relaxed/simple;
	bh=HpEMJLPbS1e9x7KewcZA9IVC8CDT0ZtOEw27vRfWDOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2z1g/RfTdDwsixUPrqfkm54k/AbXgdcQ8InJZGzwN/iQbNVPaGl1o+9yNIcG6nR4KBdqw4zBQv/ZuHWia0Fypbj3ZuLw/881p7mqJ6f/BwBSgdLMtnqCQCAq5M13+TpxvdiG42k8IgIrmsZt3iFV4jgFdUXYE362gnZuZB/Cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1D199C0D6B;
	Thu,  5 Mar 2026 16:52:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id D550C2F;
	Thu,  5 Mar 2026 16:52:09 +0000 (UTC)
Date: Thu, 5 Mar 2026 11:52:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Huiwen He
 <hehuiwen@kylinos.cn>, Jerome Marchand <jmarchan@redhat.com>, Qing Wang
 <wangqing7171@gmail.com>, Shengming Hu <hu.shengming@zte.com.cn>, Linux-MM
 <linux-mm@kvack.org>, linux-rdma <linux-rdma@vger.kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
Message-ID: <20260305115248.4d972cc7@gandalf.local.home>
In-Reply-To: <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
References: <20260305103941.11f1b27d@gandalf.local.home>
	<CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 916ur3gh9jpexos1z3hb4os1bqqobcq5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DxIVoLQN9GFaheguLVMQZrUVvPMJITzc=
X-HE-Tag: 1772729529-584749
X-HE-Meta: U2FsdGVkX18MbU/JoVVgZNbLoBDmliBGM31YSsjELhjzdBmBN42BiwmaKnYsUaYYjXlryTqwysB16K2eNG0YW+TNHoJBc9Ie/8JCb48qtN69ykGy7jHH5/0pB+yAcEq3PAhQbiv1f2pmgoRFgq5c/6sn1DvNhWVdRTmIL2gd7BbzcVhRDgYjbIghpfKgXw1RqkrfZIfw2bbazYVIq1EI5+7CxgRobihk5en2I2Lp76u+FFVk5u1uR5AG/H2uochhxQ/yE5aPJodeGu6lfPM5DjmZ2qxZTdxHQvnYYGLE/FkuQmMPr6GwoertxbHDuJ5oCqpgQs4/FI5CnLqqZbZ6n5IATw5TBP7Pj0Y2GehtUO2+hcOZF/qIPVIhb7J+zOyvCWxyHfX8PIMssaocfTxepEAEZufPlF8UVe8AjDfg2ZSZcUuK+r0tRI5yczwDDtxLi+RmaXVXMx5s0//FHwjtQA==
X-Rspamd-Queue-Id: C75CB215944
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org,oracle.com];
	TAGGED_FROM(0.00)[bounces-17548-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,goodmis.org:email,linux-foundation.org:email]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 08:44:27 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [ Adding linux-mm and the rdma people ]
> 
> On Thu, 5 Mar 2026 at 07:39, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Fix accounting of the memory mapped ring buffer on fork
> >
> >   Memory mapping the ftrace ring buffer sets the vm_flags to DONTCOPY. But
> >   this does not prevent the application from calling madvise(MADVISE_DOFORK).  
> 
> I wonder how many other things have this assumption.
> 
> Now, many (most?) of the VM_DONTCOPY users set VM_IO too, because the
> most common reason they don't want to be copied is that it's a special
> mapping.
> 
> And then madvise() does nothing.
> 
> But I also get the feeling that the whole *reason* for MADV_DOFORK
> existing in the first place simply doesn't exist any more.
> 
> It was added two decades ago when as a hack for the rdma people who
> wanted to mix fork (with COW) and concurrent DMA, which just didn't
> work reliably because the COW would break either way.
> 
> See commit f822566165dd ("[PATCH] madvise MADV_DONTFORK/MADV_DOFORK").
> 
> And that should just not be an issue any more thanks to how it's now
> done with page pinning rather than with the old GUP interfaces.
> 
> So while I've pulled the tracing fix, I get the feeling that people
> should at least think about just making MADV_{DO,DONT}FORK go away.
> 
> Now, Debian code search does show some users (libfabric, libibverbs),
> and maybe they actually want the forking behavior for other reasons
> too.
> 
> But I get the feeling that maybe we should at least limit MADV_DOFORK
> only to the case where the *source* of the DONTFORK was the user, not
> some kernel mapping.

Right, I was a bit confused when I saw this too. I asked the memory folks
about adding the VM_IO, and Lorenzo suggested against it. You can read the
discussion here:

   https://lore.kernel.org/all/e4deff21-2fb5-4f37-a7d3-ede5f69a4489@lucifer.local/

-- Steve

