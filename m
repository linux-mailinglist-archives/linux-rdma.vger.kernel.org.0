Return-Path: <linux-rdma+bounces-18560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HlTOdFCwmmCagQAu9opvQ
	(envelope-from <linux-rdma+bounces-18560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:52:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D82304304
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 849ED3025F0E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B1359A7C;
	Tue, 24 Mar 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jor5KZWO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC6358376;
	Tue, 24 Mar 2026 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338668; cv=none; b=RJo9jsxw/0kyBlnc7ZLicAyRzZnzP5MEstf6k1va/XW5MQE+S56Kt+19iogEjeU7ZQR/N5Z8JOOrH8seOoFEB6zb1l9iXyUR1u6NLZdi6IrATmEGYe0W2YMeHjlX9OXQa9QToCvdD+cyPAY/z4B1xEeifHB40xfxJjBX5NlHr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338668; c=relaxed/simple;
	bh=Jo/Yum7PMW8GvXdAg8nZGjGVKaMIowJwRdP4CkIARvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNmO/JLXoX7iOx0uh0eRC1ZelKyXoeH6+bvwUgwt4j45Qh/hXCucDBp7xxEkHy7WS1GllpF8tBYgi6viW3r2ZFizUO58bMxnl/qkFI229KMxJknEGlFdV137wqQOCnY6kh/J+po7nS3qdMrVj3DUeTmKzjK3+cwBM8msR1Y8twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jor5KZWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D2CC19424;
	Tue, 24 Mar 2026 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338668;
	bh=Jo/Yum7PMW8GvXdAg8nZGjGVKaMIowJwRdP4CkIARvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jor5KZWOVBXgwUHsBET+opMSWlYbgzMWmWY5zzx7VUfiIwnEqrF3mSbAHsyK7ODfG
	 Qfyg3dQVlpvXQ1aTnwcVi6ZyMJ1mk/JtIeAXEBu0GFv64AHbDVpzU7V9VDIHXFLAVr
	 eXIdJsMmNtFxOyPPCq0pfx6ilJjmUh0O0mSLv87Uvr/utE5yDXGRkMT/GS7LCIxtVW
	 VGVVeAmAUf92+M3iU7BJ5gIvPnievNUSrT54DroDv/BCNKxXZ2O/dj1VYRJEDbLnk9
	 FIKG4fbe3zUu5d1ddJfLu2/k9jySZTZ+DZbjhuLxfzvP8y24uiya2DxAbjPmwPE5Dm
	 fQ1bwG0ADLqng==
Date: Tue, 24 Mar 2026 09:51:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ingo Molnar <mingo@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Message-ID: <20260324075102.GL814676@unreal>
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
 <20260323110144.GG814676@unreal>
 <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
 <4b177986-dc77-4d0a-95a9-329ef62c1c94@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b177986-dc77-4d0a-95a9-329ef62c1c94@app.fastmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18560-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cornelisnetworks.com,kernel.org,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2D82304304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 08:27:45AM +0100, Arnd Bergmann wrote:
> On Mon, Mar 23, 2026, at 22:47, Dennis Dalessandro wrote:
> > On 3/23/26 7:01 AM, Leon Romanovsky wrote:
> >> On Mon, Mar 23, 2026 at 09:48:59AM +0100, Arnd Bergmann wrote:
> >>> - The use of INFINIBAND_RDMAVT seems unnecessary: right now
> >>>    this is only used by hfi1, now shared with hfi2 but later to
> >>>    be exclusive to the latter. Since it is unlikely to ever
> >>>    be used by another driver again, this may be a good time
> >>>    to drop the abstraction again and integrate it all into
> >>>    hfi2, with the old version getting dropped along with hfi1.
> >> 
> >> The best approach is to drop rdmavt as well, since hfi2 is expected to
> >> align with the other drivers in drivers/infiniband/hw.
> >> 
> >> Dennis, is this feasible?
> >
> > Feasible yes. I'd like to get hfi2 crossed off the list and in the tree 
> > first though. Then come back and do that. I'd like to do more than just 
> > plop rdmavt inside hfi2 and call it a day. There is a lot of code 
> > cleanup/simplification that we can do.
> 
> Does rdmavt have its own user-space ABI? If there is anything that
> you'd want to change, this might be the one chance to do it, otherwise
> I see nothing wrong with integrating it only after hfi1 is gone.

rdmavt has no user‑space exposure. It is a leftover from an old and never
fully realized idea to provide a shim and common layer for RDMA drivers
that require software handling in their data path.

Thanks

> 
>       Arnd

