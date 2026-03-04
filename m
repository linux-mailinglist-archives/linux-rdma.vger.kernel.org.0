Return-Path: <linux-rdma+bounces-17496-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPiqNMR6qGmHuwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17496-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 19:32:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012620665E
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 19:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B4730F0259
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD53D6CCC;
	Wed,  4 Mar 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTKWakEr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850771FCFFC;
	Wed,  4 Mar 2026 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648124; cv=none; b=pEfChQO5PpGp0qJUYQ1Fu3G0VpvBAH2NO96Rt22uzd3hj7trOMyJPNBBOTsnieSamqTuIWibzFd7KbISG0PSLuEeY5Xmp9j7ziOr/e2NMRtCDt3hJvrAG+A8tvDTzx/ffbJxeOWWUalGAip5z4OsYv8xIC/9nMe7tyfUjPnBtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648124; c=relaxed/simple;
	bh=i3AdJpcQctz2YOqXPjkQFg+xjHKpWsnaX71lZqXYgTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAkk36apwyDmvL3ZI2+SNwvtT8ynXA5vbnALv2zgHi4hH/O+cCj5E0lc4JbQMHHw1lEiRnMKMh/wFe7DL3xrWRFYh/2oG8smHQyNkDHGxWymJennf9V8JP9kiTl52Ui18W9ZtMIQ0t9od68GOjR4DWgFwxLQL4KWU/npGEyAaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTKWakEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C30C4CEF7;
	Wed,  4 Mar 2026 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648123;
	bh=i3AdJpcQctz2YOqXPjkQFg+xjHKpWsnaX71lZqXYgTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hTKWakErJUMN6EOHtpPun6JoiuBIL31PVHyD1aOa9dHGGA6DdB7MCzOdA1CZp2V4A
	 JDEX7JmDdnPZKsyOhNKkXvHds9jcKOWeufqyfS1poXMIqetu6jQbhGafvC9yQyOQ3/
	 BDBDH0uSVj47mC4LDMXG0i/vCTGUCCTgmRohYeauaOqaovoKlX/AreOV7+vjWZAAQn
	 41Dkms5LJaGlMyafs7kSyjOqEe8ZCUgrZrexfazfyNKtTdSzbwn3n5nmLLkpGHkhAr
	 2UCaLvxEY4yyZGk0YmlEa1C6zJM9W1BRcdXsqakqlayKn2aK9UVAoDaQcNtZwO0Lg0
	 pn73FWH+XHwVw==
Date: Wed, 4 Mar 2026 10:15:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260304101522.09da1f58@kernel.org>
In-Reply-To: <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
	<20260302192640.49af074f@kernel.org>
	<pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
	<jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8012620665E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17496-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 11:34:13 +0100 Jiri Pirko wrote:
> >>I have a strong suspicion that the user will want to access all
> >>resources of a device. `devlink resource show [$dev]` should dump 
> >>all resources devlink knows about, including port ones.
> >>
> >>What's the reason for the new command?  
> >
> >You are right, one cmd would do. Good thing someone forgot to implement
> >dump for it :)  
> 
> On a second thought, if we merge multiple objects into one dump, how
> does this extend? I mean, the userspace has to check there are no extra
> attributes, as they may be used as a handle to another new object
> introduced in the future... Idk, it's a bit odd.

That's true, the user space must be able to interpret the object
identifier. So if we extend the command to add more identifiers
we will have to add the bitmask to the dump request, and have
the user space tell the kernel which objects it can recognize.
I was just saying that we don't have to add such attribute now,
maybe leave a comment in a strategic place for our future selves?

