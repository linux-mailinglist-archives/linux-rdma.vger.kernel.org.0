Return-Path: <linux-rdma+bounces-18071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGOCBCtwsmmuMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:50:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B526E72B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC24A308CBE4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AE3B27D7;
	Thu, 12 Mar 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ax/gNMry"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0063AF658;
	Thu, 12 Mar 2026 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301796; cv=none; b=AfHz55wOLpuvcEEpUi9C0nE4wnYhgi0Av1P3bewX/xCWvJyenol4G3+EGCaeV3Gxm2aG1tkrE8CwFBkbFDMbXsCx76nESyUiQpJRrQmm07BjnrJ9ZbjR0csHL91ye9ebLlVxFrdSlQZx5nmLqyUCmtmwGutzg2g+EeNUl2LhD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301796; c=relaxed/simple;
	bh=qc6nhP5c2KbUKz7TVprgeRZu7pcKDVuliPuq3MEFpFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlJvRa/iL4DbfjyqBkpQLgYww5EsYNRZFwGyIyaywv3kccRMglYFebHrdVVGLLbmuHAavywHGjqp1npIk4vuPYoWshXT2vUo0Yl7RYfPn6vs8flE6X0Q31dAhu5wOijaI7EUYeHdIqtrZG4F5azxFdfpmd+vi6MLwHspyvTVN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ax/gNMry; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A48BBC4159A;
	Thu, 12 Mar 2026 07:50:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2AC65FDEB;
	Thu, 12 Mar 2026 07:49:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE4DD103685B6;
	Thu, 12 Mar 2026 08:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773301788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oT1XxdAl50AWEmjTvDhxYXZzFl6EH2KJUz4HxFpnESQ=;
	b=Ax/gNMry1zn+jSGCJbygPm1MqxQ4xxoTT66fSRTc5nLHZg0smRQfQsCBxzFAgGLzAa5lfd
	Af4Hzw3beOAKGJa2JoN1tyRRgpFbt2P1DrjSQJLrLuFisE3KcRi9NuOajpxaUhtjQbuHEK
	kR3cJQ7kSGJyJSKLk1FFFNgbzO9Llxvoc0l+zkG8/VZWxfJJLvshOLgAEPhd0YVzYaaAc3
	wf1CqHn90p9oxKToETmVmvknFNcnGt4nnaLz9lclipHxPR9jfhGQ3zeSz9iFLtb5+nxz2S
	99oywt/IIeSV4UXD45vO3Bd0BvPnK1F/DNbgdI8WLyq0hFw/oXtfNgrByjMj/Q==
Message-ID: <ebab1d3e-8967-444b-be54-437e4dfe3c7e@bootlin.com>
Date: Thu, 12 Mar 2026 08:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org> <abJJY8whzSOB8O-X@pengutronix.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <abJJY8whzSOB8O-X@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18071-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,davemloft.net,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE3B526E72B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 12/03/2026 06:04, Oleksij Rempel wrote:
> On Wed, Mar 11, 2026 at 07:50:52PM -0700, Jakub Kicinski wrote:
>> On Wed, 11 Mar 2026 20:26:39 +0100 Andrew Lunn wrote:
>>>> For that we have what we need with phy_link_topology, as each PHY has
>>>> its index, we should be good to go in that regard hopefully :)  
>>>
>>> So depth would be local to a component? We could have two PHY
>>> components, each with a different index, and depth = 0?
>>>
>>> I _think_ Jakub's depth was more at a global level? But then it would
>>> need to be passed down as we do the enumeration.
>>
>> Oh, sorry, I responded without reading the whole discussion :)
>> No, I imagined the depth would be within a single component, 
>> so under control of a single driver (instance). The ordering
>> between components should be defined by PHY topology etc so
>> it's outside of the loopback config.
> 
> As for me, it is problematic to help the user to understand the datapath
> depth on a switch. For example:
> 
> CPU -- xMII --- MAC1 [loop] --- fabric --- MAC2 [loop] --- xMII -- PHY
>                                     \----- MACx [loop] ---
> 
> ... each port has two xMII loop configurations: towards the xMII or towards
> the fabric. From a driver perspective, a loop towards the xMII is
> "remote." However, from a system perspective, a "remote" loop on MAC1 is
> a local loop at depth=0, whereas a "local" loop on MAC2 is a local loop
> at depth=1.

What's important is to specify clearly in the documentation from which
end do we start, where representing the topology. From your scenario
here, each block is already well represented and exposed, and if we use
local depth definitions we should be fine ?

> 
> Other example would be where we have a chain of components which are
> attached on the system in a unexpected direction, where the MDI
> interface is pointing towards the main CPU, so the remote loopbacks
> became to local loop.

I have a few of these types of setup on my desk, where 3 PHY devices are
daisy-chained, we don't support that for now. If we one day add support
for standalone PHYs acting as media converters, I expect we'll be able
to tell which end is pointing where, and let it up to the user to figure
out what "remote" and "local" means in that case.

> 
> One more issue is the test data generator location. The data generator
> is not always the CPU. We have HW generators located in components like
> PHYs or we may use external source (remote loopback).

There were discussions about PRBS, I think the same idea of "pinpointing
which block we want to use" can be applied for both loopback and
generation ?

Maxime


