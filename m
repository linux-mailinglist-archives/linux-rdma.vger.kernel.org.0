Return-Path: <linux-rdma+bounces-18113-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAH+AjrNsmlTPwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18113-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:27:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E82927354F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15AF3157956
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1A36BCFB;
	Thu, 12 Mar 2026 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4l/C086"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C534DCD9;
	Thu, 12 Mar 2026 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325158; cv=none; b=QPaZTCRBNQMfUIm7WyY4GJ7/QEcIuNYlYqrIJBbi/G+VoXnLNAMUmTBndAtkKcMwggR6PvqTLeV6aoU4lbLK4B4XvY4A5xLz5jJ5i517NX4DDdTSzrcgrZvQ1DOSQTC38Tm1P0DwShHkX4EEmDn4uKdZ8Gr89aVOAFJ9b8xlRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325158; c=relaxed/simple;
	bh=6h3zKnDlTMVm2UbvFLw0atWxFuDz3SlZDxNgMu4GaDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUjlF1Owml+P1tmpNcsH1hLD5J1U7uzmYdXME9tUa+pE7T32AKx5RdQCMSNSSRBncgg6aJWZOlh/v12W/11QxD16PsnYC0tswz5eJ8olHvHId9+oezXoPmTQruNKb0jOn5avmuxVNyxpg9xt7EBX3JyaqB5ckiYxgtZNgYjMDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4l/C086; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C39C19424;
	Thu, 12 Mar 2026 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325158;
	bh=6h3zKnDlTMVm2UbvFLw0atWxFuDz3SlZDxNgMu4GaDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4l/C086zILQkEVCakaW+fO8LQtTWR6rL2OkKJeOKSUCjiRuwJpf0oDBbBm6UJ76S
	 lPzUs42gvssurLdoodaO3huvyoEhYk2Njb0gczJaqURIk8EUlUftEbRkE1tymHiukP
	 O0eDMwx0JlX5OuBNDeAFw3mTRpFH56a13+DyKw+z99K6gCK9CajXPk+j/6e+tuD7iq
	 o9aGWoTXTgrIsTmKDGCSdbx0DWBvXFHcWZmtqkkg/K0HPjig56VgWkKa6WBdsTQcbU
	 S/3urzs9APxQUarYR9ccERWgjr+6CcxWd9EXFM7JrReJTOJCqZT+vi1QXuJpTjVC5u
	 eEXcQjL1qmagw==
Date: Thu, 12 Mar 2026 07:19:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark
 Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260312071916.6b759c3f@kernel.org>
In-Reply-To: <go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
References: <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
	<20260304101522.09da1f58@kernel.org>
	<np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
	<20260305063729.7e40775d@kernel.org>
	<ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
	<20260306120301.0ebe1ab2@kernel.org>
	<74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
	<20260309133341.7e08b35d@kernel.org>
	<5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
	<20260311145126.7dcca532@kernel.org>
	<go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18113-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E82927354F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 09:34:52 +0100 Jiri Pirko wrote:
> >> devlink resource show scope dev
> >> pci/0000:03:00.0:
> >> <resource>
> >> pci/0000:03:00.1:
> >> <resource>  
> >
> >LGTM  
> 
> I don't see the benefit of exposing the scope to the user to be honest.
> I mean, dump would show all, dump with "dev" handle would be used as a
> selector to dump only things related to "dev". What is the use case of
> this "scope" granularity?

If we follow the logic that dump should show the user relevant
resources, no matter which sub-object they are attached to -
having a dev specified should only filter the objects to match
the dev, including resources which are on ports of that dev.

IDK if there's a strong use case for allowing the user to set
scope on CLI but also - I don't see why not?

> >> For the do-it command:
> >> devlink resource show pci/0000:03:00.0
> >> pci/0000:03:00.0:
> >> <resource>
> >> pci/0000:03:00.0/196608:
> >> <port-resource>
> >> pci/0000:03:00.0/196609:
> >> <port-resource>
> >> 
> >> devlink resource show pci/0000:03:00.0 scope port
> >> pci/0000:03:00.0/196608:
> >> <port-resource>
> >> pci/0000:03:00.0/196609:
> >> <port-resource>
> >> 
> >> devlink resource show pci/0000:03:00.0  scope dev
> >> pci/0000:03:00.0:
> >> <resource>  
> >
> >Do we have to touch doit? Maybe we should let doit be what it is now
> >and consider it legacy going forward? doit which is in fact a filtered
> >dump is a bit of a mistake in the first place, from Netlink's
> >perspective.  
> 
> I don't think we should. If user wants doit, he is going to specify the
> object (dev/port). If user is interested only in things related to
> single device, he should do dump with selector (dev).

Could you confirm that you're agreeing that we should leave doit as is?
I'm not 100% sure after reading this twice :)

