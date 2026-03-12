Return-Path: <linux-rdma+bounces-18121-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLYNK/ztsmnAQwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18121-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:46:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CA275E01
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF4530094F4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD93932CB;
	Thu, 12 Mar 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YUqQ2YOG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EC390992;
	Thu, 12 Mar 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333615; cv=none; b=hPMEizFBL3VIr+YgCXDREVLaHW8IdVfGOptxFflvfSqx2kd5mjoc20DOj4SawDqbYCEHbQnLiOpzyRg22k4PY6npCW3UTFOPCyS5y3aGhiBuwyFhOj+r9FZBI8aHFM7A3P0SZjkBH1xU+ug4QSOdSPC2dvWg+bvOb13gDokhuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333615; c=relaxed/simple;
	bh=q/NXnvhOQfWi+LbQbNSccqrwx2HfOA+DxhA9wpmm7FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiXdkE61c6R2djK8jYM6+2dDl5MnlYGVsWe7YQyuSmEGBJf++YnF4CBZSl5GtcU6oMTnUN2KCAfZcZUGhPgUDM1L/Rs8DUXZq+tHUHy68PFu96mx7OsRE3dQUXQnPkpWtHm7bd59GQNORwufBo7t+Nqd8CJM3duSsEGIVcIfKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YUqQ2YOG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3E37E4E42654;
	Thu, 12 Mar 2026 16:40:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E273B6001B;
	Thu, 12 Mar 2026 16:40:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB43910369E41;
	Thu, 12 Mar 2026 17:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773333608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kKLJaS6EbrB3sRJEyYBFRM7jRpN8Md6Kg5iHaeN/7t0=;
	b=YUqQ2YOGos3AIyhx6et88pkmLUWI6BnfTIalcMT9G3y1US88cRcpAzAYM6nQ+V93UPc+0w
	x2fZOK1KDHf48VUBWr+0p3F1e0hmDAzw1U1aLCzfui4RQsQxb79gWzoAt58D864dUUlHmP
	YswFuSA1N7tiu/y9Yu2v5HxVAjyMIVVUwTUg45M+NLFX5Rjml7GBkdmklvhfEHcpdyLh6C
	XeDce1JCvlc6oDP+89HHSe+GLax7IpJSNILM8AttHYfV2PgDkAbQAq90z3YoWwdPbdXtcz
	D8THyOZRueXE5lQ1wgZYcWZ3AtTMHcCieO+eES76lzyTKpJ8O+7+NW04AdIDZQ==
Message-ID: <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com>
Date: Thu, 12 Mar 2026 17:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
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
 <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18121-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 561CA275E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

>> One more issue is the test data generator location. The data generator
>> is not always the CPU. We have HW generators located in components like
>> PHYs or we may use external source (remote loopback).
> 
> At the moment, we don't have a Linux model for such generators. There
> is interest in them, but nobody has actually stepped up and proposed
> anything. I do see there is an intersect, we need to be able to
> represent them in the topology, and know which way they are pointing,
> but i don't think they have a direct influence on loopback.

If I'm following Oleksij, the idea would be to have on one side the
ability to "dump" the link topology with a finer granularity so that we
can see all the different blocks (pcs, pma, pmd, etc.), how they are
chained together and who's driving them (MAC, PHY (+ phy_index), module,
etc.), and on another side commands to configure loopback on them, with
the ability to also configure traffic generators in the future, gather
stats, etc.

Another can of worms for sure, and probably too much for what Björn is
trying to achieve. It's hard to say if this is overkill or not, there's
interest in that for sure, but also quite a lot of work to do...

Maxime

