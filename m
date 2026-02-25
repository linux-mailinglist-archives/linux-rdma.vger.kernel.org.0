Return-Path: <linux-rdma+bounces-17147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL6hALLNnmnxXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:23:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56411195B7E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A445D301A924
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12239280D;
	Wed, 25 Feb 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vlic8M6d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBE2E0938;
	Wed, 25 Feb 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014953; cv=none; b=SrQh1djIZYi8Rov1fRpc642f2nAeIHlU2WmrDr7m0M6R8oPAwk18zPBUNxgzUkYVNkZzExv2hEbsGa52mr3kxmKQWEtXObwj7ZqTmuljbIlXyYuNKwsVvqruHvMjVMelPlx9WKp6y0QmNcSAJsM/nOeu3S4AWmDnZhKDdPpDQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014953; c=relaxed/simple;
	bh=ZJeQiA/+B2VZb9nLr12SB89VIEliQBQ6QjnnyKLA5ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9Q2H3RpYnEOuUpOs+JXZC5+YR0sW16rrhN/h503Y+isRmneCPyUO+I0cXnEnUWNvsniyL1Ayo7IQ9dQHRVjl4ZKkNKoNEOgX+PNu9vpbUs354/CW/fVqjPeznOdCAyjMV/ZBtS1jkngugrShUtcSbBisxurNr9Aj5xI/1405Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vlic8M6d; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6B75B1A12F9;
	Wed, 25 Feb 2026 10:22:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D0845FDE5;
	Wed, 25 Feb 2026 10:22:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C57C410369219;
	Wed, 25 Feb 2026 11:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772014947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nDQ2tWR1P0/Bga/td9qafDc7KlBqVUfchwgJwHAhXVs=;
	b=vlic8M6dhpteNSn15LeGW5ehPc9Iby9cBMVXCevCWw9Z9wLlHtc36YWqy71qrVJmgVjbx3
	Ioseo03jBsIVz9u7NaXaVh/6poPUFuU5uo7CiN6Pg3vi2uKTwO1qFeuDR4CuANS5gqLT6B
	ne6MEm2EORxuIhJSBMhP9r4YuJISpt7D8RPT1e6fmCKNqOdng1ImFX5naJQaGFl5WV/yNL
	yqxa8h2ZOk2pVo6k2oiSyNphWU3oCftEnaf+FnbnNix7ALBsur4dSqRnhbx4DGIm7rHvlO
	haS9mLCckXn+HdbpKTTamWuAzWj2Y8beyCQmSfpOHZUt5MUvsRiYGoyBHPog+w==
Message-ID: <71848101-e97c-4674-ad07-aec720123d64@bootlin.com>
Date: Wed, 25 Feb 2026 11:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>,
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
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17147-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56411195B7E
X-Rspamd-Action: no action

Hi Björn,

On 22/02/2026 20:58, Björn Töpel wrote:

> # # Simple MAC loopback:
> # ethtool --set-loopback eth0 mac (Defaults: lanes=all, dir=near)
> # # Specific SerDes (PMA) lane:
> # ethtool --set-loopback eth0 pma:lane0
> # # Complex multi-layer (PMA Near + PMD Far):
> # ethtool --set-loopback eth0 pma:0x1:near pmd:all:far
> # # Disable all loopbacks:
> ethtool --set-loopback eth0 off
> 
> Thoughts? Is this somewhat close to what you had in mind, Andrew?
> 
> I'm far from an expert on the details here, so the folks with more
> knowledge, please chime in!

I'm very sorry not to have looked into this yet, I'm having some family
events to handle right-now but I hope to be back next monday to take a
close look at this :)

Thanks for this work,

Maxime


