Return-Path: <linux-rdma+bounces-22366-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eAq9Ez5tNGqcXwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22366-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:12:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3546A2E9A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:12:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=Wa711ndb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22366-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22366-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61AA43058E69
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB534FF55;
	Thu, 18 Jun 2026 22:11:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F634D4D6
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 22:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820693; cv=none; b=e4pa7ARxVCgv+UhP/E92RYNWe2FhTei67gpnC8rr4JnJODtLgMh6B4b8ImuC/wmv3PTPxE1ItmPt2b5vgpumSpmgZ46XQYQ3NjhZjljz5FVE2mvRDIp9bgBeF+Cs98TWfWumCJEwGbVo3D2WeZo3XlxlVZ+xoSToUwdxyorgllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820693; c=relaxed/simple;
	bh=tIxdSxDXWXfXz+inSGUYt7RDez2Rfbj/IU2DS0DAyw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMjxmdWhckQce1H+RP/YX0lYBp7ikbT6FhgUEF0G/Yq4bIJhsXBjwSMwLhbQexeLLR1EDk+/+WAgOYRmNGwx5sttjQ1LYtcLy0nXC+Zo8jvPFWRZ6llLXgnIflv58sOCziZH9piXZ+edtkQp5xz991B6e+GYhbXr0lU1RthBnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Wa711ndb; arc=none smtp.client-ip=185.70.43.101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781820688; x=1782079888;
	bh=tIxdSxDXWXfXz+inSGUYt7RDez2Rfbj/IU2DS0DAyw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wa711ndbzk7S+BcHMmP49JyGOBQ4Z2fSHDIn4YuagQjKTknxqZmaQHCHsFVrb9vkV
	 ZCWrRQpnoVi5wi2sdw2rRUUhdVZeCMlwNHLt8uMx8+cRheepV5X6snBXyfpzKJD58L
	 N1bWg6ak7mOaQAwY+GdO+Ju+5/fYYL4k6CEgJ6Xlz58R7k2h6vPtvjbNUC4KqyCmv6
	 eTJLznC6Qq8mwxLEwSAq7niTUdZxmbRGhS/pnSsJKxW/G1Ex4T2ofPi+jA3LBL7e4L
	 hY/gO5iXRA9dtmdP2AXj4hk6OimFKdCR7pbpceSMlvA4jxmXKjZELUcNdttTDA7Sa1
	 i0ZIA+rhZAXbg==
Date: Thu, 18 Jun 2026 22:11:22 +0000
To: Dust Li <dust.li@linux.alibaba.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net/smc: bound the send length to the send buffer in smc_tx_sendmsg()
Message-ID: <20260618221115.236718-1-hexlabsecurity@proton.me>
In-Reply-To: <ajQX7_9xFI9GSaq5@linux.alibaba.com>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me> <20260614-b4-disp-edd64be9-v3-3-551fa514257e@proton.me> <ajQX7_9xFI9GSaq5@linux.alibaba.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: d1cb6126b360c355cf2d54ae6e61c13ede4385e5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22366-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:dkim,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE3546A2E9A

On Fri, 19 Jun 2026 00:08:15 +0800, Dust Li wrote:
> I think this is the same as patch #2.

Same story as 2/3, just on the SMC-D send side: sndbuf_space accumulates
diff_tx =3D smc_curs_diff(sndbuf_desc->len, tx_curs_fin, cons) from the pee=
r's consumer
cursor, so a cons alternating wrap 0<->1 walks it past sndbuf_desc->len (an=
d negative
over time), and smc_tx_sendmsg's wrap-around write then runs off the end of=
 the
buffer. The boundary count check doesn't bound diff_tx here either, so I'd =
keep the
same two-line bound. The same A/B covers it.

Bryam


