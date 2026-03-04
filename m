Return-Path: <linux-rdma+bounces-17494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMiMKMBdqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:28:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCAC204438
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02F231B06AF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5E34DCD1;
	Wed,  4 Mar 2026 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V96PDJpt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC0349AE0;
	Wed,  4 Mar 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640556; cv=none; b=QXw0Rxb/lz64/eTy1fGJq8IhtlsmCiYyJS7iSUop21J5g2Rld0iJNhHNDSTaJN7A572xvcgsO9nFuTfH2zCO8BBUOX1VrmEYXFi5w6fDXZZDqSEvl22tbSUcV7XCauoQYbUtpgwHbReytcnCkN9lBIJlnrm9HgSlC8ZrEQi5zto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640556; c=relaxed/simple;
	bh=cyPiqNTMV9/2OwOGOP5t4mZiXAj1R4qSbE3YHJvUUMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+HEqCdWfxOW7TodqCY7uVoQc18z//0wkiLkZTuogvmIukVnlg2fs7AoLvu6CLTPG9FfBUzJc6ySCzuOdtT2jmZFBJwvN3QRln/QP4VBYLpbyP/0wDFupwwa1zs3IJOku2NiC6wkqEwWLqGChhoUd+Vf1986xl4ubOXZP5xj7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V96PDJpt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0DA854E42544;
	Wed,  4 Mar 2026 16:09:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9F765FF5C;
	Wed,  4 Mar 2026 16:09:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEBEA10369526;
	Wed,  4 Mar 2026 17:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772640551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=o2/XV9ZfCgAgiuSeujNtGFRamCoYCgmA2/cu0ytNEpE=;
	b=V96PDJpt9PWanbUhWbce/TGSLT34xeihw/YwV29JTSuYkf6IvIK28jJYeUe60g9+I4+pVt
	rw+YTiErvwBQkgQ3D6FymrwPywgT5FUfOcMi8VA5gJQh4CEA1xqU5GaAWzPlF0LRqeABUN
	gWtfZoEdmgtH0d9/E5kaMtRey8OJkEfqZ2w9RDbP5x6d6Yuo1npJFCjC9EDls3mopeFGDJ
	0lPYNPgsinQ00Iq0XO0Zq4pThB6E8HalYcZkOxayyyRDAkAtGJyDLEds/PdgSg32Pu9cJZ
	B6m6TX/pvqUpnheeh4Xr0wt5IG57pKoEJ1znXrD9ZGZLYRcekMoYQDqMwOvTqg==
Message-ID: <9c674e92-efc4-4f4d-9bd6-2b210ffd7c9e@bootlin.com>
Date: Wed, 4 Mar 2026 17:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org>
 <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
 <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org>
 <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
 <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
 <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
 <4c51f18c-5eb1-4a9e-93b9-70cf7a4fd387@lunn.ch>
 <f2ce4c3b-407e-4c01-b117-c646feed877f@bootlin.com>
 <CAJ+HfNga2510HrgpDH==H7CpmKBAEsoQkEmhFBMPxqM296p2eA@mail.gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAJ+HfNga2510HrgpDH==H7CpmKBAEsoQkEmhFBMPxqM296p2eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4BCAC204438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17494-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Björn,

On 04/03/2026 16:52, Björn Töpel wrote:
> Hey!
> 
> On Mon, 2 Mar 2026 at 10:01, Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
> 
>> The overall approach after all these discussions sounds fine to me, I do
>> think that the index of the component that does the loopback needs to be
>> there somewhere, when relevant.
>>
>> Either through a name string, or a combo of an enum indicating the
>> component type (MAC/PHY/Module/etc.) + its index. I think it's safe to
>> assume that indices will fit in u32 ?
>>
>> something like :
>>
>> # MAC PCS loopback
>> ethtool --set-loopback eth0 loc mac name pcs
>>
>> # PHY id 2 PMA loopback (I'm making things up here)
>> ethtool --set-loopback eth0 loc phy id 2 name pma
>>
>> That way we can extend that fairly easily for, say, combo-port devices
>> where we could select which of the port we want to loopback :)
> 
> Ok! I'll spin a new version with this in mind. To improve my mental
> model, could you give an example how you would use a combo-port from a
> userland perspective?

Of course :)

Considering this setup :

 +-----+     +-----+
 | MAC |     | PHY |----- SFP
 |     |-----|     |----- RJ45
 +-----+     +-----+

It's still WIP but the current state of what I have in the pipe looks like :

# List the ports
ethtool --show-ports eth0

Port for eth10:       # <- This port represents the RJ45 port of the PHY
	Port id: 1
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi
	Active: yes
	Link: up

Port for eth1:          # <- This port represents the SFP cage
	Port id: 2
	Vacant: no
	Supported MII interfaces : 10gbase-r
	Port type: sfp
	Active: no

Port for eth1:          # <- This port represents the SFP module inside the cage
	Port id: 4
	Supported link modes:  10000baseCR/Full
	Port type: mdi
	Active: no
	Link: up


# Select the SFP port as the active one (note that we could either use
port 2 or 4 here for the same result) :

ethtool --set-port eth0 id 4 active on 

I may add something like :

ethtool --set-port eth0 type sfp active on
ethtool --set-port eth0 type tp active on
 
Maxime


