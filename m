Return-Path: <linux-rdma+bounces-17796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCAOBknyrmnZKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 17:16:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44B23C921
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68BB6301E7D5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8693ACA6B;
	Mon,  9 Mar 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gHo49FPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9191A9FB7;
	Mon,  9 Mar 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072857; cv=none; b=tlgFCv1KO0WlkYYHJMoXr6j5gVT2OeVlUsUoT5AxmuIhbkQW/yliRqbslV+WxVrlallIiD69yRNe8czvEh52WCiS2CAxAnX5qjdNy3vvprZ9TBgq1v5r2CnhwLGuFSoEpHHt+2hGkdYYBol4cfLaG/tzUfV4IyqgJohDc+B66VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072857; c=relaxed/simple;
	bh=mCSuYgrZIhgGdiDNmH9F9Ifi6uDQL4jRUkBBPnEuC9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGSEIL2RMbwaX6zxVthT+yHfVS89RWeHP+iVXqLIOxWd6hYxsEQKUla4Be/rPq9+vtLFz43JroXxR2xecK5FYAz2TFagW0bTh7yqNUjph7GqKqK5VTLmdL0X3N9xRdOU7hgiZ02KT0I9CFYPGjrO6UgCTcviFEiZs/iRYzrZMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gHo49FPn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 23CA94E425DB;
	Mon,  9 Mar 2026 16:14:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAE015FFB8;
	Mon,  9 Mar 2026 16:14:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7C2910369C05;
	Mon,  9 Mar 2026 17:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773072851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yh+8+tBhV4pW5yoIuMAB89k1SpGCp2BqzfB7wx7LInU=;
	b=gHo49FPnFH37zOPtB1DOrzDCnXKEGRkVt2DXUf5k4W579n3hu//SmvkoRXQe2SJbdFeIKy
	7yLpZiCbv/eQSYy7zcceH7QVBZckjwHZ6gcL1CszpN4hAsgGCkMlyGyBNTIEnf/QIBSA3y
	/Sp1PEttMOazLarAKVGX375VhzM5ESvCs1HJ1tKJbmS4QidKwBp3d/f07aq+V4b8/CF9+t
	JFKJhHMTc3v5OdhKL+hkaciYbQvwSBb1NXoEfNHjRkIi8RUON52LkS1PKtUFccZ3Gak0PA
	nQAhmlp6B1oy1ybcCHozxAW2QHzi0rx4Xj6tJczBrA3DtXotSFPKrVo52abNrQ==
Message-ID: <ee7febab-7005-487f-b42e-365757f7032b@bootlin.com>
Date: Mon, 9 Mar 2026 17:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 2/6] ethtool: Add loopback GET/SET netlink
 implementation
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-3-bjorn@kernel.org>
 <19aa42c1-4e3c-4722-84bd-a21b53ad3993@bootlin.com>
 <87eclth0qw.fsf@all.your.base.are.belong.to.us>
 <87y0k1njid.fsf@all.your.base.are.belong.to.us>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <87y0k1njid.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8F44B23C921
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17796-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

On 09/03/2026 15:51, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
>> Maxime Chevallier <maxime.chevallier@bootlin.com> writes:
>>
>>> Hi Björn,
>>>
>>> On 08/03/2026 13:40, Björn Töpel wrote:
>>>> Add the kernel-side ETHTOOL_MSG_LOOPBACK_GET,
>>>> ETHTOOL_MSG_LOOPBACK_SET, and ETHTOOL_MSG_LOOPBACK_NTF handlers using
>>>> the standard ethnl_request_ops infrastructure.
>>>>
>>>> GET collects loopback entries from per-component helpers via
>>>> loopback_get_entries(). SET parses the nested entry attributes,
>>>> dispatches each to loopback_set_one(), and only sends a notification
>>>> when the state is changed.
>>>>
>>>> No components are wired yet.
>>>>
>>>> Signed-off-by: Björn Töpel <bjorn@kernel.org>
>>>
>>> At a first glance, what I see is that you're using the GET ->doit method
>>> to retrieve an array of loopback entries. The pefered approach in that
>>> case is to use the GET ->dumpit command instead, issueing a netlink DUMP
>>> request to list all available loopback entities on a given netdev.
>>>
>>> If you want some reference on that, take a look at the phy.c + the
>>> 'perphy' helpers in net/ethtool/netlink.c
>>>
>>> The idea is that you can pass a netdev ifindex in the header of the DUMP
>>> request, which you can use to dump all loopbacks the passed netdev.
>>>
>>> You can also check the ethtool code itself, you'll see that when you use
>>> the "ethtool --show-phys eth0" command for example, it issues a DUMP
>>> request to the kernel.
>>
>> Ah, got it! Thanks!
> 
> Thanks for pointing this out! I like how using this can get rid of the
> fixed size array in struct ethtool_loopback_cfg, which had a bad smell
> to me.
> 
> Thinking out loud -- Now, using a similar scheme for loopback requires
> some thought around the sub-iterator: Loopback has "multiple"
> sub-iterator: (component, [id], name)... or needs scheme to deal with
> one sub-iter, and loopback can share a lot of code with the
> perphy-functions.

yeah, at some point in the past I played around with the idea of more
generic ethnl helpers for filtered DUMP requests :

https://lore.kernel.org/netdev/20250324104012.367366-1-maxime.chevallier@bootlin.com/

At that time, the PHY usecase was the main user so I ended-up ditching
that in favor of the more specific perphy helpers we have today, after
discussing the matter with Jakub.

Now that we're seeing more and more ethnl DUMP commands that can take a
netdev ifindex in the request, maybe some of that code above can be useful
for you and we can resurect this approach ?

Maxime 

> 
> 
> Björn


