Return-Path: <linux-rdma+bounces-17850-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB+iJnTxr2nkdAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17850-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:24:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA93249526
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A62D313AF99
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3063E95B5;
	Tue, 10 Mar 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zK7PTUb1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61985346AE5;
	Tue, 10 Mar 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138241; cv=none; b=SijJEHaMjhqQG9MTiMBJOqbg94Ezlde3lYltHS38nctO7+VBo1wWy/hLxaJ+oB+xSrRQqsciFZdqz3r+oVG0/RS5Fe45uTIazeTumohAQt8rqytg9r6oQ1z56csCChLIhUcJQILus+Aa8wP5IfH3Oi9yS4o75V+YCtHoqh+bquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138241; c=relaxed/simple;
	bh=V4nAKKOrlsJnLVSfpQtB7ZrgidRhEAiRET1TW0NC+Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEuL5Ay2lTeZcXqS75dtYV2akHg+ETLLMy3++c1eVMAT47aK+QddOiZQxCsO8O9t+hUTToajUpALXOeyqnf3nuFPGnmgIe5+3Eu+w0DkZWHsxTaeDFdeYWC5RX3sv5rzi3hm6pnZB5fDMXZuCn2cgeqA9ezazI/H93nLGhfFZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zK7PTUb1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7450EC40683;
	Tue, 10 Mar 2026 10:24:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB05060002;
	Tue, 10 Mar 2026 10:23:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C548310369AAA;
	Tue, 10 Mar 2026 11:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773138236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dG33aSjLs5/R1+ox7HGy2GkcqJJZcFyv8oCLXkVVO4w=;
	b=zK7PTUb1s9XSnqHU6HDC+Ezw/Qs9eHAkITmOHNSaQqdFvp9Pnc0Zm857kdzbWUFhLV2ocZ
	bvPdL5bqeKEaE2zlcdG9j55prr4u6R0aeRrBRqG+aQ8CT9T3O6uF7B5BwnpZtfozxm1a0X
	7/HzbcfSdPQiaZOJTLGmqSK6jhjrILMV718y+Y13nn1Frsgwf5n+lhXeJm6jwQ6Z7DIaBP
	BZdBLGmvX3kZBxAomTS73hB9dUqX+ptoIJlfVhcYz9C18cw80HF0f/r1uuveJ2/OqkMlCr
	7yt/Sy01ddWzu7riuNBYUDRLkSVl/Aor4lUEEbF+CJZ2e9SdSfBYlGV1ILWAEQ==
Message-ID: <2ed52f3c-ce2b-4ac9-baf5-224fd3e946f1@bootlin.com>
Date: Tue, 10 Mar 2026 11:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 1/6] ethtool: Add loopback netlink UAPI
 definitions
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Hariprasad Kelam <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-2-bjorn@kernel.org>
 <456697d6-c0d8-4edf-abd2-85062f4b25ab@bootlin.com>
 <e138acb9-f2ab-4d76-a9b1-fa7299b1260f@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <e138acb9-f2ab-4d76-a9b1-fa7299b1260f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3FA93249526
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
	TAGGED_FROM(0.00)[bounces-17850-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action



On 09/03/2026 17:45, Andrew Lunn wrote:
>>> +    doc: |
>>> +      Loopback component. Identifies where in the network path the
>>> +      loopback is applied.
>>> +    entries:
>>> +      -
>>> +        name: mac
>>> +        doc: MAC loopback
>>> +      -
>>> +        name: pcs
>>> +        doc: PCS loopback
>>> +      -
>>> +        name: phy
>>> +        doc: PHY loopback
>>> +      -
>>> +        name: module
>>> +        doc: Pluggable module (e.g. CMIS (Q)SFP) loopback
>>
>> Should we also add "serdes" ?
> 
> What is the difference between SERDES and PCS?

By Serdes I mean "generic PHY", but as you state below I don't really
want to use the word "PHY" as it's very prone to confusion with Ethernet
PHYs.

> 
> Maybe we should also make it clear PHY means Ethernet PHY. The Marvell
> Generic PHYs have
> 
> phy-mvebu-a3700-comphy.c:#define COMPHY_DIG_LOOPBACK_EN		0x23
> phy-mvebu-cp110-comphy.c:#define MVEBU_COMPHY_LOOPBACK(n)		(0x88c + (n) * 0x1000)
> 
> which suggests it can also do loopback. We don't want PHY meaning two
> different things.

Agreed,

Maxime

