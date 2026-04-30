Return-Path: <linux-rdma+bounces-19770-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWGHsHD8mkjuAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19770-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:51:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42549C8FC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A841430A3D0B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB9330676;
	Thu, 30 Apr 2026 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeiRhIJ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39532E73E;
	Thu, 30 Apr 2026 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517288; cv=none; b=OGWEG2q0ZkKnMTl1OmGuMBj4lNt4kFGF3IgpBrzWxXl1OHw9stCVV3Okso6c6+gQwehEuzjll7EULUYdCRVsqASnokM7687COdsK8ZW1GZMSrN3Xpd8r8cch6HxxWfmZZx3qjrajUr7fDRDCBoHOaQ2LJL9GpemsyRMf1zJXLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517288; c=relaxed/simple;
	bh=9EWgWOwUQP4dy4iHDSI1Tz91C4RbKMQbBcNeW+9fQk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtKGLWzFkPSCLo3tOFjh1wrYcL8GBb6lDLHLC+haIBaxdyY91KAuplTfmyrUlpaRCAgV+e4VelmcrW1Ig2eB5PpuLkQB5t+OQCdjDwZzf6xpwc13IWec60MZ0ZZsdqrwXTHmx3ixu/mIrD5ZadocQ7jytT7222u9TFG/K+x3gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeiRhIJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D05C19425;
	Thu, 30 Apr 2026 02:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777517287;
	bh=9EWgWOwUQP4dy4iHDSI1Tz91C4RbKMQbBcNeW+9fQk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WeiRhIJ8nX8FC7OsaCYYzUXUbH/kV1iLJgfOglrFHDgcvRBNomqsi4bLU0Vlw9wU+
	 Af9Bkxt7FLXS1SlYfHUCNBlkuLSdFWv3SYzRIMIxK8frCRJK/NWSBbxboj2gUXzXWP
	 xP/KuIc9aHkz1FLeK+gPCiXmV2Rdql59ynChdT0H1lt6FldXUZuwsgWnk2aJ6SZ0Vz
	 BcxVdZi6t5uzzT2RL2565XW4Jrv8tXlTtLnAEpl7HrOODxoEoZ2fIHO8O97UZPRsJz
	 EPxrI6Xf3xcPTNexPrvFH2Ee7pqDMoU4cpJrkuzsqNeMiZGW9n9T0MIsmlvWhNzApv
	 r5m0rMkSIQZYQ==
Date: Wed, 29 Apr 2026 19:48:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next v2 5/7] selftests: rds: Fix gcov and pcap
 collection
Message-ID: <20260429194806.6ae176a9@kernel.org>
In-Reply-To: <20260430024206.2452353-1-kuba@kernel.org>
References: <20260428222716.2960871-6-achender@kernel.org>
	<20260430024206.2452353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2A42549C8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19770-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+]

On Wed, 29 Apr 2026 19:42:06 -0700 Jakub Kicinski wrote:
> > +# tcpdump saves pcaps to /tmp because it requires chown to save the
> > +# pcap but chown is not supported by 9p.  Mount tmpfs on /tmp if it is
> > +# not already a separate filesystem
> > +if ! mountpoint -q /tmp 2>/dev/null; then
> > +	mount -t tmpfs tmpfs /tmp
> > +fi
> > +  
> 
> Could this introduce a regression when the test is run directly on a host
> workstation rather than inside an isolated VM?
> 
> If /tmp is a regular directory on the root filesystem, mounting tmpfs over it
> will instantly hide all existing files and UNIX domain sockets in /tmp.
> 
> Since there is no cleanup trap to unmount it on exit or failure, does this
> leave the host system in a degraded state?

I share Sashiko's mixed feelings here. Do other tests mount /tmp ?
Seems like something that belongs in the "CI setup", external
to ksft itself.

point #2 my vng does have an overlayfs mounted over /tmp so the
mountpoint check doesn't trigger IDK if this is what you meant 
or I have a different version.

