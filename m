Return-Path: <linux-rdma+bounces-18182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDf7C2ETuGk7YwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 15:27:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4829B55C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 15:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0CA300853E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131A27BF79;
	Mon, 16 Mar 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDW7PZos"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259532798ED
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671262; cv=none; b=Wlb3NtmJnB7kTArDnh2OLh+IisYSZMOU7+l2W3JJwccYU/3diMJi3QKKSpJ0t6Fs7uwCwB+fEzESjZLPd1CInDgz3OIUKXJJMa/b831wwVj0EXQKbgGYt380TtsrErWSc5+e4qLVnCLSNb4v9cRjz4d0EUlvADwgqyiVhH3DDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671262; c=relaxed/simple;
	bh=/NCT4N6e1sp+f7T5xJx4o+pZm0SJg8oWbphgWi/vD6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEOY7IzWIMpxqRVfs5yBZKrgUxDnp1IGGmTHOoRUBTcbRHQe8Sf4v9BqvQkp9L/Aha7AO2Ab6TS8kuehPTo5+QCr0z74+lIyXeuyHbtqoo+/XcpLUBjWNOG3npnNDL7SKD1pe7RmToI3CwwsdbNDHMxFSQKMmaTLb0ltLtwbp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDW7PZos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB18C19421;
	Mon, 16 Mar 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773671261;
	bh=/NCT4N6e1sp+f7T5xJx4o+pZm0SJg8oWbphgWi/vD6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDW7PZosJvgsfFKAvJhTOid5mLVKstKq6l1t4jMjl+/6/LozDyKY4M6BVmX34Jki8
	 XoqVYaOniPlx71l9ZZOlIrHI1urC64vXpXSWdiJoXq0i8Eoez5K4n1MBHXsyLfBdSZ
	 kC+iD1Nt5TiKgGJ3VWVHhgl5GOo9gJVo7k4aLL4aQgj3MFuf7tGVeyPlvwuMP7aGMR
	 9bbaO6a07xJqejyE5p4SkstUnMBUjs/5g2bxWFrPqm6mXqcnJbYZLkrhp5T6PgP8i3
	 F4A08g70+QBZ6055gkoGDez5yQ/InOrtJeZhveZt5DQOtJXoP9DCfUvnfv/IAnktiT
	 HYTiKDdYLy/VQ==
Date: Mon, 16 Mar 2026 16:27:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
Message-ID: <20260316142738.GB61385@unreal>
References: <177325043749.53056.7110333022279342594.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325043749.53056.7110333022279342594.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18182-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96D4829B55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:33:57PM -0400, Dennis Dalessandro wrote:
> hfi1 driver is being replaced eventually with an hfi2 driver. Until that
> happens rather than have all the duplicated code in header files, make hfi1
> use hfi2 variants where it can. When compatibility breaks we'll keep a
> separate hfi1 version.
> 
> This is the case for the <dev>_status struture. The hfi1 varaint is single
> port and uses a freezemsg char array while the new hfi2 chip provides
> multiple ports and thus needs and array of ports.
> 
> Likewise the tid info struct is expanded for hfi2 so we include both an
> hfi1 and hfi2 vaiant.
> 
> There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
> renamed to remove the 1 from the function name to keep the code readable
> but allow it to compile due to the #define in hfi1_ioctl.h.
> 
> The big departure from hfi1 is that we are no longer supporting access from
> users through a private character device. Instead we define two custom
> verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
> IOCTLs. We have added an additional method to get stats related to page
> pinning done by the driver.
> 
> The reason we are not removing the hfi1_ioctl.h and hfi1_user.h header
> files is user application compatibility. User apps depend on having these
> files available. Once user apps have converted and hfi1 is removed these
> files will be deleted as well.

What are the applications that use include/uapi/rdma/hfi/hfi1_* directly?
I have hard time to find any application on github which includes them.

Thanks

