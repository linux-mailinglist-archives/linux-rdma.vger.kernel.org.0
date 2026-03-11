Return-Path: <linux-rdma+bounces-17974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKVDJJaNsWnkDAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:43:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E4266B71
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E0A303CA59
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEFA3E022F;
	Wed, 11 Mar 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sAiEzUAi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4A3DDDD0;
	Wed, 11 Mar 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243747; cv=none; b=OouU74Gt2WhC/sdZFRAmWEDrQil5EzS8er38b/ELMtjNI+X5zdvmuiI3kpxRbaAMuOWtNW5832mwSZ217U//LYFkSuh7Zg3FyBvn2euPRxo50NjtlCjgxKDL/fH3jipUJYDJobyM8xUfJgbARC6ofnxSGvnXAAJ1CwnlrFOPJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243747; c=relaxed/simple;
	bh=BWwErrS9z3BJ/Kf4uE5Zd2qqwPcMU/ykSnOIsPweWGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9rHrgpJCXZC9q0EJcmzXqulaN926Sly+rYpYNyLTI1PfbZDjpaEUPSxQayJY+95zpgqLhpH7w0W9XWEyFChhC5WaVkWusrUSaV2ta/Eq796Vo46ZjkbhWDs8z9JQHXAptksyFepNHFItVGzjIpKE21G056fp6dz4s7q35vr0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sAiEzUAi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87586C41587;
	Wed, 11 Mar 2026 15:42:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37B5F60004;
	Wed, 11 Mar 2026 15:42:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96C9C103699BF;
	Wed, 11 Mar 2026 16:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773243742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uIKCV1V8/cnfFfPiktVd5Fy2Yl3h50pFoP+or1v13xc=;
	b=sAiEzUAiTmRR6CNXDs9+rbXTrv/zagyZqZ+qM8EdeRs9jIeiaIpCqzEeiOJVth/2Qd8+XL
	P+NlPm53q2AhOEF1XeyjjGmP52YSTa9xFF1oi+IdLipGRL5YCcMO2w5rMhWI2fcxaN83lY
	3nF69Mx2vS/2Vsaizy4KMqpJ8uteXLvaTyjTmQ9ANbZyMGjuMTD1wYnTYdSdK4x9OykHmD
	ksdWwI2P+fLjccAadnAqfzilYEHFGVb+21/K77jAtxgIKvSdPcWad6Bzp41nEP4N0pIiE4
	3NEIbDXRI0J9ndPPlr+meAe+iRDncoACW/y91W0SGSLezKl7i78jS6Vl7VsqgA==
Message-ID: <acb7ff65-3fed-4a89-a560-f09b53acea9d@bootlin.com>
Date: Wed, 11 Mar 2026 16:42:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <87tsum3b1o.fsf@all.your.base.are.belong.to.us>
 <ed30934a-4931-40e5-a659-6fc8d12741b5@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ed30934a-4931-40e5-a659-6fc8d12741b5@lunn.ch>
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
	TAGGED_FROM(0.00)[bounces-17974-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,pengutronix.de,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 006E4266B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 11/03/2026 16:30, Andrew Lunn wrote:
>> I like this. The nice thing is that since "name" is a string, we're not
>> locked into an enum -- drivers report what they have using 802.3
>> vocabulary, and we document the recommended names (pcs, pma, pmd, mii)
>> with references? That way it's unambiguous, but not too constrained.
> 
> It is both good and bad. I expect some vendors will just ignore the
> text and use what their data sheet says, because they don't know
> better. An enum forces more consistency.
> 
> https://gist.github.com/mjball/9cd028ac793ae8b351df1379f1e721f9
> 
> enum gets you around level 9. string around level 3.
> 
> 	Andrew

Oh didn't know that manifesto.

Givent the current discussions I'm indeed starting to think an enum
value will be enough to cover a good portion of the usecases, so I'm
OK with it :)

Maxime


