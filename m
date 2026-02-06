Return-Path: <linux-rdma+bounces-16605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHWfHz8zhWkl+AMAu9opvQ
	(envelope-from <linux-rdma+bounces-16605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 01:18:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F022FF889C
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 01:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90B7301BC11
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DA1E376C;
	Fri,  6 Feb 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf9tjtCJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5215A86D;
	Fri,  6 Feb 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337069; cv=none; b=i0IfNo7KAI0/Bh/beyzg67mRf2MuCJ/ej9QNKmskOdltfKZUNOouaSC1eldJBV/l2VaORGbalJnqm/p+dIYALQU3S1sZkhGMfGK/J9qrClGTw7EO8Av6MpONzHAjE0Wi0foxSOrTDGxtF9bo4hw7yOWLcy/BZrHdXh7gwnrfvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337069; c=relaxed/simple;
	bh=DQrq5c1J+kiv5UEj7nlCQrtJTusd0d502vuVJr1r7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io1r9SIYEgGXX3KlMpXo3ixm1xyuru3Ou5LXVTbOiH3iuYYjeE/KdpnWiy93JmELwfarLxGEhjbDzRrS/Y08KPYXrYerqQzKYbQrrVvCjCHKsxQi6Svxd9/upStEXtac/Ot6vW7Q3IZvgDe1iQNW4bbreagocs4tWa2/ljEhCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf9tjtCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59429C4CEF7;
	Fri,  6 Feb 2026 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337069;
	bh=DQrq5c1J+kiv5UEj7nlCQrtJTusd0d502vuVJr1r7pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gf9tjtCJFiCokVo3TecNVaL7vYEpVzQS+7qD7EkE4j0zwz6pQa8CJzf8yq9jCKQPh
	 inzUgyrJC/kXCAypadw2sf4WwKVDYiZpLAJ3vJtNXFKbaMABNo/IABgZ78lhjDoy3T
	 KrRc97EcUTmRJ5KPSZratWTiMDx2crawaWu41OnmHKeRBkPTjPlAqEg7qbQRoCqYQu
	 wcdjmdRXX/zZctk/GubMb8xTmTrtJiEbmboWrZfXfzGiNRfxIYC/uyEJwhU/T1twax
	 RhHenQ/IlbuNZ8iCDPEeuLPPZrOhuOmRsGkmzn98SaM2Sio/TXjfFDM9+suE00uxKk
	 yBIBVmhLjVuog==
Date: Thu, 5 Feb 2026 16:17:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 0/7] devlink: add per-port resource support
Message-ID: <20260205161747.26dd7bc5@kernel.org>
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16605-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F022FF889C
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 16:28:26 +0200 Tariq Toukan wrote:
> Userspace patches for iproute2:
> https://github.com/ohartoov/iproute2/tree/port_resource

I pulled this but the test still doesn't pass:

# TEST: resource test                                                 [ OK ]
# TEST: port resource test                                            [FAIL]
# Unexpected resource name test_resource (expected max_sfs)
# TEST: dev_info test                                                 [ OK ]
# TEST: empty reporter test                                           [ OK ]

https://netdev-ctrl.bots.linux.dev/logs/vmksft/netdevsim/results/505601/9-devlink-sh/stdout
-- 
pw-bot: cr

