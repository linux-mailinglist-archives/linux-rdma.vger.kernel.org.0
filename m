Return-Path: <linux-rdma+bounces-22185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kK9hKyCoLGpvUgQAu9opvQ
	(envelope-from <linux-rdma+bounces-22185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 02:45:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFD67D58E
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 02:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gpv9Es7L;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22185-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22185-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DDD31945AF
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D77846A;
	Sat, 13 Jun 2026 00:44:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549091F09A5;
	Sat, 13 Jun 2026 00:44:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311485; cv=none; b=K7jD+9IgWpO3vgxfjLjy+l+JTrfAfOjL/zvROED1Hmyn2QGgVKYAlxEUl2ORisRRkRS5KKhZrP36qHhcFNQ47IvDmGfwE5lVzB9prP5jhEpScP06GZjmZOcmHo7jkw4dOqCAImd9CE/s01ielI8Hovm1ondirmodXL+0RPXeoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311485; c=relaxed/simple;
	bh=c1HPFZsU0eRnti37RMqtFvZSiXq6k8XdGi4re0c8Tvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvfxTbzQmHcQBx/oApc209EWmd74jF+0gzKzZuiGCunJRMar2IapTrI6XbvRCf4s0bxM8hqj+WwigpptSBkhLQYPy3aAV3vsnWEwWtmr5C7GCS+CC1zmdr3WkyVX6K5roxsX3CgAM814CWn8VvDbdyoA3duJ6k24k9qdOyrbVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpv9Es7L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380611F000E9;
	Sat, 13 Jun 2026 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781311484;
	bh=OEt29oeVnp0fgMWbhtQ94bxVYk/Oo9ifrXVMeaXuFzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gpv9Es7L/BeqibIroIT8p3V1n1+Gt1mbGSw1xvwrzNHD6OPA7YN0OfyDJkCpAaFSb
	 iKHkLydxyWt506995rgIfgy9VFtTp3xIuQQMnXKfUI/zxpKUzj4NWE3B0rBRca5SlZ
	 fGShz+S0CZoYZJlXde3e/30gkMc7dRDL1iF8jw9VLuy+M+gVbhmhD89wpU8PNH5iz9
	 /Joc5xaLRYgqXPiTDTZ3bPJ19O+eASLINo1H/tErCzMsD7skHuF8JlqzZ7ngXMe+66
	 1ZoQ8ZMhDHycHQiz5KNpO/ashtahKg22+px+FuGlPZpieM02vWjaE3xkoWUUGQlzfe
	 UoB0dvnIxAZRw==
Date: Fri, 12 Jun 2026 17:44:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Allison Henderson
 <achender@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Grover
 <andy.grover@oracle.com>, Mark Brown <broonie@kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] rds: convert to getsockopt_iter: manual
 merge
Message-ID: <20260612174442.5fe54656@kernel.org>
In-Reply-To: <b91ff67e-ce74-4edf-a8b0-08be04586485@kernel.org>
References: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
	<20260608-getsock_more-v3-2-706ecf2ea332@debian.org>
	<2e1b0534-a1a0-4eb1-a5e2-d42fcf991188@kernel.org>
	<aivAbAIjnTeqlsdS@gmail.com>
	<b91ff67e-ce74-4edf-a8b0-08be04586485@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:leitao@debian.org,m:achender@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:broonie@kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-22185-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47BFD67D58E

On Fri, 12 Jun 2026 13:41:00 +0200 Matthieu Baerts wrote:
> > I was aware of the conflict but didn't realize a note would be helpful
> > for the merge. I should have included one.
> > 
> > Could you point me to an example commit/patch that contains such a note so I
> > can understand the expected format and procedure?  
> 
> In this particular example, I think it would have been easier to have
> waited for the fix to land in net-next -- after the weekly sync with net
> -- and then send the net-next patches.
> 
> When this cannot be avoided, then you can mention the conflict, and
> ideally share a diff of the resolution, plus a description, especially
> when it is not obvious, when simply saying "take the version from X" is
> helpful, when extra modifications are needed, etc. e.g. [1]. Something
> similar to what Mark is usually doing on the linux-next ML, or what I
> did here.

Thanks for explaining! This conflict was avoidable but I didn't find
the appropriately polite explanation within me :)

When conflicting code is _already committed_ to net-next we can deal
with the conflict. If there's a patch only posted but not commited and
we notice a bug - the net-next patch should be explicitly withdrawn and
reposted once the fix has propagated.

