Return-Path: <linux-rdma+bounces-22336-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwcXCM0sM2qo+AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22336-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 01:25:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C42F69CCB2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 01:25:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="YENY/Sh3";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22336-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22336-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51DA830D32F9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26763B8945;
	Wed, 17 Jun 2026 23:24:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC740313539;
	Wed, 17 Jun 2026 23:24:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738697; cv=none; b=j9vtC96NDMIen1Qq66K/rFpOoLUAm3iglXz2gkzcSBhp75RsVEybcMEjKZom/gkli2As/KPYa3FR3qhP7BxhTfHG/gxzDd4pAsaweJw4faEXDRxgtBCYyBf7nTZR80aRINphllnWH5C+H4uqAjk8gOzjFfXVcWI2gEdgqIOAu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738697; c=relaxed/simple;
	bh=+eI17Fy+wVIe18UVPp034CydNAaGOahSn2tIGzBPJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTgvhzpbe/7SwHf+yrtZXkSkB4ASDJ5Y6Jr8Vn0H3gMsKbwjSRW1W591GduKwz0xr9xewBt62sUfj/cDmZ+ZbkZgSAFY1FiaPwvjIoUjbBVu7oJtkLfSprNd9meJ/vHBeb1Qvr6PwjAF5gEy5hn49MXvdDQa+QP15vkKUBHxkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YENY/Sh3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B561C1F000E9;
	Wed, 17 Jun 2026 23:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781738696;
	bh=r5uSA66J9ABM/9yH9MNLyLHNRWzKIhhr4br7s8vfmak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YENY/Sh3Yed6hgB9DUIcwtRPpc0H+4BrXWXFxaL/P54FnFkM8icFFcQLmWtAvl4tJ
	 ldF2DhiYUCTuptBfefapfZopXADowAkgq71dMni6QSLpvEDkHSeN9qI3q3CzECu/GH
	 YOPI76roAKAOh6uBQgfYVmQXNlNPOWT95WlCX0d0oW8Rc6gKUSXV4HeA8owkpBu7k0
	 rkXneckPctgOlTl/SIv6YM9GtnDvOh6ndBw4kBDTB45zcW7UNzfvsTqbbEuiuD308x
	 eT3ebr5lWS+l1GGgtzxSXUwbMDQzi+hNVlz21ENIP/5Few58KctkEFHe+r36HmDZEP
	 W/RtdagPbHo0w==
Date: Wed, 17 Jun 2026 16:24:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Wenjia Zhang <wenjia@linux.ibm.com>, Dust Li
 <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Mahanta
 Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org, Ursula Braun
 <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 linux-s390@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, Tony Lu
 <tonylu@linux.alibaba.com>
Subject: Re: [PATCH v3 0/3] net/smc: bound wire-controlled CDC cursors
 against the local buffers
Message-ID: <20260617162454.33e95c2f@kernel.org>
In-Reply-To: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22336-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+hexlabsecurity.proton.me@kernel.org,m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:dust.li@linux.alibaba.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:linux-s390@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:tonylu@linux.alibaba.com,m:devnull@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,hexlabsecurity.proton.me];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C42F69CCB2

On Sun, 14 Jun 2026 03:23:29 -0500 Bryam Vargas via B4 Relay wrote:
> A peer's CDC producer/consumer cursors are copied from the wire and used,
> without an upper bound against the local buffers, as (a) a raw index into the
> RMB on the urgent path, (b) the receive length in smc_rx_recvmsg(), and (c) the
> send length in smc_tx_sendmsg() on the SMC-D DMB-merge path.  A malicious or
> buggy peer can forge a cursor so each of these runs past the relevant buffer:
> an out-of-bounds read of adjacent kernel memory (disclosed to the peer) on the
> receive/urgent side, and an out-of-bounds write of attacker-influenced length
> and content on the send side.

Once again, SMC maintainers -- please review.
-- 
mping: SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS

