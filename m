Return-Path: <linux-rdma+bounces-17619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EgiOPwyq2n2agEAu9opvQ
	(envelope-from <linux-rdma+bounces-17619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:03:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A30722275C2
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D28530417BF
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69730CD95;
	Fri,  6 Mar 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeWz6ga2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6C23EA94;
	Fri,  6 Mar 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827384; cv=none; b=nt47D50skpBFmWcKrnjfPxi5tpY+bEouN6FYQO4xeHo74RuGEqn86OlHoiOGyYCpq0HCur1+LW+UPzYgb0Ej9evDt8bp1Z9m/p8Gn9OclbJgH2wmH+0OXxS+T/2BzqPf94wQqUhauGcYKlzfEqs7+xj051clrTL5bNAOboDP8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827384; c=relaxed/simple;
	bh=qahHLobAMT9yxV+pCSgqBlfqphTkEHwnL3IOJgHvXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcKBCBN4tiBr5dRO7ppYsYz/AEjtzK4Lvw5WWWnQ/80CKcB4poMLYL3dBYmtX0qY1rNeEaCCcO/Ns02yszbIcr4VWUivfKS7GJyzTB8vQf3ys3Dp5NytGukUwfkWvXKsCms5OcAYBmLEVUalGMhN8Hwz74hs2Uh9wo3oKdwqyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeWz6ga2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EDC4CEF7;
	Fri,  6 Mar 2026 20:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772827383;
	bh=qahHLobAMT9yxV+pCSgqBlfqphTkEHwnL3IOJgHvXQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AeWz6ga2R98oPoiuLJ29E083Irjhy3TASp+fJgLx/43WSTUT+owB5XPYeuMZWBROa
	 iYeyeeel/OlvUpKCVaMufR61f2Kdpz0MG9MO1dUQyrT8cbrSV4sqc23YxmfhljsGby
	 apFdPVzfELh7631LATPMkz9rgtYNYlNbtboZnDl/sSvHSA8EtpZxzeLXQSNKtXhPdt
	 XkZWLbs5FtFo7ZG1xL980/AafTsPnxLotsU1EGhAbwKBcc8Z10bESPIcr4olVZ2AH0
	 JROXIqG0lZr0ukXQVk50ZN3EIfCfoFRRd7EIsFC2ncyc0vDKP0bUn9t3vX+kFLEurK
	 Ysq9MxwM9FFBA==
Date: Fri, 6 Mar 2026 12:03:01 -0800
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
Message-ID: <20260306120301.0ebe1ab2@kernel.org>
In-Reply-To: <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
	<20260302192640.49af074f@kernel.org>
	<pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
	<jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
	<20260304101522.09da1f58@kernel.org>
	<np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
	<20260305063729.7e40775d@kernel.org>
	<ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A30722275C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17619-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 13:13:26 +0100 Jiri Pirko wrote:
> Thu, Mar 05, 2026 at 03:37:29PM +0100, kuba@kernel.org wrote:
> >On Thu, 5 Mar 2026 08:56:42 +0100 Jiri Pirko wrote:  
> >> Or, alternatively, we can have per-object dumps as we have for all
> >> objects and command right now and leave things simple and
> >> straightforward? I mean, I don't really see a benefit of a single dump
> >> for more objects :/  
> >
> >What do you mean by straightforward, exactly?
> >
> >User will most likely want to see all resources of a device in a single
> >dump / command.  
> 
> Hmm. We actually already have this for region and health reporter dumps.
> Only for params we have that separate.
> So let's do it for resource too.

That's not a good argument, as I said in my first response to the
thread:

  I worry we are mechanically following the design of other commands.

https://lore.kernel.org/all/20260302192640.49af074f@kernel.org/

