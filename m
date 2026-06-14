Return-Path: <linux-rdma+bounces-22200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XggwOnz2LWpbngQAu9opvQ
	(envelope-from <linux-rdma+bounces-22200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 02:31:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC66801E9
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 02:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="aCYNj1/S";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22200-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22200-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2803010262
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180FF242D89;
	Sun, 14 Jun 2026 00:31:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6619D8A8;
	Sun, 14 Jun 2026 00:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781397108; cv=none; b=kMDoKLmMlgFABR1vneW7csTwooW2VDhLfrq8/Ui8MKxOS0WC53729frXayOkPyg+3jr0uTs8KmDNF7yAdQyIREMinXv4hxACxsM4gF3Z6KO2kZbPJWhpey+ue427oY8ly9OafKkfsAet2wy0xGFgX6JNPIfiONW1IGhm2xX1N7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781397108; c=relaxed/simple;
	bh=Mrg+AevGtQ73XotzAA0Pea0ZqD504RAf1CYBXl38EvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRDLYng+DonhVuunpeulPDNQTRKZRxVoOYsuC8450pVVXf+KuN6dah3s5xqbLKvP9FTnXt/9kFHdNnYhB1HjApnlM3crfCj2vYEMWnJiFw9NXFYe24lSYK+Bq5Q0wW/dL8SpTnBIhWcnE2ZysurhsbvhxM6ARIlyjyhkT5DJW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCYNj1/S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E684F1F000E9;
	Sun, 14 Jun 2026 00:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781397107;
	bh=2wHXfUnP3DR/Ofo56/WhY+6mUp7zb0Z18EcHmP1HxsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aCYNj1/ShW2ysSzpshf4vixH4c6ltWfCpaxKGOpsn2G/FFrgmQ8tJYxcclSpIFlE9
	 T9iwEEh9aB0aDw6YYI9mVsYKn0cqPhdjsLStFhU8sMJ7XIdSrVP6Ah2I36XGJeV/LT
	 g5mR1NRlV3VDJnmUys9H/GTOMrwndXMQn5ig1Y6dEf2i4cn4+K0BXQi9Sn3dG0UeMS
	 qpIRvIqJUSHHvMHpytiWlboePOTwM/3V51uGSersRCwpa1SkCsQu4HhJ5db8FLAON1
	 5yhunz/EeasrWLv4ijFPPdcyambSpBbzFzR3I6SYSmg/RRRwd5rz0dxHq9V5FAekMO
	 PnvOoL5DyzJhg==
Date: Sat, 13 Jun 2026 17:31:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi
 <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/smc: bound sndbuf_space on the SMC-D DMB-merge
 receive path
Message-ID: <20260613173146.3b4ca37d@kernel.org>
In-Reply-To: <20260610090928.192177-1-hexlabsecurity@proton.me>
References: <20260610090928.192177-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22200-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54EC66801E9

On Wed, 10 Jun 2026 09:09:36 +0000 Bryam Vargas wrote:
>  			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
> +			if (atomic_read(&conn->sndbuf_space) >
> +			    conn->sndbuf_desc->len)
> +				atomic_set(&conn->sndbuf_space,
> +					   conn->sndbuf_desc->len);

similar comments here as on the previous patch
-- 
pw-bot: cr

